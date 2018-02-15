Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226xTSQwtxxxoO+v+SYejw5H3YkDJi1xcQMUUDr83CV25wdc2+vdRARdTDJ0suWcNMOclbXc
ARC-Seal: i=1; a=rsa-sha256; t=1518708728; cv=none;
        d=google.com; s=arc-20160816;
        b=wP8BZbEKrEb7J9TYvFsPrb7dp49g6wnPZaSCe8WcSfj8Zno0war8AoGjfFqEIc2rqH
         azCgVhkbBcA5vARH0it87b6i921VrZ2cVrh6AnUTL6EyqzdMasPMj7cxSC2HrLwP3q9X
         /aYHPoNZQ3a3boGuptIAIoV/73QTf+ad2G/HhqeSBWIkFWR5eryn0kbX7pqkV5xttU7t
         OvEYQrDRaAab1hE9q2YYNnXfv1a8d8L9LIToWXjkJ0vwMsivUDKXF/SlyjCKH5kPT7sR
         S/cjSM35k5nAS6PLfVRc25zx1+pgzx5b+tlimgNcEslWATMxsSqQU7DLDPRFpGGc27YK
         aTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tqK2LwjPghljUX+DQi0ICkdIgwMri/gxM8HeN1wubME=;
        b=K8wq9FxxrNe69oRZPXKHhNY9lIrHUMJ7OpgtpVso8P6/bDslhhG1vVnshElyjvYEAW
         Vh38/0iuiukHTNUV26CqoL6TZMaHlq1ahfTmtxXcCxBrQ0k/IhuSwgo73R4ZRwwh8R2w
         WaRrwAvEz27lbkynrS24oNQXvvAGLvlJs3neaHIr1y9MpnKRU8l00jovuBoG7e9rdI8H
         GD1SUFOMRslP7Hm/CZRxj6FQosvpExvGLHPF2tr5TgnO7QkfBg8NRTJ84Sbw6K5rxsi+
         kokSxX7myOAUwx9bxfjroinrUdwghUvlsoshWQnBocnPXd5AAXWwKVrh8j49yuqPh17r
         lT/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 059/195] [Variant 1/Spectre-v1] arm64: Use pointer masking to limit uaccess speculation
Date: Thu, 15 Feb 2018 16:15:50 +0100
Message-Id: <20180215151708.683211434@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481523975589149?=
X-GMAIL-MSGID: =?utf-8?q?1592481523975589149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>


Commit 4d8efc2d5ee4 upstream.

Similarly to x86, mitigate speculation past an access_ok() check by
masking the pointer against the address limit before use.

Even if we don't expect speculative writes per se, it is plausible that
a CPU may still speculate at least as far as fetching a cache line for
writing, hence we also harden put_user() and clear_user() for peace of
mind.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -216,6 +216,26 @@ static inline void uaccess_enable_not_ua
 }
 
 /*
+ * Sanitise a uaccess pointer such that it becomes NULL if above the
+ * current addr_limit.
+ */
+#define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
+static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
+{
+	void __user *safe_ptr;
+
+	asm volatile(
+	"	bics	xzr, %1, %2\n"
+	"	csel	%0, %1, xzr, eq\n"
+	: "=&r" (safe_ptr)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "cc");
+
+	csdb();
+	return safe_ptr;
+}
+
+/*
  * The "__xxx" versions of the user access functions do not verify the address
  * space - it must have been done previously with a separate "access_ok()"
  * call.
@@ -285,7 +305,7 @@ do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
-		__get_user((x), __p) :					\
+		__p = uaccess_mask_ptr(__p), __get_user((x), __p) :	\
 		((x) = 0, -EFAULT);					\
 })
 
@@ -349,7 +369,7 @@ do {									\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?			\
-		__put_user((x), __p) :					\
+		__p = uaccess_mask_ptr(__p), __put_user((x), __p) :	\
 		-EFAULT;						\
 })
 
@@ -365,7 +385,7 @@ extern unsigned long __must_check __clea
 static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __clear_user(to, n);
+		n = __clear_user(__uaccess_mask_ptr(to), n);
 	return n;
 }
 

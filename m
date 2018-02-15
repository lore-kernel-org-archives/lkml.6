Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2251V5P6Op7vZb/LcCiEvQOZA3xhviUZyGP+saULT6ETfb7DTJ1FF3GgwQH7wls6bZiw9frG
ARC-Seal: i=1; a=rsa-sha256; t=1518709354; cv=none;
        d=google.com; s=arc-20160816;
        b=YUhyJJPPxfnvIfwSlhclpPruVm6TEGL7T6yCa1TuMC3Ww0rqks7D/uLfaiFC+Lmdcv
         IWEk49pnQ4FIb2Xety2u2bmwmOhvL0ycKT6okGp3/iM23JK5K37GOXTtxkANSQIhgDOj
         6tY1kpYgDH9qqKhJ+8b04x7LMVc+uEdu7bAW+nrx7syer+u4taoMqcc62BFkU+BH1zV2
         5DL5K3jqXAQy7+2uTqqNaQTgHBs07aZQj4UzXlR9vs8+gPqV2Vg8Oyn6SOtloCvHWyzD
         0V0UnP22m2UKFoQPjtZaIYn82h+f/xRykMr5HCgW73wCa+bJ7RaegJ3u+iP4emldfEIj
         wHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LNbwE97mkqJNvrVEMZ4ZNxijO5XhqeuzPP1UFBzZmqM=;
        b=KsdxWxWrEqCwu5CUMQrWUd1UGQbktbK5wlSDmQUK9DfAuUWt08S8mm/VyPQBwlfY+T
         b8gs3GALMEEuvcER76aY426pdqd9J3JERYZO2oeU10XrVgLOOKyQVRjywGbR0f9Ps7bj
         G1arLsI6QpP+nJgmuarY259vF6WbJgBt1okx66qy3aalMdEzZfTTyDejbYo6QAfHC7m3
         6VsmIwcRDdXPQXkda542H2kpxl2QVvSHtC4t3I3j9sB2zq1cwfG7Gi9UWVzhoXNX1s8f
         JoRJzt8nRxbz09a0+UV6S+j2XEc4aXqTYe8eoyKef/N2KFdNIUIBwdfXTYYo4n3oiraE
         6nMg==
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
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 052/202] [Variant 1/Spectre-v1] arm64: Use pointer masking to limit uaccess speculation
Date: Thu, 15 Feb 2018 16:15:52 +0100
Message-Id: <20180215151715.956044292@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481523975589149?=
X-GMAIL-MSGID: =?utf-8?q?1592482180168825740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 

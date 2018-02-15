Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fJbemHGNbW/7rSai/9m3Ftba/9m+IEzb1n3PZJwY1wP7IqAGKtvgxxsG5zIQF7w+iBYMZ
ARC-Seal: i=1; a=rsa-sha256; t=1518709259; cv=none;
        d=google.com; s=arc-20160816;
        b=pMJekyuKV2L2KPkTHgqZ9RdmzmyXLLQX6wTfXfuDyHINODZyRwWkrs5XUC49l4JsSP
         1LD42DAsTRm2OYUHjWQyTDtQHBoET7FXsJhUwffO7rm/kmLezo9pjg7JFzoVw8v9f8wq
         ziG79uILlAejRAhdcswQtzZqMIEpVWHJ/RoQx1H0Yz6eCkWj6APpUsjwHfQpEARiEqyA
         yZJ8p8beKaKgZwB40JN3xIoeLZwvagMpZknJVYtCLDIpIhruHQuTCxq0/+JR+EpnfAIz
         5ZL+4pn/qqefGsJaWSZLKJVjd6WU7UtoC/LwqLutvwlRPQEUDclddHLzv8Cnfv3mwjv8
         rOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VH6j2WsWglFT11NEg7ucCSKh/yiTy3I570y3oezcFkk=;
        b=UYp9N3S6g6Y1ElDFWiCcBafVpoo/wAXXjpm0mNhM4DBbU5BGxtZhtMeyEZnh1RYlpy
         AC7KIv1utp00hx+O61TTcPM5dN6ipg4fvd6/Lh1dJLRoRqlPcRu0oV3HcM+8YXpgZsjT
         9Z6JYubCZnpOvzXOjt9IlXIjkcFqUhFIQQnIvqpeiaOcuwTe5D1LvLJJQamFe/A1YgwO
         5IfN6SFPd1SwjM1W48kceSvHsy0qRiggp79smR8PRFEcS5YU5WYBHgVTUMKaiOpuGQlE
         bV6PU8UGfy+NyyEm8ryphvP/4JuYZiFKWSICjmgZNZkn0K7WGMJKakUBmzcqnSCS7ZRg
         fdGg==
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
Subject: [PATCH 4.15 055/202] [Variant 1/Spectre-v1] arm64: uaccess: Dont bother eliding access_ok checks in __{get, put}_user
Date: Thu, 15 Feb 2018 16:15:55 +0100
Message-Id: <20180215151716.130434875@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481532503377310?=
X-GMAIL-MSGID: =?utf-8?q?1592482080369318735?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit 84624087dd7e upstream.

access_ok isn't an expensive operation once the addr_limit for the current
thread has been loaded into the cache. Given that the initial access_ok
check preceding a sequence of __{get,put}_user operations will take
the brunt of the miss, we can make the __* variants identical to the
full-fat versions, which brings with it the benefits of address masking.

The likely cost in these sequences will be from toggling PAN/UAO, which
we can address later by implementing the *_unsafe versions.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |   54 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -294,28 +294,33 @@ do {									\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
 } while (0)
 
-#define __get_user(x, ptr)						\
+#define __get_user_check(x, ptr, err)					\
 ({									\
-	int __gu_err = 0;						\
-	__get_user_err((x), (ptr), __gu_err);				\
-	__gu_err;							\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_READ, __p, sizeof(*__p))) {		\
+		__p = uaccess_mask_ptr(__p);				\
+		__get_user_err((x), __p, (err));			\
+	} else {							\
+		(x) = 0; (err) = -EFAULT;				\
+	}								\
 })
 
 #define __get_user_error(x, ptr, err)					\
 ({									\
-	__get_user_err((x), (ptr), (err));				\
+	__get_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
-#define get_user(x, ptr)						\
+#define __get_user(x, ptr)						\
 ({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	access_ok(VERIFY_READ, __p, sizeof(*__p)) ?			\
-		__p = uaccess_mask_ptr(__p), __get_user((x), __p) :	\
-		((x) = 0, -EFAULT);					\
+	int __gu_err = 0;						\
+	__get_user_check((x), (ptr), __gu_err);				\
+	__gu_err;							\
 })
 
+#define get_user	__get_user
+
 #define __put_user_asm(instr, alt_instr, reg, x, addr, err, feature)	\
 	asm volatile(							\
 	"1:"ALTERNATIVE(instr "     " reg "1, [%2]\n",			\
@@ -358,28 +363,33 @@ do {									\
 	uaccess_disable_not_uao();					\
 } while (0)
 
-#define __put_user(x, ptr)						\
+#define __put_user_check(x, ptr, err)					\
 ({									\
-	int __pu_err = 0;						\
-	__put_user_err((x), (ptr), __pu_err);				\
-	__pu_err;							\
+	__typeof__(*(ptr)) __user *__p = (ptr);				\
+	might_fault();							\
+	if (access_ok(VERIFY_WRITE, __p, sizeof(*__p))) {		\
+		__p = uaccess_mask_ptr(__p);				\
+		__put_user_err((x), __p, (err));			\
+	} else	{							\
+		(err) = -EFAULT;					\
+	}								\
 })
 
 #define __put_user_error(x, ptr, err)					\
 ({									\
-	__put_user_err((x), (ptr), (err));				\
+	__put_user_check((x), (ptr), (err));				\
 	(void)0;							\
 })
 
-#define put_user(x, ptr)						\
+#define __put_user(x, ptr)						\
 ({									\
-	__typeof__(*(ptr)) __user *__p = (ptr);				\
-	might_fault();							\
-	access_ok(VERIFY_WRITE, __p, sizeof(*__p)) ?			\
-		__p = uaccess_mask_ptr(__p), __put_user((x), __p) :	\
-		-EFAULT;						\
+	int __pu_err = 0;						\
+	__put_user_check((x), (ptr), __pu_err);				\
+	__pu_err;							\
 })
 
+#define put_user	__put_user
+
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 #define raw_copy_from_user __arch_copy_from_user
 extern unsigned long __must_check __arch_copy_to_user(void __user *to, const void *from, unsigned long n);

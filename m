Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227hIJIzQIefGsgXlvXHuZXlw+vpfEK7CPjZbDHn3lOJyn462kVbl1zRFJtyzCyV7g9GmOBp
ARC-Seal: i=1; a=rsa-sha256; t=1518708739; cv=none;
        d=google.com; s=arc-20160816;
        b=AAkA8SwihNqAyIhnjgjGNMFyMWZFtpn2Quu4YZVhkw7DqYWVwp6ltJTORSBXL6V5hs
         qTNiCszZUNazamk6vW6RAKRGFa2f9FNs4YEb77C7v1zeBZe82kuJCbm4jLE/c+mpB1mi
         oZTUJgYgW6tgbxTRYcuiS704CzTBcI05uTqvFZZ7mjXBN8AfTqGrbVb5eoXJD3ksOuOJ
         UBfGtiJv20e1D+BjrDucYq8XbDDBFESppY6ZrSowuhrU9ZyialkdGeTleWijGIfB0L0r
         xkC7JoQdbL8Uu4gx/vcxUKMsDk31vkry9+7EUvTOWNFapcmPUGBdfKAX6tkbgxmW6pMH
         O1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xnGu04uZeEot0zHAq+ldP0KNQSZFyaqAwFwqMjRbPmM=;
        b=0vXkXuyN6JRHFuAnRfUSn50ukgZiqlBQ+kFqxU80r3NTCs422d65NM2uyGnoi43miN
         gw/3Ia85LslYHUyF96NAScEPXrU2+EToE9HCwHp46DLCVxFEu0Sct/wBZ+loOF/Q7aVo
         /3IaUSFP9pnzNwg2GVKNNwyUsUebYI5vVOJ0C6NJX/qNjWzk7kWD3tVSb7YdgQI84gsN
         P3XLwcZCQ9tZC+msSF0dUsnP6lKXOOBy3gOsTelSXlh9mNnHCF8WrIlpIcfNia4tB+uv
         3xhDYzGKt6bsQJqKau2DZ0cbd8tprhum+E6J4a9CDMXxVUIK853TfiJlCEqLV6madR5D
         pDXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 063/195] [Variant 1/Spectre-v1] arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
Date: Thu, 15 Feb 2018 16:15:54 +0100
Message-Id: <20180215151708.868489044@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481534938660043?=
X-GMAIL-MSGID: =?utf-8?q?1592481534938660043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit f71c2ffcb20d upstream.

Like we've done for get_user and put_user, ensure that user pointers
are masked before invoking the underlying __arch_{clear,copy_*}_user
operations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |   29 ++++++++++++++++++++++-------
 arch/arm64/kernel/arm64ksyms.c   |    4 ++--
 arch/arm64/lib/clear_user.S      |    6 +++---
 arch/arm64/lib/copy_in_user.S    |    5 +++--
 4 files changed, 30 insertions(+), 14 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -391,20 +391,35 @@ do {									\
 #define put_user	__put_user
 
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
-#define raw_copy_from_user __arch_copy_from_user
+#define raw_copy_from_user(to, from, n)					\
+({									\
+	__arch_copy_from_user((to), __uaccess_mask_ptr(from), (n));	\
+})
+
 extern unsigned long __must_check __arch_copy_to_user(void __user *to, const void *from, unsigned long n);
-#define raw_copy_to_user __arch_copy_to_user
-extern unsigned long __must_check raw_copy_in_user(void __user *to, const void __user *from, unsigned long n);
-extern unsigned long __must_check __clear_user(void __user *addr, unsigned long n);
+#define raw_copy_to_user(to, from, n)					\
+({									\
+	__arch_copy_to_user(__uaccess_mask_ptr(to), (from), (n));	\
+})
+
+extern unsigned long __must_check __arch_copy_in_user(void __user *to, const void __user *from, unsigned long n);
+#define raw_copy_in_user(to, from, n)					\
+({									\
+	__arch_copy_in_user(__uaccess_mask_ptr(to),			\
+			    __uaccess_mask_ptr(from), (n));		\
+})
+
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
-static inline unsigned long __must_check clear_user(void __user *to, unsigned long n)
+extern unsigned long __must_check __arch_clear_user(void __user *to, unsigned long n);
+static inline unsigned long __must_check __clear_user(void __user *to, unsigned long n)
 {
 	if (access_ok(VERIFY_WRITE, to, n))
-		n = __clear_user(__uaccess_mask_ptr(to), n);
+		n = __arch_clear_user(__uaccess_mask_ptr(to), n);
 	return n;
 }
+#define clear_user	__clear_user
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
@@ -418,7 +433,7 @@ extern unsigned long __must_check __copy
 static inline int __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
 {
 	kasan_check_write(dst, size);
-	return __copy_user_flushcache(dst, src, size);
+	return __copy_user_flushcache(dst, __uaccess_mask_ptr(src), size);
 }
 #endif
 
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -37,8 +37,8 @@ EXPORT_SYMBOL(clear_page);
 	/* user mem (segment) */
 EXPORT_SYMBOL(__arch_copy_from_user);
 EXPORT_SYMBOL(__arch_copy_to_user);
-EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(raw_copy_in_user);
+EXPORT_SYMBOL(__arch_clear_user);
+EXPORT_SYMBOL(__arch_copy_in_user);
 
 	/* physical memory */
 EXPORT_SYMBOL(memstart_addr);
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -21,7 +21,7 @@
 
 	.text
 
-/* Prototype: int __clear_user(void *addr, size_t sz)
+/* Prototype: int __arch_clear_user(void *addr, size_t sz)
  * Purpose  : clear some user memory
  * Params   : addr - user memory address to clear
  *          : sz   - number of bytes to clear
@@ -29,7 +29,7 @@
  *
  * Alignment fixed up by hardware.
  */
-ENTRY(__clear_user)
+ENTRY(__arch_clear_user)
 	uaccess_enable_not_uao x2, x3, x4
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
@@ -52,7 +52,7 @@ uao_user_alternative 9f, strb, sttrb, wz
 5:	mov	x0, #0
 	uaccess_disable_not_uao x2, x3
 	ret
-ENDPROC(__clear_user)
+ENDPROC(__arch_clear_user)
 
 	.section .fixup,"ax"
 	.align	2
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -64,14 +64,15 @@
 	.endm
 
 end	.req	x5
-ENTRY(raw_copy_in_user)
+
+ENTRY(__arch_copy_in_user)
 	uaccess_enable_not_uao x3, x4, x5
 	add	end, x0, x2
 #include "copy_template.S"
 	uaccess_disable_not_uao x3, x4
 	mov	x0, #0
 	ret
-ENDPROC(raw_copy_in_user)
+ENDPROC(__arch_copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2

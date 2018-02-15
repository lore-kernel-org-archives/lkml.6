Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1825685-1518709267-2-15487727784304736901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518709266; b=ueNORWRRJvMkyp0XTIqyyCih01JArO1eYztTEVhGuao8vvJ
    sEXVw0KJ4y+6Ge4atsJFDsoxatz8gRYgV/J+IQfaOd1EoTmAwBIGMhNeBPasuOK8
    N3LriVksHYcwy+oz4g3x2LGRhk+B0QkJBlbJqD+dJe1M49TBLdJoazDe37UtOcsY
    iyqo0QmrwI6s0o08N2+PQ6tieGcljqtW2USWQ8eVNeuDcAyCD5w7tDXwlkwzxgYL
    ZgS51y8Nmaus3Su3jJsPpae1rw7osCgO3hJ8FZXBKTLI6iC8TVG8Eik6WQA+BCBm
    /kbBw8oD+vdHfvdiY0DO0aWtHNLvxeN6if4ezsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709266; bh=6B3t3aEuuNDI6WzL3T8MZ2lyM9
    6WWKhv27pIr7OG69M=; b=YocH2HSFDpWGvy8JuXfH4hNgBxIanFvQQsNMKR+l5r
    Xq6SuixpyzRRg9wb8U1Brc/B5SN4Ic2H/kszaOhFzQbANFVqCj+YCZp/6wvMIONk
    McjAthfNrMDC+f8iHQRJxGlkQy46zQXof8ljyVTxNZUfvaDyiBCyIhU0tt5ISuKj
    tE9duOcpVXAqROYOIHbAXdJwTiB7J949F1nl4Xl9pnIVJSjtzhSSznhNLiN6xR3S
    xTpSwh5ufFUJMo5A8hFZhcHNGLUkr1EdwV9aH9jLwSW5wZSILOKC+LGSA96nNCqv
    gLAaB8Gmca3fEbn9k2qp4314tpdpBEAkTBmPZ4F68yxQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423846AbeBOPlD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:41:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60308 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423777AbeBOPlB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:41:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 056/202] [Variant 1/Spectre-v1] arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
Date: Thu, 15 Feb 2018 16:15:56 +0100
Message-Id: <20180215151716.195116716@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


Commit f71c2ffcb20d upstream.

Like we've done for get_user and put_user, ensure that user pointers
are masked before invoking the underlying __arch_{clear,copy_*}_user
operations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
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

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49tVg0mxrMRHHotgMuG5y8AnSt2xiUANTeTygtLkr6a0LCmfQqMMtQ9Y+P+tQ3i60E1nLS0
ARC-Seal: i=1; a=rsa-sha256; t=1523981308; cv=none;
        d=google.com; s=arc-20160816;
        b=mqXBc9aAZIcaafM4qR/9olpfmEiFmP0yY7XGU1qI9pqoWXT4eDfDC8fi6zFeZ4NdZG
         01M9x4JCY7oZ0/6lxeIgbKPy1ABJnofgyXRM1ayboHrIPAAmrSvnBo8U7Ip8cCBmBbIr
         YEjD5y04r4+5panyH5oiDBJdEAyI28Mcamq8WOYu3tn45688eibho4IlI5CQRzS+Qyw2
         oDBrbimoYs1M2kNIL9lg4AbZF3vrBTEZyHejiTLwHT3LKEgkhT/WWpyHJBJhvqQ+/YoW
         LZBMdjK9bbieIsIYnUdF9aNpLhIPlyuujHp4dRvUMTw5yn6nJN1v+2yD7xdQH5kvnQqX
         b7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tS0tCvWoRriht4iHAYaJ+6YcKwGC1kbMjY5VaAXja8Q=;
        b=xoa+rVx2PVN8qOBLNae06daYJmj9W3oOg9NLQaZlhj1XiJFFDXV0j8Wo5TaFsokuK/
         OIZwz83D0Ir9l1irmYY6Y+zRn0+5Q0l60ijlImD+j+ksJYVFxJQqsUhK5WRc5Hp+Jb1K
         PoiKx+ocwiCikstuW13VFLE63MLQocsBccZOGKmy+WOwnWBzufaGXmvJOxLloo917k/7
         eFRQvgIUxk8+NekyeE4FvRF/L92wpyN/VAPQztyG9sziOsJVwa1+TfOO9uNj635kEp+d
         NSGzzs1uvgxi/OloGIJ4Q2ZVCVmIRqDQ+Wa6OAB5/jjJzUReAAfvcuzzdTzU5TbCl5Rw
         uviA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Greg Hackmann <ghackmann@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 4.9 18/66] arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user
Date: Tue, 17 Apr 2018 17:58:51 +0200
Message-Id: <20180417155646.642594476@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155645.868055442@linuxfoundation.org>
References: <20180417155645.868055442@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010224439428777?=
X-GMAIL-MSGID: =?utf-8?q?1598010224439428777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>


From: Will Deacon <will.deacon@arm.com>

commit f71c2ffcb20dd8626880747557014bb9a61eb90e upstream.

Like we've done for get_user and put_user, ensure that user pointers
are masked before invoking the underlying __arch_{clear,copy_*}_user
operations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[v4.9: fixup for v4.9-style uaccess primitives]
Signed-off-by: Mark Rutland <mark.rutland@arm.com> [v4.9 backport]
Tested-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/uaccess.h |   18 ++++++++++--------
 arch/arm64/kernel/arm64ksyms.c   |    4 ++--
 arch/arm64/lib/clear_user.S      |    6 +++---
 arch/arm64/lib/copy_in_user.S    |    4 ++--
 4 files changed, 17 insertions(+), 15 deletions(-)

--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -313,21 +313,20 @@ do {									\
 
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long __must_check __arch_copy_to_user(void __user *to, const void *from, unsigned long n);
-extern unsigned long __must_check __copy_in_user(void __user *to, const void __user *from, unsigned long n);
-extern unsigned long __must_check __clear_user(void __user *addr, unsigned long n);
+extern unsigned long __must_check __arch_copy_in_user(void __user *to, const void __user *from, unsigned long n);
 
 static inline unsigned long __must_check __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	kasan_check_write(to, n);
 	check_object_size(to, n, false);
-	return __arch_copy_from_user(to, from, n);
+	return __arch_copy_from_user(to, __uaccess_mask_ptr(from), n);
 }
 
 static inline unsigned long __must_check __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
 	check_object_size(from, n, true);
-	return __arch_copy_to_user(to, from, n);
+	return __arch_copy_to_user(__uaccess_mask_ptr(to), from, n);
 }
 
 static inline unsigned long __must_check copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -355,22 +354,25 @@ static inline unsigned long __must_check
 	return n;
 }
 
-static inline unsigned long __must_check copy_in_user(void __user *to, const void __user *from, unsigned long n)
+static inline unsigned long __must_check __copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n) && access_ok(VERIFY_WRITE, to, n))
-		n = __copy_in_user(to, from, n);
+		n = __arch_copy_in_user(__uaccess_mask_ptr(to), __uaccess_mask_ptr(from), n);
 	return n;
 }
+#define copy_in_user __copy_in_user
 
 #define __copy_to_user_inatomic __copy_to_user
 #define __copy_from_user_inatomic __copy_from_user
 
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
 
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -37,8 +37,8 @@ EXPORT_SYMBOL(clear_page);
 	/* user mem (segment) */
 EXPORT_SYMBOL(__arch_copy_from_user);
 EXPORT_SYMBOL(__arch_copy_to_user);
-EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(__copy_in_user);
+EXPORT_SYMBOL(__arch_clear_user);
+EXPORT_SYMBOL(__arch_copy_in_user);
 
 	/* physical memory */
 EXPORT_SYMBOL(memstart_addr);
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -24,7 +24,7 @@
 
 	.text
 
-/* Prototype: int __clear_user(void *addr, size_t sz)
+/* Prototype: int __arch_clear_user(void *addr, size_t sz)
  * Purpose  : clear some user memory
  * Params   : addr - user memory address to clear
  *          : sz   - number of bytes to clear
@@ -32,7 +32,7 @@
  *
  * Alignment fixed up by hardware.
  */
-ENTRY(__clear_user)
+ENTRY(__arch_clear_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	mov	x2, x1			// save the size for fixup return
@@ -57,7 +57,7 @@ uao_user_alternative 9f, strb, sttrb, wz
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	ret
-ENDPROC(__clear_user)
+ENDPROC(__arch_clear_user)
 
 	.section .fixup,"ax"
 	.align	2
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -67,7 +67,7 @@
 	.endm
 
 end	.req	x5
-ENTRY(__copy_in_user)
+ENTRY(__arch_copy_in_user)
 ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_ALT_PAN_NOT_UAO, \
 	    CONFIG_ARM64_PAN)
 	add	end, x0, x2
@@ -76,7 +76,7 @@ ALTERNATIVE("nop", __stringify(SET_PSTAT
 	    CONFIG_ARM64_PAN)
 	mov	x0, #0
 	ret
-ENDPROC(__copy_in_user)
+ENDPROC(__arch_copy_in_user)
 
 	.section .fixup,"ax"
 	.align	2

Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrxewSwi9ud+0AjLwP8jE8qoh3xa6/m405R/vm1auLd9CKfGWu8xjpLfXBvmGAJjbFms8ht
ARC-Seal: i=1; a=rsa-sha256; t=1524837858; cv=none;
        d=google.com; s=arc-20160816;
        b=U4Q/wakNve0avPM6u9uVOTwGGUowiE6kla2JT7cV2Ozf4yyH7aaiBBUd/K3QLjz0bF
         dCnpXVD84+mqeY4r0Q/Pf5cxFycYGprRhWn9kiTYooiwtgL8u80JtUdPZQxmxGDJmEzm
         GXpFNZzox829KkjhwCm0b4o/JIsz5ggKkYs4hIBqrcCs8pzV5go4Pe7eJiLAlJUNs8Ab
         Md5NDM6u/6CquYq0b579unHmogpm81a1RSfUtG4XeK/sgzrQQ5+RlvBMIjQBMl7dLs0w
         CKhe+CeHEcpOPu2M+Yplsm929bS4cILZOAPY4Uf7wYP4Im/m+lkqj4ucg66ISKJOQDeL
         WDUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=rH8OQ0bGop5e6b6WXStioy+rGUSjD48VWizqoumI3a8=;
        b=rZJvSB0rLBeZkSB/s+Lbs8eqhPHaAPrsAnHRwT3O7qamooj2Do0cME6mc8vQJnmnP8
         Eg3+yTsoaQPZnftUf7H+QtUm+P4gRiceH2ifJPJjcZTBbyGE1okBqDskkTNlc1kH8N7h
         YF4JI3ClXiPyEaJsfydgdGEaxXe1C4fS90BJW2UY/p6H1qn2vDYna7I4Z0WmC6vquefu
         iqmtZb+bxKfbnep/fSGtiwEllubYSMy5sio/SvLaHh0sea3X7veEgEyM/TfdjAU77j66
         6xbK7v7vHLiXebhSmyg6YyesSpdlp9No9qAsla37v3wjLvduVRF2M3u90Z7PngYyz2IE
         Kvjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA892189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.9 42/74] s390: add automatic detection of the spectre defense
Date: Fri, 27 Apr 2018 15:58:32 +0200
Message-Id: <20180427135711.670389532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908186714193846?=
X-GMAIL-MSGID: =?utf-8?q?1598908383149938839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Schwidefsky <schwidefsky@de.ibm.com>


[ Upstream commit 6e179d64126b909f0b288fa63cdbf07c531e9b1d ]

Automatically decide between nobp vs. expolines if the spectre_v2=auto
kernel parameter is specified or CONFIG_EXPOLINE_AUTO=y is set.

The decision made at boot time due to CONFIG_EXPOLINE_AUTO=y being set
can be overruled with the nobp, nospec and spectre_v2 kernel parameters.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Kconfig                     |    2 -
 arch/s390/Makefile                    |    2 -
 arch/s390/include/asm/nospec-branch.h |    6 +--
 arch/s390/kernel/alternative.c        |    1 
 arch/s390/kernel/module.c             |   11 ++---
 arch/s390/kernel/nospec-branch.c      |   68 +++++++++++++++++++++-------------
 6 files changed, 52 insertions(+), 38 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -741,7 +741,7 @@ choice
 config EXPOLINE_OFF
 	bool "spectre_v2=off"
 
-config EXPOLINE_MEDIUM
+config EXPOLINE_AUTO
 	bool "spectre_v2=auto"
 
 config EXPOLINE_FULL
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -85,7 +85,7 @@ ifdef CONFIG_EXPOLINE
     CC_FLAGS_EXPOLINE += -mfunction-return=thunk
     CC_FLAGS_EXPOLINE += -mindirect-branch-table
     export CC_FLAGS_EXPOLINE
-    cflags-y += $(CC_FLAGS_EXPOLINE)
+    cflags-y += $(CC_FLAGS_EXPOLINE) -DCC_USING_EXPOLINE
   endif
 endif
 
--- a/arch/s390/include/asm/nospec-branch.h
+++ b/arch/s390/include/asm/nospec-branch.h
@@ -6,12 +6,10 @@
 
 #include <linux/types.h>
 
-extern int nospec_call_disable;
-extern int nospec_return_disable;
+extern int nospec_disable;
 
 void nospec_init_branches(void);
-void nospec_call_revert(s32 *start, s32 *end);
-void nospec_return_revert(s32 *start, s32 *end);
+void nospec_revert(s32 *start, s32 *end);
 
 #endif /* __ASSEMBLY__ */
 
--- a/arch/s390/kernel/alternative.c
+++ b/arch/s390/kernel/alternative.c
@@ -1,6 +1,7 @@
 #include <linux/module.h>
 #include <asm/alternative.h>
 #include <asm/facility.h>
+#include <asm/nospec-branch.h>
 
 #define MAX_PATCH_LEN (255 - 1)
 
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -171,7 +171,7 @@ int module_frob_arch_sections(Elf_Ehdr *
 	me->core_layout.size += me->arch.got_size;
 	me->arch.plt_offset = me->core_layout.size;
 	if (me->arch.plt_size) {
-		if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_call_disable)
+		if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable)
 			me->arch.plt_size += PLT_ENTRY_SIZE;
 		me->core_layout.size += me->arch.plt_size;
 	}
@@ -330,8 +330,7 @@ static int apply_rela(Elf_Rela *rela, El
 				info->plt_offset;
 			ip[0] = 0x0d10e310;	/* basr 1,0  */
 			ip[1] = 0x100a0004;	/* lg	1,10(1) */
-			if (IS_ENABLED(CONFIG_EXPOLINE) &&
-			    !nospec_call_disable) {
+			if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable) {
 				unsigned int *ij;
 				ij = me->core_layout.base +
 					me->arch.plt_offset +
@@ -452,7 +451,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	void *aseg;
 
 	if (IS_ENABLED(CONFIG_EXPOLINE) &&
-	    !nospec_call_disable && me->arch.plt_size) {
+	    !nospec_disable && me->arch.plt_size) {
 		unsigned int *ij;
 
 		ij = me->core_layout.base + me->arch.plt_offset +
@@ -479,11 +478,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
 		    (!strcmp(".nospec_call_table", secname)))
-			nospec_call_revert(aseg, aseg + s->sh_size);
+			nospec_revert(aseg, aseg + s->sh_size);
 
 		if (IS_ENABLED(CONFIG_EXPOLINE) &&
 		    (!strcmp(".nospec_return_table", secname)))
-			nospec_return_revert(aseg, aseg + s->sh_size);
+			nospec_revert(aseg, aseg + s->sh_size);
 	}
 
 	jump_label_apply_nops(me);
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -11,10 +11,17 @@ static int __init nobp_setup_early(char
 	rc = kstrtobool(str, &enabled);
 	if (rc)
 		return rc;
-	if (enabled && test_facility(82))
+	if (enabled && test_facility(82)) {
+		/*
+		 * The user explicitely requested nobp=1, enable it and
+		 * disable the expoline support.
+		 */
 		__set_facility(82, S390_lowcore.alt_stfle_fac_list);
-	else
+		if (IS_ENABLED(CONFIG_EXPOLINE))
+			nospec_disable = 1;
+	} else {
 		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	}
 	return 0;
 }
 early_param("nobp", nobp_setup_early);
@@ -28,31 +35,46 @@ early_param("nospec", nospec_setup_early
 
 #ifdef CONFIG_EXPOLINE
 
-int nospec_call_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
-int nospec_return_disable = !IS_ENABLED(CONFIG_EXPOLINE_FULL);
+int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
 
 static int __init nospectre_v2_setup_early(char *str)
 {
-	nospec_call_disable = 1;
-	nospec_return_disable = 1;
+	nospec_disable = 1;
 	return 0;
 }
 early_param("nospectre_v2", nospectre_v2_setup_early);
 
+static int __init spectre_v2_auto_early(void)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE)) {
+		/*
+		 * The kernel has been compiled with expolines.
+		 * Keep expolines enabled and disable nobp.
+		 */
+		nospec_disable = 0;
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
+	}
+	/*
+	 * If the kernel has not been compiled with expolines the
+	 * nobp setting decides what is done, this depends on the
+	 * CONFIG_KERNEL_NP option and the nobp/nospec parameters.
+	 */
+	return 0;
+}
+#ifdef CONFIG_EXPOLINE_AUTO
+early_initcall(spectre_v2_auto_early);
+#endif
+
 static int __init spectre_v2_setup_early(char *str)
 {
 	if (str && !strncmp(str, "on", 2)) {
-		nospec_call_disable = 0;
-		nospec_return_disable = 0;
-	}
-	if (str && !strncmp(str, "off", 3)) {
-		nospec_call_disable = 1;
-		nospec_return_disable = 1;
-	}
-	if (str && !strncmp(str, "auto", 4)) {
-		nospec_call_disable = 0;
-		nospec_return_disable = 1;
+		nospec_disable = 0;
+		__clear_facility(82, S390_lowcore.alt_stfle_fac_list);
 	}
+	if (str && !strncmp(str, "off", 3))
+		nospec_disable = 1;
+	if (str && !strncmp(str, "auto", 4))
+		spectre_v2_auto_early();
 	return 0;
 }
 early_param("spectre_v2", spectre_v2_setup_early);
@@ -105,15 +127,9 @@ static void __init_or_module __nospec_re
 	}
 }
 
-void __init_or_module nospec_call_revert(s32 *start, s32 *end)
-{
-	if (nospec_call_disable)
-		__nospec_revert(start, end);
-}
-
-void __init_or_module nospec_return_revert(s32 *start, s32 *end)
+void __init_or_module nospec_revert(s32 *start, s32 *end)
 {
-	if (nospec_return_disable)
+	if (nospec_disable)
 		__nospec_revert(start, end);
 }
 
@@ -121,8 +137,8 @@ extern s32 __nospec_call_start[], __nosp
 extern s32 __nospec_return_start[], __nospec_return_end[];
 void __init nospec_init_branches(void)
 {
-	nospec_call_revert(__nospec_call_start, __nospec_call_end);
-	nospec_return_revert(__nospec_return_start, __nospec_return_end);
+	nospec_revert(__nospec_call_start, __nospec_call_end);
+	nospec_revert(__nospec_return_start, __nospec_return_end);
 }
 
 #endif /* CONFIG_EXPOLINE */

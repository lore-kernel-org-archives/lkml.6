Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2CAECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF7220831
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="y/2Wvoqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF7220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeKASfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:35:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeKASfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:35:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA19NwRs182492;
        Thu, 1 Nov 2018 09:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=HAQdjCzG24J0ddTMUU+s8Zwk+DhfnxEqa/kfTN8HXlY=;
 b=y/2WvoqzHwZW8mONDo3oQUEDnYz2z9AaXkhKOtNZsnTZRzrATHX/eZgOPSisSa97B/x5
 oIIhXtfrvGrgVKnv3H0N8L2fx8ImVnTm77EH8X5WVyjmUBE18jNqYLonaMofplbMlL91
 pb5I1jdVT+JMG7nPFAu+C2m78B757xG0ByCnK3wSEs9SSvuyD6rHcCuItfdPs66ghKrU
 ZKvXkJH0/450dttTGcrb5majmu4hJcXdynIlC8PEjUp2wjnXAK6+kSv0YpTnkCnu7lTI
 rjZP0DLWe/4BF1syEz+dC+0ukEMw2A2Q0d8XSSBj4VfJB3dCALJ4/h+43e20+JmTVxR1 oQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ncgnr7t7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Nov 2018 09:31:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA19VkfQ006395
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 09:31:46 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA19VicV029478;
        Thu, 1 Nov 2018 09:31:44 GMT
MIME-Version: 1.0
Message-ID: <991cbe9b-1e31-4b12-b572-91fde5c79699@default>
Date:   Thu, 1 Nov 2018 02:31:44 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <konrad.wilk@oracle.com>, <luto@kernel.org>,
        <tglx@linutronix.de>, <dwmw@amazon.co.uk>, <bp@suse.de>,
        <srinivas.eeda@oracle.com>, <daniel@iogearbox.net>,
        <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>,
        <peterz@infradead.org>, <hpa@zytor.com>
Subject: [PATCH v2 1/2] retpolines: Only enable retpoline support when
 compiler support it
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811010083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since retpoline capable compilers are widely available, make
CONFIG_RETPOLINE hard depend on it.

The check of RETPOLINE is changed to CONFIG_RETPOLINE.

This change is based on suggestion in https://lkml.org/lkml/2018/9/18/1016

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
---
 arch/x86/Kconfig                     |  6 ++----
 arch/x86/Makefile                    |  4 +---
 arch/x86/include/asm/nospec-branch.h | 10 ++++++----
 arch/x86/kernel/cpu/bugs.c           |  2 +-
 scripts/Makefile.build               |  2 --
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ffebfc3f..277e0df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -436,6 +436,8 @@ config GOLDFISH
=20
 config RETPOLINE
 =09bool "Avoid speculative indirect branches in kernel"
+=09depends on $(cc-option,-mindirect-branch=3Dthunk-extern -mindirect-bran=
ch-register) || \
+                    $(cc-option,-mretpoline-external-thunk)
 =09default y
 =09select STACK_VALIDATION if HAVE_STACK_VALIDATION
 =09help
@@ -444,10 +446,6 @@ config RETPOLINE
 =09  branches. Requires a compiler with -mindirect-branch=3Dthunk-extern
 =09  support for full protection. The kernel may run slower.
=20
-=09  Without compiler support, at least indirect branches in assembler
-=09  code are eliminated. Since this includes the syscall entry path,
-=09  it is not entirely pointless.
-
 config INTEL_RDT
 =09bool "Intel Resource Director Technology support"
 =09depends on X86 && CPU_SUP_INTEL
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b562e4..30573dd 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -222,9 +222,7 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
=20
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
-  KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS) -DRETPOLINE
-endif
+  KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS)
 endif
=20
 archscripts: scripts_basic
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/no=
spec-branch.h
index 80dc144..8b09cbb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -162,11 +162,12 @@
 =09_ASM_PTR " 999b\n\t"=09=09=09=09=09\
 =09".popsection\n\t"
=20
-#if defined(CONFIG_X86_64) && defined(RETPOLINE)
+#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_X86_64
=20
 /*
- * Since the inline asm uses the %V modifier which is only in newer GCC,
- * the 64-bit one is dependent on RETPOLINE not CONFIG_RETPOLINE.
+ * Inline asm uses the %V modifier which is only in newer GCC
+ * which is ensured when CONFIG_RETPOLINE is defined.
  */
 # define CALL_NOSPEC=09=09=09=09=09=09\
 =09ANNOTATE_NOSPEC_ALTERNATIVE=09=09=09=09\
@@ -181,7 +182,7 @@
 =09X86_FEATURE_RETPOLINE_AMD)
 # define THUNK_TARGET(addr) [thunk_target] "r" (addr)
=20
-#elif defined(CONFIG_X86_32) && defined(CONFIG_RETPOLINE)
+#else /* CONFIG_X86_32 */
 /*
  * For i386 we use the original ret-equivalent retpoline, because
  * otherwise we'll run out of registers. We don't care about CET
@@ -211,6 +212,7 @@
 =09X86_FEATURE_RETPOLINE_AMD)
=20
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
+#endif
 #else /* No retpoline for C / inline asm */
 # define CALL_NOSPEC "call *%[thunk_target]\n"
 # define THUNK_TARGET(addr) [thunk_target] "rm" (addr)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c37e66e..d0108fb 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -252,7 +252,7 @@ static void __init spec2_print_if_secure(const char *re=
ason)
=20
 static inline bool retp_compiler(void)
 {
-=09return __is_defined(RETPOLINE);
+=09return __is_defined(CONFIG_RETPOLINE);
 }
=20
 static inline bool match_option(const char *arg, int arglen, const char *o=
pt)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a8e7ba9..6a6be9f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -236,10 +236,8 @@ ifdef CONFIG_GCOV_KERNEL
 objtool_args +=3D --no-unreachable
 endif
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args +=3D --retpoline
 endif
-endif
=20
=20
 ifdef CONFIG_MODVERSIONS
--=20
1.8.3.1

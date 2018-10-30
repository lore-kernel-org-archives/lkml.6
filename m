Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AABC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F3F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G3aGv/O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F3F20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeJ3Psd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:48:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3Psd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:48:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9U6rtVI115038;
        Tue, 30 Oct 2018 06:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=fk3o7cmibQ7f9C3D4wKwG3V2IgdJiu07HiMQaRgbgi8=;
 b=G3aGv/O3McVO5NC7Ue5Q05bVUphPAIwu5+S18l8YtGU7YEekxIkwxxRzx7GFJTZ1irvR
 baw/JAwfkFpQjJm1Ka9trrdY3dfkbRktfjNtF+uEuqctaf8z2oD/BqRVrTyMZtU+COso
 p39rGWdHUaoQGl6uaPac9cOIdnqqi70Jgp/M+47eg1d/2DWqv7DKjKcU6Z73b/iTFVDM
 gNTYNYKn6PYloGBCF2TGQ4A5HL8Kx6UbYJkK7IuxeYU7CnXDmuCLtHSokUDJpTDyrXb0
 d7f49i2CAOuuVWcium36dSq0TJkarNu+wCaLOI2n9utbg0dx5hbJ/t8eJOF29gm+vUEJ hA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ncfypt01y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 06:55:09 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t7xS017955
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 06:55:08 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9U6t5qr019539;
        Tue, 30 Oct 2018 06:55:05 GMT
MIME-Version: 1.0
Message-ID: <e63900bc-d7af-4a57-aa96-f6cc84b89e09@default>
Date:   Mon, 29 Oct 2018 23:55:04 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <luto@kernel.org>, <konrad.wilk@oracle.com>,
        <dwmw@amazon.co.uk>, <tglx@linutronix.de>,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, <bp@suse.de>,
        <daniel@iogearbox.net>, <yamada.masahiro@socionext.com>,
        <michal.lkml@markovi.net>, <peterz@infradead.org>, <hpa@zytor.com>
Subject: [PATCH 1/3] retpolines: Only enable retpoline when compiler support
 it
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9061 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since retpoline capable compilers are widely available, make
CONFIG_RETPOLINE hard depend on it.

Change KBUILD to use CONFIG_RETPOLINE_SUPPORT to avoid conflict with
CONFIG_RETPOLINE which is used by kernel.

With all that stuff, the check of RETPOLINE is changed to
CONFIG_RETPOLINE.

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
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 arch/x86/Kconfig                                |  8 ++++----
 arch/x86/Makefile                               |  5 +++--
 arch/x86/entry/vdso/Makefile                    |  4 ++--
 arch/x86/include/asm/nospec-branch.h            | 10 ++++++----
 arch/x86/kernel/cpu/bugs.c                      |  2 +-
 arch/x86/kernel/vmlinux.lds.S                   |  2 +-
 arch/x86/lib/Makefile                           |  2 +-
 arch/x86/lib/retpoline.S                        |  2 ++
 scripts/Makefile.build                          |  2 +-
 10 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index e129cd8..c26264e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4187,7 +4187,7 @@
 =09=09=09Selecting 'on' will, and 'auto' may, choose a
 =09=09=09mitigation method at run time according to the
 =09=09=09CPU, the available microcode, the setting of the
-=09=09=09CONFIG_RETPOLINE configuration option, and the
+=09=09=09CONFIG_RETPOLINE_SUPPORT configuration option, and the
 =09=09=09compiler with which the kernel was built.
=20
 =09=09=09Specific mitigations can also be selected manually:
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cbd5f28..766563f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -433,7 +433,7 @@ config GOLDFISH
        def_bool y
        depends on X86_GOLDFISH
=20
-config RETPOLINE
+config RETPOLINE_SUPPORT
 =09bool "Avoid speculative indirect branches in kernel"
 =09default y
 =09select STACK_VALIDATION if HAVE_STACK_VALIDATION
@@ -443,9 +443,9 @@ config RETPOLINE
 =09  branches. Requires a compiler with -mindirect-branch=3Dthunk-extern
 =09  support for full protection. The kernel may run slower.
=20
-=09  Without compiler support, at least indirect branches in assembler
-=09  code are eliminated. Since this includes the syscall entry path,
-=09  it is not entirely pointless.
+=09  Since retpoline capable compilers are widely available, kernel doesn'=
t
+=09  use CONFIG_RETPOLINE_SUPPORT directly but use CONFIG_RETPOLINE which
+=09  is enabled when compiler support retpoline.
=20
 config INTEL_RDT
 =09bool "Intel Resource Director Technology support"
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5b562e4..7ed35b1 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -221,9 +221,10 @@ KBUILD_CFLAGS +=3D -Wno-sign-compare
 KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
=20
 # Avoid indirect branches in kernel to deal with Spectre
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_RETPOLINE_SUPPORT
 ifneq ($(RETPOLINE_CFLAGS),)
-  KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS) -DRETPOLINE
+  KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS) -DCONFIG_RETPOLINE
+  KBUILD_AFLAGS +=3D -DCONFIG_RETPOLINE
 endif
 endif
=20
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415..87acde1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -70,7 +70,7 @@ CFL :=3D $(PROFILING) -mcmodel=3Dsmall -fPIC -O2 -fasynch=
ronous-unwind-tables -m64 \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
=20
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_RETPOLINE_SUPPORT
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
   CFL +=3D $(RETPOLINE_VDSO_CFLAGS)
 endif
@@ -145,7 +145,7 @@ KBUILD_CFLAGS_32 +=3D $(call cc-option, -foptimize-sibl=
ing-calls)
 KBUILD_CFLAGS_32 +=3D -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 +=3D -DDISABLE_BRANCH_PROFILING
=20
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_RETPOLINE_SUPPORT
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
   KBUILD_CFLAGS_32 +=3D $(RETPOLINE_VDSO_CFLAGS)
 endif
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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0d618ee..07533f7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -136,7 +136,7 @@ SECTIONS
 =09=09*(.fixup)
 =09=09*(.gnu.warning)
=20
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_RETPOLINE_SUPPORT
 =09=09__indirect_thunk_start =3D .;
 =09=09*(.text.__x86.indirect_thunk)
 =09=09__indirect_thunk_end =3D .;
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 25a972c..edfa7ab 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -27,7 +27,7 @@ lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=3D rwsem.o
 lib-$(CONFIG_INSTRUCTION_DECODER) +=3D insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) +=3D kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)=09+=3D error-inject.o
-lib-$(CONFIG_RETPOLINE) +=3D retpoline.o
+lib-$(CONFIG_RETPOLINE_SUPPORT) +=3D retpoline.o
=20
 obj-y +=3D msr.o msr-reg.o msr-reg-export.o hweight.o
=20
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index c909961..81366ad 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
=20
+#ifdef CONFIG_RETPOLINE
 #include <linux/stringify.h>
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
@@ -46,3 +47,4 @@ GENERATE_THUNK(r13)
 GENERATE_THUNK(r14)
 GENERATE_THUNK(r15)
 #endif
+#endif
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 54da4b0..259d9c6 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -247,7 +247,7 @@ endif
 ifdef CONFIG_GCOV_KERNEL
 objtool_args +=3D --no-unreachable
 endif
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_RETPOLINE_SUPPORT
 ifneq ($(RETPOLINE_CFLAGS),)
   objtool_args +=3D --retpoline
 endif
--=20
1.8.3.1

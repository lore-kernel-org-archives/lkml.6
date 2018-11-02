Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40F6C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E8C2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 08:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jRzlrnUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E8C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeKBRxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 13:53:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34736 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeKBRxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 13:53:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA28jCeS086703;
        Fri, 2 Nov 2018 08:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=XMKLSXAuBWSIOY4aaxmHV31Wj5DCB2dsOz3hgRdMtM4=;
 b=jRzlrnUqJ9zp2Ok1X2WmodWoNG2TqucMqsphT42ZjGLfrmWc78WcFph1dNeNpGSG2MPg
 kH+EApApYXQNxzjWgXH0yAUUFR/EhwPWn4M/tzGXyKRSq6vW38yesmb3wou1x2gFQ1jl
 vcoXVgJMg3i10/SGCld7TGirCtVLQz/OPJlGqel3I95+KlcOWzs6/BjXXMxukHqfsgsI
 jeOTmt6BigDjad7vs/ZM2x1w+2l48CXMLBKqfPviH0LWVvIu6QWOsioyTTWwNeyiqauG
 pU+v7S7tHZ0CL/99T5JHA7M8l0IuNGOQwnbvEN4fJuJyukjMRSHljJVmSbpurNKfATgN cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ncgnrd9bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 08:45:44 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA28jhjv011044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 08:45:43 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA28jgtp004355;
        Fri, 2 Nov 2018 08:45:42 GMT
MIME-Version: 1.0
Message-ID: <cca0cb20-f9e2-4094-840b-fb0f8810cd34@default>
Date:   Fri, 2 Nov 2018 01:45:41 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <luto@kernel.org>, <konrad.wilk@oracle.com>,
        <dwmw@amazon.co.uk>, <tglx@linutronix.de>,
        <srinivas.eeda@oracle.com>, <bp@suse.de>, <daniel@iogearbox.net>,
        <yamada.masahiro@socionext.com>, <michal.lkml@markovi.net>,
        <peterz@infradead.org>, <hpa@zytor.com>
Subject: [PATCH v3 1/2] retpolines: Enable retpoline support only when
 compiler support it
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since retpoline capable compilers are widely available, make
CONFIG_RETPOLINE hard depend on it. This is achieved by breaking
the build early and showing an error like below:

"arch/x86/Makefile:226: *** You are building kernel with non-retpoline
compiler, please update your compiler..  Stop."

[peterz@infradead.org: initial suggestion]
Link: https://lore.kernel.org/lkml/caeb3213f13e57191e362ca04f2892cfa2ccda65=
.camel@infradead.org
[dwmw@amazon.co.uk: fail the build with non-retpoline compiler]
Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1811011317400.1642@nanos=
.tec.linutronix.de
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
---
 arch/x86/Kconfig                     |  4 ----
 arch/x86/Makefile                    |  5 +++--
 arch/x86/include/asm/nospec-branch.h | 10 ++++++----
 arch/x86/kernel/cpu/bugs.c           |  2 +-
 scripts/Makefile.build               |  2 --
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c51c989..fcb7f37 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -443,10 +443,6 @@ config RETPOLINE
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
index 5b562e4..6d94fe8 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -222,9 +222,10 @@ KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables
=20
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
-ifneq ($(RETPOLINE_CFLAGS),)
-  KBUILD_CFLAGS +=3D $(RETPOLINE_CFLAGS) -DRETPOLINE
+ifeq ($(RETPOLINE_CFLAGS),)
+  $(error You are building kernel with non-retpoline compiler, please upda=
te your compiler.)
 endif
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

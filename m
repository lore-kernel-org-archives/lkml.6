Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBE6C20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UoBW82sV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE6C20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeLFFTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:19:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45941 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFFTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:19:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so10087093pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gMUsp1sPf+JXugyiSEmWZ5rKk1y3ZG2BnlutnnP++/k=;
        b=UoBW82sVIp1Dklfqp8ZMnvtEoUqrXkuhLk12+P4P4QwRBv/pcptNn33+oXKMjSD3AQ
         BivoVFAFGmXKqGLAY9QBH9N4y6ykzbQxUcoqB1Hp3QlGqYLdrGeAPZrBYYSohGbURCJ5
         2LT1F6Y5I/zCAogDG+wB2PhpCNwsYENzRpTrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gMUsp1sPf+JXugyiSEmWZ5rKk1y3ZG2BnlutnnP++/k=;
        b=WQgwFfnSkfzR+64JHsHPThDJLx6KbE6mq3J9fgRzszvSC/BchuUolioXGlXpo3IUg1
         Lz3clrwdowC1OFDLcAF1rF1wK6EGBLIZbx16A9mXEnx+ouATblwioT8EDkk+MFnBgmzr
         kyEMz2O3PXauN7AFFOEI5PSdmu0E4Gb9O6gQ2F3oMw0uQgQarQxmYILftgkmM+nmPBqL
         hP88AorXnP2huI4/CDSEaXCXLsCBGnWWr9/PEI8UfJeiefkPKWJXuIa0MTEN6Ou4h3lT
         sP+V5Ah/yJRBPdShdyPONWkegkXTEc1x8W0kfEZCFQtKAd9HjQ4Timjq48VWUIv+toam
         LFYA==
X-Gm-Message-State: AA+aEWa9SKo9FfKb23QnZHMqj1Jpv8XsvbaKo110Hoe7OHAm/+U/p+Ho
        FRyFstEWXDeNBh9H3shCW9adAA==
X-Google-Smtp-Source: AFSGD/VaO6MV6/nB+4HV8HCM/Q/dQpktWPPnzIclecicyMSp8aUe09b3JAWJ5BqtAEOHbo8rkwQGUA==
X-Received: by 2002:a63:194f:: with SMTP id 15mr23214465pgz.192.1544073574481;
        Wed, 05 Dec 2018 21:19:34 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r66sm32877803pfk.157.2018.12.05.21.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 21:19:33 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Date:   Thu,  6 Dec 2018 10:48:24 +0530
Message-Id: <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we get nanoMIPS support we'll be introducing the p32
ABI, and there's a reasonable chance that the equivalent
p64 ABI may come along in the future. Using 'n64' now would
avoid confusion in that case where we may have 2 different
64-bit ABIs.

Suggested-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/asm/asm.h                      | 6 +++---
 arch/mips/include/asm/fpregdef.h                 | 4 ++--
 arch/mips/include/asm/fw/arc/hinv.h              | 2 +-
 arch/mips/include/asm/regdef.h                   | 4 ++--
 arch/mips/include/asm/sigcontext.h               | 4 ++--
 arch/mips/include/uapi/asm/fcntl.h               | 2 +-
 arch/mips/include/uapi/asm/reg.h                 | 4 ++--
 arch/mips/include/uapi/asm/sgidefs.h             | 2 +-
 arch/mips/include/uapi/asm/sigcontext.h          | 4 ++--
 arch/mips/include/uapi/asm/stat.h                | 4 ++--
 arch/mips/include/uapi/asm/statfs.h              | 4 ++--
 arch/mips/include/uapi/asm/unistd.h              | 8 ++++----
 arch/mips/kernel/Makefile                        | 2 +-
 arch/mips/kernel/ftrace.c                        | 4 ++--
 arch/mips/kernel/{scall64-64.S => scall64-n64.S} | 4 ++--
 arch/mips/kvm/entry.c                            | 4 ++--
 arch/mips/vdso/vdso.h                            | 2 +-
 arch/mips/vdso/vdso.lds.S                        | 2 +-
 18 files changed, 33 insertions(+), 33 deletions(-)
 rename arch/mips/kernel/{scall64-64.S => scall64-n64.S} (99%)

diff --git a/arch/mips/include/asm/asm.h b/arch/mips/include/asm/asm.h
index c23527b..9244a87 100644
--- a/arch/mips/include/asm/asm.h
+++ b/arch/mips/include/asm/asm.h
@@ -110,7 +110,7 @@
 #define ALSZ	7
 #define ALMASK	~7
 #endif
-#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABIN64)
 #define ALSZ	15
 #define ALMASK	~15
 #endif
@@ -138,7 +138,7 @@
 #define REG_SUBU	subu
 #define REG_ADDU	addu
 #endif
-#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABIN64)
 #define REG_S		sd
 #define REG_L		ld
 #define REG_SUBU	dsubu
@@ -291,7 +291,7 @@
 #define MFC0		mfc0
 #define MTC0		mtc0
 #endif
-#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABI64)
+#if (_MIPS_SIM == _MIPS_SIM_NABI32) || (_MIPS_SIM == _MIPS_SIM_ABIN64)
 #define MFC0		dmfc0
 #define MTC0		dmtc0
 #endif
diff --git a/arch/mips/include/asm/fpregdef.h b/arch/mips/include/asm/fpregdef.h
index f184ba0..762ffeb 100644
--- a/arch/mips/include/asm/fpregdef.h
+++ b/arch/mips/include/asm/fpregdef.h
@@ -71,7 +71,7 @@
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#if _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
 #define fv0	$f0	/* return value */
 #define fv1	$f2
@@ -108,6 +108,6 @@
 
 #define fcr31	$31
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #endif /* _ASM_FPREGDEF_H */
diff --git a/arch/mips/include/asm/fw/arc/hinv.h b/arch/mips/include/asm/fw/arc/hinv.h
index d67b6a9..c9d0523 100644
--- a/arch/mips/include/asm/fw/arc/hinv.h
+++ b/arch/mips/include/asm/fw/arc/hinv.h
@@ -112,7 +112,7 @@
 	ULONG FullKey;
 };
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if _MIPS_SIM == _MIPS_SIM_ABIN64
 #define SGI_ARCS_VERS	64			/* sgi 64-bit version */
 #define SGI_ARCS_REV	0			/* rev .00 */
 #else
diff --git a/arch/mips/include/asm/regdef.h b/arch/mips/include/asm/regdef.h
index 3c687df..45911d8 100644
--- a/arch/mips/include/asm/regdef.h
+++ b/arch/mips/include/asm/regdef.h
@@ -60,7 +60,7 @@
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#if _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
 #define zero	$0	/* wired zero */
 #define AT	$at	/* assembler temp - uppercase because of ".set at" */
@@ -101,6 +101,6 @@
 #define s8	$30	/* callee saved */
 #define ra	$31	/* return address */
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #endif /* _ASM_REGDEF_H */
diff --git a/arch/mips/include/asm/sigcontext.h b/arch/mips/include/asm/sigcontext.h
index eeeb0f4..e3a55d1 100644
--- a/arch/mips/include/asm/sigcontext.h
+++ b/arch/mips/include/asm/sigcontext.h
@@ -11,7 +11,7 @@
 
 #include <uapi/asm/sigcontext.h>
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#if _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
 struct sigcontext32 {
 	__u32		sc_regmask;	/* Unused */
@@ -33,5 +33,5 @@ struct sigcontext32 {
 	__u32		sc_hi3;
 	__u32		sc_lo3;
 };
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 #endif /* _ASM_SIGCONTEXT_H */
diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 42e13de..34effe6 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -57,7 +57,7 @@
  * contain all the same fields as struct flock.
  */
 
-#if _MIPS_SIM != _MIPS_SIM_ABI64
+#if _MIPS_SIM != _MIPS_SIM_ABIN64
 
 #include <linux/types.h>
 
diff --git a/arch/mips/include/uapi/asm/reg.h b/arch/mips/include/uapi/asm/reg.h
index 56d15cb..57fe259 100644
--- a/arch/mips/include/uapi/asm/reg.h
+++ b/arch/mips/include/uapi/asm/reg.h
@@ -160,7 +160,7 @@
 #define EF_UNUSED0		MIPS32_EF_UNUSED0
 #define EF_SIZE			MIPS32_EF_SIZE
 
-#elif _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#elif _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
 #define EF_R0			MIPS64_EF_R0
 #define EF_R1			MIPS64_EF_R1
@@ -202,6 +202,6 @@
 #define EF_CP0_CAUSE		MIPS64_EF_CP0_CAUSE
 #define EF_SIZE			MIPS64_EF_SIZE
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #endif /* __UAPI_ASM_MIPS_REG_H */
diff --git a/arch/mips/include/uapi/asm/sgidefs.h b/arch/mips/include/uapi/asm/sgidefs.h
index 26143e3..0364eec 100644
--- a/arch/mips/include/uapi/asm/sgidefs.h
+++ b/arch/mips/include/uapi/asm/sgidefs.h
@@ -40,6 +40,6 @@
  */
 #define _MIPS_SIM_ABI32		1
 #define _MIPS_SIM_NABI32	2
-#define _MIPS_SIM_ABI64		3
+#define _MIPS_SIM_ABIN64	3
 
 #endif /* __ASM_SGIDEFS_H */
diff --git a/arch/mips/include/uapi/asm/sigcontext.h b/arch/mips/include/uapi/asm/sigcontext.h
index d0a540e..5e8a562 100644
--- a/arch/mips/include/uapi/asm/sigcontext.h
+++ b/arch/mips/include/uapi/asm/sigcontext.h
@@ -54,7 +54,7 @@ struct sigcontext {
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#if _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
 #include <linux/posix_types.h>
 /*
@@ -86,6 +86,6 @@ struct sigcontext {
 };
 
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #endif /* _UAPI_ASM_SIGCONTEXT_H */
diff --git a/arch/mips/include/uapi/asm/stat.h b/arch/mips/include/uapi/asm/stat.h
index 95416f3..c1f6433 100644
--- a/arch/mips/include/uapi/asm/stat.h
+++ b/arch/mips/include/uapi/asm/stat.h
@@ -87,7 +87,7 @@ struct stat64 {
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if _MIPS_SIM == _MIPS_SIM_ABIN64
 
 /* The memory layout is the same as of struct stat64 of the 32-bit kernel.  */
 struct stat {
@@ -126,7 +126,7 @@ struct stat {
 	unsigned long		st_blocks;
 };
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 */
 
 #define STAT_HAVE_NSEC 1
 
diff --git a/arch/mips/include/uapi/asm/statfs.h b/arch/mips/include/uapi/asm/statfs.h
index f4174dc..a9ca452 100644
--- a/arch/mips/include/uapi/asm/statfs.h
+++ b/arch/mips/include/uapi/asm/statfs.h
@@ -61,7 +61,7 @@ struct statfs64 {
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if _MIPS_SIM == _MIPS_SIM_ABIN64
 
 struct statfs64 {			/* Same as struct statfs */
 	long		f_type;
@@ -96,6 +96,6 @@ struct compat_statfs64 {
 	__u32	f_spare[5];
 };
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 */
 
 #endif /* _ASM_STATFS_H */
diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index c897195..b997f43 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -400,7 +400,7 @@
 #define __NR_O32_Linux			4000
 #define __NR_O32_Linux_syscalls		368
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if _MIPS_SIM == _MIPS_SIM_ABIN64
 
 /*
  * Linux 64-bit syscalls are in the range from 5000 to 5999.
@@ -740,10 +740,10 @@
 #define __NR_syscalls			328
 #endif
 
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 */
 
-#define __NR_64_Linux			5000
-#define __NR_64_Linux_syscalls		328
+#define __NR_N64_Linux			5000
+#define __NR_N64_Linux_syscalls		328
 
 #if _MIPS_SIM == _MIPS_SIM_NABI32
 
diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index 210c280..25af613 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -72,7 +72,7 @@ obj-$(CONFIG_IRQ_GT641XX)	+= irq-gt641xx.o
 
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_32BIT)		+= scall32-o32.o
-obj-$(CONFIG_64BIT)		+= scall64-64.o
+obj-$(CONFIG_64BIT)		+= scall64-n64.o
 obj-$(CONFIG_MIPS32_COMPAT)	+= linux32.o ptrace32.o signal32.o
 obj-$(CONFIG_MIPS32_N32)	+= binfmt_elfn32.o scall64-n32.o signal_n32.o
 obj-$(CONFIG_MIPS32_O32)	+= binfmt_elfo32.o scall64-o32.o signal_o32.o
diff --git a/arch/mips/kernel/ftrace.c b/arch/mips/kernel/ftrace.c
index b122cbb..d91a6e7 100644
--- a/arch/mips/kernel/ftrace.c
+++ b/arch/mips/kernel/ftrace.c
@@ -403,8 +403,8 @@ unsigned long __init arch_syscall_addr(int nr)
 	if (nr >= __NR_N32_Linux && nr <= __NR_N32_Linux + __NR_N32_Linux_syscalls)
 		return (unsigned long)sysn32_call_table[nr - __NR_N32_Linux];
 #endif
-	if (nr >= __NR_64_Linux  && nr <= __NR_64_Linux + __NR_64_Linux_syscalls)
-		return (unsigned long)sys_call_table[nr - __NR_64_Linux];
+	if (nr >= __NR_N64_Linux  && nr <= __NR_N64_Linux + __NR_N64_Linux_syscalls)
+		return (unsigned long)sys_call_table[nr - __NR_N64_Linux];
 #ifdef CONFIG_MIPS32_O32
 	if (nr >= __NR_O32_Linux && nr <= __NR_O32_Linux + __NR_O32_Linux_syscalls)
 		return (unsigned long)sys32_call_table[nr - __NR_O32_Linux];
diff --git a/arch/mips/kernel/scall64-64.S b/arch/mips/kernel/scall64-n64.S
similarity index 99%
rename from arch/mips/kernel/scall64-64.S
rename to arch/mips/kernel/scall64-n64.S
index 358d959..497cd62 100644
--- a/arch/mips/kernel/scall64-64.S
+++ b/arch/mips/kernel/scall64-n64.S
@@ -53,8 +53,8 @@ NESTED(handle_sys64, PT_SIZE, sp)
 	bnez	t0, syscall_trace_entry
 
 syscall_common:
-	dsubu	t2, v0, __NR_64_Linux
-	sltiu   t0, t2, __NR_64_Linux_syscalls + 1
+	dsubu	t2, v0, __NR_N64_Linux
+	sltiu   t0, t2, __NR_N64_Linux_syscalls + 1
 	beqz	t0, illegal_syscall
 
 	dsll	t0, t2, 3		# offset into table
diff --git a/arch/mips/kvm/entry.c b/arch/mips/kvm/entry.c
index 16e1c93..d30f42c 100644
--- a/arch/mips/kvm/entry.c
+++ b/arch/mips/kvm/entry.c
@@ -34,12 +34,12 @@
 #define T3		11
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
+#if _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32
 #define T0		12
 #define T1		13
 #define T2		14
 #define T3		15
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
+#endif /* _MIPS_SIM == _MIPS_SIM_ABIN64 || _MIPS_SIM == _MIPS_SIM_NABI32 */
 
 #define S0		16
 #define S1		17
diff --git a/arch/mips/vdso/vdso.h b/arch/mips/vdso/vdso.h
index cfb1be4..1fd1692 100644
--- a/arch/mips/vdso/vdso.h
+++ b/arch/mips/vdso/vdso.h
@@ -10,7 +10,7 @@
 
 #include <asm/sgidefs.h>
 
-#if _MIPS_SIM != _MIPS_SIM_ABI64 && defined(CONFIG_64BIT)
+#if _MIPS_SIM != _MIPS_SIM_ABIN64 && defined(CONFIG_64BIT)
 
 /* Building 32-bit VDSO for the 64-bit kernel. Fake a 32-bit Kconfig. */
 #undef CONFIG_64BIT
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 8df7dd5..4d049e9 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -10,7 +10,7 @@
 
 #include <asm/sgidefs.h>
 
-#if _MIPS_SIM == _MIPS_SIM_ABI64
+#if _MIPS_SIM == _MIPS_SIM_ABIN64
 OUTPUT_FORMAT("elf64-tradlittlemips", "elf64-tradbigmips", "elf64-tradlittlemips")
 #elif _MIPS_SIM == _MIPS_SIM_NABI32
 OUTPUT_FORMAT("elf32-ntradlittlemips", "elf32-ntradbigmips", "elf32-ntradlittlemips")
-- 
1.9.1


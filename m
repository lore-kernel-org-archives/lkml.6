Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE8EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DBB222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JOKwebFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407358AbfBNPIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:08:00 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:51440 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406320AbfBNPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:07:53 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 920A410C147C;
        Thu, 14 Feb 2019 07:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550156873; bh=NoiNAa22J10pan+AWkCcCRfLZPGEaQROdX+ERdes3NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOKwebFDU6LuRnC9+APMKq3fCiaIkFD3ppt2rDeKwmwcJZzdCIIAk6wEAmi1GeeM5
         nmdZCpV8nOjCI0KrBABGx3OaKv1a2bT7ty4x5olWxNpGpV11LJRqLvtYpnSIRzUpEf
         MM0QCO1ZPeksFZVR+M1bk5GkOFAnZ7PsRGbQNj4GgVlp9I0er0ok4w+nzmOf0qiRPV
         vNep6YwCuOZWs67pi592/QQnBR+PUnE/l1R19LxU+/OfFLLeyD9yl8gBL1HP34ndFm
         iTpSDXsHGMUl4oIP6542cJL44iplgU+XsxzEuUW0caacvVROfK2ZJrdR6s5Di7JkHx
         5EEuqEV5F+Blg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.62])
        by mailhost.synopsys.com (Postfix) with ESMTP id D7FDFA0091;
        Thu, 14 Feb 2019 15:07:51 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH v2 2/2] ARC: enable uboot support unconditionally
Date:   Thu, 14 Feb 2019 18:07:45 +0300
Message-Id: <20190214150745.18773-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190214150745.18773-1-Eugeniy.Paltsev@synopsys.com>
References: <20190214150745.18773-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reworking U-boot args handling code and adding paranoid
arguments check we can eliminate CONFIG_ARC_UBOOT_SUPPORT and
enable uboot support unconditionally.

For JTAG case we can assume that core registers will come up
reset value of 0 or in worst case we rely on user passing
'-on=clear_regs' to Metaware debugger.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                        | 12 ------------
 arch/arc/configs/nps_defconfig          |  1 -
 arch/arc/configs/vdk_hs38_defconfig     |  1 -
 arch/arc/configs/vdk_hs38_smp_defconfig |  2 --
 arch/arc/kernel/head.S                  |  2 --
 arch/arc/kernel/setup.c                 |  2 --
 6 files changed, 20 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..f9534417b201 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -191,7 +191,6 @@ config NR_CPUS
 
 config ARC_SMP_HALT_ON_RESET
 	bool "Enable Halt-on-reset boot mode"
-	default y if ARC_UBOOT_SUPPORT
 	help
 	  In SMP configuration cores can be configured as Halt-on-reset
 	  or they could all start at same time. For Halt-on-reset, non
@@ -515,17 +514,6 @@ config ARC_DBG_TLB_PARANOIA
 
 endif
 
-config ARC_UBOOT_SUPPORT
-	bool "Support uboot arg Handling"
-	help
-	  ARC Linux by default checks for uboot provided args as pointers to
-	  external cmdline or DTB. This however breaks in absence of uboot,
-	  when booting from Metaware debugger directly, as the registers are
-	  not zeroed out on reset by mdb and/or ARCv2 based cores. The bogus
-	  registers look like uboot args to kernel which then chokes.
-	  So only enable the uboot arg checking/processing if users are sure
-	  of uboot being in play.
-
 config ARC_BUILTIN_DTB_NAME
 	string "Built in DTB"
 	help
diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
index 6e84060e7c90..621f59407d76 100644
--- a/arch/arc/configs/nps_defconfig
+++ b/arch/arc/configs/nps_defconfig
@@ -31,7 +31,6 @@ CONFIG_ARC_CACHE_LINE_SHIFT=5
 # CONFIG_ARC_HAS_LLSC is not set
 CONFIG_ARC_KVADDR_SIZE=402
 CONFIG_ARC_EMUL_UNALIGNED=y
-CONFIG_ARC_UBOOT_SUPPORT=y
 CONFIG_PREEMPT=y
 CONFIG_NET=y
 CONFIG_UNIX=y
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 1e59a2e9c602..e447ace6fa1c 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -13,7 +13,6 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
 CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
-CONFIG_ARC_UBOOT_SUPPORT=y
 CONFIG_ARC_BUILTIN_DTB_NAME="vdk_hs38"
 CONFIG_PREEMPT=y
 CONFIG_NET=y
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index b5c3f6c54b03..c82cdb10aaf4 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -15,8 +15,6 @@ CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
 # CONFIG_ARC_TIMERS_64BIT is not set
-# CONFIG_ARC_SMP_HALT_ON_RESET is not set
-CONFIG_ARC_UBOOT_SUPPORT=y
 CONFIG_ARC_BUILTIN_DTB_NAME="vdk_hs38_smp"
 CONFIG_PREEMPT=y
 CONFIG_NET=y
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index d45b862be05c..6fb1a35f9a29 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -90,7 +90,6 @@ ENTRY(stext)
 	st.ab   0, [r5, 4]
 1:
 
-#ifdef CONFIG_ARC_UBOOT_SUPPORT
 	; Uboot - kernel ABI
 	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
 	;    r1 = magic number (always zero as of now)
@@ -98,7 +97,6 @@ ENTRY(stext)
 	; These are handled later in handle_uboot_args()
 	st	r0, [@uboot_tag]
 	st	r2, [@uboot_arg]
-#endif
 
 	; setup "current" tsk and optionally cache it in dedicated r25
 	mov	r9, @init_task
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 88a885db9bb8..dbab88c8bbb3 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -487,7 +487,6 @@ void __init handle_uboot_args(void)
 	bool use_embedded_dtb = true;
 	bool append_cmdline = false;
 
-#ifdef CONFIG_ARC_UBOOT_SUPPORT
 	/* check that we know this tag */
 	if (uboot_tag != UBOOT_TAG_NONE &&
 	    uboot_tag != UBOOT_TAG_CMDLINE &&
@@ -513,7 +512,6 @@ void __init handle_uboot_args(void)
 		append_cmdline = true;
 
 ignore_uboot_args:
-#endif
 
 	if (use_embedded_dtb) {
 		machine_desc = setup_machine_fdt(__dtb_start);
-- 
2.14.5


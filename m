Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A94CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD76217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iDEqlXG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfBLPjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:39:49 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:60756 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfBLPjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:39:47 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9696110C02CB;
        Tue, 12 Feb 2019 07:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549985987; bh=jOb5suQ02ImrbAMWOcehfu6GPe+rY+M7dslxhLE/G+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDEqlXG6V/Dr1tQLNKwYNf40Q9QsOoCJ+eusLagBlmM/zo3K3wls/dBgFwWo3jkUq
         g0YaCk60DAwUMkZDPWod6Y+T15H9LRsttF/VgIV/io4sPbyznruJg7RcyfFBBxzams
         nhw1CVlp8YiBgs3HWXbA9WqMgKQbjRT8l1P6zsBbIsfwfSQh3LsKqR8yZU6IaCx0iF
         XR9J4yC+NRoSXEQRqv6Qv3MdSLVY0IN/KmO2hZ7j2gP2Yg2mTxncod5gALpCp6zqn0
         s0aICNuJTwMwBJDEt7T3qcMkY6LvfWiJSuIKTRLpzcP7VdZuuSpPTeOP8EgH8h9sqq
         sxTzdPMA0qvNQ==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.62])
        by mailhost.synopsys.com (Postfix) with ESMTP id D6E46A0090;
        Tue, 12 Feb 2019 15:39:45 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 2/2] ARC: enable uboot support unconditionally
Date:   Tue, 12 Feb 2019 18:39:32 +0300
Message-Id: <20190212153932.28371-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
References: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
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
index fccea361e896..4b0deaff001c 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -90,7 +90,6 @@ ENTRY(stext)
 	st.ab   0, [r5, 4]
 1:
 
-#ifdef CONFIG_ARC_UBOOT_SUPPORT
 	; Uboot - kernel ABI
 	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
 	;    r1 = magic number (always zero as of now)
@@ -99,7 +98,6 @@ ENTRY(stext)
 	st	r0, [@uboot_tag]
 	st      r1, [@uboot_magic]
 	st	r2, [@uboot_arg]
-#endif
 
 	; setup "current" tsk and optionally cache it in dedicated r25
 	mov	r9, @init_task
diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index 84d394a37e79..fff946b0ab4f 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -490,7 +490,6 @@ void __init handle_uboot_args(void)
 	bool use_embedded_dtb = true;
 	bool append_cmdline = false;
 
-#ifdef CONFIG_ARC_UBOOT_SUPPORT
 	/* check that we know this tag */
 	if (uboot_tag != UBOOT_TAG_NONE &&
 	    uboot_tag != UBOOT_TAG_CMDLINE &&
@@ -521,7 +520,6 @@ void __init handle_uboot_args(void)
 		append_cmdline = true;
 
 ignore_uboot_args:
-#endif
 
 	if (use_embedded_dtb) {
 		machine_desc = setup_machine_fdt(__dtb_start);
-- 
2.14.5


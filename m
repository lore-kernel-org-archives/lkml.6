Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972E7C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B3D208A3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B3D208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeKHVFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:05:22 -0500
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:38196 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726304AbeKHVFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:05:22 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id wA8BUSiu069438;
        Thu, 8 Nov 2018 19:30:28 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from app09.andestech.com (10.0.15.117) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 8 Nov 2018
 19:30:10 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <nylon7717@gmail.com>, Nylon Chen <nylon7@andestech.com>
Subject: [PATCH v3 2/2] nds32: support hardware prefetcher
Date:   Thu, 8 Nov 2018 19:28:15 +0800
Message-ID: <20181108112815.3712-1-nylon7@andestech.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.117]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com wA8BUSiu069438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We add a config for user to enable or disable this feature.
It can be used to control the hardware prefetch function.

Signed-off-by: Nylon Chen <nylon7@andestech.com>
---
 arch/nds32/Kconfig.cpu            | 7 +++++++
 arch/nds32/include/asm/bitfield.h | 6 ++++++
 arch/nds32/kernel/head.S          | 2 +-
 arch/nds32/kernel/setup.c         | 7 +++++++
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
index 6482ed877f97..f16edf0582b4 100644
--- a/arch/nds32/Kconfig.cpu
+++ b/arch/nds32/Kconfig.cpu
@@ -177,6 +177,13 @@ config CACHE_L2
 	  Say Y here to enable L2 cache if your SoC are integrated with L2CC.
 	  If unsure, say N.
 
+config HW_PRE
+	bool "Enable hardware prefetcher"
+	default y
+	help
+	  Say Y here to enable hardware prefetcher feature.
+	  Only when CPU_VER.REV >= 0x09 can support.
+
 menu "Memory configuration"
 
 choice
diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
index c1619730192a..7414fcbbab4e 100644
--- a/arch/nds32/include/asm/bitfield.h
+++ b/arch/nds32/include/asm/bitfield.h
@@ -740,14 +740,20 @@
 #define N13MISC_CTL_offRTP	1	/* Disable Return Target Predictor */
 #define N13MISC_CTL_offPTEPF	2	/* Disable HPTWK L2 PTE pefetch */
 #define N13MISC_CTL_offSP_SHADOW_EN	4	/* Enable shadow stack pointers */
+#define MISC_CTL_offHWPRE      11      /* Enable HardWare PREFETCH */
 /* bit 6, 9:31 reserved */
 
 #define N13MISC_CTL_makBTB	( 0x1  << N13MISC_CTL_offBTB )
 #define N13MISC_CTL_makRTP	( 0x1  << N13MISC_CTL_offRTP )
 #define N13MISC_CTL_makPTEPF	( 0x1  << N13MISC_CTL_offPTEPF )
 #define N13MISC_CTL_makSP_SHADOW_EN	( 0x1  << N13MISC_CTL_offSP_SHADOW_EN )
+#define MISC_CTL_makHWPRE_EN     ( 0x1  << MISC_CTL_offHWPRE )
 
+#ifdef CONFIG_HW_PRE
+#define MISC_init	(N13MISC_CTL_makBTB|N13MISC_CTL_makRTP|N13MISC_CTL_makSP_SHADOW_EN|MISC_CTL_makHWPRE_EN)
+#else
 #define MISC_init	(N13MISC_CTL_makBTB|N13MISC_CTL_makRTP|N13MISC_CTL_makSP_SHADOW_EN)
+#endif
 
 /******************************************************************************
  * PRUSR_ACC_CTL (Privileged Resource User Access Control Registers)
diff --git a/arch/nds32/kernel/head.S b/arch/nds32/kernel/head.S
index 2c8aac6201be..db64b78b1232 100644
--- a/arch/nds32/kernel/head.S
+++ b/arch/nds32/kernel/head.S
@@ -151,7 +151,7 @@ _tlb:
 #endif
 	mtsr    $r3, $TLB_MISC
 
-	mfsr    $r0, $MISC_CTL      ! Enable BTB and RTP and shadow sp
+	mfsr    $r0, $MISC_CTL      ! Enable BTB, RTP, shadow sp, and HW_PRE
 	ori     $r0, $r0, #MISC_init
 	mtsr    $r0, $MISC_CTL
 
diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index 4b774ca433a9..31d29d92478e 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -39,6 +39,7 @@
 #define HWCAP_FPU_DP		0x040000
 #define HWCAP_V2		0x080000
 #define HWCAP_DX_REGS		0x100000
+#define HWCAP_HWPRE		0x200000
 
 unsigned long cpu_id, cpu_rev, cpu_cfgid;
 bool has_fpu = false;
@@ -75,6 +76,7 @@ static const char *hwcap_str[] = {
 	"fpu_dp",
 	"v2",
 	"dx_regs",
+	"hw_pre",
 	NULL,
 };
 
@@ -221,6 +223,11 @@ static void __init setup_cpuinfo(void)
 	if (__nds32__mfsr(NDS32_SR_MSC_CFG) & MSC_CFG_mskL2C)
 		elf_hwcap |= HWCAP_L2C;
 
+#ifdef CONFIG_HW_PRE
+	if (__nds32__mfsr(NDS32_SR_MISC_CTL) & MISC_CTL_makHWPRE_EN)
+		elf_hwcap |= HWCAP_HWPRE;
+#endif
+
 	tmp = __nds32__mfsr(NDS32_SR_CACHE_CTL);
 	if (!IS_ENABLED(CONFIG_CPU_DCACHE_DISABLE))
 		tmp |= CACHE_CTL_mskDC_EN;
-- 
2.18.0


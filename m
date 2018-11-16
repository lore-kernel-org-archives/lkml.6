Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BB6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80C3208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GIFl59UZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80C3208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389996AbeKPXxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:53:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51092 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKPXxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:53:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAGDebgo076274;
        Fri, 16 Nov 2018 07:40:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542375637;
        bh=kpdHsnSaDksoYrwIWxUtPRPoIcpruLZ8WHjFcxMWpdY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GIFl59UZWltSdxfA/LqYqOrOzY9mFsoovv03sxNSd5+2lxeaPCo4pTap6P0REoFll
         Ni7yl5Qfd46rCFvEz7SUnfZjocSGM3g/vU2upcSbdLA5NzxuBHd1QAE3eEUS6fUelY
         5tsWlrHNZLVX1qC9p1oGA2IrDwiTCjQ01VXUmaSo=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAGDebGc116422
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Nov 2018 07:40:37 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 16
 Nov 2018 07:40:36 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 16 Nov 2018 07:40:36 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAGDeQws005228;
        Fri, 16 Nov 2018 07:40:34 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] ASoC: davinci-mcasp: Update PDIR (pin direction) register handling
Date:   Fri, 16 Nov 2018 15:41:39 +0200
Message-ID: <20181116134141.17396-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181116134141.17396-1-peter.ujfalusi@ti.com>
References: <20181116134141.17396-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When McASP is master and the PDIR for the clock pins are configured as
outputs before the clocking is configured it will output whatever clock
is generated at the moment internally.
The clock will switch to the correct rate only when the we start the clock
generators.

To avoid this we must only set the pin as output after the clock is
configured and enabled.

AXR pins configured as outputs behaves somehow interesting as well:
when McASP is not enabled and the pin is selected as output it will not
honor the DISMOD settings for the inactive state, but will pull the pin
down.

Add a new bitfield and mark the pins there which needs to be output and
set the pins only at the time when they will behave correctly.

On stream stop configure the pins back to input which makes them to obey
the global pin configuration regarding to pull up/down.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 88 ++++++++++++++++++++++++++-----
 sound/soc/davinci/davinci-mcasp.h | 29 ++++------
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 740030b4d37a..0f3911be1c8e 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -28,6 +28,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/math64.h>
+#include <linux/bitmap.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -95,6 +96,8 @@ struct davinci_mcasp {
 	int	sysclk_freq;
 	bool	bclk_master;
 
+	unsigned long pdir; /* Pin direction bitfield */
+
 	/* McASP FIFO related */
 	u8	txnumevt;
 	u8	rxnumevt;
@@ -169,6 +172,30 @@ static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)
 	return !(aclkxctl & TX_ASYNC) && rxfmctl & AFSRE;
 }
 
+static inline void mcasp_set_clk_pdir(struct davinci_mcasp *mcasp, bool enable)
+{
+	u32 bit = PIN_BIT_AMUTE;
+
+	for_each_set_bit_from(bit, &mcasp->pdir, PIN_BIT_AFSR + 1) {
+		if (enable)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+	}
+}
+
+static inline void mcasp_set_axr_pdir(struct davinci_mcasp *mcasp, bool enable)
+{
+	u32 bit;
+
+	for_each_set_bit(bit, &mcasp->pdir, PIN_BIT_AFSR) {
+		if (enable)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+	}
+}
+
 static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 {
 	if (mcasp->rxnumevt) {	/* enable FIFO */
@@ -220,6 +247,8 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 	/* Start clocks */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+	mcasp_set_clk_pdir(mcasp, true);
+
 	/* Activate serializer(s) */
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
@@ -230,6 +259,8 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 	       (cnt < 100000))
 		cnt++;
 
+	mcasp_set_axr_pdir(mcasp, true);
+
 	/* Release TX state machine */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
 	/* Release Frame Sync generator */
@@ -260,8 +291,10 @@ static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 	 * In synchronous mode stop the TX clocks if no other stream is
 	 * running
 	 */
-	if (mcasp_is_synchronous(mcasp) && !mcasp->streams)
+	if (mcasp_is_synchronous(mcasp) && !mcasp->streams) {
+		mcasp_set_clk_pdir(mcasp, false);
 		mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, 0);
+	}
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, 0);
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
@@ -287,6 +320,9 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 	 */
 	if (mcasp_is_synchronous(mcasp) && mcasp->streams)
 		val =  TXHCLKRST | TXCLKRST | TXFSRST;
+	else
+		mcasp_set_clk_pdir(mcasp, false);
+
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, val);
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
@@ -296,6 +332,8 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 
 		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
 	}
+
+	mcasp_set_axr_pdir(mcasp, false);
 }
 
 static void davinci_mcasp_stop(struct davinci_mcasp *mcasp, int stream)
@@ -446,8 +484,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		/* BCLK */
+		set_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		set_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		set_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		set_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
@@ -458,8 +501,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		/* BCLK */
+		set_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		set_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		clear_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		clear_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
@@ -470,8 +518,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		/* BCLK */
+		clear_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		clear_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		set_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		set_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 0;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -482,8 +535,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG,
-			       ACLKX | AFSX | ACLKR | AHCLKR | AFSR);
+		/* BCLK */
+		clear_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		clear_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		clear_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		clear_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 0;
 		break;
 	default:
@@ -598,11 +656,11 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	if (dir == SND_SOC_CLOCK_OUT) {
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+		set_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
 	} else {
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+		clear_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
 	}
 
 	mcasp->sysclk_freq = freq;
@@ -775,17 +833,21 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 			       mcasp->serial_dir[i]);
 		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
-			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AXR(i));
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       DISMOD_LOW, DISMOD_MASK);
+			set_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			tx_ser++;
 		} else if (mcasp->serial_dir[i] == RX_MODE &&
 					rx_ser < max_active_serializers) {
-			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AXR(i));
+			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			rx_ser++;
 		} else if (mcasp->serial_dir[i] == INACTIVE_MODE) {
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       SRMOD_INACTIVE, SRMOD_MASK);
+			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
+		} else if (mcasp->serial_dir[i] == TX_MODE) {
+			/* Unused TX pins, clear PDIR  */
+			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index afddc8010c54..acb024ab6a9d 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -108,27 +108,18 @@
 
 /*
  * DAVINCI_MCASP_PFUNC_REG - Pin Function / GPIO Enable Register Bits
- */
-#define AXR(n)		(1<<n)
-#define PFUNC_AMUTE	BIT(25)
-#define ACLKX		BIT(26)
-#define AHCLKX		BIT(27)
-#define AFSX		BIT(28)
-#define ACLKR		BIT(29)
-#define AHCLKR		BIT(30)
-#define AFSR		BIT(31)
-
-/*
  * DAVINCI_MCASP_PDIR_REG - Pin Direction Register Bits
+ * DAVINCI_MCASP_PDOUT_REG - Pin output in GPIO mode
+ * DAVINCI_MCASP_PDSET_REG - Pin input in GPIO mode
  */
-#define AXR(n)		(1<<n)
-#define PDIR_AMUTE	BIT(25)
-#define ACLKX		BIT(26)
-#define AHCLKX		BIT(27)
-#define AFSX		BIT(28)
-#define ACLKR		BIT(29)
-#define AHCLKR		BIT(30)
-#define AFSR		BIT(31)
+#define PIN_BIT_AXR(n)	(n)
+#define PIN_BIT_AMUTE	25
+#define PIN_BIT_ACLKX	26
+#define PIN_BIT_AHCLKX	27
+#define PIN_BIT_AFSX	28
+#define PIN_BIT_ACLKR	29
+#define PIN_BIT_AHCLKR	30
+#define PIN_BIT_AFSR	31
 
 /*
  * DAVINCI_MCASP_TXDITCTL_REG - Transmit DIT Control Register Bits
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


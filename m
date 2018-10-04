Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF723C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E9520877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsExVI+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E9520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeJDX3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:29:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38844 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJDX3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:29:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so3409412pgr.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nfec9crX6Z0IYXdkV6/aHbqKQJKhKWoFZUQmiFu93iM=;
        b=IsExVI+nmDfVHRox7Ls/zclyRmGpVUKhTOBC5zsbbtv7PH/mwlXAEH2NFETwFeoill
         yo8Z4fU5p1WgB5nztuhd82+AKC4rjw4X5izLIIkSRg/Ga/qOiHCUJi8vf3TV9VD2oLFB
         NV3axlezaSuITTtcKq0FBRDfDsWe5GYmvwsDOQsJRQGwGeggyZwIqM8E9blysXCGB/2O
         zofIZGLGaPHDxT3NOj9f+MLWZkHhFnenr7dUIMBnjv85WTfLxnXk+r+4wWLqJYlIPHec
         IxmwdPF8ZS9h7/EXXE64INzMXKRSnpxO6AaYvCHJLyi9lk98JB/SmTp63VpUqFvOg/2E
         6Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nfec9crX6Z0IYXdkV6/aHbqKQJKhKWoFZUQmiFu93iM=;
        b=ILhIOuNpawAf3Z16S0q7XZVufOt6gHXddqOH4KnHiXvzPEaepvxZJBvb2UCNI6+EZ2
         CVHGOptWGhINKuelkYJ+iqiVstpU85yZBO1ri5nz36miI1MLtrViseAs1i9XFMZR/ZN6
         +tOQehrOXVUEWWGSa16sAPFxSSOeShxdF5iq3osYAmmCkEVVQDuchHA/QSHnDmt04LIC
         wUL38NYu/EjgUt3BLn7bqNkIvg8P9aSAWDgW/69qDK5UG6jKcNkdVt4QGf2WOwO/ReFb
         xWe2x85YAtg9NTnQ+S+tmcWiROrCrEssAIQ/oSzl5GMXvRjQB1WYf/Fm2GFV+foToKQP
         jF5g==
X-Gm-Message-State: ABuFfoh0v6KMlsmZlJhaF/Ss0RQ3b2IircMZwS5JBMCUOZAB3PN/kDMF
        pjndmzDgb4SsygFmuWCp2/E=
X-Google-Smtp-Source: ACcGV62fASzj4prwQ7oB6GSlPTi3yBEMNIM3evC07hVZuHlsZ57NLQhM9Dgb6Y3yhjbFwOAY6RtIzw==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr7704526pfd.142.1538670945636;
        Thu, 04 Oct 2018 09:35:45 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id w23-v6sm5666097pgi.18.2018.10.04.09.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 09:35:45 -0700 (PDT)
Date:   Thu, 4 Oct 2018 22:05:38 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v6 1/3] staging: mt7621-mmc: Remove #if 0 blocks in sd.c
Message-ID: <d24db4fd34fc2347ba0512aaae04b937b942ac0e.1538670306.git.nishadkamdar@gmail.com>
References: <cover.1538670306.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1538670306.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if 0 code blocks and usages of
functions defined in the #if 0 blocks in sd.c.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 249 +-------------------------------
 1 file changed, 1 insertion(+), 248 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 4a216b9e6d91..f17beff2e3df 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -72,11 +72,6 @@
 #define GPIO_PULL_DOWN      (0)
 #define GPIO_PULL_UP        (1)
 
-#if 0 /* --- by chhung */
-#define MSDC_CLKSRC_REG     (0xf100000C)
-#define PDN_REG           (0xF1000010)
-#endif /* end of --- */
-
 #define DEFAULT_DEBOUNCE    (8)       /* 8 cycles */
 #define DEFAULT_DTOC        (40)      /* data timeout counter. 65536x40 sclk. */
 
@@ -100,26 +95,6 @@ static int cd_active_low = 1;
 //#define PERI_MSDC2_PDN    (17)
 //#define PERI_MSDC3_PDN    (18)
 
-#if 0 /* --- by chhung */
-/* gate means clock power down */
-static int g_clk_gate = 0;
-#define msdc_gate_clock(id) \
-	do {					       \
-		g_clk_gate &= ~(1 << ((id) + PERI_MSDC0_PDN));	\
-	} while (0)
-/* not like power down register. 1 means clock on. */
-#define msdc_ungate_clock(id) \
-	do {					    \
-		g_clk_gate |= 1 << ((id) + PERI_MSDC0_PDN);	\
-	} while (0)
-
-// do we need sync object or not
-void msdc_clk_status(int *status)
-{
-	*status = g_clk_gate;
-}
-#endif /* end of --- */
-
 /* +++ by chhung */
 struct msdc_hw msdc0_hw = {
 	.clk_src        = 0,
@@ -221,7 +196,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 				struct msdc_host, card_delaywork.work);
 	u32 inserted;
 	u32 status = 0;
-    //u32 change = 0;
 
 	spin_lock(&host->lock);
 
@@ -231,33 +205,17 @@ static void msdc_tasklet_card(struct work_struct *work)
 	else
 		inserted = (status & MSDC_PS_CDSTS) ? 1 : 0;
 
-#if 0
-	change = host->card_inserted ^ inserted;
-	host->card_inserted = inserted;
-
-	if (change && !host->suspend) {
-		if (inserted)
-			host->mmc->f_max = HOST_MAX_MCLK;  // work around
-		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
-	}
-#else  /* Make sure: handle the last interrupt */
+	/* Make sure: handle the last interrupt */
 	host->card_inserted = inserted;
 
 	if (!host->suspend) {
 		host->mmc->f_max = HOST_MAX_MCLK;
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
-#endif
 
 	spin_unlock(&host->lock);
 }
 
-#if 0 /* --- by chhung */
-/* For E2 only */
-static u8 clk_src_bit[4] = {
-	0, 3, 5, 7
-};
-
 static void msdc_select_clksrc(struct msdc_host *host, unsigned char clksrc)
 {
 	u32 val;
@@ -358,115 +316,6 @@ static void msdc_abort_data(struct msdc_host *host)
 	//}
 }
 
-#if 0 /* --- by chhung */
-static void msdc_pin_config(struct msdc_host *host, int mode)
-{
-	struct msdc_hw *hw = host->hw;
-	int pull = (mode == MSDC_PIN_PULL_UP) ? GPIO_PULL_UP : GPIO_PULL_DOWN;
-
-	/* Config WP pin */
-	if (hw->flags & MSDC_WP_PIN_EN) {
-		if (hw->config_gpio_pin) /* NULL */
-			hw->config_gpio_pin(MSDC_WP_PIN, pull);
-	}
-
-	switch (mode) {
-	case MSDC_PIN_PULL_UP:
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPU, 1); /* Check & FIXME */
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPD, 0); /* Check & FIXME */
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPU, 1);
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPD, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPU, 1);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPD, 0);
-		break;
-	case MSDC_PIN_PULL_DOWN:
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPU, 0); /* Check & FIXME */
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPD, 1); /* Check & FIXME */
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPD, 1);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPD, 1);
-		break;
-	case MSDC_PIN_PULL_NONE:
-	default:
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPU, 0); /* Check & FIXME */
-		//sdr_set_field(MSDC_PAD_CTL0, MSDC_PAD_CTL0_CLKPD, 0); /* Check & FIXME */
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL1, MSDC_PAD_CTL1_CMDPD, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPU, 0);
-		sdr_set_field(host->base + MSDC_PAD_CTL2, MSDC_PAD_CTL2_DATPD, 0);
-		break;
-	}
-
-}
-
-void msdc_pin_reset(struct msdc_host *host, int mode)
-{
-	struct msdc_hw *hw = (struct msdc_hw *)host->hw;
-	int pull = (mode == MSDC_PIN_PULL_UP) ? GPIO_PULL_UP : GPIO_PULL_DOWN;
-
-	/* Config reset pin */
-	if (hw->flags & MSDC_RST_PIN_EN) {
-		if (hw->config_gpio_pin) /* NULL */
-			hw->config_gpio_pin(MSDC_RST_PIN, pull);
-
-		if (mode == MSDC_PIN_PULL_UP)
-			sdr_clr_bits(host->base + EMMC_IOCON, EMMC_IOCON_BOOTRST);
-		else
-			sdr_set_bits(host->base + EMMC_IOCON, EMMC_IOCON_BOOTRST);
-	}
-}
-
-static void msdc_core_power(struct msdc_host *host, int on)
-{
-	if (on && host->core_power == 0) {
-		msdc_vcore_on(host);
-		host->core_power = 1;
-		msleep(1);
-	} else if (!on && host->core_power == 1) {
-		msdc_vcore_off(host);
-		host->core_power = 0;
-		msleep(1);
-	}
-}
-
-static void msdc_host_power(struct msdc_host *host, int on)
-{
-	if (on) {
-		//msdc_core_power(host, 1); // need do card detection.
-		msdc_pin_reset(host, MSDC_PIN_PULL_UP);
-	} else {
-		msdc_pin_reset(host, MSDC_PIN_PULL_DOWN);
-		//msdc_core_power(host, 0);
-	}
-}
-
-static void msdc_card_power(struct msdc_host *host, int on)
-{
-	if (on) {
-		msdc_pin_config(host, MSDC_PIN_PULL_UP);
-		//msdc_vdd_on(host);  // need todo card detection.
-		msleep(1);
-	} else {
-		//msdc_vdd_off(host);
-		msdc_pin_config(host, MSDC_PIN_PULL_DOWN);
-		msleep(1);
-	}
-}
-
-static void msdc_set_power_mode(struct msdc_host *host, u8 mode)
-{
-	if (host->power_mode == MMC_POWER_OFF && mode != MMC_POWER_OFF) {
-		msdc_host_power(host, 1);
-		msdc_card_power(host, 1);
-	} else if (host->power_mode != MMC_POWER_OFF && mode == MMC_POWER_OFF) {
-		msdc_card_power(host, 0);
-		msdc_host_power(host, 0);
-	}
-	host->power_mode = mode;
-}
-#endif /* end of --- */
-
 #ifdef CONFIG_PM
 /*
    register as callback function of WIFI(combo_sdio_register_pm) .
@@ -722,14 +571,6 @@ static unsigned int msdc_do_command(struct msdc_host   *host,
 	return cmd->error;
 }
 
-#if 0 /* --- by chhung */
-// DMA resume / start / stop
-static void msdc_dma_resume(struct msdc_host *host)
-{
-	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_RESUME, 1);
-}
-#endif /* end of --- */
-
 static void msdc_dma_start(struct msdc_host *host)
 {
 	u32 wints = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO | MSDC_INTEN_DATCRCERR;
@@ -828,12 +669,6 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	cmd  = mrq->cmd;
 	data = mrq->cmd->data;
 
-#if 0 /* --- by chhung */
-	//if(host->id ==1){
-	msdc_ungate_clock(host->id);
-	//}
-#endif /* end of --- */
-
 	if (!data) {
 		send_type = SND_CMD;
 		if (msdc_do_command(host, cmd, 1, CMD_TIMEOUT) != 0)
@@ -920,36 +755,8 @@ static int msdc_do_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 		host->blksz = 0;
-
-#if 0 // don't stop twice!
-		if (host->hw->flags & MSDC_REMOVABLE && data->error) {
-			msdc_abort_data(host);
-			/* reset in IRQ, stop command has issued. -> No need */
-		}
-#endif
-
 	}
 
-#if 0 /* --- by chhung */
-#if 1
-	//if(host->id==1) {
-	if (send_type == SND_CMD) {
-		if (cmd->opcode == MMC_SEND_STATUS) {
-			if ((cmd->resp[0] & CARD_READY_FOR_DATA) || (CARD_CURRENT_STATE(cmd->resp[0]) != 7))
-				msdc_gate_clock(host->id);
-		} else {
-			msdc_gate_clock(host->id);
-		}
-	} else {
-		if (read)
-			msdc_gate_clock(host->id);
-	}
-	//}
-#else
-	msdc_gate_clock(host->id);
-#endif
-#endif /* end of --- */
-
 	if (mrq->cmd->error)
 		host->error = 0x001;
 	if (mrq->data && mrq->data->error)
@@ -968,11 +775,7 @@ static int msdc_app_cmd(struct mmc_host *mmc, struct msdc_host *host)
 
 	memset(&cmd, 0, sizeof(struct mmc_command));
 	cmd.opcode = MMC_APP_CMD;
-#if 0   /* bug: we meet mmc->card is null when ACMD6 */
-	cmd.arg = mmc->card->rca << 16;
-#else
 	cmd.arg = host->app_cmd_arg;
-#endif
 	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
 
 	memset(&mrq, 0, sizeof(struct mmc_request));
@@ -1359,22 +1162,10 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 
-	//=== for sdio profile ===
-#if 0 /* --- by chhung */
-	u32 old_H32, old_L32, new_H32, new_L32;
-	u32 ticks = 0, opcode = 0, sizes = 0, bRx = 0;
-#endif /* end of --- */
-
 	WARN_ON(host->mrq);
 
 	/* start to process */
 	spin_lock(&host->lock);
-#if 0 /* --- by chhung */
-	if (sdio_pro_enable) {  //=== for sdio profile ===
-		if (mrq->cmd->opcode == 52 || mrq->cmd->opcode == 53)
-			GPT_GetCounter64(&old_L32, &old_H32);
-	}
-#endif /* end of --- */
 
 	host->mrq = mrq;
 
@@ -1394,26 +1185,6 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	host->mrq = NULL;
 
-#if 0 /* --- by chhung */
-	//=== for sdio profile ===
-	if (sdio_pro_enable) {
-		if (mrq->cmd->opcode == 52 || mrq->cmd->opcode == 53) {
-			GPT_GetCounter64(&new_L32, &new_H32);
-			ticks = msdc_time_calc(old_L32, old_H32, new_L32, new_H32);
-
-			opcode = mrq->cmd->opcode;
-			if (mrq->cmd->data) {
-				sizes = mrq->cmd->data->blocks * mrq->cmd->data->blksz;
-				bRx = mrq->cmd->data->flags & MMC_DATA_READ ? 1 : 0;
-			} else {
-				bRx = mrq->cmd->arg	& 0x80000000 ? 1 : 0;
-			}
-
-			if (!mrq->cmd->error)
-				msdc_performance(opcode, sizes, bRx, ticks);
-		}
-	}
-#endif /* end of --- */
 	spin_unlock(&host->lock);
 
 	mmc_request_done(mmc, mrq);
@@ -1480,7 +1251,6 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 	case MMC_POWER_UP:
-		// msdc_set_power_mode(host, ios->power_mode); /* --- by chhung */
 		break;
 	case MMC_POWER_ON:
 		host->power_mode = MMC_POWER_ON;
@@ -1552,9 +1322,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 	/* MSDC_CD_PIN_EN set for card */
 	if (host->hw->flags & MSDC_CD_PIN_EN) {
 		spin_lock_irqsave(&host->lock, flags);
-#if 0
-		present = host->card_inserted;  /* why not read from H/W: Fix me*/
-#else
 		// CD
 		present = readl(host->base + MSDC_PS) & MSDC_PS_CDSTS;
 		if (cd_active_low)
@@ -1562,7 +1329,6 @@ static int msdc_ops_get_cd(struct mmc_host *mmc)
 		else
 			present = present ? 1 : 0;
 		host->card_inserted = present;
-#endif
 		spin_unlock_irqrestore(&host->lock, flags);
 	} else {
 		present = 0; /* TODO? Check DAT3 pins for card detection */
@@ -1725,14 +1491,6 @@ static void msdc_enable_cd_irq(struct msdc_host *host, int enable)
 static void msdc_init_hw(struct msdc_host *host)
 {
 
-	/* Power on */
-#if 0 /* --- by chhung */
-	msdc_vcore_on(host);
-	msdc_pin_reset(host, MSDC_PIN_PULL_UP);
-	msdc_select_clksrc(host, hw->clk_src);
-	enable_clock(PERI_MSDC0_PDN + host->id, "SD");
-	msdc_vdd_on(host);
-#endif /* end of --- */
 	/* Configure to MMC/SD mode */
 	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_MODE, MSDC_SDMMC);
 
@@ -1764,10 +1522,6 @@ static void msdc_init_hw(struct msdc_host *host)
 
 	writel(0x00000000, host->base + MSDC_DAT_RDDLY1);
 	writel(0x00000000, host->base + MSDC_IOCON);
-#if 0 // use MT7620 default value: 0x403c004f
-	/* bit0 modified: Rx Data Clock Source: 1 -> 2.0*/
-	writel(0x003C000F, host->base + MSDC_PATCH_BIT0);
-#endif
 
 	if (readl(host->base + MSDC_ECO_VER) >= 4) {
 		if (host->id == 1) {
@@ -1834,7 +1588,6 @@ static void msdc_deinit_hw(struct msdc_host *host)
 
 	/* Disable card detection */
 	msdc_enable_cd_irq(host, 0);
-	// msdc_set_power_mode(host, MMC_POWER_OFF);   /* make sure power down */ /* --- by chhung */
 }
 
 /* init gpd and bd list in msdc_drv_probe */
-- 
2.17.1


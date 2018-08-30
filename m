Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360EBC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39A8205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39A8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeH3QNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:13:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49030 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeH3QNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:13:20 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hPr67nWrCx7y; Thu, 30 Aug 2018 14:11:09 +0200 (CEST)
Received: from nazgul.tnic (46-10-68-224.ip.btc-net.bg [46.10.68.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 242E01EC02AE;
        Thu, 30 Aug 2018 14:11:06 +0200 (CEST)
Date:   Thu, 30 Aug 2018 14:11:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org,
        swboyd@chromium.org
Subject: Re: [PATCH v3 3/4] drivers: edac: Add EDAC driver support for QCOM
 SoCs
Message-ID: <20180830121137.GD20005@nazgul.tnic>
References: <1535503347-20507-1-git-send-email-vnkgutta@codeaurora.org>
 <1535503347-20507-4-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535503347-20507-4-git-send-email-vnkgutta@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:42:26PM -0700, Venkata Narendra Kumar Gutta wrote:
> From: Channagoud Kadabi <ckadabi@codeaurora.org>
> 
> Add error reporting driver for Single Bit Errors (SBEs) and Double Bit
> Errors (DBEs). As of now, this driver supports error reporting for
> Last Level Cache Controller (LLCC) of Tag RAM and Data RAM. Interrupts
> are triggered when the errors happen in the cache, the driver handles
> those interrupts and dumps the syndrome registers.
> 
> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Co-developed-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  MAINTAINERS                        |   8 +
>  drivers/edac/Kconfig               |  22 ++
>  drivers/edac/Makefile              |   1 +
>  drivers/edac/qcom_edac.c           | 421 +++++++++++++++++++++++++++++++++++++
>  include/linux/soc/qcom/llcc-qcom.h |  24 +++
>  5 files changed, 476 insertions(+)
>  create mode 100644 drivers/edac/qcom_edac.c

We'd also need an agreement who picks up the whole pile?

Those guys:

Andy Gross <andy.gross@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
David Brown <david.brown@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)

and I ACK the EDAC driver or I do and they ACK the soc pieces.

I have a hunch the prior would be easier...

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a23427..0bff713 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5227,6 +5227,14 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/ti_edac.c
>  
> +EDAC-QUALCOMM
> +M:	Channagoud Kadabi <ckadabi@codeaurora.org>
> +M:	Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	linux-edac@vger.kernel.org
> +S:	Maintained
> +F:	drivers/edac/qcom_edac.c
> +
>  EDIROL UA-101/UA-1000 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 57304b2..df58957 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -460,4 +460,26 @@ config EDAC_TI
>  	  Support for error detection and correction on the
>            TI SoCs.
>  
> +config EDAC_QCOM
> +	tristate "QCOM EDAC Controller"
> +	depends on EDAC
> +	help
> +	  Support for error detection and correction on the
> +	  QCOM SoCs.
> +
> +	  This driver reports Single Bit Errors (SBEs) and Double Bit Errors (DBEs).
> +	  As of now, it supports error reporting for Last Level Cache Controller (LLCC)
> +	  of Tag RAM and Data RAM.
> +
> +config EDAC_QCOM_LLCC
> +	tristate "QCOM EDAC Controller for LLCC Cache"
> +	depends on EDAC_QCOM && QCOM_LLCC

This is just silly: two EDAC config options for a single driver and this
second one only does:

#ifdef EDAC_QCOM_LLCC
        { .compatible = "qcom,llcc-edac" },
#endif

What for?!

You do this:

config EDAC_QCOM
	depends on <architecture which this driver runs on> && QCOM_LLCC

and that's it.

...

> +/* Dump Syndrome registers data for Tag RAM, Data RAM bit errors*/
> +static int
> +dump_syn_reg_values(struct llcc_drv_data *drv, u32 bank, int err_type)
> +{
> +	struct llcc_edac_reg_data reg_data = edac_reg_data[err_type];
> +	int err_cnt, err_ways, ret, i;
> +	u32 synd_reg, synd_val;
> +
> +	for (i = 0; i < reg_data.reg_cnt; i++) {
> +		synd_reg = reg_data.synd_reg + (i * 4);
> +		ret = regmap_read(drv->regmap, drv->offsets[bank] + synd_reg,
> +				  &synd_val);
> +		if (ret)
> +			goto clear;

<----- newline here.

> +		edac_printk(KERN_CRIT, EDAC_LLCC, "%s: ECC_SYN%d: 0x%8x\n",
> +			    reg_data.name, i, synd_val);
> +	}
> +
> +	ret = regmap_read(drv->regmap,
> +			  drv->offsets[bank] + reg_data.count_status_reg,
> +			  &err_cnt);
> +	if (ret)
> +		goto clear;
> +
> +	err_cnt &= reg_data.count_mask;
> +	err_cnt >>= reg_data.count_shift;
> +	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error count: 0x%4x\n",
> +		    reg_data.name, err_cnt);
> +
> +	ret = regmap_read(drv->regmap,
> +			  drv->offsets[bank] + reg_data.ways_status_reg,
> +			  &err_ways);
> +	if (ret)
> +		goto clear;
> +
> +	err_ways &= reg_data.ways_mask;
> +	err_ways >>= reg_data.ways_shift;
> +
> +	edac_printk(KERN_CRIT, EDAC_LLCC, "%s: error ways: 0x%4x\n",
> +		    reg_data.name, err_ways);
> +
> +clear:
> +	return qcom_llcc_clear_error_status(err_type, drv);
> +}
> +
> +static int
> +dump_syn_reg(struct edac_device_ctl_info *edev_ctl, int err_type, u32 bank)
> +{
> +	struct llcc_drv_data *drv = edev_ctl->pvt_info;
> +	int ret;
> +
> +	ret = dump_syn_reg_values(drv, bank, err_type);
> +	if (ret)
> +		return ret;
> +
> +	switch (err_type) {
> +	case LLCC_DRAM_CE:
> +		edac_device_handle_ce(edev_ctl, 0, bank,
> +				      "LLCC Data RAM correctable Error");
> +		break;
> +	case LLCC_DRAM_UE:
> +		edac_device_handle_ue(edev_ctl, 0, bank,
> +				      "LLCC Data RAM uncorrectable Error");
> +		break;
> +	case LLCC_TRAM_CE:
> +		edac_device_handle_ce(edev_ctl, 0, bank,
> +				      "LLCC Tag RAM correctable Error");
> +		break;
> +	case LLCC_TRAM_UE:
> +		edac_device_handle_ue(edev_ctl, 0, bank,
> +				      "LLCC Tag RAM uncorrectable Error");
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		edac_printk(KERN_CRIT, EDAC_LLCC, "Unexpected error type: %d\n",
> +			    err_type);
> +	}
> +
> +	return ret;
> +}
> +
> +static irqreturn_t
> +llcc_ecc_irq_handler(int irq, void *edev_ctl)
> +{
> +	struct edac_device_ctl_info *edac_dev_ctl = edev_ctl;
> +	struct llcc_drv_data *drv = edac_dev_ctl->pvt_info;
> +	irqreturn_t irq_rc = IRQ_NONE;
> +	u32 drp_error, trp_error, i;
> +	bool irq_handled;
> +	int ret;
> +
> +	/* Iterate over the banks and look for Tag RAM or Data RAM errors */
> +	for (i = 0; i < drv->num_banks; i++) {
> +		ret = regmap_read(drv->regmap,
> +				  drv->offsets[i] + DRP_INTERRUPT_STATUS,
> +				  &drp_error);
> +
> +		if (!ret && (drp_error & SB_ECC_ERROR)) {
> +			edac_printk(KERN_CRIT, EDAC_LLCC,
> +				    "Single Bit Error detected in Data Ram\n");

"RAM" not "Ram". You have a couple of those wrong spellings.

Otherwise it is starting to look real nice, good!

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

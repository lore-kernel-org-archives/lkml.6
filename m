Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F3FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6A620867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6A620867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIEOtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:49:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56714 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeIEOtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:49:36 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NF5iv2OjboKz; Wed,  5 Sep 2018 12:19:44 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F2701EC02AE;
        Wed,  5 Sep 2018 12:19:44 +0200 (CEST)
Date:   Wed, 5 Sep 2018 12:19:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com,
        mchehab@kernel.org, leoyang.li@nxp.com, amit.kucheria@linaro.org,
        olof@lixom.net, sgoud@xilinx.com, anirudh@xilinx.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v5 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Message-ID: <20180905101935.GD2237@zn.tnic>
References: <1535722070-10394-1-git-send-email-manish.narani@xilinx.com>
 <1535722070-10394-4-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535722070-10394-4-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 06:57:49PM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. Also add support for ECC Error
> Injection in ZynqMP. The corrected and uncorrected error interrupts
> support is added. The Row, Column, Bank, Bank Group and Rank bits
> positions are determined via Address Map registers of Synopsys DDRC.
> Minor indentation changes are also done for better readability.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |    2 +-
>  drivers/edac/synopsys_edac.c | 1054 +++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 937 insertions(+), 119 deletions(-)

...

> @@ -222,11 +408,77 @@ static int synps_edac_geterror_info(struct synps_edac_priv *priv)
>  }
>  
>  /**
> + * zynqmp_geterror_info - Get the current ECC error info
> + * @priv:	DDR memory controller private instance data
> + *
> + * Get the ECC error information from the ECC registers and clear the error
> + * status bits in the ECC registers.
> + *
> + * Return: 0 if there is no error, otherwise return 1
> + */
> +static int zynqmp_geterror_info(struct synps_edac_priv *priv)
> +{
> +	void __iomem *base;
> +	struct synps_ecc_status *p;
> +	u32 regval, clearval = 0;
> +
> +	if (!priv)
> +		return 1;

Same as for the previous patch: why are you testing this since you're
dereferencing it before calling this function?

...

> @@ -258,10 +536,46 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  }
>  
>  /**
> + * synps_edac_intr_handler - Interrupt Handler for ECC interrupts
> + * @irq:        irq number
> + * @dev_id:     device id pointer
> + *
> + * This is the ISR called by EDAC core interrupt thread.

There's an "EDAC core interrupt thread"?!? This is the first time I hear
of it.

Try again.

> + * This is used to check and post ECC errors.
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
> + */
> +static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +	const struct synps_platform_data *p_data = priv->p_data;
> +	int status, regval;
> +
> +	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
> +	if (!(regval & ECC_CE_UE_INTR_MASK))
> +		return IRQ_NONE;
> +
> +	status = p_data->geterror_info(priv);
> +	if (status)
> +		return IRQ_NONE;
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	synps_edac_handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count ce %d ue %d\n",

"ce" and "ue" are also abbreviations and should be in caps.

...

> +static DEVICE_ATTR_RW(inject_data_error);
> +static DEVICE_ATTR_RW(inject_data_poison);
> +
> +static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
> +{
> +	int rc;
> +
> +	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
> +	if (rc < 0)
> +		return rc;
> +	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
> +	if (rc < 0)
> +		return rc;
> +	return 0;
> +}

I think I'm having a deja-vu:

Last time I said:

"More importantly, you need to put all that injection functionality
behind CONFIG_EDAC_DEBUG - you don't want to expose the injection
capabilities on a production machine."

and you said:

"I agree. I will update the same by keeping the above mentioned macro."

But maybe you've misunderstood me.

Grep the other EDAC drivers to find out how to hide the injection
functionality behind CONFIG_EDAC_DEBUG.

And maybe this patch is becoming huuge and too unwieldy to review
properly and for you to incorporate all the feedback.

Therefore, please split it in single patches, each of which is doing
different things:

1. fixup/change comments
2. add defines
3. add functionality X
4. add functionality Y
...
5. add injection
6. tie it all together

Apply some common sense and put yourself in the reviewer's shoes when
doing so.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

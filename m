Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246F7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCF4214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCF4214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeIXPy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:54:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbeIXPy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:54:26 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R8hm5KivhS5t; Mon, 24 Sep 2018 11:53:10 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC69500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:9500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C23391EC01F6;
        Mon, 24 Sep 2018 11:53:10 +0200 (CEST)
Date:   Mon, 24 Sep 2018 11:53:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mchehab@kernel.org,
        michal.simek@xilinx.com, leoyang.li@nxp.com, sudeep.holla@arm.com,
        amit.kucheria@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 7/7] edac: synopsys: Add Error Injection support for
 ZynqMP DDRC
Message-ID: <20180924095314.GB20187@zn.tnic>
References: <1537194305-9243-1-git-send-email-manish.narani@xilinx.com>
 <1537194305-9243-8-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1537194305-9243-8-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 07:55:05PM +0530, Manish Narani wrote:
> Add support for Error Injection for ZynqMP DDRC IP. For injecting
> errors, the Row, Column, Bank, Bank Group and Rank bits positions are
> determined via Address Map registers of Synopsys DDRC.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 423 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 417 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7ab5b9a..177b5c3 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -302,12 +302,18 @@ struct synps_ecc_status {
>  
>  /**
>   * struct synps_edac_priv - DDR memory controller private instance data.
> - * @baseaddr:	Base address of the DDR controller.
> - * @message:	Buffer for framing the event specific info.
> - * @stat:	ECC status information.
> - * @p_data:	Platform data
> - * @ce_cnt:	Correctable Error count.
> - * @ue_cnt:	Uncorrectable Error count.
> + * @baseaddr:		Base address of the DDR controller.
> + * @message:		Buffer for framing the event specific info.
> + * @stat:		ECC status information.
> + * @p_data:		Platform data
> + * @ce_cnt:		Correctable Error count.
> + * @ue_cnt:		Uncorrectable Error count.
> + * @poison_addr:	Data poison address.
> + * @row_shift:		Bit shifts for row bit.
> + * @col_shift:		Bit shifts for column bit.
> + * @bank_shift:		Bit shifts for bank bit.
> + * @bankgrp_shift:	Bit shifts for bank group bit.
> + * @rank_shift:		Bit shifts for rank bit.
>   */
>  struct synps_edac_priv {
>  	void __iomem *baseaddr;
> @@ -316,6 +322,14 @@ struct synps_edac_priv {
>  	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
> +#ifdef CONFIG_EDAC_DEBUG
> +	ulong poison_addr;
> +	u32 row_shift[18];
> +	u32 col_shift[14];
> +	u32 bank_shift[3];
> +	u32 bankgrp_shift[2];
> +	u32 rank_shift[1];
> +#endif
>  };
>  
>  /**
> @@ -842,7 +856,12 @@ static const struct synps_platform_data zynqmp_edac_def = {
>  	.get_mtype	= zynqmp_get_mtype,
>  	.get_dtype	= zynqmp_get_dtype,
>  	.get_eccstate	= zynqmp_get_eccstate,
> +#ifdef CONFIG_EDAC_DEBUG
> +	.quirks		= (DDR_ECC_INTR_SUPPORT |
> +			   DDR_ECC_DATA_POISON_SUPPORT),
> +#else
>  	.quirks		= DDR_ECC_INTR_SUPPORT,
> +#endif
>  };

Simplify that:

        .quirks         = (DDR_ECC_INTR_SUPPORT
#ifdef CONFIG_EDAC_DEBUG
                          | DDR_ECC_DATA_POISON_SUPPORT
#endif
                        ),

> +/**
> + * setup_address_map -	Set Address Map by querying ADDRMAP registers.
> + * @priv:		DDR memory controller private instance data.
> + *
> + * Set Address Map by querying ADDRMAP registers.
> + *
> + * Return: none.
> + */
> +static void setup_address_map(struct synps_edac_priv *priv)
> +{
> +	u32 addrmap[12];
> +	int index;
> +
> +	for (index = 0; index < 12; index++) {
> +		u32 addrmap_offset;
> +
> +		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
> +		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
> +	}
> +
> +	/* Set Row Address Map */
> +	setup_row_address_map(priv, addrmap);
> +
> +	/* Set Column Address Map */
> +	setup_column_address_map(priv, addrmap);
> +
> +	/* Set Bank Address Map */
> +	setup_bank_address_map(priv, addrmap);
> +
> +	/* Set Bank Group Address Map */
> +	setup_bg_address_map(priv, addrmap);
> +
> +	/* Set Rank Address Map */
> +	setup_rank_address_map(priv, addrmap);

All those comments which basically repeat the function name look useless
to me.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5863C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL9SSoys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6348520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeLEHwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEHwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:52:33 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D1C206B7;
        Wed,  5 Dec 2018 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543996353;
        bh=POJbcNFyOOfMywF6Y+A29Rjy0FkDckB2SS02kjfwMOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mL9SSoysF+KRFA+IjenpldCyqXQ1lODNJMRB6GZf5iu/JrBrz8I1taAI18wt2I+ej
         YAMiY1nM84V0icfKhp1HRJk3HwCMnrcXCIxNxsX/xHDQM6cbxgVrRZVmsEOS8+V1RO
         7pki6R/0pY4FM9j/VD471vcHkciiwH/TDIkhEog8=
Date:   Wed, 5 Dec 2018 15:51:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     thesven73@gmail.com
Cc:     TheSven73@googlemail.com, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bus: imx-weim: support multiple address ranges
 per child node
Message-ID: <20181205075145.GN3987@dragon>
References: <20181130205624.16227-1-TheSven73@googlemail.com>
 <20181130205624.16227-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130205624.16227-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 03:56:23PM -0500, thesven73@gmail.com wrote:
> From: Sven Van Asbroeck <TheSven73@googlemail.com>
> 
> Ensure that timing values for the child node are applied to
> all chip selects in the child's address ranges.
> 
> Note that this does not support multiple timing settings per
> child; this can be added in the future if required.
> 
> Example:
> &weim {
> 	acme@0,0 {
> 		compatible = "acme,whatever";
> 		reg = <0 0 0x100>, <0 0x400000 0x800>,
> 				<1 0x400000 0x800>;
> 		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
> 				0x00000000 0xa0000240 0x00000000>;
> 	};
> };

I'm not sure about that.  Shouldn't we have another child node for
different chip select, something like below?

&weim {
 	acme@0,0 {
 		compatible = "acme,whatever";
 		reg = <0 0 0x100>, <0 0x400000 0x800>;
 		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
 				      0x00000000 0xa0000240 0x00000000>;
 	};

 	acme@1,400000 {
 		compatible = "acme,whatever";
 		reg = <1 0x400000 0x800>;
 		fsl,weim-cs-timing = <0x024400b1 0x00001010 0x20081100
 				      0x00000000 0xa0000240 0x00000000>;
 	};

Shawn

> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> ---
>  drivers/bus/imx-weim.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index f01308172de9..24f22285395d 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -46,6 +46,7 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
>  };
>  
>  #define MAX_CS_REGS_COUNT	6
> +#define OF_REG_SIZE		3
>  
>  static const struct of_device_id weim_id_table[] = {
>  	/* i.MX1/21 */
> @@ -115,27 +116,40 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>  				    const struct imx_weim_devtype *devtype)
>  {
>  	u32 cs_idx, value[MAX_CS_REGS_COUNT];
> -	int i, ret;
> +	int i, ret, reg_idx, num_regs;
>  
>  	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
>  		return -EINVAL;
>  
> -	/* get the CS index from this child node's "reg" property. */
> -	ret = of_property_read_u32(np, "reg", &cs_idx);
> +	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
> +					 value, devtype->cs_regs_count);
>  	if (ret)
>  		return ret;
>  
> -	if (cs_idx >= devtype->cs_count)
> +	/*
> +	 * the child node's "reg" property may contain multiple address ranges,
> +	 * extract the chip select for each.
> +	 */
> +	num_regs = of_property_count_elems_of_size(np, "reg", OF_REG_SIZE);
> +	if (num_regs < 0)
> +		return num_regs;
> +	if (!num_regs)
>  		return -EINVAL;
> +	for (reg_idx = 0; reg_idx < num_regs; reg_idx++) {
> +		/* get the CS index from this child node's "reg" property. */
> +		ret = of_property_read_u32_index(np, "reg",
> +					reg_idx*OF_REG_SIZE, &cs_idx);
> +		if (ret)
> +			break;
>  
> -	ret = of_property_read_u32_array(np, "fsl,weim-cs-timing",
> -					 value, devtype->cs_regs_count);
> -	if (ret)
> -		return ret;
> +		if (cs_idx >= devtype->cs_count)
> +			return -EINVAL;
>  
> -	/* set the timing for WEIM */
> -	for (i = 0; i < devtype->cs_regs_count; i++)
> -		writel(value[i], base + cs_idx * devtype->cs_stride + i * 4);
> +		/* set the timing for WEIM */
> +		for (i = 0; i < devtype->cs_regs_count; i++)
> +			writel(value[i],
> +				base + cs_idx * devtype->cs_stride + i * 4);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 

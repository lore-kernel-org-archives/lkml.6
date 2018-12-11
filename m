Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76457C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C01C2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544509241;
	bh=9QfilBkoZKcwDjl63hdletdNAMnok1nXyPq3Y5/o7Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XD2gZ77j79gPaPx+xg+aXTIDbFNXcKtKSF0OpLTM6UWxM9WZiiHfxVwCWUNED/X8a
	 bDdzOuWS4VkEKir1NjQFJhSIbD7+MVqR14J6C5zVah96iiVRZFgiDcn6+i0TK1BdHF
	 gE1QHYoRfRTOHi76b8QD2KhTSAwPtWcb1Ud7rA2Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C01C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeLKGUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:20:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728717AbeLKGUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:20:39 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F1902081B;
        Tue, 11 Dec 2018 06:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544509238;
        bh=9QfilBkoZKcwDjl63hdletdNAMnok1nXyPq3Y5/o7Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qz/Judf8mSwl+AXoVXVAfPVY/2A9zETcOO3pcZqPfSZrX3QAgCptioYP7OX/4w0m8
         h1CcaRvktAI+7zPI4Azn5OpQf4IcfbM6ZKE5x9N84SS8QDm6ehl7yB0ISDpbZaDccB
         L6WK+szns7MZ2ZDlDnlwxEgC45mRBMvgk9X7btQA=
Date:   Tue, 11 Dec 2018 14:19:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     TheSven73@googlemail.com, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] bus: imx-weim: guard against timing configuration
 conflicts
Message-ID: <20181211061942.GX3987@dragon>
References: <20181206192633.25319-1-TheSven73@googlemail.com>
 <20181206192633.25319-4-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206192633.25319-4-TheSven73@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:26:33PM -0500, Sven Van Asbroeck wrote:
> When specifying weim child devices, there is a risk that more than
> one timing setting is specified for the same chip select.
> 
> The driver cannot support such a configuration.
> 
> In case of conflict, this patch will print a warning to the log,
> and will ignore the child node in question.
> 
> In this example, node acme@1 will be ignored, as it tries to modify
> timing settings for CS0:
> 
> &weim {
> 	acme@0 {
> 		compatible = "acme,whatever";
> 		reg = <0 0 0x100>;
> 		fsl,weim-cs-timing = <something>;
> 	};
> 	acme@1 {
> 		compatible = "acme,whatnot";
> 		reg = <0 0x500 0x100>;
> 		fsl,weim-cs-timing = <something else>;
> 	};
> };
> 
> However in this example, the driver will be happy:
> 
> &weim {
>         acme@0 {
>                 compatible = "acme,whatever";
>                 reg = <0 0 0x100>;
>                 fsl,weim-cs-timing = <something>;
>         };
>         acme@1 {
>                 compatible = "acme,whatnot";
>                 reg = <0 0x500 0x100>;
>                 fsl,weim-cs-timing = <something>;
>         };
> };
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> ---
>  drivers/bus/imx-weim.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 5452d22d1bd8..dfe74b8c512a 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -46,8 +46,18 @@ static const struct imx_weim_devtype imx51_weim_devtype = {
>  };
>  
>  #define MAX_CS_REGS_COUNT	6
> +#define MAX_CS_REGS		6

The macro name can easily confuse people with existing
MAX_CS_REGS_COUNT.  By its meaning, I guess MAX_CS_COUNT should be more
accurate?

>  #define OF_REG_SIZE		3
>  
> +struct cs_timing {
> +	bool is_applied;
> +	u32 regs[MAX_CS_REGS_COUNT];
> +};
> +
> +struct cs_timing_state {
> +	struct cs_timing cs[MAX_CS_REGS];
> +};
> +
>  static const struct of_device_id weim_id_table[] = {
>  	/* i.MX1/21 */
>  	{ .compatible = "fsl,imx1-weim", .data = &imx1_weim_devtype, },
> @@ -112,11 +122,14 @@ static int __init imx_weim_gpr_setup(struct platform_device *pdev)
>  }
>  
>  /* Parse and set the timing for this device. */
> -static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
> -				    const struct imx_weim_devtype *devtype)
> +static int __init weim_timing_setup(struct device *dev,
> +				    struct device_node *np, void __iomem *base,
> +				    const struct imx_weim_devtype *devtype,
> +				    struct cs_timing_state *ts)
>  {
>  	u32 cs_idx, value[MAX_CS_REGS_COUNT];
>  	int i, ret, reg_idx, num_regs;
> +	struct cs_timing *cst;
>  
>  	if (WARN_ON(devtype->cs_regs_count > MAX_CS_REGS_COUNT))
>  		return -EINVAL;
> @@ -145,10 +158,23 @@ static int __init weim_timing_setup(struct device_node *np, void __iomem *base,
>  		if (cs_idx >= devtype->cs_count)
>  			return -EINVAL;
>  
> +		/* prevent re-configuring a CS that's already been configured */
> +		cst = &ts->cs[cs_idx];
> +		if (cst->is_applied && memcmp(value, cst->regs,
> +					devtype->cs_regs_count*sizeof(u32))) {

There should be space around *.

> +			dev_err(dev, "fsl,weim-cs-timing conflict on %pOF", np);
> +			return -EINVAL;
> +		}
> +
>  		/* set the timing for WEIM */
>  		for (i = 0; i < devtype->cs_regs_count; i++)
>  			writel(value[i],
>  				base + cs_idx * devtype->cs_stride + i * 4);
> +		if (!cst->is_applied) {
> +			cst->is_applied = true;
> +			memcpy(cst->regs, value,
> +				devtype->cs_regs_count*sizeof(u32));

Ditto.

Shawn

> +		}
>  	}
>  
>  	return 0;
> @@ -162,6 +188,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  	const struct imx_weim_devtype *devtype = of_id->data;
>  	struct device_node *child;
>  	int ret, have_child = 0;
> +	struct cs_timing_state ts = {};
>  
>  	if (devtype == &imx50_weim_devtype) {
>  		ret = imx_weim_gpr_setup(pdev);
> @@ -170,7 +197,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  	}
>  
>  	for_each_available_child_of_node(pdev->dev.of_node, child) {
> -		ret = weim_timing_setup(child, base, devtype);
> +		ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
>  		if (ret)
>  			dev_warn(&pdev->dev, "%pOF set timing failed.\n",
>  				child);
> -- 
> 2.17.1
> 

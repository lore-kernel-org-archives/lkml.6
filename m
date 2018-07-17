Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D177ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2423B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Jvj+Tns9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2423B20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbeGQMkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:40:03 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:56632 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeGQMkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:40:03 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 58EC525BF06;
        Tue, 17 Jul 2018 22:07:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1531829260; bh=ZY4aBZ4PLEKoNhWoofZrgnO/iond7/PtMAEr3yEThuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jvj+Tns9aPXMCh+rP9jnq9u872Xq5f1kuawO0lY00KIRhkzPVVJ/jy7s6a10jcqt+
         MHSTNz+V0Xc+CfeKd8v3HdxAE7j+V1ebYyS4LgLUDZIwbd6wUTrRo3LfBC/0v9O3kN
         7Ifk2VTyHjoVcGvqdroJHsCuXvQSPKPXok6E1nM8=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id C3EB9940456; Tue, 17 Jul 2018 14:07:37 +0200 (CEST)
Date:   Tue, 17 Jul 2018 14:07:37 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Message-ID: <20180717120737.bipotpki3yhn6klf@verge.net.au>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
 <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:59:13AM +0100, Phil Edworthy wrote:
> The Synopsys I2C Controller has a bus clock, but typically SoCs hide this away.
> However, on some SoCs you need to explicity enable the bus clock in order to
> access the registers.
> Therefore, enable an optional bus clock specified by DT.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  drivers/i2c/busses/i2c-designware-common.c  | 14 +++++++++++++-
>  drivers/i2c/busses/i2c-designware-core.h    |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c |  2 ++
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index 48914df..4fa67d6 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -186,13 +186,25 @@ unsigned long i2c_dw_clk_rate(struct dw_i2c_dev *dev)
>  
>  int i2c_dw_prepare_clk(struct dw_i2c_dev *dev, bool prepare)
>  {
> +	int ret;
> +
>  	if (IS_ERR(dev->clk))
>  		return PTR_ERR(dev->clk);
>  
> -	if (prepare)
> +	if (prepare) {
> +		/* Optional bus clock */
> +		if (!IS_ERR(dev->busclk)) {

I suspect that error values stored in dev->busclk,  other than -ENOENT,
should be treated as errors.

> +			ret = clk_prepare_enable(dev->busclk);
> +			if (ret)
> +				return ret;
> +		}
> +
>  		return clk_prepare_enable(dev->clk);
> +	}
>  
>  	clk_disable_unprepare(dev->clk);
> +	clk_disable_unprepare(dev->busclk);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(i2c_dw_prepare_clk);
> diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
> index d690e64..10f905d 100644
> --- a/drivers/i2c/busses/i2c-designware-core.h
> +++ b/drivers/i2c/busses/i2c-designware-core.h
> @@ -239,6 +239,7 @@ struct dw_i2c_dev {
>  	void __iomem		*base;
>  	struct completion	cmd_complete;
>  	struct clk		*clk;
> +	struct clk		*busclk;
>  	struct reset_control	*rst;
>  	struct i2c_client		*slave;
>  	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 5660daf..64389fe 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -332,6 +332,8 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
>  	else
>  		i2c_dw_configure_master(dev);
>  
> +	/* Optional bus clock */
> +	dev->busclk = devm_clk_get(&pdev->dev, "bus");
>  	dev->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (!i2c_dw_prepare_clk(dev, true)) {
>  		dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
> -- 
> 2.7.4
> 

Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB08C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A96620875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="ZEJ/P/U5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A96620875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=horus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937800AbeFSMYh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:24:37 -0400
Received: from mail.horus.com ([78.46.148.228]:48988 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937502AbeFSMYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:24:35 -0400
Received: from [192.168.1.20] (193-83-224-126.adsl.highway.telekom.at [193.83.224.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (verified OK))
        by mail.horus.com (Postfix) with ESMTPSA id DB9896409A;
        Tue, 19 Jun 2018 14:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1529411074;
        bh=QmkftLUPeTw5xKNUnktNp05QlXSVTaPMINkqTa7OB3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZEJ/P/U5oxu7NqYOlDADxcBl1C6pdE9T3PHCCIXTP4PECoix3thqAwlNV/KKXoucH
         bXZ8yWhr+rGc9+0QBooABTcZv1yZJmnRcK798gPYDVEBNboO/TTLOu4M76zD4xxozU
         //DbDlwIL01WHmlO5ex02uBzcUFTZEML8vcGBfCA=
Received: by camel2.lan (Postfix, from userid 1000)
        id 3EEFE1C7228; Tue, 19 Jun 2018 14:24:33 +0200 (CEST)
Date:   Tue, 19 Jun 2018 14:24:33 +0200
From:   Matthias Reichl <hias@horus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, linus.walleij@linaro.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: arizona-ldo1: Use correct device to get
 enable GPIO
Message-ID: <20180619122432.6rgh4zjqrfk45ofs@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lgirdwood@gmail.com, linus.walleij@linaro.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20180619093245.1261-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619093245.1261-1-ckeepax@opensource.cirrus.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:32:45AM +0100, Charles Keepax wrote:
> Currently the enable GPIO is being looked up on the regulator
> device itself but that does not have its own DT node, this causes
> the lookup to fail and the regulator not to get its GPIO. The DT
> node is shared across the whole MFD and as such the lookup needs
> to happen on that parent device. Moving the lookup to the parent
> device also means devres can no longer be used as the life time
> would attach to the wrong device.
> 
> Fixes: e1739e86f0cb ("regulator: arizona-ldo1: Look up a descriptor and pass to the core")
> Reported-by: Matthias Reichl <hias@horus.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Tested-by: Matthias Reichl <hias@horus.com>

> Apologies for missing this again, we should have caught
> this in our testing and thanks for reporting it.

No problem, and thank you a lot for the quick fix!

During testing I noticed another minor change introduced by
commit e1739e86f0cb, see comment inline below.

> 
> Thanks,
> Charles
> 
>  drivers/regulator/arizona-ldo1.c | 27 ++++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
> index f6d6a4ad9e8a..a981896c056a 100644
> --- a/drivers/regulator/arizona-ldo1.c
> +++ b/drivers/regulator/arizona-ldo1.c
> @@ -36,6 +36,8 @@ struct arizona_ldo1 {
>  
>  	struct regulator_consumer_supply supply;
>  	struct regulator_init_data init_data;
> +
> +	struct gpio_desc *ena_gpiod;
>  };
>  
>  static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
> @@ -253,12 +255,17 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
>  		}
>  	}
>  
> -	/* We assume that high output = regulator off */
> -	config.ena_gpiod = devm_gpiod_get_optional(&pdev->dev, "wlf,ldoena",
> -						   GPIOD_OUT_HIGH);
> +	/* We assume that high output = regulator off
> +	 * Don't use devm, since we need to get against the parent device
> +	 * so clean up would happen at the wrong time
> +	 */
> +	config.ena_gpiod = gpiod_get_optional(parent_dev, "wlf,ldoena",
> +					      GPIOD_OUT_HIGH);

The WM5102 datasheet lists LDOENA as an active-high input,
so GPIOD_OUT_HIGH causes arizona-ldo1 to start up enabled.
Not sure about the other devices from the Arizona family.

I did some tests monitoring ldoena and reset gpios with my scope:

With commit e1739e86f0cb reverted ldoena changes from low to high
about 1.6ms before reset changes from low to high.

With your patch ldoena goes high about 11.5ms before reset goes high.

With your patch and GPIOD_OUT_HIGH changed to GPIOD_OUT_LOW
the delay is again about 1.6ms.

So I guess it'd be better to adjust the comment and change
to gpiod flag to GPIOD_OUT_LOW.

so long,

Hias

>  	if (IS_ERR(config.ena_gpiod))
>  		return PTR_ERR(config.ena_gpiod);
>  
> +	ldo1->ena_gpiod = config.ena_gpiod;
> +
>  	if (pdata->init_data)
>  		config.init_data = pdata->init_data;
>  	else
> @@ -276,6 +283,9 @@ static int arizona_ldo1_common_init(struct platform_device *pdev,
>  	of_node_put(config.of_node);
>  
>  	if (IS_ERR(ldo1->regulator)) {
> +		if (config.ena_gpiod)
> +			gpiod_put(config.ena_gpiod);
> +
>  		ret = PTR_ERR(ldo1->regulator);
>  		dev_err(&pdev->dev, "Failed to register LDO1 supply: %d\n",
>  			ret);
> @@ -334,8 +344,19 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int arizona_ldo1_remove(struct platform_device *pdev)
> +{
> +	struct arizona_ldo1 *ldo1 = platform_get_drvdata(pdev);
> +
> +	if (ldo1->ena_gpiod)
> +		gpiod_put(ldo1->ena_gpiod);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver arizona_ldo1_driver = {
>  	.probe = arizona_ldo1_probe,
> +	.remove = arizona_ldo1_remove,
>  	.driver		= {
>  		.name	= "arizona-ldo1",
>  	},
> -- 
> 2.11.0
> 

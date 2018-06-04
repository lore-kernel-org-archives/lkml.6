Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753005AbeFDMYQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 08:24:16 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35485 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeFDMYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 08:24:14 -0400
X-Google-Smtp-Source: ADUXVKLs5Hfb/MYRvaR+eVCpQnKzqKbZO2+2oc19AT3Nmchiv019+5eBzQ8qZbVdPCSdvur13Hzr3A==
Date: Mon, 4 Jun 2018 13:24:10 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 01/10] mfd: da9063: Fix failpath in core
Message-ID: <20180604122410.GA21163@dell>
References: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180602101155.26375-1-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jun 2018, Marek Vasut wrote:

> In case mfd_add_devices() fails, da9063_irq_exit() is not called to
> undo the IRQchip setup done by da9063_irq_init(). Fix this by adding
> the missing fail path.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Steve Twiss <stwiss.opensource@diasemi.com>
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
> V3: New patch
> ---
>  drivers/mfd/da9063-core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index 6c2870d4e754..8226ebd8b96d 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -229,10 +229,16 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
>  			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
>  			      NULL);
> -	if (ret)
> +	if (ret) {
>  		dev_err(da9063->dev, "Cannot add MFD cells\n");
> +		goto err_irq_exit;
> +	}
>  
>  	return ret;
> +
> +err_irq_exit:
> +	da9063_irq_exit(da9063);
> +	return ret;
>  }
>  
>  void da9063_device_exit(struct da9063 *da9063)

I haven't seen the later patches yet, so maybe the goto label expanded
on, but if it's not, then this would be better:

 -	if (ret)
 +	if (ret) {
  		dev_err(da9063->dev, "Cannot add MFD cells\n");
 +		da9063_irq_exit(da9063);
 +	}
  
  	return ret;
  }

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

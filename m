Return-Path: <cyrilbur@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519082423; cv=none;
        d=google.com; s=arc-20160816;
        b=rPZLumdN69qNeyLWwTeBd+XlaRe1s7jOyVNNs5Est0OcljIY1lYOA51z65ABJcMjZV
         8AMJbypPiXkdY0k0MRP/VO0C9EpZLOYQyglSw5EDeqVbUZvdXgchKkbWrCAqTRC/Gzge
         veJ6z86PuVBen/keaP8LbXhubyfJsLzvR7JXFZOFoo/fMy/Ah9hWxRjYqsFrUmXqtjBp
         4AXxFo3FENWs0b9sgfRvnpjmpwZhgHdHgwPE6YHjvRU6AZBgxUfkzpPIioSX1EJKZMIL
         TWnKWCysA6E5wSYSfqsjUWjGeSP4x5kTJngSv3/9OBMpQsZJ+cgGbxd2pzEM1yc7PoyZ
         7VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=ja4dponV35DLLmUYJsy8ngwXk5CbCiWF6CJizMjynZQ=;
        b=U8+xDIyzb6IlhASB0btxiBps4zbZZL//9MmqQCEQ+zy+KIS+azTxDJNxyATAG4aZdq
         IqSGB5T/15Ud6wXWFRfZsqzfZROB2fj7Mh+hWdAeCuX7FO5T3fhoBUD0H+Kx8YCfTYzh
         P0+L5n0ygZgoV4en4x5iuALMCy7r4Hq4aSXBF4zDt3/0bjTlh19NOxDrc0yWqQ/YiHK9
         K+GibLfz7YmVNEzq7a7jw+qrY0Qc/dyNcWrd/0x8LrdDIN8OFq3syPxEwl4yuj0+Zpqg
         XotswPZQlrqTKM+n/V//rO0M8smDyod+Zs7NHoUvt8WQF2rS9NdTJ3I/5hb5/3+IWM3L
         CWeA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mZEOvXGA;
       spf=pass (google.com: domain of cyrilbur@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cyrilbur@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mZEOvXGA;
       spf=pass (google.com: domain of cyrilbur@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=cyrilbur@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2240lAsKEavxJbEJPnqB2nAHscpEWxtJB8iQRP4HYvAh1wPlsDnlclfhVxkvGE7lDAe8Qn3fAA==
Message-ID: <1519082417.6563.1.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] misc: aspeed-lpc: Request and enable LPC clock
From: Cyril Bur <cyrilbur@gmail.com>
To: Joel Stanley <joel@jms.id.au>, Lee Jones <lee.jones@linaro.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Lei YU <mine260309@gmail.com>
Date: Tue, 20 Feb 2018 10:20:17 +1100
In-Reply-To: <20180219072422.22733-3-joel@jms.id.au>
References: <20180219072422.22733-1-joel@jms.id.au>
	 <20180219072422.22733-3-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592813259990001062?=
X-GMAIL-MSGID: =?utf-8?q?1592873371048006446?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-19 at 17:54 +1030, Joel Stanley wrote:
> The LPC device needs to ensure it's clock is enabled before it can do
> anything.
> 
> In the past the clock was enabled and left running by u-boot, however
> Linux now has an upstream clock driver that disables unused clocks.
> 
> Tested-by: Lei YU <mine260309@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  drivers/misc/aspeed-lpc-ctrl.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
> index b5439643f54b..1827b7aa6674 100644
> --- a/drivers/misc/aspeed-lpc-ctrl.c
> +++ b/drivers/misc/aspeed-lpc-ctrl.c
> @@ -7,6 +7,7 @@
>   * 2 of the License, or (at your option) any later version.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/miscdevice.h>
>  #include <linux/mm.h>
> @@ -26,6 +27,7 @@
>  struct aspeed_lpc_ctrl {
>  	struct miscdevice	miscdev;
>  	struct regmap		*regmap;
> +	struct clk		*clk;
>  	phys_addr_t		mem_base;
>  	resource_size_t		mem_size;
>  	u32		pnor_size;
> @@ -221,16 +223,33 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	lpc_ctrl->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(lpc_ctrl->clk)) {
> +		dev_err(dev, "couldn't get clock\n");
> +		return PTR_ERR(lpc_ctrl->clk);
> +	}
> +	rc = clk_prepare_enable(lpc_ctrl->clk);
> +	if (rc) {
> +		dev_err(dev, "couldn't enable clock\n");
> +		return rc;
> +	}
> +
>  	lpc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
>  	lpc_ctrl->miscdev.name = DEVICE_NAME;
>  	lpc_ctrl->miscdev.fops = &aspeed_lpc_ctrl_fops;
>  	lpc_ctrl->miscdev.parent = dev;
>  	rc = misc_register(&lpc_ctrl->miscdev);
> -	if (rc)
> +	if (rc) {
>  		dev_err(dev, "Unable to register device\n");
> -	else
> -		dev_info(dev, "Loaded at %pr\n", &resm);
> +		goto err;
> +	}
> +
> +	dev_info(dev, "Loaded at %pr\n", &resm);
> +
> +	return 0;
>  
> +err:
> +	clk_disable_unprepare(lpc_ctrl->clk);
>  	return rc;
>  }
>  
> @@ -239,6 +258,7 @@ static int aspeed_lpc_ctrl_remove(struct platform_device *pdev)
>  	struct aspeed_lpc_ctrl *lpc_ctrl = dev_get_drvdata(&pdev->dev);
>  
>  	misc_deregister(&lpc_ctrl->miscdev);
> +	clk_disable_unprepare(lpc_ctrl->clk);
>  
>  	return 0;
>  }

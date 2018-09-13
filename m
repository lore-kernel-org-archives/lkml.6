Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45867C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D896820853
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJgPy1Ev"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D896820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeINBgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:36:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43707 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeINBgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:36:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id f66-v6so3103523plb.10;
        Thu, 13 Sep 2018 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VavW6Fp8eytJTv1MtQ7agZO5Ltq4cw86Oxx0YjnPPiA=;
        b=JJgPy1Ev3DJdfFLy9dHfF3+FTUvB82dqXUviMUhmBAcsMcgpQRkxZNUsDsfa4xCwFq
         FPJhGBwDBzLJI85gEpHUc+92g8mFXI4zDGAY+bcgzQ33oZKR2IZZqMfomJn1F4R991Nz
         NdRDfptIrRx/0kZMDob5nsk6z0sCABFRyIP8PQvPC/NrVLbhSIZyGXQizAxUyz8llqp+
         r2V+tYlulty1lYLN/abVBXIAH77jvQ8iEoiv4crEOYe6+nnxFPgH5XqxYAcIhESdLs9F
         kAs4cLgG2QOqy6cpwvxa0hFbRhMTnaNe3M4JQjFQXBYDqaYJ5C+DsmRfx2vVcV0oYBs/
         kI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VavW6Fp8eytJTv1MtQ7agZO5Ltq4cw86Oxx0YjnPPiA=;
        b=PpLDDLxaQ+FpxR9dw5s0zZ7mpk4ciHeNX3LgQmKKygKsaVMDDkTLKvg34YtR6DEquz
         voUNQGNSrwzGjN3pXsewgp9Q8k2xhqpSAmMc7B5YP1vm0mPRLfNXiimcla0zcV3xfJAC
         hAoQ7n5Rly0/WMGizQtqsEjuJWPACSpz50A01ts+nueYPUjRhif9GF/0SOEPX33414zB
         TBOwLz5yBe/zq+lc6eT2kk465PQPbVLpjRiiihE/CSOboGT3qpdpEKf/jd6naxRnC5WJ
         X+k+g+FkGtaGOrHPFmX37/85tx6id11PZNEqOlDlEn85Vyk+BWT6DTyq0sGA4pNolUcg
         CSYw==
X-Gm-Message-State: APzg51AeD/CDFfLCgy8N/yTFCxCLiJHFkX1zAm/plEF3y8ko2+K2lr+Z
        qKMxsqinFzQzOdcj0H5u/jE=
X-Google-Smtp-Source: ANB0VdaPrL3NDwQIWqBrN4ETQ3LfFPsVcUbpeOzPB59PpoWWrYG/Q0VRa2imA2FpvMrycvPnwFZrdg==
X-Received: by 2002:a17:902:26c:: with SMTP id 99-v6mr8783066plc.341.1536870342336;
        Thu, 13 Sep 2018 13:25:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 71-v6sm6656825pfx.182.2018.09.13.13.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 13:25:41 -0700 (PDT)
Date:   Thu, 13 Sep 2018 13:25:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Radu Rendec <radu.rendec@gmail.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: mpc8xxx: provide boot status
Message-ID: <20180913202540.GA18019@roeck-us.net>
References: <055ff141d12942ed5750cc9e803e730de0e38c93.1536778520.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055ff141d12942ed5750cc9e803e730de0e38c93.1536778520.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 08:07:21AM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver supports the following platforms:
> - mpc8xx
> - mpc83xx
> - mpc86xx
> 
> Those three platforms have a 32 bits register which provides the
> reason of the last boot, including whether it was caused by the
> watchdog.
> 
> mpc8xx: Register RSR, bit SWRS (bit 3)
> mpc83xx: Register RSR, bit SWRS (bit 28)
> mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)
> 
> This patch maps the register as defined in the device tree and updates
> wdt.bootstatus based on the value of the watchdog related bit. Then
> the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.
> 
> Hereunder is an exemple of devicetree for mpc8xx,

example

> the Reset Status Register being at offset 0x288:
> 
> 		WDT: watchdog@0 {
> 			compatible = "fsl,mpc823-wdt";
> 			reg = <0x0 0x10 0x288 0x4>;

This isn't documented anywhere, and no one wil know how to use it.
So far that was grandfathered in, but with more complex usage
it really needs to be documented.

> 		};
> 
> On the mpc83xx, RSR is at offset 0x910
> On the mpc86xx, RSTRSCR is at offset 0xe0094
> 
> Suggested-by: Radu Rendec <radu.rendec@gmail.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index aca2d6323f8a..2951a485a6b4 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -49,10 +49,12 @@ struct mpc8xxx_wdt {
>  struct mpc8xxx_wdt_type {
>  	int prescaler;
>  	bool hw_enabled;
> +	u32 rsr_mask;
>  };
>  
>  struct mpc8xxx_wdt_ddata {
>  	struct mpc8xxx_wdt __iomem *base;
> +	u32 __iomem *rsr;
>  	struct watchdog_device wdd;
>  	spinlock_t lock;
>  	u16 swtc;
> @@ -137,6 +139,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  	struct mpc8xxx_wdt_ddata *ddata;
>  	u32 freq = fsl_get_sys_freq();
>  	bool enabled;
> +	struct device *dev = &ofdev->dev;

If you introduce this variable, please use it everywhere
in the function.

>  
>  	wdt_type = of_device_get_match_data(&ofdev->dev);
>  	if (!wdt_type)
> @@ -160,6 +163,22 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  		return -ENODEV;
>  	}
>  
> +	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
> +	ddata->rsr = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ddata->rsr)) {
> +		dev_info(dev, "Could not map reset status register");

Please, no such message. It would start to show up everywhere unless
devicetree files are updated, which likely won't happen. Then we get
bogged down by people asking where this message suddenly comes from.

> +	} else {
> +		u32 rsr_v = in_be32(ddata->rsr);
> +		bool status = rsr_v & wdt_type->rsr_mask;
> +
> +		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
> +		 /* clear reset status bits related to watchdog time */
> +		out_be32(ddata->rsr, wdt_type->rsr_mask);
> +
> +		dev_info(dev, "Last boot was %s by watchdog (RSR = 0x%8.8x)\n",
> +			 status ? "caused" : "not caused", rsr_v);

The hex value of RSR may be interesting for developers, but not for users.
Please drop.

Also, "caused" is redundant. Add it to the base string and add "not "
when needed.

> +	}
> +
>  	spin_lock_init(&ddata->lock);
>  
>  	ddata->wdd.info = &mpc8xxx_wdt_info,
> @@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.compatible = "mpc83xx_wdt",
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
> +			.rsr_mask = BIT(3), /* RSR Bit 28 */

The comment is quite useless. How does BIT(3) match RSR bit 28 ?
I am sure it is because the HW manual counts bits the other way,
but here it is just confusing and thus doesn't add value unless
you provide additional context.

>  		},
>  	},
>  	{
> @@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x10000,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(20), /* RSTRSCR Bit 11 */
>  		},
>  	},
>  	{
> @@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
>  		.data = &(struct mpc8xxx_wdt_type) {
>  			.prescaler = 0x800,
>  			.hw_enabled = true,
> +			.rsr_mask = BIT(28), /* RSR Bit 3 */
>  		},
>  	},
>  	{},
> -- 
> 2.13.3
> 

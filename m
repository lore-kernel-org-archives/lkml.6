Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AFAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8002206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EHVV+ubU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfBLHuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:50:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38272 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBLHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:50:02 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C7nvYS123938;
        Tue, 12 Feb 2019 01:49:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549957797;
        bh=NblLj6ZlZlZaQ9vCsm4vs/5cqfQoulS3dM4tsow0qtg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EHVV+ubUbT4q5iiDVjlXv5QxIzTVWhDqNhQYOnQ0LiJFFg8ggH/CsaxGpFvR5INLW
         7IYncxAEJBxNtm5C3KOE6jSmjvVzuhvE8T5K//HO4I9ep+soej0n1CFU/EmleA1AI0
         D9Ho4xbokW+FHoqFvDG5Yh+kgk1cPjJqVO5HW2sY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C7nvPj066401
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 01:49:57 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 01:49:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 01:49:54 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C7nrbL009307;
        Tue, 12 Feb 2019 01:49:53 -0600
Subject: Re: [PATCH] mfd: twl6040: Fix device init errors for ACCCTL register
To:     Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Florian Vaussard <florian.vaussard@epfl.ch>
References: <20190211225726.38355-1-tony@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d749644a-95ae-822d-f7cb-69010a8f71e0@ti.com>
Date:   Tue, 12 Feb 2019 09:50:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211225726.38355-1-tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2019 0.57, Tony Lindgren wrote:
> I noticed that we can get a -EREMOTEIO errors on at least omap4 duovero:
> 
> twl6040 0-004b: Failed to write 2d = 19: -121
> 
> And then any following register access will produce errors.
> 
> There 2d offset above is register ACCCTL that gets written on twl6040
> powerup. With error checking added to the related regcache_sync() call,
> the -EREMOTEIO error is reproducable on twl6040 powerup at least
> duovero.
> 
> To fix the error, we need to wait until twl6040 is accessible after the
> powerup. Based on tests on omap4 duovero, we need to wait over 8ms after
> powerup before register write will complete without failures. Let's also
> make sure we warn about possible errors too.
> 
> Note that we have twl6040_patch[] reg_sequence with the ACCCTL register
> configuration and regcache_sync() will write the new value to ACCCTL.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/twl6040.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -322,8 +322,19 @@ int twl6040_power(struct twl6040 *twl6040, int on)
>  			}
>  		}
>  
> +		/*
> +		 * Register access can produce errors after power-up unless we
> +		 * wait at least 8ms based on measurements on duovero.
> +		 */
> +		usleep_range(10000, 12000);
> +
>  		/* Sync with the HW */
> -		regcache_sync(twl6040->regmap);
> +		ret = regcache_sync(twl6040->regmap);
> +		if (ret) {
> +			dev_err(twl6040->dev, "%s register write failed: %i\n",
> +				__func__, ret);
> +			goto out;
> +		}
>  
>  		/* Default PLL configuration after power up */
>  		twl6040->pll = TWL6040_SYSCLK_SEL_LPPLL;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

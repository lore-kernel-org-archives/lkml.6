Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B8C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75A220685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mJrGY9Lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75A220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeKHULz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:11:55 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52458 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeKHULz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:11:55 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8AagPe025320;
        Thu, 8 Nov 2018 04:36:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541673402;
        bh=XuDMRopSgPrsNOHjWn5CvcleVHxhfIg8XLdX4pSoK0g=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=mJrGY9LtmPDZdREiJADKWc2oUdQfbJZEkKuZi3jMOmI1rTaqncM9TvXEBNQCzZ13C
         K4STfbHaQ8bUSjVlycGX+qVl6QfOPeBoJBmFf+WL99D7+SIhDRhdwz5h7YMa1wPmIA
         3adHYAPQQvbcbG9Ka+rDQnflEonk9iTDWtnSMLic=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8AagP2102591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 04:36:42 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 04:36:41 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 04:36:41 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8Aabp0028880;
        Thu, 8 Nov 2018 04:36:38 -0600
Subject: Re: [PATCH 1/2] clk: ti: add a usecount for autoidle
To:     Andreas Kemnade <andreas@kemnade.info>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <tony@atomide.com>,
        <letux-kernel@openphoenux.org>
References: <20181004203817.22101-1-andreas@kemnade.info>
 <20181004203817.22101-2-andreas@kemnade.info>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <23cbfc19-20d9-99f0-c086-e782cc36de34@ti.com>
Date:   Thu, 8 Nov 2018 12:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181004203817.22101-2-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 23:38, Andreas Kemnade wrote:
> We have the scenario that first autoidle is disabled for all clocks,
> then it is disabled for selected ones and then enabled for all. So
> we should have some counting here, also according to the
> comment in  _setup_iclk_autoidle()
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++--------
>   include/linux/clk/ti.h    |  1 +
>   2 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> index 7bb9afbe4058..bb6cff168e73 100644
> --- a/drivers/clk/ti/autoidle.c
> +++ b/drivers/clk/ti/autoidle.c
> @@ -37,6 +37,14 @@ struct clk_ti_autoidle {
>   static LIST_HEAD(autoidle_clks);
>   static LIST_HEAD(clk_hw_omap_clocks);
>   
> +/*
> + * we have some non-atomic read/write
> + * operations behind it, so lets
> + * take one mutex for handling autoidle
> + * of all clocks
> + */
> +static DEFINE_MUTEX(autoidle_mutex);

Why mutex? This prevents calling the autoidle APIs from atomic context. 
Did you check the mutex debug kernel configs with this?

This may cause problems with the runtime PM entries to the code at least.


> +
>   /**
>    * omap2_clk_deny_idle - disable autoidle on an OMAP clock
>    * @clk: struct clk * to disable autoidle for
> @@ -48,8 +56,13 @@ int omap2_clk_deny_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->deny_idle)
> -		c->ops->deny_idle(c);
> +	if (c->ops && c->ops->deny_idle) {
> +		mutex_lock(&autoidle_mutex);
> +		c->autoidle_count--;
> +		if (c->autoidle_count == -1)

I think you should swap the arithmetics here, all the other usecounters 
use positive values, here you enter deep to the negative side when 
autoidle is denied by multiple users, which might be confusing.

-Tero

> +			c->ops->deny_idle(c);
> +		mutex_unlock(&autoidle_mutex);
> +	}
>   	return 0;
>   }
>   
> @@ -64,8 +77,13 @@ int omap2_clk_allow_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->allow_idle)
> -		c->ops->allow_idle(c);
> +	if (c->ops && c->ops->allow_idle) {
> +		mutex_lock(&autoidle_mutex);
> +		c->autoidle_count++;
> +		if (c->autoidle_count == 0)
> +			c->ops->allow_idle(c);
> +		mutex_unlock(&autoidle_mutex);
> +	}
>   	return 0;
>   }
>   
> @@ -201,8 +219,7 @@ int omap2_clk_enable_autoidle_all(void)
>   	struct clk_hw_omap *c;
>   
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
> -		if (c->ops && c->ops->allow_idle)
> -			c->ops->allow_idle(c);
> +		omap2_clk_allow_idle(c->hw.clk);
>   
>   	_clk_generic_allow_autoidle_all();
>   
> @@ -223,8 +240,7 @@ int omap2_clk_disable_autoidle_all(void)
>   	struct clk_hw_omap *c;
>   
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
> -		if (c->ops && c->ops->deny_idle)
> -			c->ops->deny_idle(c);
> +		omap2_clk_deny_idle(c->hw.clk);
>   
>   	_clk_generic_deny_autoidle_all();
>   
> diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
> index a8faa38b1ed6..c460355419c0 100644
> --- a/include/linux/clk/ti.h
> +++ b/include/linux/clk/ti.h
> @@ -159,6 +159,7 @@ struct clk_hw_omap {
>   	const char		*clkdm_name;
>   	struct clockdomain	*clkdm;
>   	const struct clk_hw_omap_ops	*ops;
> +	int autoidle_count;
>   };
>   
>   /*
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

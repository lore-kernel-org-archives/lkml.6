Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C1BC64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFF62082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LURBpQo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCFF62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJDVeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:34:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57744 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJDVeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:34:23 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94EePDa077483;
        Thu, 4 Oct 2018 09:40:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538664025;
        bh=aPovNyvTfDgVh/o+GOf22MxoMVCBXn7eQkdU3zejh88=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=LURBpQo4VUZJCEvxOMK++3vSGamiN3hXlVvviVc3lneQvLuTeo5ESEDuSeUo69W3p
         e4m1G9Retr2rfvG+V4yVUfHqVEDvoDreI0hi8K96EmVb09RSUNExDu7llpeq1hqD8F
         ujD3ag5pP/QMiq4JvVXwAuw54R/2Rqb69cgHYDqM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94EePid002361;
        Thu, 4 Oct 2018 09:40:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 09:40:25 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 09:40:25 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94EeKrU030461;
        Thu, 4 Oct 2018 09:40:21 -0500
Subject: Re: [PATCH RFC 1/2] clk: ti: add a usecount for autoidle
To:     Andreas Kemnade <andreas@kemnade.info>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <paul@pwsan.com>, <tony@atomide.com>,
        <letux-kernel@openphoenux.org>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004055147.23048-2-andreas@kemnade.info>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <d3119268-2716-c5e6-5ed8-28495f597fb0@ti.com>
Date:   Thu, 4 Oct 2018 17:40:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181004055147.23048-2-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/18 08:51, Andreas Kemnade wrote:
> We have the scenario that first autoidle is disabled for all clocks,
> then it is disabled for selected ones and then enabled for all. So
> we should have some counting here, also according to the
> comment in  _setup_iclk_autoidle()
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   drivers/clk/ti/autoidle.c | 20 ++++++++++++--------
>   include/linux/clk/ti.h    |  1 +
>   2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> index 7bb9afbe4058..be2ce42e4f33 100644
> --- a/drivers/clk/ti/autoidle.c
> +++ b/drivers/clk/ti/autoidle.c
> @@ -48,8 +48,11 @@ int omap2_clk_deny_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->deny_idle)
> -		c->ops->deny_idle(c);
> +	if (c->ops && c->ops->deny_idle) {
> +		c->autoidle_count--;
> +		if (c->autoidle_count == -1)
> +			c->ops->deny_idle(c);

This code is racy as you have no locking in place. Please fix.

Also, this should be verified that it doesn't cause any PM regressions, 
I hope you have done that?

-Tero

> +	}
>   	return 0;
>   }
>   
> @@ -64,8 +67,11 @@ int omap2_clk_allow_idle(struct clk *clk)
>   	struct clk_hw_omap *c;
>   
>   	c = to_clk_hw_omap(__clk_get_hw(clk));
> -	if (c->ops && c->ops->allow_idle)
> -		c->ops->allow_idle(c);
> +	if (c->ops && c->ops->allow_idle) {
> +		c->autoidle_count++;
> +		if (c->autoidle_count == 0)
> +			c->ops->allow_idle(c);
> +	}
>   	return 0;
>   }
>   
> @@ -201,8 +207,7 @@ int omap2_clk_enable_autoidle_all(void)
>   	struct clk_hw_omap *c;
>   
>   	list_for_each_entry(c, &clk_hw_omap_clocks, node)
> -		if (c->ops && c->ops->allow_idle)
> -			c->ops->allow_idle(c);
> +		omap2_clk_allow_idle(c->hw.clk);
>   
>   	_clk_generic_allow_autoidle_all();
>   
> @@ -223,8 +228,7 @@ int omap2_clk_disable_autoidle_all(void)
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

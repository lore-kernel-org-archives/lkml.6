Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A588EECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723182086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 10:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723182086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeKHUBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:01:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53734 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeKHUBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:01:24 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8AQEll010324;
        Thu, 8 Nov 2018 04:26:14 -0600
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8AQETu058923
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 04:26:14 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 04:26:13 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 04:26:13 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8AQAAt017734;
        Thu, 8 Nov 2018 04:26:11 -0600
Subject: Re: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod
 requires that
To:     Andreas Kemnade <andreas@kemnade.info>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcousson@baylibre.com>, <paul@pwsan.com>, <tony@atomide.com>,
        <letux-kernel@openphoenux.org>
References: <20181004203817.22101-1-andreas@kemnade.info>
 <20181004203817.22101-3-andreas@kemnade.info>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
Date:   Thu, 8 Nov 2018 12:26:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181004203817.22101-3-andreas@kemnade.info>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 23:38, Andreas Kemnade wrote:
> Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> that makes hwmods working properly which cannot handle
> autoidle properly in lower power states.
> Affected is e. g. the omap_hdq.
> Since an ick might have mulitple users, autoidle is disabled
> when an individual user requires that rather than in
> _setup_iclk_autoidle. dss_ick is an example for that.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index bb641e6c93d0..0078b0e1d242 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
>   		clk_enable(oh->_clk);
>   
>   	list_for_each_entry(os, &oh->slave_ports, node) {
> -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
> +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
> +			omap2_clk_deny_idle(os->_clk);

I think calling this unconditionally across all platforms / clock types 
might cause problems. Checking kernel, am33xx seems to have one clock 
with this flag that is not of omap2 type. Do we have any testing data 
that this doesn't break things?

-Tero

>   			clk_enable(os->_clk);
> +		}
>   	}
>   
>   	/* The opt clocks are controlled by the device driver. */
> @@ -1039,8 +1041,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
>   		clk_disable(oh->_clk);
>   
>   	list_for_each_entry(os, &oh->slave_ports, node) {
> -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
> +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
>   			clk_disable(os->_clk);
> +			omap2_clk_allow_idle(os->_clk);
> +		}
>   	}
>   
>   	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
> @@ -2410,9 +2414,13 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
>   			continue;
>   
>   		if (os->flags & OCPIF_SWSUP_IDLE) {
> -			/* XXX omap_iclk_deny_idle(c); */
> +			/*
> +			 * we might have multiple users of one iclk with
> +			 * different requirements, disable autoidle when
> +			 * the module is enabled, e.g. dss iclk
> +			 */
>   		} else {
> -			/* XXX omap_iclk_allow_idle(c); */
> +			/* we are enabling autoidle afterwards anyways */
>   			clk_enable(os->_clk);
>   		 >   	}
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

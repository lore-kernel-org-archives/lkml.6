Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BC2ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E9B2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E9B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKHWKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:10:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43432 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbeKHWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:10:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA8CZKwO043079;
        Thu, 8 Nov 2018 06:35:20 -0600
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA8CZKPe101802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Nov 2018 06:35:20 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 8 Nov
 2018 06:35:20 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 8 Nov 2018 06:35:20 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA8CZG1h017519;
        Thu, 8 Nov 2018 06:35:17 -0600
Subject: Re: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod
 requires that
To:     Andreas Kemnade <andreas@kemnade.info>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bcousson@baylibre.com>,
        <paul@pwsan.com>, <tony@atomide.com>,
        <letux-kernel@openphoenux.org>
References: <20181004203817.22101-1-andreas@kemnade.info>
 <20181004203817.22101-3-andreas@kemnade.info>
 <bac125b7-68c5-4c90-ad98-22872db9ccff@ti.com>
 <20181108120847.1ef7ec02@kemnade.info>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <0976e09f-3f83-d1bc-5bd0-651e2f9c42d4@ti.com>
Date:   Thu, 8 Nov 2018 14:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181108120847.1ef7ec02@kemnade.info>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2018 13:08, Andreas Kemnade wrote:
> Hi,
> 
> On Thu, 8 Nov 2018 12:26:08 +0200
> Tero Kristo <t-kristo@ti.com> wrote:
> 
>> On 04/10/2018 23:38, Andreas Kemnade wrote:
>>> Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
>>> that makes hwmods working properly which cannot handle
>>> autoidle properly in lower power states.
>>> Affected is e. g. the omap_hdq.
>>> Since an ick might have mulitple users, autoidle is disabled
>>> when an individual user requires that rather than in
>>> _setup_iclk_autoidle. dss_ick is an example for that.
>>>
>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>> ---
>>>    arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>>> index bb641e6c93d0..0078b0e1d242 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
>>>    		clk_enable(oh->_clk);
>>>    
>>>    	list_for_each_entry(os, &oh->slave_ports, node) {
>>> -		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
>>> +		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
>>> +			omap2_clk_deny_idle(os->_clk);
>>
>> I think calling this unconditionally across all platforms / clock types
>> might cause problems. Checking kernel, am33xx seems to have one clock
>> with this flag that is not of omap2 type. Do we have any testing data
>> that this doesn't break things?
>>
> Somehow I have missed that am33xx clock. I have not tested it on that
> platform. Concerning am3xxx I have only a beaglebone block but it not
> am33xx I guess. So I have to recheck I guess.

Beaglebone black is am33xx based device, so you can use that for testing.

> But I think the intention of this flag was to control autoidle
> vs. sw-controlled idle according to...
> [...]
>>>    		if (os->flags & OCPIF_SWSUP_IDLE) {
>>> -			/* XXX omap_iclk_deny_idle(c); */
>>> +			/*
> this comment. So we need a if (clock_is_omap2()) or something like that
> or remove that flag from any other clocks?

You could add check within the omap2_clk_deny_idle / allow_idle calls 
themselves. You can check for presence of flag CLK_IS_BASIC, this is not 
set for omap clocks.

-Tero

> 
> Regards,
> Andreas
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13276C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC37A20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CJoeERnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC37A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeK3UaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:30:09 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39416 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeK3UaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:30:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAU9L6IT020067;
        Fri, 30 Nov 2018 03:21:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543569666;
        bh=ewj7bf+JT7WE8HBqOzw3TfWKuPxI4h38YP9VQN/tb0Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CJoeERnkJA6YOPewoyGwmahYHP6+mBMy4oivtxDH5Nbj9jK2pD3xXLhjumaSUQvFk
         yWsbbNf+GqKO/ffuF8thaJYTqnPsEBdI2hzfxnAqvZtelaM1ZQkT5YaR5MwKTuoPGP
         /5PDi5YYhzJpDnYDrYEm+5OvYD6MNX7Ru6eU+NI0=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAU9L62B088953
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 03:21:06 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 30
 Nov 2018 03:21:04 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 30 Nov 2018 03:21:04 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAU9Kxqo009835;
        Fri, 30 Nov 2018 03:21:00 -0600
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
To:     Stephen Boyd <sboyd@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     <bcousson@baylibre.com>, <letux-kernel@openphoenux.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <mturquette@baylibre.com>,
        <paul@pwsan.com>, <tony@atomide.com>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
Date:   Fri, 30 Nov 2018 11:20:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 09:57, Stephen Boyd wrote:
> Quoting Tero Kristo (2018-11-29 23:35:35)
>> On 30/11/2018 09:20, Stephen Boyd wrote:
>>> Quoting Andreas Kemnade (2018-11-29 22:15:34)
>>>> Hi Stephen,
>>>>
>>>> On Thu, 29 Nov 2018 16:25:05 -0800
>>>> Stephen Boyd <sboyd@kernel.org> wrote:
>>>>
>>>>> Quoting Andreas Kemnade (2018-11-10 12:31:14)
>>>>>> Code might use autoidle api with clocks not being omap2 clocks,
>>>>>> so check if clock type is not basic
>>>>>>
>>>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>>>> ---
>>>>>> New in v2
>>>>>> ---
>>>>>>    drivers/clk/ti/autoidle.c | 12 ++++++++++--
>>>>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
>>>>>> index 161f67850393..5bdae5552d38 100644
>>>>>> --- a/drivers/clk/ti/autoidle.c
>>>>>> +++ b/drivers/clk/ti/autoidle.c
>>>>>> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
>>>>>>    int omap2_clk_deny_idle(struct clk *clk)
>>>>>>    {
>>>>>>           struct clk_hw_omap *c;
>>>>>> +       struct clk_hw *hw = __clk_get_hw(clk);
>>>>>>    
>>>>>> -       c = to_clk_hw_omap(__clk_get_hw(clk));
>>>>>> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
>>>>>
>>>>> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
>>>>> Maybe add some flag in clk_hw_omap() instead?
>>>>>
>>>> hmm, Tero suggested that.
>>>> But to check flags in clk_hw_omap I first need to know that there is a
>>>> clk_hw_omap behind clk_hw. And for that I either need to check flags in
>>>> clk_hw or do more changes in the omap_hwmod code.
>>>
>>> Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
>>> other users are marking clks with this but there is no reason to do so.
>>> I'll go make another pass over the tree and nuke those ones from orbit.
>>
>> The reason for using this flag is because OMAP uses two clock types
>> around, the basic clocks like fixed-factor-clock/fixed-clock, and then
>> all the omap derivatives, which can be cast to clk_hw_omap. If we want
>> to avoid usage of CLK_IS_BASIC, we need to copy paste the remaining
>> basic code under drivers/clk/ti/ and convert them to use clk_hw_omap as
>> internal datatype. Is this preferred?
>>
> 
> No that is not preferred. Can the omap2_clk_deny_idle() function be
> integrated closer into the clk framework in some way that allows it to
> be part of the clk_ops structure? And then have that take a clk_hw
> structure instead of a struct clk? I haven't looked at this in any
> detail whatsoever so I may be way off right now.

It could be added under the main clk_ops struct, however this would 
introduce two new func pointers to it which are not used by anything 
else but OMAP. Are you aware of any other platforms requiring similar 
feature?

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

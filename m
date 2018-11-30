Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A08CC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B902D21473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bg/Dr6KC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B902D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeK3Soc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:44:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37032 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3Sob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:44:31 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAU7Zocw114723;
        Fri, 30 Nov 2018 01:35:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543563350;
        bh=Wmx+MeFv4MMaM8bbmPVvczNYR9YYoG1JpCOSe0pw5a8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bg/Dr6KCWYJyNQiajuvAowtjZWFbRh5W3DLJXbbw8TQUiFqTU+KnHhfLJwnIqjcru
         esaSDygvyHcIGVcR58U95EPDt9YaZ4Y/e4stKtIUIFZZaLn81O60QY244/wAK0BR4V
         Q4OfL7HCXqHh7wIyJP0fNxNb2bCG4qtPSK035HtI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAU7Zo1L060728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Nov 2018 01:35:50 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 30
 Nov 2018 01:35:49 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 30 Nov 2018 01:35:49 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAU7ZjSe018132;
        Fri, 30 Nov 2018 01:35:46 -0600
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
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
Date:   Fri, 30 Nov 2018 09:35:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 09:20, Stephen Boyd wrote:
> Quoting Andreas Kemnade (2018-11-29 22:15:34)
>> Hi Stephen,
>>
>> On Thu, 29 Nov 2018 16:25:05 -0800
>> Stephen Boyd <sboyd@kernel.org> wrote:
>>
>>> Quoting Andreas Kemnade (2018-11-10 12:31:14)
>>>> Code might use autoidle api with clocks not being omap2 clocks,
>>>> so check if clock type is not basic
>>>>
>>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>>>> ---
>>>> New in v2
>>>> ---
>>>>   drivers/clk/ti/autoidle.c | 12 ++++++++++--
>>>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
>>>> index 161f67850393..5bdae5552d38 100644
>>>> --- a/drivers/clk/ti/autoidle.c
>>>> +++ b/drivers/clk/ti/autoidle.c
>>>> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
>>>>   int omap2_clk_deny_idle(struct clk *clk)
>>>>   {
>>>>          struct clk_hw_omap *c;
>>>> +       struct clk_hw *hw = __clk_get_hw(clk);
>>>>   
>>>> -       c = to_clk_hw_omap(__clk_get_hw(clk));
>>>> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
>>>
>>> Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
>>> Maybe add some flag in clk_hw_omap() instead?
>>>
>> hmm, Tero suggested that.
>> But to check flags in clk_hw_omap I first need to know that there is a
>> clk_hw_omap behind clk_hw. And for that I either need to check flags in
>> clk_hw or do more changes in the omap_hwmod code.
> 
> Can you do it? The omap code is the only user of CLK_IS_BASIC. All the
> other users are marking clks with this but there is no reason to do so.
> I'll go make another pass over the tree and nuke those ones from orbit.

The reason for using this flag is because OMAP uses two clock types 
around, the basic clocks like fixed-factor-clock/fixed-clock, and then 
all the omap derivatives, which can be cast to clk_hw_omap. If we want 
to avoid usage of CLK_IS_BASIC, we need to copy paste the remaining 
basic code under drivers/clk/ti/ and convert them to use clk_hw_omap as 
internal datatype. Is this preferred?

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

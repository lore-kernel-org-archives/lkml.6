Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D3220663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nTAhGB2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfANI0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:26:25 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43754 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfANI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:26:25 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0E8Q2nD059121;
        Mon, 14 Jan 2019 02:26:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547454362;
        bh=itRLtQbk4nshFzexDM6gmq0aSF+3531xyv2QFknaLAk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nTAhGB2XBcNkWGVuZnSjKI7fEaoOu6TCpfns5a/3VAUG8gqNsz5wEyFfliIOmnrpx
         9y863raObhjFMQ8hG8dL0/VQF2mNgIRQQZHs5HX9fa82It9vkQLleUgE51PcJeYgHp
         Z3vHBcEI9yZJhUZpYlleqstO0066muG/sKBn7048=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0E8Q2GC013795
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 02:26:02 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 02:25:57 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 02:25:58 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0E8PqbI017787;
        Mon, 14 Jan 2019 02:25:53 -0600
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
To:     Stephen Boyd <sboyd@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     Tony Lindgren <tony@atomide.com>, <bcousson@baylibre.com>,
        <letux-kernel@openphoenux.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <mturquette@baylibre.com>, <paul@pwsan.com>
References: <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com> <20181203172246.0e767a16@kemnade.info>
 <20181204164556.GB6707@atomide.com> <20181227211222.5996c356@aktux>
 <20181228200229.GY6707@atomide.com>
 <76d9fc57-898b-53ba-1dca-78e5b5c9b2be@ti.com> <20181231092944.014fc1c0@aktux>
 <154655874528.15366.10423050138946294754@swboyd.mtv.corp.google.com>
 <33b3aecd-54dc-ae93-dabe-883275e1d7b0@ti.com>
 <154724694850.169631.6179537075340016611@swboyd.mtv.corp.google.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <2cd42549-7209-ced7-fc95-bd837f6c0f68@ti.com>
Date:   Mon, 14 Jan 2019 10:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <154724694850.169631.6179537075340016611@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2019 00:49, Stephen Boyd wrote:
> Quoting Tero Kristo (2019-01-03 23:28:58)
>> On 04/01/2019 01:39, Stephen Boyd wrote:
>>> Quoting Andreas Kemnade (2018-12-31 00:30:21)
>>>> On Mon, 31 Dec 2018 09:23:01 +0200
>>>> Tero Kristo <t-kristo@ti.com> wrote:
>>>>
>>>>> On 28/12/2018 22:02, Tony Lindgren wrote:
>>>>>> * Andreas Kemnade <andreas@kemnade.info> [181227 20:13]:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Tue, 4 Dec 2018 08:45:57 -0800
>>>>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>>>>    
>>>>>>>> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
>>>>>>>>> On Mon, 3 Dec 2018 07:39:10 -0800
>>>>>>>>> Tony Lindgren <tony@atomide.com> wrote:
>>>>>>>>>> The consumer device stays active just fine with PM runtime
>>>>>>>>>> calls. So yes, the problem is keeping a clock controller forced
>>>>>>>>>> active for the period of consumer device reset. Other than
>>>>>>>>>> that typically autoidle can be just kept enabled.
>>>>>>>>>>        
>>>>>>>>> Are we still talking about the same problem? Maybe I am losing track
>>>>>>>>> here. Just to make sure.
>>>>>>>>> The patch series was about disabling autoidle for devices which cannot
>>>>>>>>> work with it during normal operation. Not during reset or something
>>>>>>>>> like that.
>>>>>>>>> Or is the keep-clock-active-during-reset just a requirement for bigger
>>>>>>>>> restructuring ideas?
>>>>>>>>
>>>>>>>> Yeah there are two issues: The fix needed for the issue you brought up,
>>>>>>>> and also how to let a reset driver to block autoidle for reset.
>>>>>>>>    
>>>>>>> Hmm, is this set now waiting for the famous "somebody" fixing all
>>>>>>> the stuff?
>>>>>>
>>>>>> Well I think we're still waiting on Tero to comment on this.
>>>>>
>>>>> The only item requiring immediate fixing is the point Stephen made out,
>>>>> removing the usage of CLK_IS_BASIC from this patch.
>>>>>
>>>>> Afaics, the reset related concerns Tony has can be handled later.
>>>>>
>>>> hmm, and there we need Stephen's opinion about having the allow/deny
>>>> autoidle functions in the main clk_ops struct.
>>>>
>>>
>>> I have unanswered questions on the list for this thread[1].
>>
>> The reset portion we can't answer with the current knowledge I fear, we
>> need to prototype this a bit first and see which way to go.
>>
>>> I'm not sure
>>> what allow/deny autoidle functions mean to clk drivers. It looks like an
>>> OMAP specific addition to the clk_ops struct, which sounds wrong to put
>>> it plainly.
>>
>> Yeah, I don't think other SoCs implement the same functionality, at
>> least not in the same way. The autoidle bits are available in
>> omap2/omap3 only, where they control the HW autoidle functionality of
>> these clocks. If the bit is enabled, the HW can autonomously disable the
>> clock once it is not needed anymore by HW.
> 
> Some qcom chips have automatic clock gating (basically hw clk gating)
> but they don't really need to involve that with the reset asserting or
> deasserting anymore. It used to be that they had to turn off the
> automatic mode, assert the reset, deassert the reset, and then reenable
> the automatic mode. So there is some precedence for this. But again, I
> think that the reset controller and the clk controller are the same
> device in both vendor instances so in theory the driver can be one
> driver for both clk and reset and do the proper things on the backend.
> So just use reset controller framework and register that from the clk
> controller driver?
> 
>>
>>> Hopefully it can be done outside of the clk framework by
>>> having the provider driver know more things about all the frameworks
>>> it's hooking into.
>>
>> This is how it has been done so far, however Andreas wants to expand the
>> functionality a bit where it breaks... unless we can use the
>> CLK_IS_BASIC flag to detect if we accessing an OMAP specific clock or
>> not. If we are passing in a clk pointer from a consumer level API, I
>> don't know if there is any other way to go with this if we can't modify
>> the generic clk_ops struct.
>>
>> The same flag check is used across TI clock driver already btw.
>>
> 
> Sure, it's not like this is a new problem. I'd just like to see if we
> can solve it now and get rid of the CLK_IS_BASIC flag now. It would be
> great if some extra effort could be put into it vs. punting the problem
> until 2020 or something.

Ok, let me see if I can figure out something for this...

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

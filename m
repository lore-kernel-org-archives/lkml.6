Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD5ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0578F206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0578F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeGSKgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:36:21 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:8191 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbeGSKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:36:20 -0400
Received: from [192.168.90.200] (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 19 Jul
 2018 17:53:16 +0800
Subject: Re: [PATCH 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
References: <20180613161314.14894-1-yixun.lan@amlogic.com>
 <20180613161314.14894-3-yixun.lan@amlogic.com>
 <20180624213844.2207ca6f@bbrezillon>
 <76d428ff-376a-dce3-cb51-d238564b7c3e@amlogic.com>
 <20180718210849.493f0087@bbrezillon>
 <45c1a96c-0d14-dece-37cf-ac428bb98621@amlogic.com>
 <20180719103953.26164eb6@bbrezillon>
CC:     <yixun.lan@amlogic.com>, Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        <linux-mtd@lists.infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
From:   Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <ffa5a2ce-932b-700d-25ee-723db3cbd163@amlogic.com>
Date:   Thu, 19 Jul 2018 17:53:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180719103953.26164eb6@bbrezillon>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


HI Boris


On 07/19/18 16:39, Boris Brezillon wrote:
> Hi Yixun,
> 
> On Thu, 19 Jul 2018 16:13:47 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>>>>> You're doing DMA on those buffers, and devm_kzalloc() is not
>>>>> DMA-friendly (returned buffers are not aligned on a cache line). Also,
>>>>> you don't have to allocate your own buffers because the core already
>>>>> allocate them (chip->data_buf, chip->oob_poi). All you need to do is
>>>>> set the NAND_USE_BOUNCE_BUFFER flag in chip->options to make sure
>>>>> you're always passed a DMA-able buffer.
>>>>>     
>>>>
>>>> thanks for the suggestion, we've migrated to use the
>>>> dmam_alloc_coherent() API  
>>>
>>> kzalloc() should be just fine, no need to alloc a DMA coherent region. 
>>>   
>>
>> we're a little bit confused here, isn't devm_kzalloc (previously we are
>> using) a variant of kzalloc? and since the NAND controller is doing DMA
>> here, using DMA coherent API is more proper way?
> 
> Well, making buffers DMA coherent might be expensive, especially if you
> access them a lot (unless you have a coherency unit and the cache is
> kept enabled).
> 
> Regarding the "why is devm_kzalloc() is not DMA-safe?" question, I'd
> recommend that you read this discussion [1].
> 
great, thanks for the info.

we fixed this in patch v2

>>>>>> +	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
>>>>>> +				   "%s:nand", dev_name(dev));
>>>>>> +	if (!mtd->name) {
>>>>>> +		dev_err(nfc->dev, "Failed to allocate mtd->name\n");
>>>>>> +		return -ENOMEM;
>>>>>> +	}    
>>>>>
>>>>> You set the name after nand_scan_ident() and make it conditional (only
>>>>> if ->name == NULL) so that the label property defined in the DT takes
>>>>> precedence over the default name.    
>>>>  
>> for setting mtd->name conditional, do you mean doing something like this?
>>
>> if (!mtd->name)
>> 	mtd->name = devm_kasprintf(..)
> 
> Yes, that's what I meant.
> 
>>
>> but we found mtd->name = "ffe07800.nfc" after function
>> nand_scan_ident(), which is same value as dev_name(dev)..
>> and there is no cs information encoded there.
> 
> Hm, that shouldn't be the case. Maybe you can add traces to find out
> who is setting mtd->name to this value.
> 
will trace this, then get back to you
>>
>>>>  
>>>>> Also, I recommend suffixing this name
>>>>> with the CS id, just in case you ever need to support connecting several
>>>>> chips to the same controller. 
>>>>>     
>>>>
>>>> we actually didn't get the point here, cs is about chip selection with
>>>> multiple nand chip? and how to get this information?  
>>>
>>> Well, you currently seem to only support one chip per controller, but I
>>> guess the IP can handle several CS lines. So my recommendation is about
>>> choosing a name so that you can later easily add support for multiple
>>> chips without breaking setups where mtdparts is used.
>>>
>>> To sum-up, assuming your NAND chip is always connected to CS0 (on the
>>> controller side), I'd suggest doing:
>>>   
>> yes, this is exactly how the hardware connected.
>>> 	mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
>>> 				   "%s:nand.%d", dev_name(dev), cs_id);
>>>
>>> where cs_id is the value you extracted from the reg property of the
>>> NAND node.
>>>   
>> Ok, you right.
>> current, the NAND chip is only use one CS (which CE0) for now, what's in
>> the DT is
>>
>> nand@0 {
>>  reg = < 0 >;
>>  ..
>> };
>>
>> so for the multiple chips it would something like this in DT?
>>
>> nand@0 {
>>   reg = < 0 >;
>> };
>>
>> nand@1 {
>>   reg = < 1 >;
>> };
> 
> Yep, that's for 2 single-die chips.
> 
>>
>> or even
>> nand@0 {
>>   reg = < 0 2 >;
>> };
>>
>> nand@1 {
> 
> nand@3 {
> 
>>   reg = < 3 4 >;
>> };
> 
> And this is describing 2 dual-die chips.
> 
>>
>> do we need to encode all the cs information here? not sure if we
>> understand this correctly, but could send out the patch for review..
> 
> Yes, reg should contain an array of controller-side CS lines used to
> select the chip (or a specific die in a chip, the index in the reg
> table being the id of the die).
>
much clear about this, thanks

Yixun



Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1FECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E1D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89E1D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJSQgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:36:00 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:61982 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbeJSQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:36:00 -0400
Received: from [10.28.18.51] (10.28.18.51) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Oct
 2018 16:30:48 +0800
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>, Rob Herring <robh@kernel.org>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        Yixun Lan <yixun.lan@amlogic.com>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018213308.3f8a5279@bbrezillon>
 <09f76f17-05c4-d9e0-0167-f68e224f00c4@amlogic.com>
 <20181019101033.0a160506@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <3e462d23-a100-6eb2-3740-abe2373a8e15@amlogic.com>
Date:   Fri, 19 Oct 2018 16:30:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019101033.0a160506@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.51]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/19 16:10, Boris Brezillon wrote:
> On Fri, 19 Oct 2018 15:29:05 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>>> How about defining that the HW returns an array of __le64 instead and then
>>> define the following macros which you can use after converting in the
>>> CPU endianness
>>>
>>> #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * (1 + y)) & GENMASK(7, 0))
>>> #define ECC_COMPLETE			BIT(31)
>>> #define ECC_ERR_CNT(x)			(((x) >> 24) & GENMASK(5, 0))
>>>
>>> (I'm not entirely sure the field positions are correct, but I'll let you
>>> check that).
>>>    
>> ok. i think it should be:
>>
>> #define ECC_GET_PROTECTED_OOB_BYTE(x, y)	(((x) >> (8 * y) &
>> GENMASK(7, 0))
>>
>> if x represents the u64 and y represents the index of the u64.
> 
> Absolutely.
> 
>>
>>
>>
>>>> +
>>>> +#define PER_INFO_BYTE	(sizeof(struct meson_nfc_info_format))
>>>> +
>>>> +struct meson_nfc_nand_chip {
>>>> +	struct list_head node;
>>>> +	struct nand_chip nand;
>>>> +	bool is_scramble;
>>>
>>> I think I already mentioned the NAND_NEED_SCRAMBLING flag []. Please
>>> drop this field and test (chip->flags & NAND_NEED_SCRAMBLING) instead.
>>>    
>> em, i use NAND_NEED_SCRAMBLING and is_scramble is set:
>> static int meson_nand_attach_chip(struct nand_chip *nand)
>> {
>> 	......
>> 	meson_chip->is_scramble =
>> 		(nand->options & NAND_NEED_SCRAMBLING) ? 1 : 0;
>> 	......
>> }
> 
> Why do you need to add a new field then? Just test
> nand->options & NAND_NEED_SCRAMBLING directly or provide a helper
> function that does that.
> 
ok, i will fix it.
> .
> 

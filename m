Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AEEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6524F20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6524F20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLKJjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:39:33 -0500
Received: from mail-sz2.amlogic.com ([211.162.65.114]:63866 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKJjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:39:33 -0500
Received: from [10.28.18.115] (10.28.18.115) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 11 Dec
 2018 17:39:50 +0800
Subject: Re: [PATCH v7 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
 <1542386439-30166-3-git-send-email-jianxin.pan@amlogic.com>
 <20181207102456.1dc67e07@xps13>
 <823825a3-86fb-9a20-ae29-85cc52d44093@amlogic.com>
 <20181210123809.5ade45c4@bbrezillon>
 <79a797c2-f37f-7f7c-e907-2d3c2283ec2d@amlogic.com>
 <20181210155057.38788656@xps13>
 <d60bac6f-732d-0ddc-2644-17f650dfa885@amlogic.com>
 <20181211093933.2fab8cc3@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <6abef955-5ce0-6213-b616-67a306d1fb31@amlogic.com>
Date:   Tue, 11 Dec 2018 17:39:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181211093933.2fab8cc3@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.115]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 2018/12/11 16:39, Boris Brezillon wrote:
> On Tue, 11 Dec 2018 09:56:25 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>> Hi Miquel,
>>
>> On 2018/12/10 22:50, Miquel Raynal wrote:
>>> Hi Liang,
>>>
>>> Liang Yang <liang.yang@amlogic.com> wrote on Mon, 10 Dec 2018 20:12:39
>>> +0800:
>>>    
>>>> On 2018/12/10 19:38, Boris Brezillon wrote:
>>>>> On Mon, 10 Dec 2018 19:23:46 +0800
>>>>> Liang Yang <liang.yang@amlogic.com> wrote:
>>>>>       
>>>>>>>> +			mtd->ecc_stats.failed++;
>>>>>>>> +			continue;
>>>>>>>> +		}
>>>>>>>> +		mtd->ecc_stats.corrected += ECC_ERR_CNT(*info);
>>>>>>>> +		bitflips = max_t(u32, bitflips, ECC_ERR_CNT(*info));
>>>>>>>> +	}
>>>>>>>
>>>>>>> Are you sure you handle correctly empty pages with bf?
>>>>>>>      >> if scramble is enable, i would say yes here.
>>>>>> when scramble is disabled, i am considering how to use the helper
>>>>>> nand_check_erased_ecc_chunk, but it seems that i can't get the ecc
>>>>>> bytes which is caculated by ecc engine.by the way, nfc dma doesn't send
>>>>>> out the ecc parity bytes.
>>>>>
>>>>> Even if the ECC engine is disabled?
>>>>>       
>>>> No.
>>>> When ECC engine is disabled, it can read the ecc parity bytes ; but there is another problem that i need to consider how code struct looks better when reading error with ecc opened and then try to raw read.
>>>> Is there a good idea?
>>>
>>> When reading with ECC enabled, in case of uncorrectable error you
>>> must re-read without ECC, then check if the page is empty or not with
>>> the core helpers (nand_check_erased_*()).
>>>
>>> Is this what you meant?
>>>    
>> yes. when uncorrectable ECC error, i need firstly read out the ECC bytes
>> without ECC engine and then use the helper nand_check_erased_ecc_chunk
>> to check if blank page.
>> Of course, the precondition is without scrambler, or the bland page can
>> be detected by meson NFC.
> 
> Yep, raw accessors should disable both the scrambler and the ECC
> engine (see what's done in sunxi_nand.c).
> 

i see sunxi_nfc_hw_ecc_read_chunk and it will re-read the data for 
bitflips with scrambler off when ECC failed.
also we can do the same implementation and it seems to be the only answer.

> .
> 

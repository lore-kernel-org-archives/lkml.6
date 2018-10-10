Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C507E2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C507E2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJJOXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:23:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55194 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbeJJOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:23:48 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w9A6wl2t019978;
        Wed, 10 Oct 2018 09:02:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mxjgxw4jy-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Oct 2018 09:02:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A17CB31;
        Wed, 10 Oct 2018 07:02:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D9132535;
        Wed, 10 Oct 2018 07:02:37 +0000 (GMT)
Received: from [10.201.23.236] (10.75.127.45) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Oct
 2018 09:02:36 +0200
Subject: Re: [PATCH v3 4/7] dmaengine: stm32-dma: Add DMA/MDMA chaining
 support
To:     Vinod <vkoul@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
 <1538139715-24406-5-git-send-email-pierre-yves.mordret@st.com>
 <20181007160030.GB2372@vkoul-mobl>
 <e9cedfdd-ad90-9123-03bb-34a2e84059c5@st.com>
 <20181010040343.GO2372@vkoul-mobl>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <d64da587-a680-20c4-7139-f59fd1f299bc@st.com>
Date:   Wed, 10 Oct 2018 09:02:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010040343.GO2372@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-10_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/2018 06:03 AM, Vinod wrote:
> On 09-10-18, 10:40, Pierre Yves MORDRET wrote:
>>
>>
>> On 10/07/2018 06:00 PM, Vinod wrote:
>>> On 28-09-18, 15:01, Pierre-Yves MORDRET wrote:
>>>> This patch adds support of DMA/MDMA chaining support.
>>>> It introduces an intermediate transfer between peripherals and STM32 DMA.
>>>> This intermediate transfer is triggered by SW for single M2D transfer and
>>>> by STM32 DMA IP for all other modes (sg, cyclic) and direction (D2M).
>>>>
>>>> A generic SRAM allocator is used for this intermediate buffer
>>>> Each DMA channel will be able to define its SRAM needs to achieve chaining
>>>> feature : (2 ^ order) * PAGE_SIZE.
>>>> For cyclic, SRAM buffer is derived from period length (rounded on
>>>> PAGE_SIZE).
>>>
>>> So IIUC, you chain two dma txns together and transfer data via an SRAM?
>>
>> Correct. one DMA is DMAv2 (stm32-dma) and the other is MDMA(stm32-mdma).
>> Intermediate transfer is between device and memory.
>> This intermediate transfer is using SDRAM.
> 
> Ah so you use dma calls to setup mdma xtfers? I dont think that is a
> good idea. How do you know you should use mdma for subsequent transfer?
> 

When user bindings told to setup chaining intermediate MDMA transfers are always
triggers.
For instance if a user requests a Dev2Mem transfer with chaining. From client
pov this is still a prep_slave_sg. Internally DMAv2 is setup in cyclic mode (in
double buffer mode indeed => 2 buffer of PAGE_SIZE/2) and destination is SDRAM.
DMAv2 will flip/flop on those 2 buffers.
At the same time DMAv2 driver prepares a MDMA SG that will fetch data from those
2 buffers in SDRAM and fills final destination memory.

> 
>>>>  drivers/dma/stm32-dma.c | 879 ++++++++++++++++++++++++++++++++++++++++++------
>>>
>>> that is a lot of change for a driver, consider splitting it up
>>> logically in smaller changes...
>>>
>>
>> This feature is rather monolithic. Difficult to split up.
>> All the code is required at once.
> 
> It can be enabled at last but split up logically. Intrusive changes to a
> driver make it hard to review..
> 
Ok. I will to think about it how to proceed.

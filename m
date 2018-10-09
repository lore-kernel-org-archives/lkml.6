Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2B9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458282086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458282086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbeJIVDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:03:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43823 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726540AbeJIVDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:03:33 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w99DjDnk030277;
        Tue, 9 Oct 2018 15:46:08 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2n0muxtqcd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 09 Oct 2018 15:46:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2644734;
        Tue,  9 Oct 2018 13:46:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EC0E05219;
        Tue,  9 Oct 2018 13:46:07 +0000 (GMT)
Received: from [10.201.23.236] (10.75.127.44) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 9 Oct
 2018 15:46:07 +0200
Subject: Re: [PATCH v3 1/7] dt-bindings: stm32-dma: Add DMA/MDMA chaining
 support bindings
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
 <1538139715-24406-2-git-send-email-pierre-yves.mordret@st.com>
 <20181007145722.GY2372@vkoul-mobl>
 <5d7a218c-9e96-3931-88ab-0b4dcb3ec4e5@st.com>
 <20181009085757.GI2372@vkoul-mobl>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <b6079edc-66df-90eb-7da1-74af4e2dcdd5@st.com>
Date:   Tue, 9 Oct 2018 15:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009085757.GI2372@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-09_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2018 10:57 AM, Vinod wrote:
> Hi Pierre,
> 
> On 09-10-18, 09:18, Pierre Yves MORDRET wrote:
> 
>>>>  * DMA client
>>>> @@ -68,7 +84,16 @@ channel: a phandle to the DMA controller plus the following four integer cells:
>>>>  	0x1: 1/2 full FIFO
>>>>  	0x2: 3/4 full FIFO
>>>>  	0x3: full FIFO
>>>> -
>>>> + -bit 2: Intermediate M2M transfer from/to DDR to/from SRAM throughout MDMA
>>>> +	0: MDMA not used to generate an intermediate M2M transfer
>>>> +	1: MDMA used to generate an intermediate M2M transfer.
>>>> + -bit 3-4: indicated SRAM Buffer size in (2^order)*PAGE_SIZE.
>>>> +	PAGE_SIZE is given by Linux at 4KiB: include/asm-generic/page.h.
>>>> +	Order is given by those 2 bits starting at 0.
>>>> +	Valid only whether Intermediate M2M transfer is set.
>>>
>>> why do we need this as a property?
>>
>> In some UC, we need more than 4KiB in case of chaining for better performances.
>> Chaining has to be enabled by client if performance is at sacks.
> 
> Okay if that is the case why is the user not taking care of this?
> Creating DMA txn and chaining them up and starting the chain? Why would
> dmaengine driver need to do that?
> 

User is using standard DMA API (single, sg or cyclic) and is agnostic on what is
behind the scene(almost). As driver I just fulfill the request to transfer what
he wants. My driver scatters transfer into SDRAM chunks defined by user.
Unfortunately all transfer are not % the SDRAM size given in DT. This very last
txn is to flush the last expected bytes.
Whatever user set for chaining(bit 2) the DMA API remains the same at its side.


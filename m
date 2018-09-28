Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F849C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61770204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61770204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeI1Uz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:55:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10446 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbeI1Uz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:55:29 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8SET7bB025957;
        Fri, 28 Sep 2018 16:30:58 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mnb6y2dc3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 28 Sep 2018 16:30:58 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD42C38;
        Fri, 28 Sep 2018 14:30:57 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5059250E0;
        Fri, 28 Sep 2018 14:30:57 +0000 (GMT)
Received: from [10.129.6.39] (10.75.127.46) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 28 Sep
 2018 16:30:55 +0200
Subject: Re: [PATCH v2 0/7] Add-DMA-MDMA-chaining-support
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
From:   Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Message-ID: <6bc2e022-1a36-f36c-b23b-e2ba7b16f2fc@st.com>
Date:   Fri, 28 Sep 2018 16:30:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538123794-17085-1-git-send-email-pierre-yves.mordret@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-28_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I've submitted a V3 following a KBuild warning.
You can thus drop this V2.

Thanks and sorry for the spamming.

Have a nice weekend.
Regards

On 09/28/2018 10:36 AM, Pierre-Yves MORDRET wrote:
> This serie adds support for M2M transfer triggered by STM32 DMA in order to
> transfer data from/to SRAM to/from DDR.
> 
> Normally, this mode should not be needed as transferring data from/to DDR
> is supported by the STM32 DMA.
> However, the STM32 DMA don't have the ability to generate burst transfer
> on the DDR as it only embeds only a 4-word FIFO although the minimal burst
> length on the DDR is 8 words.
> Due to this constraint, the STM32 DMA transfers data from/to DDR in a
> single way and could lead to pollute the DDR.
> To avoid this, we have to use SRAM for all transfers where STM32 DMA is
> involved.
> 
> An Hw design has been specially put in place to allow this chaining where DMA
> interrupt is connected on GIC and MDMA request line as well. This grants the
> possibility to trigger an MDMA transfer from the completion of DMA.
> At the same time MDMA has the ability to acknowlege DMA. The aim is to have an
> self refreching mechanism to transfer from/to device to/from DDR with minimal
> sw support.
> For instance the DMA is set in cyclic double buffering to feed SRAM and MDMA
> transfer to DDR thanks to LLI.
> 
> M'boumba Cedric Madianga (7):
>   dt-bindings: stm32-dma: Add DMA/MDMA chaining support bindings
>   dt-bindings: stm32-dmamux: Add one cell to support DMA/MDMA chain
>   dt-bindings: stm32-mdma: Add DMA/MDMA chaining support bindings
>   dmaengine: stm32-dma: Add DMA/MDMA chaining support
>   dmaengine: stm32-mdma: Add DMA/MDMA chaining support
>   dmaengine: stm32-dma: enable descriptor_reuse
>   dmaengine: stm32-mdma: enable descriptor_reuse
> 
>  .../devicetree/bindings/dma/stm32-dma.txt          |  27 +-
>  .../devicetree/bindings/dma/stm32-dmamux.txt       |   6 +-
>  .../devicetree/bindings/dma/stm32-mdma.txt         |  12 +-
>  drivers/dma/stm32-dma.c                            | 903 ++++++++++++++++++---
>  drivers/dma/stm32-mdma.c                           | 133 ++-
>  5 files changed, 949 insertions(+), 132 deletions(-)
> 

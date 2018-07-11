Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6CCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 058EE20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058EE20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeGKJpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:45:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44784 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732376AbeGKJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:45:01 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6B9dD8d018059;
        Wed, 11 Jul 2018 11:41:09 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2k5eu1g6u2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Jul 2018 11:41:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5C70138;
        Wed, 11 Jul 2018 09:41:08 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A2972635;
        Wed, 11 Jul 2018 09:41:08 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.47) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 11:41:06 +0200
Subject: Re: [PATCH 01/19] mmc: mmci: regroup and define dma operations
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1528809280-31116-1-git-send-email-ludovic.Barre@st.com>
 <1528809280-31116-2-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFpt5HUeUqaoS9icDodM+r64jB9vQ=zTecO0tuBv=TtOXg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <d93e6886-1dee-7915-459f-466a54d0c242@st.com>
Date:   Wed, 11 Jul 2018 11:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpt5HUeUqaoS9icDodM+r64jB9vQ=zTecO0tuBv=TtOXg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2018 05:17 PM, Ulf Hansson wrote:
> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> Prepare mmci driver to manage dma interface by new property.
>> This patch defines and regroups dma operations for mmci drivers.
>> mmci_dma_XX prototypes are added to call member of mmci_dma_ops
>> if not null. Based on legacy need, a mmci dma interface has been
>> defined with:
>> -mmci_dma_setup
>> -mmci_dma_release
>> -mmci_dma_pre_req
>> -mmci_dma_start
>> -mmci_dma_finalize
>> -mmci_dma_post_req
>> -mmci_dma_error
>> -mmci_dma_get_next_data
> 
> As I suggested for one of the other patches, I would rather turn core
> mmci functions into library functions, which can be either invoked
> from variant callbacks or assigned directly to them.
> 
> In other words, I would leave the functions that you move in this
> patch to stay in mmci.c. Although some needs to be re-factored and we
> also needs to make some of them available to be called from another
> file, hence the functions needs to be shared via mmci.h rather than
> being declared static.

In previous exchange mail "STM32MP1 SDMMC driver review"
we are said:

 >>> -dma variant à should fit in Qualcomm implementation, reuse (rename)
 >>> mmci_qcom_dml.c file and integrate ST dma in.
 >>
 >> stm32 sdmmc has an internal dma, no need to use dmaengine API;
 >> So some modifications in mmci (pre/post request, mmci_dma_xx). perhaps
 >> should be done with an ops or not.
 >
 >Yes.
 >
 >The Qualcomm variant is also using an internal DMA, hence I thought
 >there may be something we could re-use, or at least have some new
 >common ops for.

It's not crystal clear for me.
Do you always agree with a dma ops which allow to address different
DMA transfer:
-with dmaengine API
-sdmmc idma, without dmaengine API
-...

> 
> Let me take a concrete example on how I would move forward, hopefully
> that explains it a bit better. Please see below.
> 
> [...]
> 
>> -/*
>> - * All the DMA operation mode stuff goes inside this ifdef.
>> - * This assumes that you have a generic DMA device interface,
>> - * no custom DMA interfaces are supported.
>> - */
>> -#ifdef CONFIG_DMA_ENGINE
>> -static void mmci_dma_setup(struct mmci_host *host)
>> -{
>> -       const char *rxname, *txname;
>> -       struct variant_data *variant = host->variant;
>> -
>> -       host->dma_rx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "rx");
>> -       host->dma_tx_channel = dma_request_slave_channel(mmc_dev(host->mmc), "tx");
>> -
>> -       /* initialize pre request cookie */
>> -       host->next_data.cookie = 1;
>> -
>> -       /*
>> -        * If only an RX channel is specified, the driver will
>> -        * attempt to use it bidirectionally, however if it is
>> -        * is specified but cannot be located, DMA will be disabled.
>> -        */
>> -       if (host->dma_rx_channel && !host->dma_tx_channel)
>> -               host->dma_tx_channel = host->dma_rx_channel;
>> -
>> -       if (host->dma_rx_channel)
>> -               rxname = dma_chan_name(host->dma_rx_channel);
>> -       else
>> -               rxname = "none";
>> -
>> -       if (host->dma_tx_channel)
>> -               txname = dma_chan_name(host->dma_tx_channel);
>> -       else
>> -               txname = "none";
>> -
>> -       dev_info(mmc_dev(host->mmc), "DMA channels RX %s, TX %s\n",
>> -                rxname, txname);
>> -
>> -       /*
>> -        * Limit the maximum segment size in any SG entry according to
>> -        * the parameters of the DMA engine device.
>> -        */
>> -       if (host->dma_tx_channel) {
>> -               struct device *dev = host->dma_tx_channel->device->dev;
>> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
>> -
>> -               if (max_seg_size < host->mmc->max_seg_size)
>> -                       host->mmc->max_seg_size = max_seg_size;
>> -       }
>> -       if (host->dma_rx_channel) {
>> -               struct device *dev = host->dma_rx_channel->device->dev;
>> -               unsigned int max_seg_size = dma_get_max_seg_size(dev);
>> -
>> -               if (max_seg_size < host->mmc->max_seg_size)
>> -                       host->mmc->max_seg_size = max_seg_size;
>> -       }
> 
> Everything above shall be left as generic library function,
> mmci_dma_setup() and I would share it via mmci.h and thus change it
> from being static.
> 

each interfaces mmci_dma_XXX have very different needs depending
dma_ops (legacy, sdmmc idma)

>> -
>> -       if (variant->qcom_dml && host->dma_rx_channel && host->dma_tx_channel)
>> -               if (dml_hw_init(host, host->mmc->parent->of_node))
>> -                       variant->qcom_dml = false;
> 
> This piece of code, should be made specific to the qcom variant and
> managed though a "mmci_host_ops" callback. The corresponding code in
> that callback would then start by invoking mmci_dma_setup(), before it
> continues with the qcom specific operations.
> 
> For legacy variants, the corresponding callback would be set directly
> to mmci_dma_setup() and called through the callback from mmci.c when
> needed. There is no need to have a separate file for DMA for the
> legacy variants, I think.
> 
> [...]
> 
> Kind regards
> Uffe
> 

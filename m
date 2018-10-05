Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC27C65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B50420834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B50420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJEWcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:32:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55571 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727572AbeJEWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:32:52 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w95FT0jv000504;
        Fri, 5 Oct 2018 17:33:18 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mv4mjm4w8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 05 Oct 2018 17:33:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C80B73A;
        Fri,  5 Oct 2018 15:33:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 950374FAF;
        Fri,  5 Oct 2018 15:33:16 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.51) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 5 Oct
 2018 17:33:16 +0200
Subject: Re: [PATCH V5 02/24] mmc: mmci: create common mmci_dma_setup/release
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
 <1538745782-27446-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFogS_74csmZm5_M3D-JFNn_8fi2sxcHpRwVxZOqZhndVg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <adccdd2f-0525-67b9-35d0-718accc5a7ed@st.com>
Date:   Fri, 5 Oct 2018 17:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFogS_74csmZm5_M3D-JFNn_8fi2sxcHpRwVxZOqZhndVg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-05_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/05/2018 03:47 PM, Ulf Hansson wrote:
> On 5 October 2018 at 15:22, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch creates a common mmci_dma_setup/release which calls
>> dma_setup/release callbacks of mmci_host_ops and manages
>> common features like use_dma... If there is a fallbacks to
>> pio mode, dma functions must check use_dma.
>>
>> error management:
>> -mmci_dmae_setup fail if Tx and Rx dma channels are not defined
>> -qcom_dma_setup fail if one of both dma channels is not defined,
>>   Qcom has no specific resource to release, just mmci dmae resource.
> 
> Makes perfect sense!
> 
> [...]
> 
>> +void mmci_dma_setup(struct mmci_host *host)
>> +{
>> +       if (!host->ops || !host->ops->dma_setup)
>> +               return;
>> +
>> +       if (host->ops->dma_setup(host)) {
>> +               mmci_dma_release(host);
> 
> Please remove this and let the variants clean up themselves. That
> makes it more straight forward.

This common call was not such a good idea.
Ok, I will back on first idea.

> 
>> +               return;
>> +       }
>> +
>> +       host->use_dma = true;
>> +}
>> +
> 
> [...]
> 
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 01e6c6b..9b0a960 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -273,7 +273,8 @@ struct variant_data {
>>
>>   /* mmci variant callbacks */
>>   struct mmci_host_ops {
>> -       void (*dma_setup)(struct mmci_host *host);
>> +       int (*dma_setup)(struct mmci_host *host);
>> +       void (*dma_release)(struct mmci_host *host);
>>   };
>>
>>   struct mmci_host_next {
>> @@ -323,6 +324,7 @@ struct mmci_host {
>>          unsigned int            size;
>>          int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
>>
>> +       u8                      use_dma:1;
>>   #ifdef CONFIG_DMA_ENGINE
>>          /* DMA stuff */
>>          struct dma_chan         *dma_current;
>> @@ -336,3 +338,14 @@ struct mmci_host {
>>   #endif
>>   };
>>
>> +#ifdef CONFIG_DMA_ENGINE
>> +void mmci_variant_init(struct mmci_host *host);
>> +#else
>> +static inline void mmci_variant_init(struct mmci_host *host)
>> +{
>> +}
>> +#endif
> 
> This can be kept in mmci.c instead.

OK

> 
>> +
>> +int mmci_dmae_setup(struct mmci_host *host);
>> +void mmci_dmae_release(struct mmci_host *host);
>> +
>> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
>> index be3fab5..aa070a9 100644
>> --- a/drivers/mmc/host/mmci_qcom_dml.c
>> +++ b/drivers/mmc/host/mmci_qcom_dml.c
>> @@ -119,19 +119,22 @@ static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>>   }
>>
>>   /* Initialize the dml hardware connected to SD Card controller */
>> -static void qcom_dma_setup(struct mmci_host *host)
>> +static int qcom_dma_setup(struct mmci_host *host)
>>   {
>>          u32 config;
>>          void __iomem *base;
>>          int consumer_id, producer_id;
>>          struct device_node *np = host->mmc->parent->of_node;
>>
>> +       if (mmci_dmae_setup(host))
>> +               return -EINVAL;
>> +
>>          consumer_id = of_get_dml_pipe_index(np, "tx");
>>          producer_id = of_get_dml_pipe_index(np, "rx");
>>
>>          if (producer_id < 0 || consumer_id < 0) {
>>                  host->variant->qcom_dml = false;
>> -               return;
>> +               return -EINVAL;
> 
> This relies on error handling to be done by mmci_dma_setup(), which as
> stated, feels a bit wrong.
> 
> I would rather just call mmci_dmae_realease() here, before returning -EINVAL.

OK

> 
> [...]
> 
> Otherwise, this looks good to me now.
> 
> Kind regards
> Uffe
> 

Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EBE21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EBE21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389327AbeIUNad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:30:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51897 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388875AbeIUNad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:30:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8L7dUxL001032;
        Fri, 21 Sep 2018 09:42:29 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2mmkmr2gxc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 21 Sep 2018 09:42:29 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C26356;
        Fri, 21 Sep 2018 07:42:26 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 969B1252F;
        Fri, 21 Sep 2018 07:42:26 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.50) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 21 Sep
 2018 09:42:25 +0200
Subject: Re: [PATCH V2 02/27] mmc: mmci: internalize dma_inprogress into mmci
 dma functions
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gerald Baeza <gerald.baeza@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
 <1537268144-21152-3-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFrwiQv-EFfSrY7TwxXN-AnOsbbPop88GPo8_32hcjBzsg@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <4a1ab21e-0c0c-8d93-fd9d-1662a2fa642c@st.com>
Date:   Fri, 21 Sep 2018 09:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrwiQv-EFfSrY7TwxXN-AnOsbbPop88GPo8_32hcjBzsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-21_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/20/2018 07:56 PM, Ulf Hansson wrote:
> On 18 September 2018 at 12:55, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch internalizes the dma_inprogress into mmci dma interfaces.
>> This allows to simplify and prepare the next dma callbacks
>> for mmci host ops. __dma_inprogress is called in mmci_dma_data_error
>> and mmci_dma_finalize.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 16 ++++++++++------
>>   drivers/mmc/host/mmci.h |  4 +---
>>   2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index bf0bb07..7d22cb9 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -497,6 +497,9 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>>
>>   static void mmci_dma_data_error(struct mmci_host *host)
>>   {
>> +       if (!__dma_inprogress(host))
>> +               return;
>> +
>>          dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
>>          dmaengine_terminate_all(host->dma_current);
>>          host->dma_in_progress = false;
>> @@ -512,6 +515,9 @@ static void mmci_dma_finalize(struct mmci_host *host, struct mmc_data *data)
>>          u32 status;
>>          int i;
>>
>> +       if (!__dma_inprogress(dmae))
>> +               return;
>> +
>>          /* Wait up to 1ms for the DMA to complete */
>>          for (i = 0; ; i++) {
>>                  status = readl(host->base + MMCISTATUS);
>> @@ -903,8 +909,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>                  u32 remain, success;
>>
>>                  /* Terminate the DMA transfer */
>> -               if (dma_inprogress(host))
>> -                       mmci_dma_data_error(host);
>> +               mmci_dma_data_error(host);
>>
>>                  /*
>>                   * Calculate how far we are into the transfer.  Note that
>> @@ -942,8 +947,8 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>                  dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>>
>>          if (status & MCI_DATAEND || data->error) {
>> -               if (dma_inprogress(host))
>> -                       mmci_dma_finalize(host, data);
>> +               mmci_dma_finalize(host, data);
>> +
>>                  mmci_stop_data(host);
>>
>>                  if (!data->error)
>> @@ -1050,8 +1055,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>          if ((!sbc && !cmd->data) || cmd->error) {
>>                  if (host->data) {
>>                          /* Terminate the DMA transfer */
>> -                       if (dma_inprogress(host))
>> -                               mmci_dma_data_error(host);
>> +                       mmci_dma_data_error(host);
>>
>>                          mmci_stop_data(host);
>>                  }
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 696a066..f1ec066 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -332,9 +332,7 @@ struct mmci_host {
>>          struct mmci_host_next   next_data;
>>          bool                    dma_in_progress;
>>
>> -#define dma_inprogress(host)   ((host)->dma_in_progress)
>> -#else
>> -#define dma_inprogress(host)   (0)
>> +#define __dma_inprogress(host) ((host)->dma_in_progress)
> 
> Overall the change makes good sense to me, however I don't get why you
> want to rename the macro-function. Please don't.

Oops it's a mistake, I forgot this patch (I remove this)  .
I wait the end of review and will resend.

like you proposed in previous review this macros is renamed with
mmci_dmae_inprogress (in patch 04/14) to has common prefix with 
structure mmci_dmae_priv, mmci_dmae_next...

> 
>>   #endif
>>   };
>>
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 

Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD22C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F348208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F348208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbeGKJAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:00:55 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:32574 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbeGKJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:00:54 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6B8rp5P024275;
        Wed, 11 Jul 2018 10:57:14 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2k5e1088yg-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Jul 2018 10:57:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8318638;
        Wed, 11 Jul 2018 08:57:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 31D3924EB;
        Wed, 11 Jul 2018 08:57:13 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 11 Jul
 2018 10:57:12 +0200
Subject: Re: [PATCH 13/19] mmc: mmci: send stop cmd if a data command fail
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
 <1528809280-31116-14-git-send-email-ludovic.Barre@st.com>
 <CAPDyKFrbHcyy+rcVPrJAvO+y-ywQ=yE=gT3dbG2kqroQAhMF2Q@mail.gmail.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <f8b5540d-d797-60d6-2351-8867b6b2b444@st.com>
Date:   Wed, 11 Jul 2018 10:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrbHcyy+rcVPrJAvO+y-ywQ=yE=gT3dbG2kqroQAhMF2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_01:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

thanks for review, comments below

On 07/04/2018 03:37 PM, Ulf Hansson wrote:
> On 12 June 2018 at 15:14, Ludovic Barre <ludovic.Barre@st.com> wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> The mmc framework follows the requirement of SD_Specification:
>> the STOP_TRANSMISSION is sent on multiple write/read commands
>> and the stop command (alone), not needed on other ADTC commands.
>>
>> But, some variants require a stop command "STOP_TRANSMISION" to clear
>> the DPSM "Data Path State Machine" if an error happens on command or data
>> step. If it's not done the next data command will freeze hardware block.
>> Needed to support the STM32 sdmmc variant.
>>
>> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
>> ---
>>   drivers/mmc/host/mmci.c | 36 +++++++++++++++++++++++++++++++-----
>>   drivers/mmc/host/mmci.h |  3 +++
>>   2 files changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 87724e1..9af7db8 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/mmc/pm.h>
>>   #include <linux/mmc/host.h>
>>   #include <linux/mmc/card.h>
>> +#include <linux/mmc/mmc.h>
>>   #include <linux/mmc/slot-gpio.h>
>>   #include <linux/amba/bus.h>
>>   #include <linux/clk.h>
>> @@ -522,11 +523,28 @@ static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
>>          host->mask1_reg = mask;
>>   }
>>
>> -static void mmci_stop_data(struct mmci_host *host)
>> +static int mmci_stop_data(struct mmci_host *host)
> 
> Let's leave this as void function and instead add a check in
> mmci_start_command(), to see if the command is a
> MMC_STOP_TRANSMISSION. If so, then add host->variant->cmdreg_stop to
> the register that is written in it.

In fact: the cmdreg_stop bit (which abort and reinit the DPSM)
should have been activated only in error case. But I see a mistake in 
this piece of code => cmdreg_stop bit is set for all MMC_STOP_TRANSMISSION.

So, I read closely the sdmmc datasheet and it seems possible
to set cmdreg_stop bit for all MMC_STOP_TRANSMISSION (error or not).

So, I will try your proposition to set cmdreg_stop bit in 
mmci_start_command() if the command is MMC_STOP_TRANSMISSION.

> 
> And actually, I think this change alone should be a separate patch
> coming before $subject patch in the series, as it addresses the first
> problem of two.
> 
>>   {
>> +       struct mmc_command *stop = &host->stop_abort;
>> +       struct mmc_data *data = host->data;
>> +       unsigned int cmd = 0;
>> +
>>          mmci_write_datactrlreg(host, 0);
>>          mmci_set_mask1(host, 0);
>>          host->data = NULL;
>> +
>> +       if (host->variant->cmdreg_stop) {
>> +               cmd |= host->variant->cmdreg_stop;
>> +               if (!data->stop) {
>> +                       memset(stop, 0, sizeof(struct mmc_command));
>> +                       stop->opcode = MMC_STOP_TRANSMISSION;
>> +                       stop->arg = 0;
>> +                       stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
>> +                       data->stop = stop;
> 
> I don't understand why you want the host->stop_abort being present in
> the mmci host struct? Can we get rid of that?
> 
> Anyway, re-using the data->stop pointer seems reasonable.

In fact mrq->data->stop could be not referenced (NULL).

for data command, the stop command is allocated in mmc_blk_request
struct mmc_blk_request {
   struct mmc_command stop;
};
struct mmc_data {
   struct mmc_command *stop;
};
struct mmc_request {
   struct mmc_command *stop;
};

in mmc_blk_rw_rq_prep function:
if data.blocks > 1
	brq->mrq.stop = &brq->stop;
else
	brq->mrq.stop = NULL;

in mmc_mrq_prep function:
if (mrq->stop) {
	mrq->data->stop = mrq->stop;


Update about this topic:
This last week I found a new specific need for sdmmc variant.
On response type MMC_RSP_BUSY (example mmc_switch command cmd6, AC
command without data): SDMMC needs to set MMCIDATATIMER to define
busy_timeout.
If timeout expires Datatimeout and DPSM flags occur.
So a MMC_STOP_TRANSMISSION with cmdreg_stop bit is required to
abort and reinitialize the DPSM.

So, I think we could keep "host->stop_abort" which may be used in
cmd or data requests. The stop_abort command is always the same, so
stop_abort command could be initialized only while probe function (under 
variant->cmdreg_stop).

What do you think about it ?

> 
>> +               }
>> +       }
>> +
>> +       return cmd;
>>   }
>>
>>   static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
>> @@ -703,6 +721,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>                unsigned int status)
>>   {
>>          unsigned int status_err;
>> +       unsigned int cmd_reg = 0;
>>
>>          /* Make sure we have data to handle */
>>          if (!data)
>> @@ -761,7 +780,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>          if (status & MCI_DATAEND || data->error) {
>>                  mmci_dma_finalize(host, data);
>>
>> -               mmci_stop_data(host);
>> +               cmd_reg = mmci_stop_data(host);
>>
>>                  if (!data->error)
>>                          /* The error clause is handled above, success! */
>> @@ -770,7 +789,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>>                  if (!data->stop || host->mrq->sbc) {
>>                          mmci_request_end(host, data->mrq);
>>                  } else {
>> -                       mmci_start_command(host, data->stop, 0);
>> +                       mmci_start_command(host, data->stop, cmd_reg);
>>                  }
>>          }
>>   }
>> @@ -780,6 +799,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>               unsigned int status)
>>   {
>>          void __iomem *base = host->base;
>> +       struct mmc_data *data = host->data;
>> +       unsigned int cmd_reg = 0;
>>          bool sbc;
>>
>>          if (!cmd)
>> @@ -865,11 +886,16 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
>>          }
>>
>>          if ((!sbc && !cmd->data) || cmd->error) {
>> -               if (host->data) {
>> +               if (data) {
>>                          /* Terminate the DMA transfer */
>>                          mmci_dma_error(host);
>>
>> -                       mmci_stop_data(host);
>> +                       cmd_reg = mmci_stop_data(host);
>> +
>> +                       if (data->stop) {
> 
> This means a change in behavior for !host->variant->cmdreg_stop
> variants, because the mmc core may have assigned data->stop. Did you
> test this path for any of the old variants?
I just tested on:
-stm32f7 => close to pl180 variant.
-stm32h7 and mp1 => sdmmc variant.
-I like try to snowball but I've not yet find this board.
-no arm or qcom boards

that seem ok for the both (f7/mp1).

> 
> The change as such anyway seems like a good idea. If we had data, we
> may play safe and send a stop command to let the card to try to close
> down the transfer. On the other hand, we don't want this to come as
> side-effect, but rather it deserves is own standalone patch.
> 
> I guess there are two options going forward.
> 1) Split the patch and see if this works for other variants first and
> the add your changes on top for the new ST variant.
> 2) Make this change only to affect the new ST variant.

At first time, I prefer not to have a side effect on other variant.
This part must be rework, like I note above in "Update about this 
topic", the stop transmission with cmdreg_stop bit could be send
on command without data (like cmd6: mmc_switch)

> 
> I am fine with both.
> 
>> +                               mmci_start_command(host, data->stop, cmd_reg);
>> +                               return;
>> +                       }
>>                  }
>>                  mmci_request_end(host, host->mrq);
>>          } else if (sbc) {
>> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
>> index 2d7e901..4b4cd1d 100644
>> --- a/drivers/mmc/host/mmci.h
>> +++ b/drivers/mmc/host/mmci.h
>> @@ -243,6 +243,7 @@ struct mmci_host;
>>    * @cmdreg_lrsp_crc: enable value for long response with crc
>>    * @cmdreg_srsp_crc: enable value for short response with crc
>>    * @cmdreg_srsp: enable value for short response without crc
>> + * @cmdreg_stop: enable value for stop and abort transmission
>>    * @datalength_bits: number of bits in the MMCIDATALENGTH register
>>    * @fifosize: number of bytes that can be written when MMCI_TXFIFOEMPTY
>>    *           is asserted (likewise for RX)
>> @@ -298,6 +299,7 @@ struct variant_data {
>>          unsigned int            cmdreg_lrsp_crc;
>>          unsigned int            cmdreg_srsp_crc;
>>          unsigned int            cmdreg_srsp;
>> +       unsigned int            cmdreg_stop;
>>          unsigned int            datalength_bits;
>>          unsigned int            fifosize;
>>          unsigned int            fifohalfsize;
>> @@ -343,6 +345,7 @@ struct mmci_host {
>>          struct mmc_request      *mrq;
>>          struct mmc_command      *cmd;
>>          struct mmc_data         *data;
>> +       struct mmc_command      stop_abort;
>>          struct mmc_host         *mmc;
>>          struct clk              *clk;
>>          bool                    singleirq;
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 

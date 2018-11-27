Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0217C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836BD208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836BD208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbeK0LqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:46:12 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:34196 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeK0LqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:46:12 -0500
X-Greylist: delayed 414 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2018 06:46:10 EST
Received: from shawn.lin?rock-chips.com (unknown [192.168.167.225])
        by lucky1.263xmail.com (Postfix) with ESMTP id 408632D1;
        Tue, 27 Nov 2018 08:43:12 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2310T140245714597632S1543279391070572_;
        Tue, 27 Nov 2018 08:43:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3eb034347292c05a75cd01c3ecb673dc>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dw_mmc: IDMAC Invalidate cache after read
To:     Robin Murphy <robin.murphy@arm.com>,
        JABLONSKY Jan <Jan.JABLONSKY@thalesgroup.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
References: <1542786115.18775.83.camel@atviedlbe741.rss.d3s.at.thales>
 <a45eca28-fd89-e595-5b34-689bc3a09b9c@arm.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <d20a3c39-dea7-e324-e677-ec416c16559c@rock-chips.com>
Date:   Tue, 27 Nov 2018 08:43:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a45eca28-fd89-e595-5b34-689bc3a09b9c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/23 23:29, Robin Murphy wrote:
> Hi Jan,
> 
> [repeating some of the discussion from your other thread for the benefit 
> of the MMC audience]
> 
> On 21/11/2018 07:42, JABLONSKY Jan wrote:
>> CPU may not see most up-to-date and correct copy of DMA buffer, when
>> internal DMA controller is in use.
>> Problem appears on The Altera SoC FPGA (uses integrated DMA controller),
>> during higher CPU and system memory load
>>
>> Signed-off-by: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 80dc2fd..63873d9 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -499,8 +499,7 @@ static void dw_mci_dmac_complete_dma(void *arg)
>>       dev_vdbg(host->dev, "DMA complete\n");
>> -    if ((host->use_dma == TRANS_MODE_EDMAC) &&
>> -        data && (data->flags & MMC_DATA_READ))
>> +    if (data && (data->flags & MMC_DATA_READ))
>>           /* Invalidate cache after read */
>>           dma_sync_sg_for_cpu(mmc_dev(host->slot->mmc),
>>                       data->sg,
> 
> It looks very dubious whether this is actually the right thing to do. 
> Just considering this driver, edma has an complementary sync_sg call in 
> its .start method, so if idma needed this one, logically shouldn't it 
> also need the other one as well?
> 
> However, from a DMA API point of view, these syncs make no sense either 
> way - the very next thing we do here is call host->dma_ops->cleanup(), 
> which calls dma_unmap_sg(), which will perform the appropriate cache 
> maintenance anyway. Thus I can't see why this code is even here to begin 
> with. Similarly on the request path - the sg list really shouldn't have 
> been touched since being mapped in dw_mci_pre_dma_transfer(), so that 
> sync should also be an effective no-op unless it's papering over some 
> race condition elsewhere.
> 
> Shawn - do you remember why these syncs were added in 3fc7eaef44dbc? 
> Were you seeing actual coherency issues on RK31xx SoCs, or was it 
> perhaps just some leftover or misunderstanding which missed getting 
> cleaned up?

I  can't remember too much details but looking at the dma-mapping code 
again, it seems the complemetary sync-op here is useless.

> 
> Robin.
> 
> 
> 



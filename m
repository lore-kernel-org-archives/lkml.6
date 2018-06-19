Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6439D2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="li3yLdcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6439D2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937843AbeFSMwb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:52:31 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:46491 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937814AbeFSMw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi; s=20161220;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=TrbIG8UEZnaXzIaYcW4xh/bqldMu6mg2Q81NlRiJAY4=;
        b=li3yLdcjM5uzqJPisaPoz9a9/y3X2yg4Y2EZTJ6qUt7lYwCNEaQLQm2D++DLIJnjVMpF+ZyMfvlhWQdwQzI/0Qee2aXwrEem5NMkZE0NnfDi3SoomGpatocSQdDDkuQVCKDe/QY+dfaqitiAUNbhtjhRAKefRzo9Lk0yVjHvvDoRvLL52mppyyRY8nsOv/FQujlN0ExWBEyp1Onr5TDJuGNXE6llEjGdicKiPHgwNOW2SgNMe9ZVv1ZeyTJNBiZM6Hc3fLxWoTMU0R2rGj1HvkbG1dGWa9kUQRkfsDCB7hU2umf05ZgvSvDsumcCVwCJ2SaK4WAWlr0j/i4sjRLYYw==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fVG7T-0000I0-OK; Tue, 19 Jun 2018 15:52:23 +0300
Subject: Re: [PATCH 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
To:     Jon Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, jassisinghbrar@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com
Cc:     araza@nvidia.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-5-mperttunen@nvidia.com>
 <8306b033-e7f5-748c-6e6a-131dfd6a26b8@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <11fd8a32-87f1-6e90-fa1e-9399d5222611@kapsi.fi>
Date:   Tue, 19 Jun 2018 15:52:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8306b033-e7f5-748c-6e6a-131dfd6a26b8@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2018 18:36, Jon Hunter wrote:
> 
> On 08/05/18 12:43, Mikko Perttunen wrote:
>> The HSP driver is currently in many places written with the assumption
>> of only supporting doorbells. Prepare for the addition of shared
>> mailbox support by removing these assumptions and cleaning up the code.
>>
>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>> ---
>>   drivers/mailbox/tegra-hsp.c | 124 
>> +++++++++++++++++++++++++++++---------------
>>   1 file changed, 82 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
>> index 0cde356c11ab..16eb970f2c9f 100644
>> --- a/drivers/mailbox/tegra-hsp.c
>> +++ b/drivers/mailbox/tegra-hsp.c
>> @@ -1,5 +1,5 @@
>>   /*
>> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
>> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>>    *
>>    * This program is free software; you can redistribute it and/or 
>> modify it
>>    * under the terms and conditions of the GNU General Public License,
>> @@ -42,6 +42,7 @@ struct tegra_hsp_channel;
>>   struct tegra_hsp;
>>   struct tegra_hsp_channel {
>> +    unsigned int type;
>>       struct tegra_hsp *hsp;
>>       struct mbox_chan *chan;
>>       void __iomem *regs;
>> @@ -55,6 +56,12 @@ struct tegra_hsp_doorbell {
>>       unsigned int index;
>>   };
>> +static inline struct tegra_hsp_doorbell *
>> +channel_to_doorbell(struct tegra_hsp_channel *channel)
>> +{
>> +    return container_of(channel, struct tegra_hsp_doorbell, channel);
>> +}
>> +
>>   struct tegra_hsp_db_map {
>>       const char *name;
>>       unsigned int master;
>> @@ -69,7 +76,7 @@ struct tegra_hsp {
>>       const struct tegra_hsp_soc *soc;
>>       struct mbox_controller mbox;
>>       void __iomem *regs;
>> -    unsigned int irq;
>> +    unsigned int doorbell_irq;
>>       unsigned int num_sm;
>>       unsigned int num_as;
>>       unsigned int num_ss;
>> @@ -194,7 +201,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, 
>> const char *name,
>>       if (!db)
>>           return ERR_PTR(-ENOMEM);
>> -    offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
>> +    offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * 
>> SZ_64K;
>>       offset += index * 0x100;
>>       db->channel.regs = hsp->regs + offset;
>> @@ -218,18 +225,8 @@ static void __tegra_hsp_doorbell_destroy(struct 
>> tegra_hsp_doorbell *db)
>>       kfree(db);
>>   }
>> -static int tegra_hsp_doorbell_send_data(struct mbox_chan *chan, void 
>> *data)
>> -{
>> -    struct tegra_hsp_doorbell *db = chan->con_priv;
>> -
>> -    tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
>> -
>> -    return 0;
>> -}
>> -
>> -static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
>> +static int tegra_hsp_doorbell_startup(struct tegra_hsp_doorbell *db)
>>   {
>> -    struct tegra_hsp_doorbell *db = chan->con_priv;
>>       struct tegra_hsp *hsp = db->channel.hsp;
>>       struct tegra_hsp_doorbell *ccplex;
>>       unsigned long flags;
>> @@ -260,9 +257,8 @@ static int tegra_hsp_doorbell_startup(struct 
>> mbox_chan *chan)
>>       return 0;
>>   }
>> -static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
>> +static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
>>   {
>> -    struct tegra_hsp_doorbell *db = chan->con_priv;
>>       struct tegra_hsp *hsp = db->channel.hsp;
>>       struct tegra_hsp_doorbell *ccplex;
>>       unsigned long flags;
>> @@ -281,35 +277,61 @@ static void tegra_hsp_doorbell_shutdown(struct 
>> mbox_chan *chan)
>>       spin_unlock_irqrestore(&hsp->lock, flags);
>>   }
>> -static const struct mbox_chan_ops tegra_hsp_doorbell_ops = {
>> -    .send_data = tegra_hsp_doorbell_send_data,
>> -    .startup = tegra_hsp_doorbell_startup,
>> -    .shutdown = tegra_hsp_doorbell_shutdown,
>> +static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
>> +{
>> +    struct tegra_hsp_channel *channel = chan->con_priv;
>> +    struct tegra_hsp_doorbell *db;
>> +
>> +    switch (channel->type) {
>> +    case TEGRA_HSP_MBOX_TYPE_DB:
>> +        db = channel_to_doorbell(channel);
>> +        tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
> 
> The above appears to be redundant. We go from channel to db and then end 
> up passing channels. Do we really need the 'db' struct above?

Fixed.

> 
>> +    }
>> +
>> +    return -EINVAL;
> 
> Does this function always return -EINVAL?

Fixed.

> 
>> +}
>> +
>> +static int tegra_hsp_startup(struct mbox_chan *chan)
>> +{
>> +    struct tegra_hsp_channel *channel = chan->con_priv;
>> +
>> +    switch (channel->type) {
>> +    case TEGRA_HSP_MBOX_TYPE_DB:
>> +        return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +static void tegra_hsp_shutdown(struct mbox_chan *chan)
>> +{
>> +    struct tegra_hsp_channel *channel = chan->con_priv;
>> +
>> +    switch (channel->type) {
>> +    case TEGRA_HSP_MBOX_TYPE_DB:
>> +        tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
>> +        break;
>> +    }
>> +}
>> +
>> +static const struct mbox_chan_ops tegra_hsp_ops = {
>> +    .send_data = tegra_hsp_send_data,
>> +    .startup = tegra_hsp_startup,
>> +    .shutdown = tegra_hsp_shutdown,
>>   };
>> -static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller 
>> *mbox,
>> -                        const struct of_phandle_args *args)
>> +static struct mbox_chan *tegra_hsp_doorbell_xlate(struct tegra_hsp *hsp,
>> +                          unsigned int master)
>>   {
>>       struct tegra_hsp_channel *channel = ERR_PTR(-ENODEV);
>> -    struct tegra_hsp *hsp = to_tegra_hsp(mbox);
>> -    unsigned int type = args->args[0];
>> -    unsigned int master = args->args[1];
>>       struct tegra_hsp_doorbell *db;
>>       struct mbox_chan *chan;
>>       unsigned long flags;
>>       unsigned int i;
>> -    switch (type) {
>> -    case TEGRA_HSP_MBOX_TYPE_DB:
>> -        db = tegra_hsp_doorbell_get(hsp, master);
>> -        if (db)
>> -            channel = &db->channel;
>> -
>> -        break;
>> -
>> -    default:
>> -        break;
>> -    }
>> +    db = tegra_hsp_doorbell_get(hsp, master);
>> +    if (db)
>> +        channel = &db->channel;
>>       if (IS_ERR(channel))
>>           return ERR_CAST(channel);
>> @@ -321,6 +343,7 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct 
>> mbox_controller *mbox,
>>           if (!chan->con_priv) {
>>               chan->con_priv = channel;
>>               channel->chan = chan;
>> +            channel->type = TEGRA_HSP_MBOX_TYPE_DB;
>>               break;
> 
> I see that you are making the above only used for doorbells, but don't 
> we still need to set the chan->con_priv for shared mailboxes as well?

That's done elsewhere in the next patch that actually adds the shared 
mailbox support.

> 
> Cheers
> Jon
> 

Thanks,
Mikko

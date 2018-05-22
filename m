Return-Path: <jonathanh@nvidia.com>
X-Google-Smtp-Source: AB8JxZpGuSJU1PznwpewtuAIXfDPyi7nbHZEb91uY/si6Hg44zGl/bUSeOISXFtJ/7Hdj+LgSpxj
ARC-Seal: i=1; a=rsa-sha256; t=1527003408; cv=none;
        d=google.com; s=arc-20160816;
        b=tKX0G2VHzQugtbJr9zb4uHIYQPlYmtHoYdHNTozqUW1Re4AutPa4cyNLZSpQca+CHr
         T6NgrEWNR3fsFlUilJscw0p9FgR8atCxh2NUMBvQSXMMxdyHWlaZkdMiBRB3NTg2AKqw
         n+wTO763NzQFtnblxvlqZQm8hBkkOwkTuWhxFQl/y+mNNuEVYy4VbZeR6j0awrCFlcmZ
         9N+u+ubuQg12PNfe5dVJLnNoCXhKOwR9f+l1LyHvxfJYcGEHOHlqCfpU/ASFkhwjnv8x
         cU5ZTStmafFEKqIrbWe4ApmJE+HwuECXNL525uyue8ckG7x+zS39V+3MhQd+ts9jzuNr
         iS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=/w8DgRVODCU9zJNY6tj8og9adTs1gRh6Cx4OcGg2QvM=;
        b=a8AO7Grx6b9fUd1qV2nXX5Y0Gb8gTqpOikzaDdpixwEsNlZGwoNRQpCTmWuz90fU7a
         muvcyITLZgW379+M0G2Q8vNTeHajfDJ9NIkzp0gVfJQ0YHxVzUIfR2KQsK+NaaPvKDy3
         pQzcJWUQe0DQYlsMPmI2o244ycoOWsK7YL9ZimbE1EU0fYd0FJrzGwrsz8qVFQKpJWxg
         zFn0y9PvVARFkqQScKX1em9zwLKGgBu3XGWxWpTT4OL7PH7zmWP81Ebg0nh7W2zC1UhO
         FoxG4MPfSeLuNLUOOrPkQur4PMyBBGR2WQiOw+WZi4qTfYyR1zOcULmj5IIq2A6gFibo
         jIyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathanh@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=jonathanh@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Tue, 22 May 2018 08:36:49 -0700
Subject: Re: [PATCH 4/8] mailbox: tegra-hsp: Refactor in preparation of
 mailboxes
To: Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
	<gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC: <araza@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20180508114403.14499-1-mperttunen@nvidia.com>
 <20180508114403.14499-5-mperttunen@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8306b033-e7f5-748c-6e6a-131dfd6a26b8@nvidia.com>
Date: Tue, 22 May 2018 16:36:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508114403.14499-5-mperttunen@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599896472420172969?=
X-GMAIL-MSGID: =?utf-8?q?1601179125437155667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 08/05/18 12:43, Mikko Perttunen wrote:
> The HSP driver is currently in many places written with the assumption
> of only supporting doorbells. Prepare for the addition of shared
> mailbox support by removing these assumptions and cleaning up the code.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>   drivers/mailbox/tegra-hsp.c | 124 +++++++++++++++++++++++++++++---------------
>   1 file changed, 82 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 0cde356c11ab..16eb970f2c9f 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
> + * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
>    *
>    * This program is free software; you can redistribute it and/or modify it
>    * under the terms and conditions of the GNU General Public License,
> @@ -42,6 +42,7 @@ struct tegra_hsp_channel;
>   struct tegra_hsp;
>   
>   struct tegra_hsp_channel {
> +	unsigned int type;
>   	struct tegra_hsp *hsp;
>   	struct mbox_chan *chan;
>   	void __iomem *regs;
> @@ -55,6 +56,12 @@ struct tegra_hsp_doorbell {
>   	unsigned int index;
>   };
>   
> +static inline struct tegra_hsp_doorbell *
> +channel_to_doorbell(struct tegra_hsp_channel *channel)
> +{
> +	return container_of(channel, struct tegra_hsp_doorbell, channel);
> +}
> +
>   struct tegra_hsp_db_map {
>   	const char *name;
>   	unsigned int master;
> @@ -69,7 +76,7 @@ struct tegra_hsp {
>   	const struct tegra_hsp_soc *soc;
>   	struct mbox_controller mbox;
>   	void __iomem *regs;
> -	unsigned int irq;
> +	unsigned int doorbell_irq;
>   	unsigned int num_sm;
>   	unsigned int num_as;
>   	unsigned int num_ss;
> @@ -194,7 +201,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
>   	if (!db)
>   		return ERR_PTR(-ENOMEM);
>   
> -	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
> +	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K;
>   	offset += index * 0x100;
>   
>   	db->channel.regs = hsp->regs + offset;
> @@ -218,18 +225,8 @@ static void __tegra_hsp_doorbell_destroy(struct tegra_hsp_doorbell *db)
>   	kfree(db);
>   }
>   
> -static int tegra_hsp_doorbell_send_data(struct mbox_chan *chan, void *data)
> -{
> -	struct tegra_hsp_doorbell *db = chan->con_priv;
> -
> -	tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);
> -
> -	return 0;
> -}
> -
> -static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
> +static int tegra_hsp_doorbell_startup(struct tegra_hsp_doorbell *db)
>   {
> -	struct tegra_hsp_doorbell *db = chan->con_priv;
>   	struct tegra_hsp *hsp = db->channel.hsp;
>   	struct tegra_hsp_doorbell *ccplex;
>   	unsigned long flags;
> @@ -260,9 +257,8 @@ static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
>   	return 0;
>   }
>   
> -static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
> +static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
>   {
> -	struct tegra_hsp_doorbell *db = chan->con_priv;
>   	struct tegra_hsp *hsp = db->channel.hsp;
>   	struct tegra_hsp_doorbell *ccplex;
>   	unsigned long flags;
> @@ -281,35 +277,61 @@ static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
>   	spin_unlock_irqrestore(&hsp->lock, flags);
>   }
>   
> -static const struct mbox_chan_ops tegra_hsp_doorbell_ops = {
> -	.send_data = tegra_hsp_doorbell_send_data,
> -	.startup = tegra_hsp_doorbell_startup,
> -	.shutdown = tegra_hsp_doorbell_shutdown,
> +static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct tegra_hsp_channel *channel = chan->con_priv;
> +	struct tegra_hsp_doorbell *db;
> +
> +	switch (channel->type) {
> +	case TEGRA_HSP_MBOX_TYPE_DB:
> +		db = channel_to_doorbell(channel);
> +		tegra_hsp_channel_writel(&db->channel, 1, HSP_DB_TRIGGER);

The above appears to be redundant. We go from channel to db and then end 
up passing channels. Do we really need the 'db' struct above?

> +	}
> +
> +	return -EINVAL;

Does this function always return -EINVAL?

> +}
> +
> +static int tegra_hsp_startup(struct mbox_chan *chan)
> +{
> +	struct tegra_hsp_channel *channel = chan->con_priv;
> +
> +	switch (channel->type) {
> +	case TEGRA_HSP_MBOX_TYPE_DB:
> +		return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void tegra_hsp_shutdown(struct mbox_chan *chan)
> +{
> +	struct tegra_hsp_channel *channel = chan->con_priv;
> +
> +	switch (channel->type) {
> +	case TEGRA_HSP_MBOX_TYPE_DB:
> +		tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
> +		break;
> +	}
> +}
> +
> +static const struct mbox_chan_ops tegra_hsp_ops = {
> +	.send_data = tegra_hsp_send_data,
> +	.startup = tegra_hsp_startup,
> +	.shutdown = tegra_hsp_shutdown,
>   };
>   
> -static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
> -					    const struct of_phandle_args *args)
> +static struct mbox_chan *tegra_hsp_doorbell_xlate(struct tegra_hsp *hsp,
> +						  unsigned int master)
>   {
>   	struct tegra_hsp_channel *channel = ERR_PTR(-ENODEV);
> -	struct tegra_hsp *hsp = to_tegra_hsp(mbox);
> -	unsigned int type = args->args[0];
> -	unsigned int master = args->args[1];
>   	struct tegra_hsp_doorbell *db;
>   	struct mbox_chan *chan;
>   	unsigned long flags;
>   	unsigned int i;
>   
> -	switch (type) {
> -	case TEGRA_HSP_MBOX_TYPE_DB:
> -		db = tegra_hsp_doorbell_get(hsp, master);
> -		if (db)
> -			channel = &db->channel;
> -
> -		break;
> -
> -	default:
> -		break;
> -	}
> +	db = tegra_hsp_doorbell_get(hsp, master);
> +	if (db)
> +		channel = &db->channel;
>   
>   	if (IS_ERR(channel))
>   		return ERR_CAST(channel);
> @@ -321,6 +343,7 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
>   		if (!chan->con_priv) {
>   			chan->con_priv = channel;
>   			channel->chan = chan;
> +			channel->type = TEGRA_HSP_MBOX_TYPE_DB;
>   			break;

I see that you are making the above only used for doorbells, but don't 
we still need to set the chan->con_priv for shared mailboxes as well?

Cheers
Jon

-- 
nvpublic

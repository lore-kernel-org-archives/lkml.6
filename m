Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89686C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20109218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+QL/sPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfBFWRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 17:17:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39505 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 17:17:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so3554527pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=r/dl3Vsvn5PoU6Hsu9RivCtB/Q+TsVZ1QO2xTvFxUXs=;
        b=T+QL/sPxMpWJZ77BJ029lbyI/aaw23zzlYa9/xSOF+1gMkGhDWEGalG8P+qsY7ZJB2
         pR671zcTeeTn/etCrgSFI0YuN905Siu4+w8HQYcHZ82O2RylLNqF9GExky9I+QnN8RB+
         aJgMoNE344vUtKeY9noNmFWZkGsI/SQHibtykBjKTSYJJmWqdpm9rzJjLtIsyAv3fAUd
         7hSJzgDF8RzmNbV8/5Yno4xvlkpw6WBJ02CwV6+cJwL+vNg7ixhd+VNMtQYD1MMBpi/f
         G8gQ5Ypklr6PgkMBbmDxamEYxYplu3YqyvVj9wbTIxbBvD0/KNjpn4A/1WZdMKMr3LQ/
         wrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=r/dl3Vsvn5PoU6Hsu9RivCtB/Q+TsVZ1QO2xTvFxUXs=;
        b=tunv1NXzUq5UuQRsIuyIJ4mxNKtiSUnUGzJycaIjlv8PNAcsTDcOTyAvYEa8CrJ0tm
         vCUphrfKnrFYv0f/97sRLy7tBoJLwgdIQkjv6JM4gjQ584fqoGLmpUA/WOhHSsj2Sgki
         kBz5S5a5bxo2wuQ7f3Mh9UneIitKew86J5KZhvrOaAwSviT0zOcX1/jkGF4NeEVpUyxJ
         YqobF5Gk2VAxTVdVKM1W5D36aLMr0XMoRHVRPg4eHPo7g9+h+42lTB/FCTdd2m+1BZ/0
         U0Ujm0sqpeDqxSxa7n86AWPo2iRosxj4dez6SI5GHsnavEriOfrBD3wjHBVgi3LDFLEB
         z6Gw==
X-Gm-Message-State: AHQUAuaxG95pbNhVPXAJm/WuJZrMEa9r9C9tEx9mzE3mTZWvPWkDDqPF
        m0jiiQjBvGvH5XFjdAy0iiE=
X-Google-Smtp-Source: AHgI3IZd/bWrzVbjrPbQ+Z462BzHcqGTrmbF9abMlIrK0SYwMb9zO4IETI6r3Y8diEjeUPgebD417Q==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr12917062pfb.55.1549491432943;
        Wed, 06 Feb 2019 14:17:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm23717047pfd.99.2019.02.06.14.17.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 14:17:12 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:17:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Timo Alho <talho@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: Refactor BPMP driver
Message-ID: <20190206221711.GA21703@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 07:03:53PM +0200, Timo Alho wrote:
> Split BPMP driver into common and chip specific parts to facilitate
> adding support for previous and future Tegra chips that are using BPMP
> as co-processor.
> 
> Signed-off-by: Timo Alho <talho@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

arm:allmodconfig in linux-next:

drivers/firmware/tegra/bpmp.o:(.rodata+0x280): undefined reference to `tegra210_bpmp_ops'
drivers/firmware/tegra/bpmp.o:(.rodata+0x2ac): undefined reference to `tegra186_bpmp_ops'

Guenter

> ---
>  drivers/firmware/tegra/Makefile        |   1 +
>  drivers/firmware/tegra/bpmp-private.h  |  28 +++
>  drivers/firmware/tegra/bpmp-tegra186.c | 310 +++++++++++++++++++++++++++++++++
>  drivers/firmware/tegra/bpmp.c          | 257 ++++++---------------------
>  include/soc/tegra/bpmp.h               |  12 +-
>  5 files changed, 400 insertions(+), 208 deletions(-)
>  create mode 100644 drivers/firmware/tegra/bpmp-private.h
>  create mode 100644 drivers/firmware/tegra/bpmp-tegra186.c
> 
> diff --git a/drivers/firmware/tegra/Makefile b/drivers/firmware/tegra/Makefile
> index 1b826dcca719..559355674bca 100644
> --- a/drivers/firmware/tegra/Makefile
> +++ b/drivers/firmware/tegra/Makefile
> @@ -1,4 +1,5 @@
>  tegra-bpmp-y			= bpmp.o
> +tegra-bpmp-$(CONFIG_ARCH_TEGRA_186_SOC)	+= bpmp-tegra186.o
>  tegra-bpmp-$(CONFIG_DEBUG_FS)	+= bpmp-debugfs.o
>  obj-$(CONFIG_TEGRA_BPMP)	+= tegra-bpmp.o
>  obj-$(CONFIG_TEGRA_IVC)		+= ivc.o
> diff --git a/drivers/firmware/tegra/bpmp-private.h b/drivers/firmware/tegra/bpmp-private.h
> new file mode 100644
> index 000000000000..6fb10f1cfb8f
> --- /dev/null
> +++ b/drivers/firmware/tegra/bpmp-private.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.
> + */
> +
> +#ifndef __FIRMWARE_TEGRA_BPMP_PRIVATE_H
> +#define __FIRMWARE_TEGRA_BPMP_PRIVATE_H
> +
> +#include <soc/tegra/bpmp.h>
> +
> +struct tegra_bpmp_ops {
> +	int (*init)(struct tegra_bpmp *bpmp);
> +	void (*deinit)(struct tegra_bpmp *bpmp);
> +	bool (*is_response_ready)(struct tegra_bpmp_channel *channel);
> +	bool (*is_request_ready)(struct tegra_bpmp_channel *channel);
> +	int (*ack_response)(struct tegra_bpmp_channel *channel);
> +	int (*ack_request)(struct tegra_bpmp_channel *channel);
> +	bool (*is_response_channel_free)(struct tegra_bpmp_channel *channel);
> +	bool (*is_request_channel_free)(struct tegra_bpmp_channel *channel);
> +	int (*post_response)(struct tegra_bpmp_channel *channel);
> +	int (*post_request)(struct tegra_bpmp_channel *channel);
> +	int (*ring_doorbell)(struct tegra_bpmp *bpmp);
> +	int (*resume)(struct tegra_bpmp *bpmp);
> +};
> +
> +extern const struct tegra_bpmp_ops tegra186_bpmp_ops;
> +
> +#endif
> diff --git a/drivers/firmware/tegra/bpmp-tegra186.c b/drivers/firmware/tegra/bpmp-tegra186.c
> new file mode 100644
> index 000000000000..89bb32b97345
> --- /dev/null
> +++ b/drivers/firmware/tegra/bpmp-tegra186.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, NVIDIA CORPORATION.
> + */
> +
> +#include <linux/clk/tegra.h>
> +#include <linux/genalloc.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/semaphore.h>
> +
> +#include <soc/tegra/bpmp.h>
> +#include <soc/tegra/bpmp-abi.h>
> +#include <soc/tegra/ivc.h>
> +
> +#include "bpmp-private.h"
> +
> +struct tegra186_bpmp {
> +	struct tegra_bpmp *parent;
> +
> +	struct {
> +		struct gen_pool *pool;
> +		dma_addr_t phys;
> +		void *virt;
> +	} tx, rx;
> +
> +	struct {
> +		struct mbox_client client;
> +		struct mbox_chan *channel;
> +	} mbox;
> +};
> +
> +static inline struct tegra_bpmp *
> +mbox_client_to_bpmp(struct mbox_client *client)
> +{
> +	struct tegra186_bpmp *priv;
> +
> +	priv = container_of(client, struct tegra186_bpmp, mbox.client);
> +
> +	return priv->parent;
> +}
> +
> +static bool tegra186_bpmp_is_message_ready(struct tegra_bpmp_channel *channel)
> +{
> +	void *frame;
> +
> +	frame = tegra_ivc_read_get_next_frame(channel->ivc);
> +	if (IS_ERR(frame)) {
> +		channel->ib = NULL;
> +		return false;
> +	}
> +
> +	channel->ib = frame;
> +
> +	return true;
> +}
> +
> +static bool tegra186_bpmp_is_channel_free(struct tegra_bpmp_channel *channel)
> +{
> +	void *frame;
> +
> +	frame = tegra_ivc_write_get_next_frame(channel->ivc);
> +	if (IS_ERR(frame)) {
> +		channel->ob = NULL;
> +		return false;
> +	}
> +
> +	channel->ob = frame;
> +
> +	return true;
> +}
> +
> +static int tegra186_bpmp_ack_message(struct tegra_bpmp_channel *channel)
> +{
> +	return tegra_ivc_read_advance(channel->ivc);
> +}
> +
> +static int tegra186_bpmp_post_message(struct tegra_bpmp_channel *channel)
> +{
> +	return tegra_ivc_write_advance(channel->ivc);
> +}
> +
> +static int tegra186_bpmp_ring_doorbell(struct tegra_bpmp *bpmp)
> +{
> +	struct tegra186_bpmp *priv = bpmp->priv;
> +	int err;
> +
> +	err = mbox_send_message(priv->mbox.channel, NULL);
> +	if (err < 0)
> +		return err;
> +
> +	mbox_client_txdone(priv->mbox.channel, 0);
> +
> +	return 0;
> +}
> +
> +static void tegra186_bpmp_ivc_notify(struct tegra_ivc *ivc, void *data)
> +{
> +	struct tegra_bpmp *bpmp = data;
> +	struct tegra186_bpmp *priv = bpmp->priv;
> +
> +	if (WARN_ON(priv->mbox.channel == NULL))
> +		return;
> +
> +	tegra186_bpmp_ring_doorbell(bpmp);
> +}
> +
> +static int tegra186_bpmp_channel_init(struct tegra_bpmp_channel *channel,
> +				      struct tegra_bpmp *bpmp,
> +				      unsigned int index)
> +{
> +	struct tegra186_bpmp *priv = bpmp->priv;
> +	size_t message_size, queue_size;
> +	unsigned int offset;
> +	int err;
> +
> +	channel->ivc = devm_kzalloc(bpmp->dev, sizeof(*channel->ivc),
> +				    GFP_KERNEL);
> +	if (!channel->ivc)
> +		return -ENOMEM;
> +
> +	message_size = tegra_ivc_align(MSG_MIN_SZ);
> +	queue_size = tegra_ivc_total_queue_size(message_size);
> +	offset = queue_size * index;
> +
> +	err = tegra_ivc_init(channel->ivc, NULL,
> +			     priv->rx.virt + offset, priv->rx.phys + offset,
> +			     priv->tx.virt + offset, priv->tx.phys + offset,
> +			     1, message_size, tegra186_bpmp_ivc_notify,
> +			     bpmp);
> +	if (err < 0) {
> +		dev_err(bpmp->dev, "failed to setup IVC for channel %u: %d\n",
> +			index, err);
> +		return err;
> +	}
> +
> +	init_completion(&channel->completion);
> +	channel->bpmp = bpmp;
> +
> +	return 0;
> +}
> +
> +static void tegra186_bpmp_channel_reset(struct tegra_bpmp_channel *channel)
> +{
> +	/* reset the channel state */
> +	tegra_ivc_reset(channel->ivc);
> +
> +	/* sync the channel state with BPMP */
> +	while (tegra_ivc_notified(channel->ivc))
> +		;
> +}
> +
> +static void tegra186_bpmp_channel_cleanup(struct tegra_bpmp_channel *channel)
> +{
> +	tegra_ivc_cleanup(channel->ivc);
> +}
> +
> +static void mbox_handle_rx(struct mbox_client *client, void *data)
> +{
> +	struct tegra_bpmp *bpmp = mbox_client_to_bpmp(client);
> +
> +	tegra_bpmp_handle_rx(bpmp);
> +}
> +
> +static int tegra186_bpmp_init(struct tegra_bpmp *bpmp)
> +{
> +	struct tegra186_bpmp *priv;
> +	unsigned int i;
> +	int err;
> +
> +	priv = devm_kzalloc(bpmp->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	bpmp->priv = priv;
> +	priv->parent = bpmp;
> +
> +	priv->tx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 0);
> +	if (!priv->tx.pool) {
> +		dev_err(bpmp->dev, "TX shmem pool not found\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv->tx.virt = gen_pool_dma_alloc(priv->tx.pool, 4096, &priv->tx.phys);
> +	if (!priv->tx.virt) {
> +		dev_err(bpmp->dev, "failed to allocate from TX pool\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv->rx.pool = of_gen_pool_get(bpmp->dev->of_node, "shmem", 1);
> +	if (!priv->rx.pool) {
> +		dev_err(bpmp->dev, "RX shmem pool not found\n");
> +		err = -ENOMEM;
> +		goto free_tx;
> +	}
> +
> +	priv->rx.virt = gen_pool_dma_alloc(priv->rx.pool, 4096, &priv->rx.phys);
> +	if (!priv->rx.virt) {
> +		dev_err(bpmp->dev, "failed to allocate from RX pool\n");
> +		err = -ENOMEM;
> +		goto free_tx;
> +	}
> +
> +	err = tegra186_bpmp_channel_init(bpmp->tx_channel, bpmp,
> +					 bpmp->soc->channels.cpu_tx.offset);
> +	if (err < 0)
> +		goto free_rx;
> +
> +	err = tegra186_bpmp_channel_init(bpmp->rx_channel, bpmp,
> +					 bpmp->soc->channels.cpu_rx.offset);
> +	if (err < 0)
> +		goto cleanup_tx_channel;
> +
> +	for (i = 0; i < bpmp->threaded.count; i++) {
> +		unsigned int index = bpmp->soc->channels.thread.offset + i;
> +
> +		err = tegra186_bpmp_channel_init(&bpmp->threaded_channels[i],
> +						 bpmp, index);
> +		if (err < 0)
> +			goto cleanup_channels;
> +	}
> +
> +	/* mbox registration */
> +	priv->mbox.client.dev = bpmp->dev;
> +	priv->mbox.client.rx_callback = mbox_handle_rx;
> +	priv->mbox.client.tx_block = false;
> +	priv->mbox.client.knows_txdone = false;
> +
> +	priv->mbox.channel = mbox_request_channel(&priv->mbox.client, 0);
> +	if (IS_ERR(priv->mbox.channel)) {
> +		err = PTR_ERR(priv->mbox.channel);
> +		dev_err(bpmp->dev, "failed to get HSP mailbox: %d\n", err);
> +		goto cleanup_channels;
> +	}
> +
> +	tegra186_bpmp_channel_reset(bpmp->tx_channel);
> +	tegra186_bpmp_channel_reset(bpmp->rx_channel);
> +
> +	for (i = 0; i < bpmp->threaded.count; i++)
> +		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
> +
> +	return 0;
> +
> +cleanup_channels:
> +	for (i = 0; i < bpmp->threaded.count; i++) {
> +		if (!bpmp->threaded_channels[i].bpmp)
> +			continue;
> +
> +		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> +	}
> +
> +	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
> +cleanup_tx_channel:
> +	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> +free_rx:
> +	gen_pool_free(priv->rx.pool, (unsigned long)priv->rx.virt, 4096);
> +free_tx:
> +	gen_pool_free(priv->tx.pool, (unsigned long)priv->tx.virt, 4096);
> +
> +	return err;
> +}
> +
> +static void tegra186_bpmp_deinit(struct tegra_bpmp *bpmp)
> +{
> +	struct tegra186_bpmp *priv = bpmp->priv;
> +	unsigned int i;
> +
> +	mbox_free_channel(priv->mbox.channel);
> +
> +	for (i = 0; i < bpmp->threaded.count; i++)
> +		tegra186_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> +
> +	tegra186_bpmp_channel_cleanup(bpmp->rx_channel);
> +	tegra186_bpmp_channel_cleanup(bpmp->tx_channel);
> +
> +	gen_pool_free(priv->rx.pool, (unsigned long)priv->rx.virt, 4096);
> +	gen_pool_free(priv->tx.pool, (unsigned long)priv->tx.virt, 4096);
> +}
> +
> +static int tegra186_bpmp_resume(struct tegra_bpmp *bpmp)
> +{
> +	unsigned int i;
> +
> +	/* reset message channels */
> +	tegra186_bpmp_channel_reset(bpmp->tx_channel);
> +	tegra186_bpmp_channel_reset(bpmp->rx_channel);
> +
> +	for (i = 0; i < bpmp->threaded.count; i++)
> +		tegra186_bpmp_channel_reset(&bpmp->threaded_channels[i]);
> +
> +	return 0;
> +}
> +
> +const struct tegra_bpmp_ops tegra186_bpmp_ops = {
> +	.init = tegra186_bpmp_init,
> +	.deinit = tegra186_bpmp_deinit,
> +	.is_response_ready = tegra186_bpmp_is_message_ready,
> +	.is_request_ready = tegra186_bpmp_is_message_ready,
> +	.ack_response = tegra186_bpmp_ack_message,
> +	.ack_request = tegra186_bpmp_ack_message,
> +	.is_response_channel_free = tegra186_bpmp_is_channel_free,
> +	.is_request_channel_free = tegra186_bpmp_is_channel_free,
> +	.post_response = tegra186_bpmp_post_message,
> +	.post_request = tegra186_bpmp_post_message,
> +	.ring_doorbell = tegra186_bpmp_ring_doorbell,
> +	.resume = tegra186_bpmp_resume,
> +};
> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
> index e7fd68ebedd0..2b498deacdbc 100644
> --- a/drivers/firmware/tegra/bpmp.c
> +++ b/drivers/firmware/tegra/bpmp.c
> @@ -26,6 +26,8 @@
>  #include <soc/tegra/bpmp-abi.h>
>  #include <soc/tegra/ivc.h>
>  
> +#include "bpmp-private.h"
> +
>  #define MSG_ACK		BIT(0)
>  #define MSG_RING	BIT(1)
>  #define TAG_SZ		32
> @@ -36,6 +38,14 @@ mbox_client_to_bpmp(struct mbox_client *client)
>  	return container_of(client, struct tegra_bpmp, mbox.client);
>  }
>  
> +static inline const struct tegra_bpmp_ops *
> +channel_to_ops(struct tegra_bpmp_channel *channel)
> +{
> +	struct tegra_bpmp *bpmp = channel->bpmp;
> +
> +	return bpmp->soc->ops;
> +}
> +
>  struct tegra_bpmp *tegra_bpmp_get(struct device *dev)
>  {
>  	struct platform_device *pdev;
> @@ -98,22 +108,16 @@ static bool tegra_bpmp_message_valid(const struct tegra_bpmp_message *msg)
>  
>  static bool tegra_bpmp_is_response_ready(struct tegra_bpmp_channel *channel)
>  {
> -	void *frame;
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
>  
> -	frame = tegra_ivc_read_get_next_frame(channel->ivc);
> -	if (IS_ERR(frame)) {
> -		channel->ib = NULL;
> -		return false;
> -	}
> -
> -	channel->ib = frame;
> -
> -	return true;
> +	return ops->is_response_ready(channel);
>  }
>  
>  static bool tegra_bpmp_is_request_ready(struct tegra_bpmp_channel *channel)
>  {
> -	return tegra_bpmp_is_response_ready(channel);
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
> +
> +	return ops->is_request_ready(channel);
>  }
>  
>  static int tegra_bpmp_wait_response(struct tegra_bpmp_channel *channel)
> @@ -133,34 +137,32 @@ static int tegra_bpmp_wait_response(struct tegra_bpmp_channel *channel)
>  
>  static int tegra_bpmp_ack_response(struct tegra_bpmp_channel *channel)
>  {
> -	return tegra_ivc_read_advance(channel->ivc);
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
> +
> +	return ops->ack_response(channel);
>  }
>  
>  static int tegra_bpmp_ack_request(struct tegra_bpmp_channel *channel)
>  {
> -	return tegra_ivc_read_advance(channel->ivc);
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
> +
> +	return ops->ack_request(channel);
>  }
>  
>  static bool
>  tegra_bpmp_is_request_channel_free(struct tegra_bpmp_channel *channel)
>  {
> -	void *frame;
> -
> -	frame = tegra_ivc_write_get_next_frame(channel->ivc);
> -	if (IS_ERR(frame)) {
> -		channel->ob = NULL;
> -		return false;
> -	}
> -
> -	channel->ob = frame;
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
>  
> -	return true;
> +	return ops->is_request_channel_free(channel);
>  }
>  
>  static bool
>  tegra_bpmp_is_response_channel_free(struct tegra_bpmp_channel *channel)
>  {
> -	return tegra_bpmp_is_request_channel_free(channel);
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
> +
> +	return ops->is_response_channel_free(channel);
>  }
>  
>  static int
> @@ -183,28 +185,21 @@ tegra_bpmp_wait_request_channel_free(struct tegra_bpmp_channel *channel)
>  
>  static int tegra_bpmp_post_request(struct tegra_bpmp_channel *channel)
>  {
> -	return tegra_ivc_write_advance(channel->ivc);
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
> +
> +	return ops->post_request(channel);
>  }
>  
>  static int tegra_bpmp_post_response(struct tegra_bpmp_channel *channel)
>  {
> -	return tegra_ivc_write_advance(channel->ivc);
> +	const struct tegra_bpmp_ops *ops = channel_to_ops(channel);
> +
> +	return ops->post_response(channel);
>  }
>  
>  static int tegra_bpmp_ring_doorbell(struct tegra_bpmp *bpmp)
>  {
> -	int err;
> -
> -	if (WARN_ON(bpmp->mbox.channel == NULL))
> -		return -EINVAL;
> -
> -	err = mbox_send_message(bpmp->mbox.channel, NULL);
> -	if (err < 0)
> -		return err;
> -
> -	mbox_client_txdone(bpmp->mbox.channel, 0);
> -
> -	return 0;
> +	return bpmp->soc->ops->ring_doorbell(bpmp);
>  }
>  
>  static ssize_t __tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
> @@ -668,9 +663,8 @@ static void tegra_bpmp_channel_signal(struct tegra_bpmp_channel *channel)
>  	complete(&channel->completion);
>  }
>  
> -static void tegra_bpmp_handle_rx(struct mbox_client *client, void *data)
> +void tegra_bpmp_handle_rx(struct tegra_bpmp *bpmp)
>  {
> -	struct tegra_bpmp *bpmp = mbox_client_to_bpmp(client);
>  	struct tegra_bpmp_channel *channel;
>  	unsigned int i, count;
>  	unsigned long *busy;
> @@ -698,66 +692,9 @@ static void tegra_bpmp_handle_rx(struct mbox_client *client, void *data)
>  	spin_unlock(&bpmp->lock);
>  }
>  
> -static void tegra_bpmp_ivc_notify(struct tegra_ivc *ivc, void *data)
> -{
> -	struct tegra_bpmp *bpmp = data;
> -
> -	WARN_ON(tegra_bpmp_ring_doorbell(bpmp));
> -}
> -
> -static int tegra_bpmp_channel_init(struct tegra_bpmp_channel *channel,
> -				   struct tegra_bpmp *bpmp,
> -				   unsigned int index)
> -{
> -	size_t message_size, queue_size;
> -	unsigned int offset;
> -	int err;
> -
> -	channel->ivc = devm_kzalloc(bpmp->dev, sizeof(*channel->ivc),
> -				    GFP_KERNEL);
> -	if (!channel->ivc)
> -		return -ENOMEM;
> -
> -	message_size = tegra_ivc_align(MSG_MIN_SZ);
> -	queue_size = tegra_ivc_total_queue_size(message_size);
> -	offset = queue_size * index;
> -
> -	err = tegra_ivc_init(channel->ivc, NULL,
> -			     bpmp->rx.virt + offset, bpmp->rx.phys + offset,
> -			     bpmp->tx.virt + offset, bpmp->tx.phys + offset,
> -			     1, message_size, tegra_bpmp_ivc_notify,
> -			     bpmp);
> -	if (err < 0) {
> -		dev_err(bpmp->dev, "failed to setup IVC for channel %u: %d\n",
> -			index, err);
> -		return err;
> -	}
> -
> -	init_completion(&channel->completion);
> -	channel->bpmp = bpmp;
> -
> -	return 0;
> -}
> -
> -static void tegra_bpmp_channel_reset(struct tegra_bpmp_channel *channel)
> -{
> -	/* reset the channel state */
> -	tegra_ivc_reset(channel->ivc);
> -
> -	/* sync the channel state with BPMP */
> -	while (tegra_ivc_notified(channel->ivc))
> -		;
> -}
> -
> -static void tegra_bpmp_channel_cleanup(struct tegra_bpmp_channel *channel)
> -{
> -	tegra_ivc_cleanup(channel->ivc);
> -}
> -
>  static int tegra_bpmp_probe(struct platform_device *pdev)
>  {
>  	struct tegra_bpmp *bpmp;
> -	unsigned int i;
>  	char tag[TAG_SZ];
>  	size_t size;
>  	int err;
> @@ -769,32 +706,6 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
>  	bpmp->soc = of_device_get_match_data(&pdev->dev);
>  	bpmp->dev = &pdev->dev;
>  
> -	bpmp->tx.pool = of_gen_pool_get(pdev->dev.of_node, "shmem", 0);
> -	if (!bpmp->tx.pool) {
> -		dev_err(&pdev->dev, "TX shmem pool not found\n");
> -		return -ENOMEM;
> -	}
> -
> -	bpmp->tx.virt = gen_pool_dma_alloc(bpmp->tx.pool, 4096, &bpmp->tx.phys);
> -	if (!bpmp->tx.virt) {
> -		dev_err(&pdev->dev, "failed to allocate from TX pool\n");
> -		return -ENOMEM;
> -	}
> -
> -	bpmp->rx.pool = of_gen_pool_get(pdev->dev.of_node, "shmem", 1);
> -	if (!bpmp->rx.pool) {
> -		dev_err(&pdev->dev, "RX shmem pool not found\n");
> -		err = -ENOMEM;
> -		goto free_tx;
> -	}
> -
> -	bpmp->rx.virt = gen_pool_dma_alloc(bpmp->rx.pool, 4096, &bpmp->rx.phys);
> -	if (!bpmp->rx.virt) {
> -		dev_err(&pdev->dev, "failed to allocate from RX pool\n");
> -		err = -ENOMEM;
> -		goto free_tx;
> -	}
> -
>  	INIT_LIST_HEAD(&bpmp->mrqs);
>  	spin_lock_init(&bpmp->lock);
>  
> @@ -804,81 +715,38 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
>  	size = BITS_TO_LONGS(bpmp->threaded.count) * sizeof(long);
>  
>  	bpmp->threaded.allocated = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> -	if (!bpmp->threaded.allocated) {
> -		err = -ENOMEM;
> -		goto free_rx;
> -	}
> +	if (!bpmp->threaded.allocated)
> +		return -ENOMEM;
>  
>  	bpmp->threaded.busy = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> -	if (!bpmp->threaded.busy) {
> -		err = -ENOMEM;
> -		goto free_rx;
> -	}
> +	if (!bpmp->threaded.busy)
> +		return -ENOMEM;
>  
>  	spin_lock_init(&bpmp->atomic_tx_lock);
>  	bpmp->tx_channel = devm_kzalloc(&pdev->dev, sizeof(*bpmp->tx_channel),
>  					GFP_KERNEL);
> -	if (!bpmp->tx_channel) {
> -		err = -ENOMEM;
> -		goto free_rx;
> -	}
> +	if (!bpmp->tx_channel)
> +		return -ENOMEM;
>  
>  	bpmp->rx_channel = devm_kzalloc(&pdev->dev, sizeof(*bpmp->rx_channel),
>  	                                GFP_KERNEL);
> -	if (!bpmp->rx_channel) {
> -		err = -ENOMEM;
> -		goto free_rx;
> -	}
> +	if (!bpmp->rx_channel)
> +		return -ENOMEM;
>  
>  	bpmp->threaded_channels = devm_kcalloc(&pdev->dev, bpmp->threaded.count,
>  					       sizeof(*bpmp->threaded_channels),
>  					       GFP_KERNEL);
> -	if (!bpmp->threaded_channels) {
> -		err = -ENOMEM;
> -		goto free_rx;
> -	}
> -
> -	err = tegra_bpmp_channel_init(bpmp->tx_channel, bpmp,
> -				      bpmp->soc->channels.cpu_tx.offset);
> -	if (err < 0)
> -		goto free_rx;
> +	if (!bpmp->threaded_channels)
> +		return -ENOMEM;
>  
> -	err = tegra_bpmp_channel_init(bpmp->rx_channel, bpmp,
> -				      bpmp->soc->channels.cpu_rx.offset);
> +	err = bpmp->soc->ops->init(bpmp);
>  	if (err < 0)
> -		goto cleanup_tx_channel;
> -
> -	for (i = 0; i < bpmp->threaded.count; i++) {
> -		err = tegra_bpmp_channel_init(
> -			&bpmp->threaded_channels[i], bpmp,
> -			bpmp->soc->channels.thread.offset + i);
> -		if (err < 0)
> -			goto cleanup_threaded_channels;
> -	}
> -
> -	/* mbox registration */
> -	bpmp->mbox.client.dev = &pdev->dev;
> -	bpmp->mbox.client.rx_callback = tegra_bpmp_handle_rx;
> -	bpmp->mbox.client.tx_block = false;
> -	bpmp->mbox.client.knows_txdone = false;
> -
> -	bpmp->mbox.channel = mbox_request_channel(&bpmp->mbox.client, 0);
> -	if (IS_ERR(bpmp->mbox.channel)) {
> -		err = PTR_ERR(bpmp->mbox.channel);
> -		dev_err(&pdev->dev, "failed to get HSP mailbox: %d\n", err);
> -		goto cleanup_threaded_channels;
> -	}
> -
> -	/* reset message channels */
> -	tegra_bpmp_channel_reset(bpmp->tx_channel);
> -	tegra_bpmp_channel_reset(bpmp->rx_channel);
> -	for (i = 0; i < bpmp->threaded.count; i++)
> -		tegra_bpmp_channel_reset(&bpmp->threaded_channels[i]);
> +		return err;
>  
>  	err = tegra_bpmp_request_mrq(bpmp, MRQ_PING,
>  				     tegra_bpmp_mrq_handle_ping, bpmp);
>  	if (err < 0)
> -		goto free_mbox;
> +		goto deinit;
>  
>  	err = tegra_bpmp_ping(bpmp);
>  	if (err < 0) {
> @@ -920,37 +788,21 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
>  
>  free_mrq:
>  	tegra_bpmp_free_mrq(bpmp, MRQ_PING, bpmp);
> -free_mbox:
> -	mbox_free_channel(bpmp->mbox.channel);
> -cleanup_threaded_channels:
> -	for (i = 0; i < bpmp->threaded.count; i++) {
> -		if (bpmp->threaded_channels[i].bpmp)
> -			tegra_bpmp_channel_cleanup(&bpmp->threaded_channels[i]);
> -	}
> +deinit:
> +	if (bpmp->soc->ops->deinit)
> +		bpmp->soc->ops->deinit(bpmp);
>  
> -	tegra_bpmp_channel_cleanup(bpmp->rx_channel);
> -cleanup_tx_channel:
> -	tegra_bpmp_channel_cleanup(bpmp->tx_channel);
> -free_rx:
> -	gen_pool_free(bpmp->rx.pool, (unsigned long)bpmp->rx.virt, 4096);
> -free_tx:
> -	gen_pool_free(bpmp->tx.pool, (unsigned long)bpmp->tx.virt, 4096);
>  	return err;
>  }
>  
>  static int __maybe_unused tegra_bpmp_resume(struct device *dev)
>  {
>  	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
> -	unsigned int i;
> -
> -	/* reset message channels */
> -	tegra_bpmp_channel_reset(bpmp->tx_channel);
> -	tegra_bpmp_channel_reset(bpmp->rx_channel);
> -
> -	for (i = 0; i < bpmp->threaded.count; i++)
> -		tegra_bpmp_channel_reset(&bpmp->threaded_channels[i]);
>  
> -	return 0;
> +	if (bpmp->soc->ops->resume)
> +		return bpmp->soc->ops->resume(bpmp);
> +	else
> +		return 0;
>  }
>  
>  static SIMPLE_DEV_PM_OPS(tegra_bpmp_pm_ops, NULL, tegra_bpmp_resume);
> @@ -971,6 +823,7 @@ static const struct tegra_bpmp_soc tegra186_soc = {
>  			.timeout = 0,
>  		},
>  	},
> +	.ops = &tegra186_bpmp_ops,
>  	.num_resets = 193,
>  };
>  
> diff --git a/include/soc/tegra/bpmp.h b/include/soc/tegra/bpmp.h
> index b02f926a0216..bdd1bd107aba 100644
> --- a/include/soc/tegra/bpmp.h
> +++ b/include/soc/tegra/bpmp.h
> @@ -23,6 +23,7 @@
>  #include <soc/tegra/bpmp-abi.h>
>  
>  struct tegra_bpmp_clk;
> +struct tegra_bpmp_ops;
>  
>  struct tegra_bpmp_soc {
>  	struct {
> @@ -32,6 +33,8 @@ struct tegra_bpmp_soc {
>  			unsigned int timeout;
>  		} cpu_tx, thread, cpu_rx;
>  	} channels;
> +
> +	const struct tegra_bpmp_ops *ops;
>  	unsigned int num_resets;
>  };
>  
> @@ -63,12 +66,7 @@ struct tegra_bpmp_mrq {
>  struct tegra_bpmp {
>  	const struct tegra_bpmp_soc *soc;
>  	struct device *dev;
> -
> -	struct {
> -		struct gen_pool *pool;
> -		dma_addr_t phys;
> -		void *virt;
> -	} tx, rx;
> +	void *priv;
>  
>  	struct {
>  		struct mbox_client client;
> @@ -173,6 +171,8 @@ static inline bool tegra_bpmp_mrq_is_supported(struct tegra_bpmp *bpmp,
>  }
>  #endif
>  
> +void tegra_bpmp_handle_rx(struct tegra_bpmp *bpmp);
> +
>  #if IS_ENABLED(CONFIG_CLK_TEGRA_BPMP)
>  int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp);
>  #else
> -- 
> 2.7.4

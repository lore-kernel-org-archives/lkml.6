Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C98C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F5C204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F5C204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932961AbeFUIaJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:30:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1784 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeFUIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:30:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2b620f0001>; Thu, 21 Jun 2018 01:30:07 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Jun 2018 01:30:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Jun 2018 01:30:05 -0700
Received: from [10.26.11.123] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 21 Jun
 2018 08:30:01 +0000
Subject: Re: [PATCH v2 5/8] mailbox: tegra-hsp: Add support for shared
 mailboxes
To:     Mikko Perttunen <mperttunen@nvidia.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jassisinghbrar@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180620122042.10950-1-mperttunen@nvidia.com>
 <20180620122042.10950-6-mperttunen@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9593bcd9-f1c5-ebce-4aec-eff55bf39079@nvidia.com>
Date:   Thu, 21 Jun 2018 09:29:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620122042.10950-6-mperttunen@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/06/18 13:20, Mikko Perttunen wrote:
> The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
> registers consisting of a FULL bit in MSB position and 31 bits of data.
> The hardware can be configured to trigger interrupts when a mailbox
> is empty or full. Add support for these shared mailboxes to the HSP
> driver.
> 
> The initial use for the mailboxes is the Tegra Combined UART. For this
> purpose, we use interrupts to receive data, and spinning to wait for
> the transmit mailbox to be emptied to minimize unnecessary overhead.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Added defines for some register fields
>     - Simplified bit looping logic in interrupt handler
>     - Changed write done polling to use readl_poll_timeout
>     - Removed unnecessary zero assignments
>     - Fixed two error cases in probe to do proper cleanup
> 
>  drivers/mailbox/tegra-hsp.c | 210 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 190 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> index 5dc21a6d01bb..6864446417c9 100644
> --- a/drivers/mailbox/tegra-hsp.c
> +++ b/drivers/mailbox/tegra-hsp.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
>  #include <linux/mailbox_controller.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -21,6 +22,13 @@
>  
>  #include <dt-bindings/mailbox/tegra186-hsp.h>
>  
> +#include "mailbox.h"
> +
> +#define HSP_INT0_IE		0x100
> +#define HSP_INT_IR		0x304
> +#define HSP_INT_IR_FULL_SHIFT	8
> +#define HSP_INT_IR_FULL_MASK	0xff
> +
>  #define HSP_INT_DIMENSIONING	0x380
>  #define HSP_nSM_SHIFT		0
>  #define HSP_nSS_SHIFT		4
> @@ -34,6 +42,9 @@
>  #define HSP_DB_RAW	0x8
>  #define HSP_DB_PENDING	0xc
>  
> +#define HSP_SM_SHRD_MBOX	0x0
> +#define HSP_SM_SHRD_MBOX_FULL	BIT(31)
> +
>  #define HSP_DB_CCPLEX		1
>  #define HSP_DB_BPMP		3
>  #define HSP_DB_MAX		7
> @@ -68,6 +79,18 @@ struct tegra_hsp_db_map {
>  	unsigned int index;
>  };
>  
> +struct tegra_hsp_mailbox {
> +	struct tegra_hsp_channel channel;
> +	unsigned int index;
> +	bool sending;
> +};
> +
> +static inline struct tegra_hsp_mailbox *
> +channel_to_mailbox(struct tegra_hsp_channel *channel)
> +{
> +	return container_of(channel, struct tegra_hsp_mailbox, channel);
> +}
> +
>  struct tegra_hsp_soc {
>  	const struct tegra_hsp_db_map *map;
>  };
> @@ -77,6 +100,7 @@ struct tegra_hsp {
>  	struct mbox_controller mbox;
>  	void __iomem *regs;
>  	unsigned int doorbell_irq;
> +	unsigned int shared_irq;
>  	unsigned int num_sm;
>  	unsigned int num_as;
>  	unsigned int num_ss;
> @@ -85,6 +109,7 @@ struct tegra_hsp {
>  	spinlock_t lock;
>  
>  	struct list_head doorbells;
> +	struct tegra_hsp_mailbox *mailboxes;
>  };
>  
>  static inline struct tegra_hsp *
> @@ -189,6 +214,33 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static irqreturn_t tegra_hsp_shared_irq(int irq, void *data)
> +{
> +	struct tegra_hsp_mailbox *mb;
> +	struct tegra_hsp *hsp = data;
> +	unsigned long bit, mask;
> +	u32 value;
> +
> +	mask = tegra_hsp_readl(hsp, HSP_INT_IR);
> +	/* Only interested in FULL interrupts */
> +	mask = (mask >> HSP_INT_IR_FULL_SHIFT) & HSP_INT_IR_FULL_MASK;
> +
> +	for_each_set_bit(bit, &mask, 8) {
> +		mb = &hsp->mailboxes[bit];
> +
> +		if (!mb->sending) {
> +			value = tegra_hsp_channel_readl(&mb->channel,
> +							HSP_SM_SHRD_MBOX);
> +			value &= ~HSP_SM_SHRD_MBOX_FULL;
> +			mbox_chan_received_data(mb->channel.chan, &value);
> +			tegra_hsp_channel_writel(&mb->channel, value,
> +						 HSP_SM_SHRD_MBOX);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static struct tegra_hsp_channel *
>  tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
>  			  unsigned int master, unsigned int index)
> @@ -277,14 +329,57 @@ static void tegra_hsp_doorbell_shutdown(struct tegra_hsp_doorbell *db)
>  	spin_unlock_irqrestore(&hsp->lock, flags);
>  }
>  
> +static int tegra_hsp_mailbox_startup(struct tegra_hsp_mailbox *mb)
> +{
> +	struct tegra_hsp *hsp = mb->channel.hsp;
> +	u32 value;
> +
> +	mb->channel.chan->txdone_method = TXDONE_BY_BLOCK;
> +
> +	/* Route FULL interrupt to external IRQ 0 */
> +	value = tegra_hsp_readl(hsp, HSP_INT0_IE);
> +	value |= BIT(mb->index + 8);

Ideally this '8' should be defined as something like HSP_SM_FULL_IRQ_BASE.

> +	tegra_hsp_writel(hsp, value, HSP_INT0_IE);
> +
> +	return 0;
> +}
> +
> +static int tegra_hsp_mailbox_shutdown(struct tegra_hsp_mailbox *mb)
> +{
> +	struct tegra_hsp *hsp = mb->channel.hsp;
> +	u32 value;
> +
> +	value = tegra_hsp_readl(hsp, HSP_INT0_IE);
> +	value &= ~BIT(mb->index + 8);
> +	tegra_hsp_writel(hsp, value, HSP_INT0_IE);
> +
> +	return 0;
> +}
> +
>  static int tegra_hsp_send_data(struct mbox_chan *chan, void *data)
>  {
>  	struct tegra_hsp_channel *channel = chan->con_priv;
> +	struct tegra_hsp_mailbox *mailbox;
> +	uint32_t value;
>  
>  	switch (channel->type) {
>  	case TEGRA_HSP_MBOX_TYPE_DB:
>  		tegra_hsp_channel_writel(channel, 1, HSP_DB_TRIGGER);
>  		return 0;
> +
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		mailbox = channel_to_mailbox(channel);
> +		mailbox->sending = true;
> +
> +		value = *(uint32_t *)data;
> +		/* Mark mailbox full */
> +		value |= HSP_SM_SHRD_MBOX_FULL;
> +
> +		tegra_hsp_channel_writel(channel, value, HSP_SM_SHRD_MBOX);
> +
> +		return readl_poll_timeout(
> +			channel->regs + HSP_SM_SHRD_MBOX, value,
> +			!(value & HSP_SM_SHRD_MBOX_FULL), 0, 10000);
>  	}
>  
>  	return -EINVAL;
> @@ -297,6 +392,8 @@ static int tegra_hsp_startup(struct mbox_chan *chan)
>  	switch (channel->type) {
>  	case TEGRA_HSP_MBOX_TYPE_DB:
>  		return tegra_hsp_doorbell_startup(channel_to_doorbell(channel));
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		return tegra_hsp_mailbox_startup(channel_to_mailbox(channel));
>  	}
>  
>  	return -EINVAL;
> @@ -310,6 +407,9 @@ static void tegra_hsp_shutdown(struct mbox_chan *chan)
>  	case TEGRA_HSP_MBOX_TYPE_DB:
>  		tegra_hsp_doorbell_shutdown(channel_to_doorbell(channel));
>  		break;
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		tegra_hsp_mailbox_shutdown(channel_to_mailbox(channel));
> +		break;
>  	}
>  }
>  
> @@ -363,7 +463,16 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
>  
>  	switch (type) {
>  	case TEGRA_HSP_MBOX_TYPE_DB:
> -		return tegra_hsp_doorbell_xlate(hsp, param);
> +		if (hsp->doorbell_irq)
> +			return tegra_hsp_doorbell_xlate(hsp, param);
> +		else
> +			return ERR_PTR(-EINVAL);
> +
> +	case TEGRA_HSP_MBOX_TYPE_SM:
> +		if (hsp->shared_irq && param < hsp->num_sm)
> +			return hsp->mailboxes[param].channel.chan;
> +		else
> +			return ERR_PTR(-EINVAL);
>  
>  	default:
>  		return ERR_PTR(-EINVAL);
> @@ -402,6 +511,31 @@ static int tegra_hsp_add_doorbells(struct tegra_hsp *hsp)
>  	return 0;
>  }
>  
> +static int tegra_hsp_add_mailboxes(struct tegra_hsp *hsp, struct device *dev)
> +{
> +	int i;
> +
> +	hsp->mailboxes = devm_kcalloc(dev, hsp->num_sm, sizeof(*hsp->mailboxes),
> +				      GFP_KERNEL);
> +	if (!hsp->mailboxes)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < hsp->num_sm; i++) {
> +		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
> +
> +		mb->index = i;
> +		mb->sending = false;
> +
> +		mb->channel.hsp = hsp;
> +		mb->channel.type = TEGRA_HSP_MBOX_TYPE_SM;
> +		mb->channel.regs = hsp->regs + SZ_64K + i * SZ_32K;
> +		mb->channel.chan = &hsp->mbox.chans[i];
> +		mb->channel.chan->con_priv = &mb->channel;
> +	}
> +
> +	return 0;
> +}
> +
>  static int tegra_hsp_probe(struct platform_device *pdev)
>  {
>  	struct tegra_hsp *hsp;
> @@ -430,14 +564,15 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>  	hsp->num_si = (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
>  
>  	err = platform_get_irq_byname(pdev, "doorbell");
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to get doorbell IRQ: %d\n", err);
> -		return err;
> -	}
> +	if (err >= 0)
> +		hsp->doorbell_irq = err;
>  
> -	hsp->doorbell_irq = err;
> +	err = platform_get_irq_byname(pdev, "shared0");
> +	if (err >= 0)
> +		hsp->shared_irq = err;
>  
>  	hsp->mbox.of_xlate = of_tegra_hsp_xlate;
> +	/* First nSM are reserved for mailboxes */
>  	hsp->mbox.num_chans = 32;
>  	hsp->mbox.dev = &pdev->dev;
>  	hsp->mbox.txdone_irq = false;
> @@ -450,10 +585,22 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>  	if (!hsp->mbox.chans)
>  		return -ENOMEM;
>  
> -	err = tegra_hsp_add_doorbells(hsp);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
> -		return err;
> +	if (hsp->doorbell_irq) {
> +		err = tegra_hsp_add_doorbells(hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "failed to add doorbells: %d\n",
> +			        err);
> +			return err;
> +		}
> +	}
> +
> +	if (hsp->shared_irq) {
> +		err = tegra_hsp_add_mailboxes(hsp, &pdev->dev);
> +		if (err < 0) {
> +			dev_err(&pdev->dev, "failed to add mailboxes: %d\n",
> +			        err);
> +			goto remove_doorbells;
> +		}
>  	}
>  
>  	platform_set_drvdata(pdev, hsp);
> @@ -461,20 +608,42 @@ static int tegra_hsp_probe(struct platform_device *pdev)
>  	err = mbox_controller_register(&hsp->mbox);
>  	if (err) {
>  		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
> -		tegra_hsp_remove_doorbells(hsp);
> -		return err;
> +		goto remove_doorbells;
>  	}
>  
> -	err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
> -			       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
> -			       dev_name(&pdev->dev), hsp);
> -	if (err < 0) {
> -		dev_err(&pdev->dev, "failed to request doorbell IRQ#%u: %d\n",
> -			hsp->doorbell_irq, err);
> -		return err;
> +	if (hsp->doorbell_irq) {
> +		err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
> +				       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
> +				       dev_name(&pdev->dev), hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +			        "failed to request doorbell IRQ#%u: %d\n",
> +				hsp->doorbell_irq, err);
> +			goto unregister_mbox_controller;
> +		}
> +	}
> +
> +	if (hsp->shared_irq) {
> +		err = devm_request_irq(&pdev->dev, hsp->shared_irq,
> +				       tegra_hsp_shared_irq, 0,
> +				       dev_name(&pdev->dev), hsp);
> +		if (err < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to request shared0 IRQ%u: %d\n",
> +				hsp->shared_irq, err);
> +			goto unregister_mbox_controller;
> +		}
>  	}
>  
>  	return 0;
> +
> +unregister_mbox_controller:
> +	mbox_controller_unregister(&hsp->mbox);
> +remove_doorbells:
> +	if (hsp->doorbell_irq)
> +		tegra_hsp_remove_doorbells(hsp);

This bit looks like it should have been a separate patch to fix the
clean-up if probe fails. However, unless there is a reason to re-spin
the series, probably OK.

> +
> +	return err;
>  }
>  
>  static int tegra_hsp_remove(struct platform_device *pdev)
> @@ -482,7 +651,8 @@ static int tegra_hsp_remove(struct platform_device *pdev)
>  	struct tegra_hsp *hsp = platform_get_drvdata(pdev);
>  
>  	mbox_controller_unregister(&hsp->mbox);
> -	tegra_hsp_remove_doorbells(hsp);
> +	if (hsp->doorbell_irq)
> +		tegra_hsp_remove_doorbells(hsp);
>  
>  	return 0;
>  }
> 

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

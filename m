Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26313F6E1F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8D620894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8D620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeG3LF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:05:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13661 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeG3LF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:05:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5edadd0000>; Mon, 30 Jul 2018 02:31:10 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Jul 2018 02:31:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Jul 2018 02:31:20 -0700
Received: from [10.21.132.122] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 30 Jul
 2018 09:31:18 +0000
Subject: Re: [PATCH 2/4] ASoC: tegra: Add a TDM configuration callback
To:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kernel@lists.codethink.co.uk>
References: <20180727125931.9794-1-jorge.sanjuan@codethink.co.uk>
 <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <2392df6f-12bc-74fe-ec0f-50dbb7b9a33a@nvidia.com>
Date:   Mon, 30 Jul 2018 10:31:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727125931.9794-3-jorge.sanjuan@codethink.co.uk>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/07/18 13:59, Jorge Sanjuan wrote:
> From: Edward Cragg <edward.cragg@codethink.co.uk>
> 
> Add a callback to configure TDM settings for the Tegra30
> I2S ASoC 'platform' driver.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
> [jorge.sanjuan@codethink.co.uk: Style fixes]
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/soc/tegra/tegra30_i2s.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
> index 0b176ea24914..ff1996f215ed 100644
> --- a/sound/soc/tegra/tegra30_i2s.c
> +++ b/sound/soc/tegra/tegra30_i2s.c
> @@ -265,6 +265,39 @@ static int tegra30_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>  	return 0;
>  }
>  
> +static int tegra30_i2s_set_tdm(struct snd_soc_dai *dai,
> +			       unsigned int tx_mask, unsigned int rx_mask,
> +			       int slots, int slot_width)
> +{
> +	struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +	unsigned int mask = 0, val = 0;
> +
> +	dev_dbg(dai->dev, "%s: setting TDM: tx_mask: 0x%08x rx_mask: 0x%08x"
> +		"slots: 0x%08x width: %d\n",
> +		__func__, tx_mask, rx_mask, slots, slot_width);
> +
> +	/* Set up slots and tx/rx masks */
> +	mask = TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_MASK |
> +	       TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_MASK |
> +	       TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_MASK;
> +
> +	val = (tx_mask << TEGRA30_I2S_SLOT_CTRL_TX_SLOT_ENABLES_SHIFT) |
> +	      (rx_mask << TEGRA30_I2S_SLOT_CTRL_RX_SLOT_ENABLES_SHIFT) |
> +	      ((slots - 1) << TEGRA30_I2S_SLOT_CTRL_TOTAL_SLOTS_SHIFT);
> +
> +	pm_runtime_get_sync(dai->dev);
> +	regmap_update_bits(i2s->regmap, TEGRA30_I2S_SLOT_CTRL, mask, val);
> +
> +	/* Set FSYNC width */
> +	mask = TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_MASK;
> +	val = (slot_width - 1) << TEGRA30_I2S_CH_CTRL_FSYNC_WIDTH_SHIFT;
> +
> +	regmap_update_bits(i2s->regmap, TEGRA30_I2S_CH_CTRL, mask, val);
> +	pm_runtime_put(dai->dev);
> +
> +	return 0;
> +}
> +

Looking at the TRM for Tegra30 and Tegra124, the I2S_SLOT_CTRL register is different
where for Tegra30 the 'TOTAL_SLOTS' bit are in position 18:16, but for Tegra124 they
are 3:0. This driver supports both Tegra30 and Tegra124, and so this function will
need to handle both.

It can be quite common for the fsync-width for DSP modes to be a single clock and so 
I am not sure that is makes sense to set this here always to the slot width. It maybe
worth considering add a DT property for specifying the fsync width.

Cheers
Jon

-- 
nvpublic

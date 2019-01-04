Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE17C43444
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B3221874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546616397;
	bh=F4sKUK4O07tb0szES5xEALFkkCdT1ICUyACGH9scCuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QFSypQyDuo0MQKhZalHS+qi46k9n98U3nefZjrL85R/e79R4xkYWJfyJMGQjF0gVC
	 gIQCglU9kq9U4AhsyVGpPt9HcKvgz64aKxmewxs0XW/vEIUtVGQentbdJVmBbd/pTZ
	 D2hPhpMKXgj89Gpzi9uYAlVbtbj/17iDP0tLNPhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfADPjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:39:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfADPjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:39:54 -0500
Received: from localhost (unknown [171.76.109.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8D720874;
        Fri,  4 Jan 2019 15:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546616393;
        bh=F4sKUK4O07tb0szES5xEALFkkCdT1ICUyACGH9scCuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6/pRZTdqXUA79btEPz7fl8tY6di/tQYeVASebVpaycbBurZTItIqUxFZCaYGDzAL
         b+DHdA97jMiC55YA9lXkP7c9CBV/hqX+DuZQRZLwR79dyVBHRguBklYYr8uxV7YaX+
         foEKLMfGNYGWA/UYbnXfPcUTYr9AL9K+nM4BcsqU=
Date:   Fri, 4 Jan 2019 21:08:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mesih Kilinc <mesihkilinc@gmail.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [RFC PATCH 01/10] dma-engine: sun4i: Add a quirk to support
 different chips
Message-ID: <20190104153815.GN13372@vkoul-mobl.Dlink>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
 <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864e28404a31ba24094f74fd060d11c16562e965.1543782328.git.mesihkilinc@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-18, 00:23, Mesih Kilinc wrote:
> Allwinner suniv F1C100s has similar DMA engine to sun4i. Several
> registers has different addresses. Total dma channels, endpoint counts
> and max burst counts are also different.

So if register layout is the only diff, have you thought about using
regmap_field so that you dont care about the layout

> +struct sun4i_dma_config {
> +	u32 ndma_nr_max_channels;
> +	u32 ndma_nr_max_vchans;
> +
> +	u32 ddma_nr_max_channels;
> +	u32 ddma_nr_max_vchans;
> +
> +	u32 dma_nr_max_channels;
> +
> +        void (*set_dst_data_width)(u32 *p_cfg, s8 data_width);
> +        void (*set_src_data_width)(u32 *p_cfg, s8 data_width);

aligned please, checkpatch should warn about this stuff

>  struct sun4i_dma_dev {
> -	DECLARE_BITMAP(pchans_used, SUN4I_DMA_NR_MAX_CHANNELS);
> +	unsigned long *pchans_used;

why not bitmap?

> +static struct sun4i_dma_config sun4i_a10_dma_cfg = {
> +	.ndma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS,
> +	.ndma_nr_max_vchans	= SUN4I_NDMA_NR_MAX_VCHANS,
> +
> +	.ddma_nr_max_channels	= SUN4I_DDMA_NR_MAX_CHANNELS,
> +	.ddma_nr_max_vchans	= SUN4I_DDMA_NR_MAX_VCHANS,
> +
> +	.dma_nr_max_channels	= SUN4I_NDMA_NR_MAX_CHANNELS + 
> +		SUN4I_DDMA_NR_MAX_CHANNELS,
> +
> +	.set_dst_data_width	= set_dst_data_width_a10,
> +	.set_src_data_width	= set_src_data_width_a10,
> +	.convert_burst		= convert_burst_a10,
> +
> +	.ndma_drq_sdram		= SUN4I_NDMA_DRQ_TYPE_SDRAM,
> +	.ddma_drq_sdram		= SUN4I_DDMA_DRQ_TYPE_SDRAM,
> +
> +	.max_burst		= SUN4I_MAX_BURST,
> +};
> +
>  static const struct of_device_id sun4i_dma_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-dma" },
> +	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },

I would prefer this to be split into two patches, first one does the
refactoring of driver (better if we split things logically) and then
addition of new one..

-- 
~Vinod

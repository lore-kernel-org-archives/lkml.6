Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49E5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8462473D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/sLG+b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8462473D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeGDHAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752772AbeGDHAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:00:43 -0400
Received: from localhost (unknown [122.178.204.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EABC2473C;
        Wed,  4 Jul 2018 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530687642;
        bh=TziA6ne/lUrKxCsqb2jbjHSzGNMnU/LY9bsoGg44AYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D/sLG+b5IABze7NXh1s3desasIKK+j86EAk6NRtP7a3hJnrUufODSTa3PuN06KG2l
         kFuvogNjg59OaDzYra88v8Ta/VA3VIUQ+0BVkmiGzGZ5kAmy/VUf8lEzUCAZ2+VSI1
         emB8OC7AHbjBgZlVCtPguVEpoOK6JE1AyCTnH5K4=
Date:   Wed, 4 Jul 2018 12:30:33 +0530
From:   Vinod <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] dma: add support for reporting pause and resume
 separately
Message-ID: <20180704070033.GA22377@vkoul-mobl>
References: <CGME20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65@eucas1p2.samsung.com>
 <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702130819eucas1p2e11d8fabec93ba78d9e84f4ca6e5fd65~9jzNWZMqQ1216712167eucas1p27@eucas1p2.samsung.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 02-07-18, 15:08, Marek Szyprowski wrote:
> 'cmd_pause' DMA channel capability means that respective DMA engine
> supports both pausing and resuming given DMA channel. However, in some
> cases it is important to know if DMA channel can be paused without the
> need to resume it. This is a typical requirement for proper residue
> reading on transfer timeout in UART drivers. There are also some DMA
> engines with limited hardware, which doesn't really support resuming.

Am curious given that your hardware does not support resume, what was motivation
for adding pause?

> Reporting pause and resume capabilities separately allows UART drivers to
> properly check for the really required capabilities and operate in DMA
> mode also in systems with limited DMA hardware. On the other hand drivers,
> which rely on full channel suspend/resume support, should now check for
> both 'pause' and 'resume' features.
> 
> Existing clients of dma_get_slave_caps() have been checked and the only
> driver which rely on proper channel resuming is soc-generic-dmaengine-pcm
> driver, which has been updated to check the newly added capability.
> Existing 'cmd_pause' now only indicates that DMA engine support pausing
> given DMA channel.

The change looks fine to me. I was hoping that serial would also check
this..

Mark, Lars you okay with this?

> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> This patch is a follow-up of the Vinod's advise from the following
> discussion:
> https://www.spinics.net/lists/linux-samsung-soc/msg63166.html
> ---
>  drivers/dma/dmaengine.c               | 8 ++------
>  include/linux/dmaengine.h             | 5 ++++-
>  sound/soc/soc-generic-dmaengine-pcm.c | 2 +-
>  3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 08ba8473a284..84ac38dbdb65 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -500,12 +500,8 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
>  	caps->max_burst = device->max_burst;
>  	caps->residue_granularity = device->residue_granularity;
>  	caps->descriptor_reuse = device->descriptor_reuse;
> -
> -	/*
> -	 * Some devices implement only pause (e.g. to get residuum) but no
> -	 * resume. However cmd_pause is advertised as pause AND resume.
> -	 */
> -	caps->cmd_pause = !!(device->device_pause && device->device_resume);
> +	caps->cmd_pause = !!device->device_pause;
> +	caps->cmd_resume = !!device->device_resume;
>  	caps->cmd_terminate = !!device->device_terminate_all;
>  
>  	return 0;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 861be5cab1df..c8c3a7a93802 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -415,7 +415,9 @@ enum dma_residue_granularity {
>   *	each type, the dma controller should set BIT(<TYPE>) and same
>   *	should be checked by controller as well
>   * @max_burst: max burst capability per-transfer
> - * @cmd_pause: true, if pause and thereby resume is supported
> + * @cmd_pause: true, if pause is supported (i.e. for reading residue or
> + *	       for resume later)
> + * @cmd_resume: true, if resume is supported
>   * @cmd_terminate: true, if terminate cmd is supported
>   * @residue_granularity: granularity of the reported transfer residue
>   * @descriptor_reuse: if a descriptor can be reused by client and
> @@ -427,6 +429,7 @@ struct dma_slave_caps {
>  	u32 directions;
>  	u32 max_burst;
>  	bool cmd_pause;
> +	bool cmd_resume;
>  	bool cmd_terminate;
>  	enum dma_residue_granularity residue_granularity;
>  	bool descriptor_reuse;
> diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> index 56a541b9ff9e..76c46d793843 100644
> --- a/sound/soc/soc-generic-dmaengine-pcm.c
> +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> @@ -156,7 +156,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
>  
>  	ret = dma_get_slave_caps(chan, &dma_caps);
>  	if (ret == 0) {
> -		if (dma_caps.cmd_pause)
> +		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
>  			hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
>  		if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
>  			hw.info |= SNDRV_PCM_INFO_BATCH;
> -- 
> 2.17.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
~Vinod

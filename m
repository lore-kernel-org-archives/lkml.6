Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625AC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9BB2098A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/PhLFey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9BB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeJEH11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:27:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeJEH11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:27:27 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C19220645;
        Fri,  5 Oct 2018 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538699482;
        bh=szwcifsys4gScf294UTJuvlBycOt6CQTI66QCTrDC8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/PhLFeyxXItIK9Kxm+//jKCLIP75DMpB1ZH3kiiQOJBPfA84wy7a9ddMoEM0mfyI
         NPZFUjiQb2ERxWWza5X4HcLVQfj0ltuz73lK26ogi9cl7Yg1weWt++Co6T6zx2ty0j
         tTGpANadwYFfGjumxgMK028m3NhPVIkti0F2riKE=
Date:   Fri, 5 Oct 2018 06:01:12 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v2 1/5] ALSA: soc-compress: add support to
 snd_compr_set_runtime_buffer()
Message-ID: <20181005003112.GG2372@vkoul-mobl>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926102349.23481-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-09-18, 11:23, Srinivas Kandagatla wrote:
> This patch adds support to set runtime dma buffer on compressed stream.

The change is fine as is, but I feel we need to document the motivation
in the changelog. The core changes need a bit more explanation on why we
should add this..

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/sound/compress_driver.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> index ea8c93bbb0e0..0cdc3999ecfa 100644
> --- a/include/sound/compress_driver.h
> +++ b/include/sound/compress_driver.h
> @@ -23,6 +23,7 @@ struct snd_compr_ops;
>   * struct snd_compr_runtime: runtime stream description
>   * @state: stream state
>   * @ops: pointer to DSP callbacks
> + * @dma_buffer_p: runtime dma buffer pointer
>   * @buffer: pointer to kernel buffer, valid only when not in mmap mode or
>   *	DSP doesn't implement copy
>   * @buffer_size: size of the above buffer
> @@ -37,6 +38,7 @@ struct snd_compr_ops;
>  struct snd_compr_runtime {
>  	snd_pcm_state_t state;
>  	struct snd_compr_ops *ops;
> +	struct snd_dma_buffer *dma_buffer_p;
>  	void *buffer;
>  	u64 buffer_size;
>  	u32 fragment_size;
> @@ -175,6 +177,23 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
>  	wake_up(&stream->runtime->sleep);
>  }
>  
> +/**
> + * snd_compr_set_runtime_buffer - Set the Compress runtime buffer
> + * @substream: compress substream to set
> + * @bufp: the buffer information, NULL to clear
> + *
> + * Copy the buffer information to runtime buffer when @bufp is non-NULL.
> + * Otherwise it clears the current buffer information.
> + */
> +static inline void snd_compr_set_runtime_buffer(
> +					struct snd_compr_stream *substream,
> +					struct snd_dma_buffer *bufp)
> +{
> +	struct snd_compr_runtime *runtime = substream->runtime;
> +
> +	runtime->dma_buffer_p = bufp;
> +}
> +
>  int snd_compr_stop_error(struct snd_compr_stream *stream,
>  			 snd_pcm_state_t state);
>  
> -- 
> 2.19.0

-- 
~Vinod

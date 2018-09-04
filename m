Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7944C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BB220843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zYBXgriT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BB220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeIDSUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeIDSUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:20:50 -0400
Received: from localhost (unknown [171.61.91.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0935F2082B;
        Tue,  4 Sep 2018 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536069336;
        bh=wlzm/5TLDiwVSrW48xlRWYMXRCVnvhI1BUptyA3w+gw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zYBXgriTxlLFruILdnzr/YYl5knAU5oUrkhnUzrSZNZeN9hgzp/3L/NEBBP8I1ZQ0
         RFWtmCEjdmkIDFQPAxuwUqVKpNQG4k6TkocR7Ng7F4uZvanL2PneQFgTdxJ+scZWwv
         sSXRSBj5SIYfhU3s1O7lUYA9n0mnpWT/yDL6o0EY=
Date:   Tue, 4 Sep 2018 19:25:26 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        devicetree@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 3/3] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
Message-ID: <20180904135526.GK2322@vkoul-mobl>
References: <20180903123455.9290-1-srinivas.kandagatla@linaro.org>
 <20180903123455.9290-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903123455.9290-4-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-18, 13:34, Srinivas Kandagatla wrote:

> +static void compress_event_handler(uint32_t opcode, uint32_t token,
> +				   uint32_t *payload, void *priv)
> +{
> +	struct q6asm_dai_rtd *prtd = priv;
> +	struct snd_compr_stream *substream = prtd->cstream;
> +	unsigned long flags;
> +	uint64_t avail;
> +
> +	switch (opcode) {
> +	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
> +		spin_lock_irqsave(&prtd->lock, flags);
> +		avail = prtd->bytes_received - prtd->bytes_sent;
> +		if (!prtd->bytes_sent) {
> +			if (avail < substream->runtime->fragment_size) {
> +				prtd->xrun = 1;

so you are trying to detect xrun :) So in compress core we added support
for .ack callback which tells driver how much data is valid in ring
buffer and we can send this to DSP, so DSP "knows" valid data and should
not overrun, ofcourse DSP needs support for it

> +			} else {
> +				q6asm_write_async(prtd->audio_client,
> +						  prtd->pcm_count,
> +						  0, 0, NO_TIMESTAMP);
> +				prtd->bytes_sent += prtd->pcm_count;
> +			}
> +		}
> +
> +		spin_unlock_irqrestore(&prtd->lock, flags);
> +		break;

empty line after break helps readability

> +	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
> +		prtd->state = Q6ASM_STREAM_STOPPED;
> +		break;
> +	case ASM_CLIENT_EVENT_DATA_WRITE_DONE:
> +		spin_lock_irqsave(&prtd->lock, flags);
> +		prtd->byte_offset += prtd->pcm_count;
> +		prtd->copied_total += prtd->pcm_count;

so should you need two counters, copied_total should give you byte_offset
as well, we know the ring buffer size

> +
> +		if (prtd->byte_offset >= prtd->pcm_size)
> +			prtd->byte_offset -= prtd->pcm_size;

:)

> +
> +		snd_compr_fragment_elapsed(substream);

so will ASM_CLIENT_EVENT_DATA_WRITE_DONE be invoked on fragment bytes
consumed?

> +static int q6asm_dai_compr_set_params(struct snd_compr_stream *stream,
> +				      struct snd_compr_params *params)
> +{
> +

redundant empty line

> +static int q6asm_dai_compr_trigger(struct snd_compr_stream *stream, int cmd)
> +{
> +	struct snd_compr_runtime *runtime = stream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);

the triggers are not in atomic context, do we have q6asm_run()

> +static int q6asm_dai_compr_copy(struct snd_compr_stream *stream,
> +				char __user *buf, size_t count)
> +{
> +	struct snd_compr_runtime *runtime = stream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +	uint64_t avail = 0;
> +	unsigned long flags;
> +	size_t copy;
> +	void *dstn;
> +
> +	dstn = prtd->buffer + prtd->copy_pointer;
> +	if (count < prtd->pcm_size - prtd->copy_pointer) {
> +		if (copy_from_user(dstn, buf, count))
> +			return -EFAULT;
> +
> +		prtd->copy_pointer += count;
> +	} else {
> +		copy = prtd->pcm_size - prtd->copy_pointer;
> +		if (copy_from_user(dstn, buf, copy))
> +			return -EFAULT;
> +
> +		if (copy_from_user(prtd->buffer, buf + copy, count - copy))
> +			return -EFAULT;
> +		prtd->copy_pointer = count - copy;
> +	}
> +
> +	spin_lock_irqsave(&prtd->lock, flags);
> +	prtd->bytes_received += count;

why not use core copy method and...
> +
> +	if (prtd->state == Q6ASM_STREAM_RUNNING && prtd->xrun) {
> +		avail = prtd->bytes_received - prtd->copied_total;
> +		if (avail >= runtime->fragment_size) {
> +			prtd->xrun = 0;
> +			q6asm_write_async(prtd->audio_client,
> +				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +			prtd->bytes_sent += prtd->pcm_count;
> +		}
> +	}

move this to .ack

> +static int q6asm_dai_compr_get_codec_caps(struct snd_compr_stream *stream,
> +					  struct snd_compr_codec_caps *codec)
> +{
> +	switch (codec->codec) {
> +	case SND_AUDIOCODEC_MP3:
> +		codec->num_descriptors = 2;
> +		codec->descriptor[0].max_ch = 2;
> +		memcpy(codec->descriptor[0].sample_rates,
> +		       supported_sample_rates,
> +		       sizeof(supported_sample_rates));
> +		codec->descriptor[0].num_sample_rates =
> +			sizeof(supported_sample_rates)/sizeof(unsigned int);
> +		codec->descriptor[0].bit_rate[0] = 320; /* 320kbps */
> +		codec->descriptor[0].bit_rate[1] = 128;
> +		codec->descriptor[0].num_bitrates = 2;
> +		codec->descriptor[0].profiles = 0;
> +		codec->descriptor[0].modes = SND_AUDIOCHANMODE_MP3_STEREO;
> +		codec->descriptor[0].formats = 0;

since we are static here, how about using a table based approach and
use that here

-- 
~Vinod

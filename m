Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ACCC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176CF20854
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+rZUdcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176CF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbeJEHfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbeJEHfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:35:36 -0400
Received: from localhost (unknown [171.76.113.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D78EC20645;
        Fri,  5 Oct 2018 00:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538699968;
        bh=TxEoprQic9d3tPmBcey5XV58BFVIoafqQnGPHRMlKvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K+rZUdcOgnww8hREebaW6AoBGAqP6FgcX8OFoTwIbbpZdObEmuH5BwLAST0J5Nrja
         EM7e7hBwIATTkjM07oXgjNHHUhLkFL9NwRYzEbBrtXHiThsL8KtX0mNF7m1guzuKFt
         ZkwESl9ruVNlb53WBcRlXf7jyeTf7eUpFBa3sQ3w=
Date:   Fri, 5 Oct 2018 06:09:19 +0530
From:   Vinod <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH v2 5/5] ASoC: qdsp6: q6asm-dai: Add support to compress
 offload
Message-ID: <20181005003919.GH2372@vkoul-mobl>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
 <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926102349.23481-6-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-09-18, 11:23, Srinivas Kandagatla wrote:
> This patch adds MP3 playback support in q6asm dais, adding other codec
> support should be pretty trivial.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  sound/soc/qcom/Kconfig           |   1 +
>  sound/soc/qcom/qdsp6/q6asm-dai.c | 377 ++++++++++++++++++++++++++++++-
>  2 files changed, 377 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 2a4c912d1e48..ebf991bb546c 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -66,6 +66,7 @@ config SND_SOC_QDSP6_ASM
>  	tristate
>  
>  config SND_SOC_QDSP6_ASM_DAI
> +	select SND_SOC_COMPRESS
>  	tristate
>  
>  config SND_SOC_QDSP6
> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
> index 9db9a2944ef2..57b8abcbebcd 100644
> --- a/sound/soc/qcom/qdsp6/q6asm-dai.c
> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
> @@ -11,6 +11,8 @@
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
>  #include <sound/pcm.h>
> +#include <linux/spinlock.h>
> +#include <sound/compress_driver.h>
>  #include <asm/dma.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/of_device.h>
> @@ -31,6 +33,16 @@
>  #define CAPTURE_MIN_PERIOD_SIZE     320
>  #define SID_MASK_DEFAULT	0xF
>  
> +/* Default values used if user space does not set */
> +#define COMPR_PLAYBACK_MIN_FRAGMENT_SIZE (8 * 1024)
> +#define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
> +#define COMPR_PLAYBACK_MIN_NUM_FRAGMENTS (4)
> +#define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
> +#define Q6ASM_DAI_TX_RX	0
> +#define Q6ASM_DAI_TX	1
> +#define Q6ASM_DAI_RX	2
> +
> +

Unnecessary double space

>  enum stream_state {
>  	Q6ASM_STREAM_IDLE = 0,
>  	Q6ASM_STREAM_STOPPED,
> @@ -39,11 +51,22 @@ enum stream_state {
>  
>  struct q6asm_dai_rtd {
>  	struct snd_pcm_substream *substream;
> +	struct snd_compr_stream *cstream;
> +	struct snd_compr_params codec_param;
> +	struct snd_dma_buffer dma_buffer;
> +
>  	phys_addr_t phys;
> +	spinlock_t lock;

why would we need a lock for compress case?

-- 
~Vinod

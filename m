Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E60BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C905B20898
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 12:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C905B20898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeH0QO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 12:14:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:44536 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeH0QO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 12:14:28 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1fuGcV-0002iE-98; Mon, 27 Aug 2018 14:27:47 +0200
Received: from [2003:93:4e1f:ab00:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fuGcV-0001Jh-3w; Mon, 27 Aug 2018 14:27:47 +0200
Subject: Re: [PATCH 1/1] axi-i2s: set period size register
To:     Luca Ceresoli <luca@lucaceresoli.net>, alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
References: <20180824160430.10222-1-luca@lucaceresoli.net>
 <20180824160430.10222-2-luca@lucaceresoli.net>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b87937b6-da7c-76d7-5dd2-24909e648671@metafoo.de>
Date:   Mon, 27 Aug 2018 14:27:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824160430.10222-2-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/24877/Mon Aug 27 06:46:55 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/24/2018 06:04 PM, Luca Ceresoli wrote:
> The default value of the PERIOD_LEN register is 0 and results in
> axi-i2s keeping TLAST always asserted in its AXI Stream output.
> 
> When the AXI Stream is sent to a Xilinx AXI-DMA, this results in the
> DMA generating an interrupt flood and ALSA produce a corrupted
> recording. This is because AXI-DMA raises an interrupt whenever TLAST
> is active.
> 
> Fix by setting the PERIOD_LEN register as soon as the period is
> known. This way TLAST is emitted once per period, and the DMA raises
> interrupts correctly.

The patch looks OK. But I'd prefer not to merge it if possible.

We've done some early experiments with the Xilinx AXI-DMA, but it turned out
to be to unreliable and we've abandoned support for it. One of the more
critical issues was that you can't abort a DMA transfer. That means when
audio capture is stopped the DMA will halt, but not complete the current
transfer. Then when the next audio capture start the DMA will continue with
the previous transfer. The observed effect of this was that the system would
just crash randomly (Presumably due to memory corruption).

Have you considered using the ADI AXI-DMAC? That should work just fine.

> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  sound/soc/adi/axi-i2s.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/adi/axi-i2s.c b/sound/soc/adi/axi-i2s.c
> index 4c23381727a1..af581a313a40 100644
> --- a/sound/soc/adi/axi-i2s.c
> +++ b/sound/soc/adi/axi-i2s.c
> @@ -24,6 +24,7 @@
>  #define AXI_I2S_REG_CTRL	0x04
>  #define AXI_I2S_REG_CLK_CTRL	0x08
>  #define AXI_I2S_REG_STATUS	0x10
> +#define AXI_I2S_REG_PERIOD_LEN	0x18
>  
>  #define AXI_I2S_REG_RX_FIFO	0x28
>  #define AXI_I2S_REG_TX_FIFO	0x2C
> @@ -101,6 +102,17 @@ static int axi_i2s_hw_params(struct snd_pcm_substream *substream,
>  	return 0;
>  }
>  
> +static int axi_i2s_prepare(struct snd_pcm_substream *substream,
> +			   struct snd_soc_dai *dai)
> +{
> +	struct axi_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> +	unsigned int period_bytes = snd_pcm_lib_period_bytes(substream);
> +
> +	/* adi_i2s counts 32-bit words, thus divide bytes by 4 */
> +	return regmap_write(i2s->regmap, AXI_I2S_REG_PERIOD_LEN,
> +			    (period_bytes / 4) - 1);
> +}
> +
>  static int axi_i2s_startup(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *dai)
>  {
> @@ -147,6 +159,7 @@ static const struct snd_soc_dai_ops axi_i2s_dai_ops = {
>  	.shutdown = axi_i2s_shutdown,
>  	.trigger = axi_i2s_trigger,
>  	.hw_params = axi_i2s_hw_params,
> +	.prepare = axi_i2s_prepare,
>  };
>  
>  static struct snd_soc_dai_driver axi_i2s_dai = {
> @@ -175,7 +188,7 @@ static const struct regmap_config axi_i2s_regmap_config = {
>  	.reg_bits = 32,
>  	.reg_stride = 4,
>  	.val_bits = 32,
> -	.max_register = AXI_I2S_REG_STATUS,
> +	.max_register = AXI_I2S_REG_PERIOD_LEN,
>  };
>  
>  static int axi_i2s_probe(struct platform_device *pdev)
> 


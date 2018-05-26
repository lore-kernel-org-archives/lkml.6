Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032467AbeEZVeQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 17:34:16 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38853 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032388AbeEZVeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 17:34:15 -0400
X-Google-Smtp-Source: ADUXVKIBwlkal7m3wY9EYlZJ2a2iAkX0iotPgU5mchD5BtEvLYDO7NnibnK/lA5WtBFVHIow6+1fovSpOiV7RqadV2A=
MIME-Version: 1.0
References: <1527240163-9804-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1527240163-9804-1-git-send-email-akshu.agrawal@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sat, 26 May 2018 15:34:02 -0600
Message-ID: <CAGS+omBnK35j9dt-5DzRK+sq8N6vqtYy-3j80TsYmLZ8OpA2rA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: AMD: make channel 1 dma as circular
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com,
        Vijendar.Mukunda@amd.com, Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 3:23 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:

> channel 1: SYSMEM<->ACP
> channel 2: ACP<->I2S
> Instead of waiting on period interrupt of ch 2 and then starting
> dma on ch1, we make ch1 dma as circular.
> This removes dependency of period granularity on hw pointer.

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>


Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>


> ---
>   sound/soc/amd/acp-pcm-dma.c | 72
+++++++--------------------------------------
>   1 file changed, 10 insertions(+), 62 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index ac32dea..f1d8678 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -337,8 +337,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
>   }

>   /* Start a given DMA channel transfer */
> -static void acp_dma_start(void __iomem *acp_mmio,
> -                         u16 ch_num, bool is_circular)
> +static void acp_dma_start(void __iomem *acp_mmio, u16 ch_num)
>   {
>          u32 dma_ctrl;

> @@ -369,11 +368,8 @@ static void acp_dma_start(void __iomem *acp_mmio,
>                  break;
>          }

> -       /* enable  for ACP SRAM to/from I2S DMA channel */
> -       if (is_circular == true)
> -               dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
> -       else
> -               dma_ctrl &= ~ACP_DMA_CNTL_0__Circular_DMA_En_MASK;
> +       /* circular for both DMA channel */
> +       dma_ctrl |= ACP_DMA_CNTL_0__Circular_DMA_En_MASK;

>          acp_reg_write(dma_ctrl, acp_mmio, mmACP_DMA_CNTL_0 + ch_num);
>   }
> @@ -617,7 +613,6 @@ static int acp_deinit(void __iomem *acp_mmio)
>   /* ACP DMA irq handler routine for playback, capture usecases */
>   static irqreturn_t dma_irq_handler(int irq, void *arg)
>   {
> -       u16 dscr_idx;
>          u32 intr_flag, ext_intr_status;
>          struct audio_drv_data *irq_data;
>          void __iomem *acp_mmio;
> @@ -634,33 +629,13 @@ static irqreturn_t dma_irq_handler(int irq, void
*arg)

>          if ((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) != 0) {
>                  valid_irq = true;
> -               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_13) ==
> -                               PLAYBACK_START_DMA_DESCR_CH13)
> -                       dscr_idx = PLAYBACK_END_DMA_DESCR_CH12;
> -               else
> -                       dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
> -               config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_CH_NUM,
dscr_idx,
> -                                      1, 0);
> -               acp_dma_start(acp_mmio, SYSRAM_TO_ACP_CH_NUM, false);
> -
>                  snd_pcm_period_elapsed(irq_data->play_i2ssp_stream);
> -
>                  acp_reg_write((intr_flag & BIT(ACP_TO_I2S_DMA_CH_NUM)) <<
16,
>                                acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>          }

>          if ((intr_flag & BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) != 0) {
>                  valid_irq = true;
> -               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_9) ==
> -                       PLAYBACK_START_DMA_DESCR_CH9)
> -                       dscr_idx = PLAYBACK_END_DMA_DESCR_CH8;
> -               else
> -                       dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
> -               config_acp_dma_channel(acp_mmio,
> -                                      SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
> -                                      dscr_idx, 1, 0);
> -               acp_dma_start(acp_mmio, SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM,
> -                             false);
>                  snd_pcm_period_elapsed(irq_data->play_i2sbt_stream);
>                  acp_reg_write((intr_flag &
>                                BIT(ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM)) <<
16,
> @@ -669,38 +644,20 @@ static irqreturn_t dma_irq_handler(int irq, void
*arg)

>          if ((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) != 0) {
>                  valid_irq = true;
> -               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_15) ==
> -                               CAPTURE_START_DMA_DESCR_CH15)
> -                       dscr_idx = CAPTURE_END_DMA_DESCR_CH14;
> -               else
> -                       dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
> -               config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_CH_NUM,
dscr_idx,
> -                                      1, 0);
> -               acp_dma_start(acp_mmio, ACP_TO_SYSRAM_CH_NUM, false);
> -
> +               snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
>                  acp_reg_write((intr_flag & BIT(I2S_TO_ACP_DMA_CH_NUM)) <<
16,
>                                acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>          }

>          if ((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) != 0) {
>                  valid_irq = true;
> -               snd_pcm_period_elapsed(irq_data->capture_i2ssp_stream);
>                  acp_reg_write((intr_flag & BIT(ACP_TO_SYSRAM_CH_NUM)) <<
16,
>                                acp_mmio, mmACP_EXTERNAL_INTR_STAT);
>          }

>          if ((intr_flag & BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) != 0) {
>                  valid_irq = true;
> -               if (acp_reg_read(acp_mmio, mmACP_DMA_CUR_DSCR_11) ==
> -                       CAPTURE_START_DMA_DESCR_CH11)
> -                       dscr_idx = CAPTURE_END_DMA_DESCR_CH10;
> -               else
> -                       dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
> -               config_acp_dma_channel(acp_mmio,
> -                                      ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
> -                                      dscr_idx, 1, 0);
> -               acp_dma_start(acp_mmio, ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM,
> -                             false);
> +               snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
>                  acp_reg_write((intr_flag &
>                                BIT(I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM)) <<
16,
>                                acp_mmio, mmACP_EXTERNAL_INTR_STAT);
> @@ -708,7 +665,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)

>          if ((intr_flag & BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) != 0) {
>                  valid_irq = true;
> -               snd_pcm_period_elapsed(irq_data->capture_i2sbt_stream);
>                  acp_reg_write((intr_flag &
>                                BIT(ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM)) <<
16,
>                                acp_mmio, mmACP_EXTERNAL_INTR_STAT);
> @@ -1015,11 +971,9 @@ static int acp_dma_prepare(struct snd_pcm_substream
*substream)
>   static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
>   {
>          int ret;
> -       u32 loops = 4000;
>          u64 bytescount = 0;

>          struct snd_pcm_runtime *runtime = substream->runtime;
> -       struct snd_soc_pcm_runtime *prtd = substream->private_data;
>          struct audio_substream_data *rtd = runtime->private_data;
>          struct snd_soc_component *component = snd_soc_rtdcom_lookup(prtd,

DRV_NAME);
> @@ -1034,18 +988,12 @@ static int acp_dma_trigger(struct
snd_pcm_substream *substream, int cmd)
>                  if (rtd->bytescount == 0)
>                          rtd->bytescount = bytescount;
>                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -                       acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
> -                       while (acp_reg_read(rtd->acp_mmio,
mmACP_DMA_CH_STS) &
> -                               BIT(rtd->ch1)) {
> -                               if (!loops--) {
> -                                       dev_err(component->dev,
> -                                               "acp dma start
timeout\n");
> -                                       return -ETIMEDOUT;
> -                               }
> -                               cpu_relax();
> -                       }
> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1);
> +                       acp_dma_start(rtd->acp_mmio, rtd->ch2);
> +               } else {
> +                       acp_dma_start(rtd->acp_mmio, rtd->ch2);
> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1);
>                  }
> -               acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>                  ret = 0;
>                  break;
>          case SNDRV_PCM_TRIGGER_STOP:
> --
> 1.9.1

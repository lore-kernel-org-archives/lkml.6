Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524549915; cv=none;
        d=google.com; s=arc-20160816;
        b=h7meNZgnIiJBu2z/up7AhjtcEdwbJ2ukXg5uUtVH3kBkGM0xN93PCG/B3AN1TlUjIJ
         Ut9EHj8QLRlKHkkKoQjzY2iAZNGI2CLqTyMX+xvDG7awhcRUXFmXonxBYFWr1pH0MPfi
         u2zRZ+5mc79Hz+helrwhIotXYN4zUbINZyVSq7+TN5YOtX0OWscygB+t4tAelup+5C1T
         GlYc2WhbNasGgHWVRtbI1prFxvOhdrkuvI4Mha7Q3v+QUrrR6wnxGY0uWI6t5fXud80s
         Lvg1ve4NujiETocUJzsmsoF4udIGUAhuCi8o65ghSjxNffhmx3k2/PeX8+vymcz17DAN
         BDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=O7KAu7NUWzGAN05YuIkdn3gkw3b71LWeAq5yI9CeXdY=;
        b=BGoNOPhGnd2Rc+fyZjUNnpVGS9DyRL7T+d62c9gIXDqDQkcRo6mMTjCRPuAzpJUc45
         733sa/zZfojZqzDytHkSLHC1N/aUGbyTBPuYvNicABrYpnSdbIoVN44ILMd8BPrk1vT3
         Ehqx91b1uQik3A/Nrv+B/E6o7TWywg2oHTZbeViNXvzofw0xA60/9ft4eIXQBKjAbj74
         ugp6WA4rdrbPSEc6SzNMd33SZqT6x/puDc1P31xaV+LTl1XTonIwpeurKOMfuq1fp85z
         W85HfvwpPYQO1/Fl2XdEPfThXYZFk9wBbT1tLWPgphr7XSxda9p+MrQhH6bwGQ2auQEK
         +K1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F/MWI84h;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F/MWI84h;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZqIHmPUu0aydi7pgDC+JxEwAcxwZ5cgrL7vbIDB/VnfSU/968oKVZPvvMJYFzpq2aCNII88552TDIg4W4WSVjw=
MIME-Version: 1.0
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Tue, 24 Apr 2018 06:05:03 +0000
Message-ID: <CAGS+omA0Um=borxoDSKzsq0UjATq0cPE9DCZEkokhLK__utEpg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: amd: acp dma driver code cleanup
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com,
	Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org,
	Guenter Roeck <linux@roeck-us.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598594949725044405?=
X-GMAIL-MSGID: =?utf-8?q?1598606451820517350?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vijendar,


On Mon, Apr 23, 2018 at 9:02 PM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> Added dma configuration parameters in audio_substream_data
> structure. Moved dma configuration parameters initialization
> to dma hw params callback.
> Removed separate byte count variables for playback and capture.
> Added variables to store ACP register offsets in audio_substream_data
> structure.

Thanks for splitting the patch, this is moving in the right direction, but
still very difficult to review since it is mixing different changes
together.
Just try to make each patch a single logical cleanup.
For example, perhaps create a set of patches that does:
   (1) Variable renames (eg audio_config -> rtd) & white space cleanup
   (2) Add dma configuration parameters to audio_substream_data structure
and initialize them in hw_params.
   (3) Remove separate byte count variables for playback and capture
   (4) Update the PTE offsets
   (5) Update the SRAM_BANKs

Note that (1) doesn't change functionality at all, (2) refactors but
doesn't change behavior or logic, (3) simplifies behavior but doesn't
change logic, and (4) & (5) build on the others but start making real
logical changes.

-Dan


> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/acp-pcm-dma.c | 241
++++++++++++++++++--------------------------
>   sound/soc/amd/acp.h         |  35 +++++--
>   2 files changed, 126 insertions(+), 150 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 5ffe2ef..4a4bbdf 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -317,54 +317,21 @@ static void acp_pte_config(void __iomem *acp_mmio,
struct page *pg,
>   }

>   static void config_acp_dma(void __iomem *acp_mmio,
> -                          struct audio_substream_data *audio_config,
> +                          struct audio_substream_data *rtd,
>                             u32 asic_type)
>   {
> -       u32 pte_offset, sram_bank;
> -       u16 ch1, ch2, destination, dma_dscr_idx;
> -
> -       if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
> -               pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
> -               sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
> -               destination = TO_ACP_I2S_1;
> -
> -       } else {
> -               pte_offset = ACP_CAPTURE_PTE_OFFSET;
> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
> -               switch (asic_type) {
> -               case CHIP_STONEY:
> -                       sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
> -                       break;
> -               default:
> -                       sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
> -               }
> -               destination = FROM_ACP_I2S_1;
> -       }
> -
> -       acp_pte_config(acp_mmio, audio_config->pg,
audio_config->num_of_pages,
> -                      pte_offset);
> -       if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
> -       else
> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
> -
> +       acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
> +                      rtd->pte_offset);
>          /* Configure System memory <-> ACP SRAM DMA descriptors */
> -       set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
> -                                      audio_config->direction,
pte_offset, ch1,
> -                                      sram_bank, dma_dscr_idx,
asic_type);
> -
> -       if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
> -       else
> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
> +       set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
> +                                      rtd->direction, rtd->pte_offset,
> +                                      rtd->ch1, rtd->sram_bank,
> +                                      rtd->dma_dscr_idx_1, asic_type);
>          /* Configure ACP SRAM <-> I2S DMA descriptors */
> -       set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
> -                                      audio_config->direction, sram_bank,
> -                                      destination, ch2, dma_dscr_idx,
> -                                      asic_type);
> +       set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
> +                                      rtd->direction, rtd->sram_bank,
> +                                      rtd->destination, rtd->ch2,
> +                                      rtd->dma_dscr_idx_2, asic_type);
>   }

>   /* Start a given DMA channel transfer */
> @@ -700,7 +667,6 @@ static irqreturn_t dma_irq_handler(int irq, void *arg)

>   static int acp_dma_open(struct snd_pcm_substream *substream)
>   {
> -       u16 bank;
>          int ret = 0;
>          struct snd_pcm_runtime *runtime = substream->runtime;
>          struct snd_soc_pcm_runtime *prtd = substream->private_data;
> @@ -720,6 +686,7 @@ static int acp_dma_open(struct snd_pcm_substream
*substream)
>                  default:
>                          runtime->hw = acp_pcm_hardware_playback;
>                  }
> +               adata->bytescount = 0;
>          } else {
>                  switch (intr_data->asic_type) {
>                  case CHIP_STONEY:
> @@ -728,6 +695,7 @@ static int acp_dma_open(struct snd_pcm_substream
*substream)
>                  default:
>                          runtime->hw = acp_pcm_hardware_capture;
>                  }
> +               adata->bytescount = 0;
>          }

>          ret = snd_pcm_hw_constraint_integer(runtime,
> @@ -749,28 +717,6 @@ static int acp_dma_open(struct snd_pcm_substream
*substream)
>           */
>          if (!intr_data->play_i2ssp_stream &&
!intr_data->capture_i2ssp_stream)
>                  acp_reg_write(1, adata->acp_mmio,
mmACP_EXTERNAL_INTR_ENB);
> -
> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               intr_data->play_i2ssp_stream = substream;
> -               /*
> -                * For Stoney, Memory gating is disabled,i.e SRAM Banks
> -                * won't be turned off. The default state for SRAM banks
is ON.
> -                * Setting SRAM bank state code skipped for STONEY
platform.
> -                */
> -               if (intr_data->asic_type != CHIP_STONEY) {
> -                       for (bank = 1; bank <= 4; bank++)
> -
acp_set_sram_bank_state(intr_data->acp_mmio,
> -                                                       bank, true);
> -               }
> -       } else {
> -               intr_data->capture_i2ssp_stream = substream;
> -               if (intr_data->asic_type != CHIP_STONEY) {
> -                       for (bank = 5; bank <= 8; bank++)
> -
acp_set_sram_bank_state(intr_data->acp_mmio,
> -                                                       bank, true);
> -               }
> -       }
> -
>          return 0;
>   }

> @@ -779,6 +725,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream
*substream,
>   {
>          int status;
>          uint64_t size;
> +       u16 bank;
>          u32 val = 0;
>          struct page *pg;
>          struct snd_pcm_runtime *runtime;
> @@ -804,6 +751,60 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>                  acp_reg_write(val, adata->acp_mmio,
>                                mmACP_I2S_16BIT_RESOLUTION_EN);
>          }
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +               switch (adata->asic_type) {
> +               case CHIP_STONEY:
> +                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
> +                       break;
> +               default:
> +                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +               }
> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> +               rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
> +               rtd->destination = TO_ACP_I2S_1;
> +               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
> +               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
> +               rtd->byte_cnt_high_reg_offset =
> +               mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
> +               rtd->byte_cnt_low_reg_offset =
mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
> +               adata->play_i2ssp_stream = substream;
> +               /*
> +                * For Stoney, Memory gating is disabled,i.e SRAM Banks
> +                * won't be turned off. The default state for SRAM banks
is ON.
> +                * Setting SRAM bank state code skipped for STONEY
platform.
> +                */
> +               if (adata->asic_type != CHIP_STONEY) {
> +                       for (bank = 1; bank <= 4; bank++)
> +                               acp_set_sram_bank_state(adata->acp_mmio,
> +                                                       bank, true);
> +               }
> +       } else {
> +               rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> +               switch (adata->asic_type) {
> +               case CHIP_STONEY:
> +                       rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
> +                       break;
> +               default:
> +                       rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
> +               }
> +               rtd->destination = FROM_ACP_I2S_1;
> +               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
> +               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
> +               rtd->byte_cnt_high_reg_offset =
> +               mmACP_I2S_RECEIVED_BYTE_CNT_HIGH;
> +               rtd->byte_cnt_low_reg_offset =
mmACP_I2S_RECEIVED_BYTE_CNT_LOW;
> +               adata->capture_i2ssp_stream = substream;
> +               if (adata->asic_type != CHIP_STONEY) {
> +                       for (bank = 5; bank <= 8; bank++)
> +                               acp_set_sram_bank_state(adata->acp_mmio,
> +                                                       bank, true);
> +               }
> +       }
> +
>          size = params_buffer_bytes(params);
>          status = snd_pcm_lib_malloc_pages(substream, size);
>          if (status < 0)
> @@ -837,26 +838,15 @@ static int acp_dma_hw_free(struct snd_pcm_substream
*substream)
>          return snd_pcm_lib_free_pages(substream);
>   }

> -static u64 acp_get_byte_count(void __iomem *acp_mmio, int stream)
> +static u64 acp_get_byte_count(struct audio_substream_data *rtd)
>   {
> -       union acp_dma_count playback_dma_count;
> -       union acp_dma_count capture_dma_count;
> -       u64 bytescount = 0;
> +       union acp_dma_count byte_count;

> -       if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               playback_dma_count.bcount.high = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH);
> -               playback_dma_count.bcount.low  = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_TRANSMIT_BYTE_CNT_LOW);
> -               bytescount = playback_dma_count.bytescount;
> -       } else {
> -               capture_dma_count.bcount.high = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_HIGH);
> -               capture_dma_count.bcount.low  = acp_reg_read(acp_mmio,
> -                                       mmACP_I2S_RECEIVED_BYTE_CNT_LOW);
> -               bytescount = capture_dma_count.bytescount;
> -       }
> -       return bytescount;
> +       byte_count.bcount.high = acp_reg_read(rtd->acp_mmio,
> +
rtd->byte_cnt_high_reg_offset);
> +       byte_count.bcount.low  = acp_reg_read(rtd->acp_mmio,
> +
rtd->byte_cnt_low_reg_offset);
> +       return byte_count.bytescount;
>   }

>   static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream
*substream)
> @@ -872,15 +862,10 @@ static snd_pcm_uframes_t acp_dma_pointer(struct
snd_pcm_substream *substream)
>                  return -EINVAL;

>          buffersize = frames_to_bytes(runtime, runtime->buffer_size);
> -       bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
> +       bytescount = acp_get_byte_count(rtd);

> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               if (bytescount > rtd->i2ssp_renderbytescount)
> -                       bytescount = bytescount -
rtd->i2ssp_renderbytescount;
> -       } else {
> -               if (bytescount > rtd->i2ssp_capturebytescount)
> -                       bytescount = bytescount -
rtd->i2ssp_capturebytescount;
> -       }
> +       if (bytescount > rtd->bytescount)
> +               bytescount = bytescount - rtd->bytescount;
>          pos = do_div(bytescount, buffersize);
>          return bytes_to_frames(runtime, pos);
>   }
> @@ -898,21 +883,15 @@ static int acp_dma_prepare(struct snd_pcm_substream
*substream)

>          if (!rtd)
>                  return -EINVAL;
> -       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -               config_acp_dma_channel(rtd->acp_mmio,
SYSRAM_TO_ACP_CH_NUM,
> -                                      PLAYBACK_START_DMA_DESCR_CH12,
> -                                      NUM_DSCRS_PER_CHANNEL, 0);
> -               config_acp_dma_channel(rtd->acp_mmio,
ACP_TO_I2S_DMA_CH_NUM,
> -                                      PLAYBACK_START_DMA_DESCR_CH13,
> -                                      NUM_DSCRS_PER_CHANNEL, 0);
> -       } else {
> -               config_acp_dma_channel(rtd->acp_mmio,
ACP_TO_SYSRAM_CH_NUM,
> -                                      CAPTURE_START_DMA_DESCR_CH14,
> -                                      NUM_DSCRS_PER_CHANNEL, 0);
> -               config_acp_dma_channel(rtd->acp_mmio,
I2S_TO_ACP_DMA_CH_NUM,
> -                                      CAPTURE_START_DMA_DESCR_CH15,
> -                                      NUM_DSCRS_PER_CHANNEL, 0);
> -       }
> +
> +       config_acp_dma_channel(rtd->acp_mmio,
> +                              rtd->ch1,
> +                              rtd->dma_dscr_idx_1,
> +                              NUM_DSCRS_PER_CHANNEL, 0);
> +       config_acp_dma_channel(rtd->acp_mmio,
> +                              rtd->ch2,
> +                              rtd->dma_dscr_idx_2,
> +                              NUM_DSCRS_PER_CHANNEL, 0);
>          return 0;
>   }

> @@ -934,15 +913,13 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>          case SNDRV_PCM_TRIGGER_START:
>          case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>          case SNDRV_PCM_TRIGGER_RESUME:
> -               bytescount = acp_get_byte_count(rtd->acp_mmio,
> -                                               substream->stream);
> +               bytescount = acp_get_byte_count(rtd);
> +               if (rtd->bytescount == 0)
> +                       rtd->bytescount = bytescount;
>                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -                       if (rtd->i2ssp_renderbytescount == 0)
> -                               rtd->i2ssp_renderbytescount = bytescount;
> -                       acp_dma_start(rtd->acp_mmio,
> -                                     SYSRAM_TO_ACP_CH_NUM, false);
> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>                          while (acp_reg_read(rtd->acp_mmio,
mmACP_DMA_CH_STS) &
> -
BIT(SYSRAM_TO_ACP_CH_NUM)) {
> +                               BIT(rtd->ch1)) {
>                                  if (!loops--) {
>                                          dev_err(component->dev,
>                                                  "acp dma start
timeout\n");
> @@ -950,40 +927,21 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>                                  }
>                                  cpu_relax();
>                          }
> -
> -                       acp_dma_start(rtd->acp_mmio,
> -                                     ACP_TO_I2S_DMA_CH_NUM, true);
> -
> -               } else {
> -                       if (rtd->i2ssp_capturebytescount == 0)
> -                               rtd->i2ssp_capturebytescount = bytescount;
> -                       acp_dma_start(rtd->acp_mmio,
> -                                     I2S_TO_ACP_DMA_CH_NUM, true);
>                  }
> +               acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>                  ret = 0;
>                  break;
>          case SNDRV_PCM_TRIGGER_STOP:
>          case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>          case SNDRV_PCM_TRIGGER_SUSPEND:
> -               /*
> -                * Need to stop only circular DMA channels :
> -                * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM.
Non-circular
> -                * channels will stopped automatically after its transfer
> -                * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
> -                */
>                  if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          SYSRAM_TO_ACP_CH_NUM);
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          ACP_TO_I2S_DMA_CH_NUM);
> -                       rtd->i2ssp_renderbytescount = 0;
> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch1);
> +                       ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>                  } else {
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          I2S_TO_ACP_DMA_CH_NUM);
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          ACP_TO_SYSRAM_CH_NUM);
> -                       rtd->i2ssp_capturebytescount = 0;
> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch2);
> +                       ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);
>                  }
> +               rtd->bytescount = 0;
>                  break;
>          default:
>                  ret = -EINVAL;
> @@ -1028,8 +986,6 @@ static int acp_dma_close(struct snd_pcm_substream
*substream)

DRV_NAME);
>          struct audio_drv_data *adata = dev_get_drvdata(component->dev);

> -       kfree(rtd);
> -
>          if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                  adata->play_i2ssp_stream = NULL;
>                  /*
> @@ -1059,6 +1015,7 @@ static int acp_dma_close(struct snd_pcm_substream
*substream)
>          if (!adata->play_i2ssp_stream && !adata->capture_i2ssp_stream)
>                  acp_reg_write(0, adata->acp_mmio,
mmACP_EXTERNAL_INTR_ENB);

> +       kfree(rtd);
>          return 0;
>   }

> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 0e6089b..62695ed 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -10,17 +10,28 @@
>   #define ACP_PLAYBACK_PTE_OFFSET                        10
>   #define ACP_CAPTURE_PTE_OFFSET                 0

> +/* Playback and Capture Offset for Stoney */
> +#define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
> +#define ACP_ST_CAPTURE_PTE_OFFSET      0x00
> +
>   #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>   #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4

>   #define ACP_PHYSICAL_BASE                      0x14000

> -/* Playback SRAM address (as a destination in dma descriptor) */
> -#define ACP_SHARED_RAM_BANK_1_ADDRESS          0x4002000
> -
> -/* Capture SRAM address (as a source in dma descriptor) */
> -#define ACP_SHARED_RAM_BANK_5_ADDRESS          0x400A000
> -#define ACP_SHARED_RAM_BANK_3_ADDRESS          0x4006000
> +/*
> + * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
> + * playback and SRAM Bank 2 for capture where as in case of BT I2S
> + * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
> + * be used for capture. Carrizo uses I2S SP controller instance. SRAM
Banks
> + * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be
used
> + * for capture scenario.
> + */
> +#define ACP_SRAM_BANK_1_ADDRESS                0x4002000
> +#define ACP_SRAM_BANK_2_ADDRESS                0x4004000
> +#define ACP_SRAM_BANK_3_ADDRESS                0x4006000
> +#define ACP_SRAM_BANK_4_ADDRESS                0x4008000
> +#define ACP_SRAM_BANK_5_ADDRESS                0x400A000

>   #define ACP_DMA_RESET_TIME                     10000
>   #define ACP_CLOCK_EN_TIME_OUT_VALUE            0x000000FF
> @@ -85,9 +96,17 @@ struct audio_substream_data {
>          unsigned int order;
>          u16 num_of_pages;
>          u16 direction;
> +       u16 ch1;
> +       u16 ch2;
> +       u16 destination;
> +       u16 dma_dscr_idx_1;
> +       u16 dma_dscr_idx_2;
> +       u32 pte_offset;
> +       u32 sram_bank;
> +       u32 byte_cnt_high_reg_offset;
> +       u32 byte_cnt_low_reg_offset;
>          uint64_t size;
> -       u64 i2ssp_renderbytescount;
> -       u64 i2ssp_capturebytescount;
> +       u64 bytescount;
>          void __iomem *acp_mmio;
>   };

> --
> 2.7.4

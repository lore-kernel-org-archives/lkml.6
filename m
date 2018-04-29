Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525038574; cv=none;
        d=google.com; s=arc-20160816;
        b=BYt1dGJMztNqb6vjV5j3ZRqKz76FR3hCFQWxEsxvnW/jCRmh0u3ZOvvX7HU3HkXPha
         LeMYtvhZ9GAHnD26ZcE05TbLIdjsmKLHzamu+0awLPR5GB7fcO50SC8LEbIPsOZXiV+I
         o4HAk2+QVNFN8Zm4gz2+pqkd+bsx8MAdXRhMykTcg3Sevf89X084IRWhqxAGERdLIo8p
         vy7Za6OtyUloWFDibSB1EzbT2M3k7JZ5PVZJTm9PntUK5DRBwLfhf70iI+Tn9kHNABZs
         SEybBPTHPaB/AC7qNkiDInFPN3Bmu91asQPuiro8iH0Wz6mxX977ahRbGpBFxQjIsE0G
         1rcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7UVKzSqMhUdNIElnB0oZWWGhepIAipBf9xbUcJlewvI=;
        b=mSTSxoNUicWpUT5fTYjaC+K3AcFJuKj/0yp7MwG/6sXgX8wHnUehbD74X4t6CrYklf
         nyxJBoRGcKvjSGmjXB4Q8Kj3G4lU+OXRZ8SyCJy/yVEzOKLvO1nGpJW+K/ZBBgaNcDoe
         lPku55xcUcBnFkA5pxmreqQN2EkZJGsIichmkYGdqI84Go5ZVF1cEjjjzUdu7utEzfDj
         SGcL5SEBbSFD+f+DfPUDY91twvD1lCp2ulhdiVU16geIm2GvfiKcPvzLJG1jSrbgUX+F
         WF1tyEBZRzwNof1gs9QjuWXpXPK0JAZTn6GL90ZGVQigbBj2gtcmXgcpH8S01j1XT7qQ
         YTog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Cxdsi1/G;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=Cxdsi1/G;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZq3jjld/rlcwLCcurXatx7o/I0/A89DnM7ZYNLrP16BH0IFVlBlDXclalmIRyrmHhoQEVgC0ixCVvZJel4R4jY=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-2-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-2-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:49:22 +0000
Message-ID: <CAGS+omBgTPJMB0V5s_K8cYtg+koB_-HBdy33kcRCAe4deEK-Gw@mail.gmail.com>
Subject: Re: [PATCH 02/11] ASoC: amd: dma config parameters changes
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com, jclinton@chromium.org,
	Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807079775772304?=
X-GMAIL-MSGID: =?utf-8?q?1599118848346381550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vijendar,

On Thu, Apr 26, 2018 at 5:14 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> Added dma configuration parameters to rtd structure.
> Moved dma configuration parameters intialization to
> hw_params callback.
> Removed hard coding in prepare and trigger callbacks.

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>    sound/soc/amd/acp-pcm-dma.c | 97
+++++++++++++++++----------------------------
>    sound/soc/amd/acp.h         |  5 +++
>    2 files changed, 41 insertions(+), 61 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 9c026c4..f18ed9a 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -321,19 +321,12 @@ static void config_acp_dma(void __iomem *acp_mmio,
>                              u32 asic_type)
>    {
>           u32 pte_offset, sram_bank;
> -       u16 ch1, ch2, destination, dma_dscr_idx;

>           if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
>                   pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;
>                   sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
> -               destination = TO_ACP_I2S_1;
> -
>           } else {
>                   pte_offset = ACP_CAPTURE_PTE_OFFSET;
> -               ch1 = SYSRAM_TO_ACP_CH_NUM;
> -               ch2 = ACP_TO_I2S_DMA_CH_NUM;

Wait... since this is the capture stream, shouldn't the channels have been:

    ch1 = ACP_TO_SYSRAM_CH_NUM; /* 14 */
    ch2 = I2S_TO_ACP_DMA_CH_NUM; /* 15 */

Is this an existing bug?  Why does everything still work if these are wrong?

>                   switch (asic_type) {
>                   case CHIP_STONEY:
>                           sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
> @@ -341,30 +334,19 @@ static void config_acp_dma(void __iomem *acp_mmio,
>                   default:
>                           sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
>                   }
> -               destination = FROM_ACP_I2S_1;
>           }
> -
>           acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>                          pte_offset);
> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
> -       else
> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
> -
>           /* Configure System memory <-> ACP SRAM DMA descriptors */
>           set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
> -                                      rtd->direction, pte_offset, ch1,
> -                                      sram_bank, dma_dscr_idx,
asic_type);
> -
> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
> -               dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
> -       else
> -               dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
> +                                      rtd->direction, pte_offset,
> +                                      rtd->ch1, sram_bank,
> +                                      rtd->dma_dscr_idx_1, asic_type);
>           /* Configure ACP SRAM <-> I2S DMA descriptors */
>           set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
>                                          rtd->direction, sram_bank,
> -                                      destination, ch2, dma_dscr_idx,
> -                                      asic_type);
> +                                      rtd->destination, rtd->ch2,
> +                                      rtd->dma_dscr_idx_2, asic_type);
>    }

>    /* Start a given DMA channel transfer */
> @@ -804,6 +786,21 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>                   acp_reg_write(val, adata->acp_mmio,
>                                 mmACP_I2S_16BIT_RESOLUTION_EN);
>           }
> +
> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> +               rtd->destination = TO_ACP_I2S_1;
> +               rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
> +               rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
> +       } else {
> +               rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
> +               rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
> +               rtd->destination = FROM_ACP_I2S_1;
> +               rtd->dma_dscr_idx_1 = CAPTURE_START_DMA_DESCR_CH14;
> +               rtd->dma_dscr_idx_2 = CAPTURE_START_DMA_DESCR_CH15;
> +       }
> +

I think you should do this initialization in acp_dma_open(), where the
audio_substream_data is kzalloc'ed and otherwise initialized to match the
provided snd_pcm_substream.

>           size = params_buffer_bytes(params);
>           status = snd_pcm_lib_malloc_pages(substream, size);
>           if (status < 0)
> @@ -898,21 +895,15 @@ static int acp_dma_prepare(struct snd_pcm_substream
*substream)

>           if (!rtd)
>                   return -EINVAL;
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

The original code was using ACP_TO_SYSRAM_CH_NUM for the capture case, but
now you are using SYSRAM_TO_ACP_CH_NUM as just initialized in
acp_dma_hw_params().  I think the old config_acp_dma() was wrong, and it
should still be ACP_TO_SYSRAM_CH_NUM.  When you make this fix, either do it
in a separate preliminary patch (preferred), or at least call it out in the
commit message.

Also, instead of "ch1" and "ch2", perhaps we can use the more descriptive
"ch_i2s" and "ch_sysram" [and same for dma_descr].

> +                              rtd->dma_dscr_idx_2,
> +                              NUM_DSCRS_PER_CHANNEL, 0);
>           return 0;
>    }

> @@ -939,10 +930,9 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                           if (rtd->i2ssp_renderbytescount == 0)
>                                   rtd->i2ssp_renderbytescount = bytescount;
> -                       acp_dma_start(rtd->acp_mmio,
> -                                     SYSRAM_TO_ACP_CH_NUM, false);
> +                       acp_dma_start(rtd->acp_mmio, rtd->ch1, false);
>                           while (acp_reg_read(rtd->acp_mmio,
mmACP_DMA_CH_STS) &
> -
BIT(SYSRAM_TO_ACP_CH_NUM)) {
> +                               BIT(rtd->ch1)) {
>                                   if (!loops--) {
>                                           dev_err(component->dev,
>                                                   "acp dma start
timeout\n");
> @@ -950,38 +940,23 @@ static int acp_dma_trigger(struct snd_pcm_substream
*substream, int cmd)
>                                   }
>                                   cpu_relax();
>                           }
> -
> -                       acp_dma_start(rtd->acp_mmio,
> -                                     ACP_TO_I2S_DMA_CH_NUM, true);
> -
>                   } else {
>                           if (rtd->i2ssp_capturebytescount == 0)
>                                   rtd->i2ssp_capturebytescount =
bytescount;
> -                       acp_dma_start(rtd->acp_mmio,
> -                                     I2S_TO_ACP_DMA_CH_NUM, true);
>                   }
> +               acp_dma_start(rtd->acp_mmio, rtd->ch2, true);
>                   ret = 0;
>                   break;
>           case SNDRV_PCM_TRIGGER_STOP:
>           case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>           case SNDRV_PCM_TRIGGER_SUSPEND:
> -               /*
> -                * Need to stop only circular DMA channels :
> -                * ACP_TO_I2S_DMA_CH_NUM / I2S_TO_ACP_DMA_CH_NUM.
Non-circular
> -                * channels will stopped automatically after its transfer
> -                * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
> -                */
>                   if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          SYSRAM_TO_ACP_CH_NUM);
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          ACP_TO_I2S_DMA_CH_NUM);
> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch1);
> +                       ret =  acp_dma_stop(rtd->acp_mmio, rtd->ch2);
>                           rtd->i2ssp_renderbytescount = 0;
>                   } else {
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          I2S_TO_ACP_DMA_CH_NUM);
> -                       ret = acp_dma_stop(rtd->acp_mmio,
> -                                          ACP_TO_SYSRAM_CH_NUM);
> +                       acp_dma_stop(rtd->acp_mmio, rtd->ch2);
> +                       ret = acp_dma_stop(rtd->acp_mmio, rtd->ch1);

Using "ch_i2s" and "ch_sysram" would help here, since then it wouldn't need
to do the slightly confusing "stop 2 then stop 1".

-Dan


>                           rtd->i2ssp_capturebytescount = 0;
>                   }
>                   break;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 0e6089b..5e25428 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -85,6 +85,11 @@ struct audio_substream_data {
>           unsigned int order;
>           u16 num_of_pages;
>           u16 direction;
> +       u16 ch1;
> +       u16 ch2;
> +       u16 destination;
> +       u16 dma_dscr_idx_1;
> +       u16 dma_dscr_idx_2;
>           uint64_t size;
>           u64 i2ssp_renderbytescount;
>           u64 i2ssp_capturebytescount;
> --
> 2.7.4

Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525038522; cv=none;
        d=google.com; s=arc-20160816;
        b=IjNjam5T04x0B8TcpBMaY+CXuXsyJynNtWoFM8Bm+FpOvbFCGSl6hc/1M8XTj7ebbT
         lJLsWNVOI6kVc5zTlOwiYaCkih6KDdoe4MJD7v7Hh95sCJ6RBzMz9uBacqOafvOtQl9S
         jCfQWOz5+FevSVGpc7jPLmm5ssM3EYcvg19KWvcFHisPqxQ3ABHyl3hS6q3HG64ZgCCu
         MIncIa76UEbrpF9fV3W0YMQ2+TTEzyd7T3RucSZxCvtJ0hoSvBPSIuQ+PV89OvDvu//o
         KwWAEG1N3C5np9gAh/bCAjMon5bH9cOWS2FGWRbPC1KyRmxvnVnGLthD8EFpVCbxf7CO
         R40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nhWh3FP4X/eVWxo2SOFcbFJ5gik/USd2wdfkdGnJcBA=;
        b=xSCxqNskZdcEX7obF+FLdKk4pR74nT1yDcbunpRc9xb2A3WOsgh717ulAMCcK4ZQk8
         Kqz6+4fohtb5wsNfs1TI8p052Y4vqqNznW8DC3Tak3Q1z2lKwGq/aD2LEhhVD0O+mU5I
         ubVGjpR7OAAYe93Y67e80F7UmtaZoSQN0nFsSDF9mCKtVY5qRxq9hht9CjfHRr10X3xj
         a/Fhx7yXBcT2zV3K2bgnluMr/3wtL4fBNalcyNkjYC0Oux+5OR49qBbdpHLov4O34YbA
         FTikXYkVgt9yzg7+QYwv4CDPELt780QSYjUd9kL9VSUohdqQBwos0Fb0iTqkU//kcsdx
         LH5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=nR+SEtTK;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=nR+SEtTK;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZo2jBbouzXRhycTcVlz6HX9Zm1bJ9ImHOx7+aTQ5ShSOQj8iZluX6cp1sjAHdD7HzDIAkOM3DUFMKfa+DYGlHM=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-5-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-5-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:48:31 +0000
Message-ID: <CAGS+omAH+W0yRxS4F42LOyVhKR3mTsNA1wXP-RQFr-BF6f_JJA@mail.gmail.com>
Subject: Re: [PATCH 05/11] ASoC: amd: pte offset related dma driver changes
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com, jclinton@chromium.org,
	Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807203680552021?=
X-GMAIL-MSGID: =?utf-8?q?1599118794497348859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 5:16 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> Added pte offset variable in audio_substream_data structure.
> Added Stoney related PTE offset macros in acp header file.
> Modified hw_params callback to assign the pte offset value
> based on asic_type.

> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>   sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
>   sound/soc/amd/acp.h         |  5 +++++
>   2 files changed, 24 insertions(+), 7 deletions(-)

> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 5f34be1..cb22653 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
>                             struct audio_substream_data *rtd,
>                             u32 asic_type)
>   {
> -       u32 pte_offset, sram_bank;
> +       u32 sram_bank;

> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
> -               pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>                  sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
> -       } else {
> -               pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +       else {
>                  switch (asic_type) {
>                  case CHIP_STONEY:
>                          sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
> @@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
>                  }
>          }
>          acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
> -                      pte_offset);
> +                      rtd->pte_offset);
>          /* Configure System memory <-> ACP SRAM DMA descriptors */
>          set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
> -                                      rtd->direction, pte_offset,
> +                                      rtd->direction, rtd->pte_offset,
>                                         rtd->ch1, sram_bank,
>                                         rtd->dma_dscr_idx_1, asic_type);
>          /* Configure ACP SRAM <-> I2S DMA descriptors */
> @@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>          }

>          if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +               switch (adata->asic_type) {
> +               case CHIP_STONEY:
> +                       rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
> +                       break;
> +               default:
> +                       rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +               }

As in patch 2, I believe this would be better done in acp_dma_open().

Why does Stoney use a different PTE_OFFSET?  Please answer this question in
the commit message.

-Dan

>                  rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>                  rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>                  rtd->destination = TO_ACP_I2S_1;
> @@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct
snd_pcm_substream *substream,
>                  mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>                  rtd->byte_cnt_low_reg_offset =
mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>          } else {
> +               switch (adata->asic_type) {
> +               case CHIP_STONEY:
> +                       rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
> +                       break;
> +               default:
> +                       rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +               }
>                  rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>                  rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>                  rtd->destination = FROM_ACP_I2S_1;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 82470bc..2f48d1d 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -10,6 +10,10 @@
>   #define ACP_PLAYBACK_PTE_OFFSET                        10
>   #define ACP_CAPTURE_PTE_OFFSET                 0

> +/* Playback and Capture Offset for Stoney */
> +#define ACP_ST_PLAYBACK_PTE_OFFSET     0x04
> +#define ACP_ST_CAPTURE_PTE_OFFSET      0x00
> +
>   #define ACP_GARLIC_CNTL_DEFAULT                        0x00000FB4
>   #define ACP_ONION_CNTL_DEFAULT                 0x00000FB4

> @@ -90,6 +94,7 @@ struct audio_substream_data {
>          u16 destination;
>          u16 dma_dscr_idx_1;
>          u16 dma_dscr_idx_2;
> +       u32 pte_offset;
>          u32 byte_cnt_high_reg_offset;
>          u32 byte_cnt_low_reg_offset;
>          uint64_t size;
> --
> 2.7.4

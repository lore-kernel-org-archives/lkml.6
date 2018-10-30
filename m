Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8898FC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2782A2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFrjJHRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2782A2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeJ3KYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:24:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39151 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeJ3KYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:24:10 -0400
Received: by mail-ua1-f66.google.com with SMTP id j38so3844697uae.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 18:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOLHPtts+YxboUGcvn3QxdQS2KyzHsIoCJ0QPvpA1tI=;
        b=FFrjJHRmiBasoclJOXcamiOPVs0WEAG9DR7CIts0ycxkVkazZA7zj1SqaoqmuOag/b
         G5vrNGRmlfx/k8voQUNWcchPKzo/Cwtnt0+K4Mn7+ne9R8I2dfKs9Wi0jCgW/WL0REJ6
         oyNxnXC2gtMsTlFgXsIj35VetcyimFTAp0PeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOLHPtts+YxboUGcvn3QxdQS2KyzHsIoCJ0QPvpA1tI=;
        b=jL3xopxawKq3W8bICPJtdGe/OuyrJHMvBZxqbKPMQP3NOG6gvL63379rs0GvutHXkr
         hAx//gfj9CGkGoYGYNWY5AWDanHWAKjIrv2EY/Mjx7tEa1+/dri/xYF1B35/2zmkg1UC
         OKCh9Q5It8cMwTZZP7RhkcO+14Q25G1DOT4OGK6dj7o/hhAYIgmT407fV4fQhKnFm4KL
         JUxNDx/fP+SXNk8rS5VDyIHxz9ZYGOOMjKO6SNc/8Mv1WTE4SCw+NotJz8JZkq7sL/65
         8wff5v3VY+MEHMUjYPF3ACCx56cf/HmUO3jcC4IH84HCI7cpbZgcUQqluAKgYUV0Gx2e
         N6fw==
X-Gm-Message-State: AGRZ1gJdblisNJwD8Mi2IIjrsvany4w43gf5qToOoNzS0S+VgLryWhel
        b/35nt3t7PuIsgTH2iRJdZIbc3zuF38=
X-Google-Smtp-Source: AJdET5cKBsHS/NkzTgM/zWtp8TdP/NtlvOVu/ZZ6nm8mSs6FMqaC+MpvHhW/1YwlvfuUu5zYAPgxNA==
X-Received: by 2002:a9f:3829:: with SMTP id p38mr7485704uad.25.1540863169417;
        Mon, 29 Oct 2018 18:32:49 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id f126sm4604900vsd.11.2018.10.29.18.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 18:32:48 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id w194so6624434vsc.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 18:32:48 -0700 (PDT)
X-Received: by 2002:a67:2b43:: with SMTP id r64mr6461642vsr.64.1540863168206;
 Mon, 29 Oct 2018 18:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <1540798621-32627-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1540798621-32627-1-git-send-email-akshu.agrawal@amd.com>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Mon, 29 Oct 2018 19:32:52 -0600
X-Gmail-Original-Message-ID: <CAGS+omAbvoYpZvK+WWejDF3YJWpCqDJXA7=3+7--nO897LLE8g@mail.gmail.com>
Message-ID: <CAGS+omAbvoYpZvK+WWejDF3YJWpCqDJXA7=3+7--nO897LLE8g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: AMD: Fix race condition between register access
To:     Akshu Agrawal <Akshu.Agrawal@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, Vijendar.Mukunda@amd.com,
        Guenter Roeck <linux@roeck-us.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akshu,


On Mon, Oct 29, 2018 at 1:39 AM Agrawal, Akshu <Akshu.Agrawal@amd.com> wrote:
>
> During simultaneous running of playback and capture, we
> got hit by incorrect value write on common register. This was due
> to race condition between 2 streams.
> Fixing this by locking the common register access.

Nice catch!  It looks looks like one of the operations you are trying
to make atomic is that two step Addr + Data register update.
If so, then I recommend refactoring a bit, and just doing that locked
2-step-access in its own helper function, like this:

  static void acp_reg_write_srbm_targ(void __iomem *acp_mmio, u32
addr, u32 data)
  {
    unsigned long flags;

    spin_lock_irqsave(&lock, flags);
    acp_reg_write(addr, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
    acp_reg_write(data, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
    spin_unlock_irqrestore(&lock, flags);
  }

And similarly, you can add 2 more locking helpers, one for modifying
the imr/ch and another for mmACP_I2S_16BIT_RESOLUTION_EN.

>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
>  sound/soc/amd/acp-pcm-dma.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 0ac4b5b..993a7db 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -121,6 +121,9 @@
>         .periods_max = CAPTURE_MAX_NUM_PERIODS,
>  };
>
> +/* Lock to protect access to registers */
> +static DEFINE_SPINLOCK(lock);
> +
>  static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
>  {
>         return readl(acp_mmio + (reg * 4));
> @@ -168,9 +171,12 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
>                                           acp_dma_dscr_transfer_t *descr_info)
>  {
>         u32 sram_offset;
> +       unsigned long flags;
>
>         sram_offset = (descr_idx * sizeof(acp_dma_dscr_transfer_t));
>
> +       spin_lock_irqsave(&lock, flags);
> +
>         /* program the source base address. */
>         acp_reg_write(sram_offset, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
>         acp_reg_write(descr_info->src,  acp_mmio, mmACP_SRBM_Targ_Idx_Data);
> @@ -181,6 +187,8 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
>         /* program the number of bytes to be transferred for this descriptor. */
>         acp_reg_write(sram_offset + 8,  acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
>         acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
> @@ -309,8 +317,12 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
>         u32 low;
>         u32 high;
>         u32 offset;
> +       unsigned long flags;
>
>         offset  = ACP_DAGB_GRP_SRBM_SRAM_BASE_OFFSET + (pte_offset * 8);
> +
> +       spin_lock_irqsave(&lock, flags);
> +
>         for (page_idx = 0; page_idx < (num_of_pages); page_idx++) {
>                 /* Load the low address of page int ACP SRAM through SRBM */
>                 acp_reg_write((offset + (page_idx * 8)),
> @@ -333,6 +345,8 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
>                 /* Move to next physically contiguos page */
>                 pg++;
>         }
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  static void config_acp_dma(void __iomem *acp_mmio,
> @@ -367,6 +381,7 @@ static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
>                                        u16 cap_channel)
>  {
>         u32 val, ch_reg, imr_reg, res_reg;
> +       unsigned long flags;
>
>         switch (cap_channel) {
>         case CAP_CHANNEL1:
> @@ -381,6 +396,8 @@ static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
>                 imr_reg = mmACP_I2SMICSP_IMR0;
>                 break;
>         }
> +       spin_lock_irqsave(&lock, flags);
> +
>         val = acp_reg_read(acp_mmio,
>                            mmACP_I2S_16BIT_RESOLUTION_EN);
>         if (val & ACP_I2S_MIC_16BIT_RESOLUTION_EN) {
> @@ -393,12 +410,15 @@ static void acp_dma_cap_channel_enable(void __iomem *acp_mmio,
>         val &= ~ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
>         acp_reg_write(val, acp_mmio, imr_reg);
>         acp_reg_write(0x1, acp_mmio, ch_reg);
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
>                                         u16 cap_channel)
>  {
>         u32 val, ch_reg, imr_reg;
> +       unsigned long flags;
>
>         switch (cap_channel) {
>         case CAP_CHANNEL1:
> @@ -411,11 +431,15 @@ static void acp_dma_cap_channel_disable(void __iomem *acp_mmio,
>                 ch_reg = mmACP_I2SMICSP_RER0;
>                 break;
>         }
> +       spin_lock_irqsave(&lock, flags);
> +
>         val = acp_reg_read(acp_mmio, imr_reg);
>         val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXDAM_MASK;
>         val |= ACP_I2SMICSP_IMR1__I2SMICSP_RXFOM_MASK;
>         acp_reg_write(val, acp_mmio, imr_reg);
>         acp_reg_write(0x0, acp_mmio, ch_reg);
> +
> +       spin_unlock_irqrestore(&lock, flags);
>  }
>
>  /* Start a given DMA channel transfer */
> @@ -847,6 +871,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>         int status;
>         uint64_t size;
>         u32 val = 0;
> +       unsigned long flags;
>         struct page *pg;
>         struct snd_pcm_runtime *runtime;
>         struct audio_substream_data *rtd;
> @@ -870,6 +895,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>                 }
>         }
>         if (adata->asic_type == CHIP_STONEY) {
> +               spin_lock_irqsave(&lock, flags);
> +
>                 val = acp_reg_read(adata->acp_mmio,
>                                    mmACP_I2S_16BIT_RESOLUTION_EN);
>                 if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> @@ -893,6 +920,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>                 }
>                 acp_reg_write(val, adata->acp_mmio,
>                               mmACP_I2S_16BIT_RESOLUTION_EN);
> +
> +               spin_unlock_irqrestore(&lock, flags);
>         }
>
>         if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> --
> 1.9.1
>

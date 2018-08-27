Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2692EC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB946208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O4ACl2gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB946208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeH1Ct5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:49:57 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34468 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeH1Ct5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:49:57 -0400
Received: by mail-vk0-f68.google.com with SMTP id l143-v6so356239vke.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfKBQQP0XiTYAbO3m1CjkqLYWuIeFBiGpT6Kjx9kc+U=;
        b=O4ACl2gxwFc++koTOwfZHh9QjAbx08JSK0v3B4F4ModozViPWG8pXHC69sXj2Dxu8u
         e3gSbP/OWW+FrVp5x/VT77W0CYGyCp810pfzICxmJTAmRbHz2BHpWACU/++4JD1+2LRP
         V4bL+Ld91HUHe0i+nF9pXu5v2G3fIzZ/x75cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfKBQQP0XiTYAbO3m1CjkqLYWuIeFBiGpT6Kjx9kc+U=;
        b=OB+PNtqoSHghDmDY9blSDT7+6/EuF3f/YbSZ6KLNpgyAhMbT95WJgKrBsN3rP6BVdx
         9UnFByxnhdbfwJVNu4ow5girXZZxcZ5XNayev9lx4+INdX460dOpl8wtVzNtC2wteUL3
         8dxDRRfgvGjsKNrME9JxlPB8TZS7j6/E2z7tzDYyM5VErllZh9jxfTqoGUpptn1rGBSG
         QvRS4po5z1QsBgsK5W31hkFZej5dJ3D/zaJguDzgPzj7HkeOOlPo4X+BnO4Z425bm1bZ
         ie/3MJAAOvsRPWI2zz0WeMEFctqVj/470O9f2x4bjyJIQ/HYvHxBHZI0NiK4oenSKoNn
         6CRg==
X-Gm-Message-State: APzg51BpPR4+Lp+o5nE7BpUS2S8YrEcxLuyTEPFZNZqI8T9iijsodUiz
        5wbj4/Oujt8oRNFdPW1W5o1v3/JilmR0xg==
X-Google-Smtp-Source: ANB0VdYAVkrGq9YTBlCGdjyBud5C/b0/g41EetnJugjaEqtAbuzHK7/QT75zTJoscQdFqdeD+SyzKA==
X-Received: by 2002:a1f:c9c7:: with SMTP id z190-v6mr9038371vkf.168.1535410874182;
        Mon, 27 Aug 2018 16:01:14 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 22-v6sm151040vkw.26.2018.08.27.16.01.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:01:13 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id i4-v6so448017uak.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:01:12 -0700 (PDT)
X-Received: by 2002:a9f:2432:: with SMTP id 47-v6mr9838646uaq.56.1535410872197;
 Mon, 27 Aug 2018 16:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <1534834520-18397-1-git-send-email-akshu.agrawal@amd.com>
In-Reply-To: <1534834520-18397-1-git-send-email-akshu.agrawal@amd.com>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Mon, 27 Aug 2018 17:01:01 -0600
X-Gmail-Original-Message-ID: <CAGS+omDCWFjLKNOfRHQzWNUG4efpC+9Tk=RXDDUDtza7skZ2dA@mail.gmail.com>
Message-ID: <CAGS+omDCWFjLKNOfRHQzWNUG4efpC+9Tk=RXDDUDtza7skZ2dA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: AMD: Set constraints for DMIC and MAX98357a codec
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, Vijendar.Mukunda@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        weiyongjun1@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 12:55 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> We support dual channel, 48Khz. This constraint was set only for
> da7219. It is being extended to DMIC and MAX98357a.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index 066d5489..cf2f648 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -162,10 +162,21 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
>
>  static int cz_max_startup(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_card *card = rtd->card;
>         struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
>
> +       /*
> +        * On this platform for PCM device we support stereo
> +        */
> +
> +       runtime->hw.channels_max = DUAL_CHANNEL;
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +                                  &constraints_channels);
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +                                  &constraints_rates);
> +
>         machine->i2s_instance = I2S_BT_INSTANCE;
>         return da7219_clk_enable(substream);
>  }
> @@ -177,20 +188,42 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
>
>  static int cz_dmic0_startup(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_card *card = rtd->card;
>         struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
>
> +       /*
> +        * On this platform for PCM device we support stereo
> +        */
> +
> +       runtime->hw.channels_max = DUAL_CHANNEL;
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +                                  &constraints_channels);
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +                                  &constraints_rates);
> +
>         machine->i2s_instance = I2S_BT_INSTANCE;
>         return da7219_clk_enable(substream);
>  }
>
>  static int cz_dmic1_startup(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_card *card = rtd->card;
>         struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
>
> +       /*
> +        * On this platform for PCM device we support stereo
> +        */
> +
> +       runtime->hw.channels_max = DUAL_CHANNEL;
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +                                  &constraints_channels);
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +                                  &constraints_rates);
> +
>         machine->i2s_instance = I2S_SP_INSTANCE;
>         machine->capture_channel = CAP_CHANNEL0;
>         return da7219_clk_enable(substream);
> --
> 1.9.1
>

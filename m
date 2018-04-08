Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeDHMQX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 08:16:23 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:56688 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDHMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 08:16:22 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 08 Apr 2018 14:16:20 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 14/15] ARM: pxa: change SSP devices allocation
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <20180402142656.26815-15-robert.jarzmik@free.fr>
        <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
        <87lge4485x.fsf@belgarion.home>
        <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
        <87zi2i2ljy.fsf@belgarion.home>
        <CAK8P3a0xJnVfXfUtP+JXGNgc2-LuHUmZCMq-SnEQw3wu3azemA@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Sun, 08 Apr 2018 14:16:17 +0200
In-Reply-To: <CAK8P3a0xJnVfXfUtP+JXGNgc2-LuHUmZCMq-SnEQw3wu3azemA@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 5 Apr 2018 09:29:30 +0200")
Message-ID: <87o9it3nce.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> I don't know exactly how the probing works, but I'd assume that we have
> the correct device pointers in pxa2xx_ac97_dev_probe() and
> asoc_ssp_probe(), or maybe in pxa2xx_ac97_*_startup() and
> pxa_ssp_startup().

Yes, let's try this way, in the former patch

"ASoC: pxa: remove the dmaengine compat need" :
+++ b/sound/arm/pxa2xx-pcm-lib.c
@@ -126,7 +127,7 @@ int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
                return ret;
 
        return snd_dmaengine_pcm_open(
-               substream, dma_request_slave_channel(rtd->platform->dev,
+               substream, dma_request_slave_channel(rtd->cpu_dai->dev,
                                                     dma_params->chan_name));
 }

The cpu_dai device should be either pxa27x_ac97 or pxa-ssp-dai.<Id>, and amend
the dma slave map accordingly.

Cheers.

-- 
Robert

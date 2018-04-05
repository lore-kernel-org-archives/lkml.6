Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDEH3c (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 03:29:32 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34452 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEH3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 03:29:31 -0400
X-Google-Smtp-Source: AIpwx48YdtuDYtHlaE51YLFqjgK9rTKAmhwHTT2E0XpxEAKSpU0ji6aKkrQBHDtPK9mqlFNmENz8fG5aoUtvejEASqI=
MIME-Version: 1.0
In-Reply-To: <87zi2i2ljy.fsf@belgarion.home>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-15-robert.jarzmik@free.fr> <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
 <87lge4485x.fsf@belgarion.home> <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
 <87zi2i2ljy.fsf@belgarion.home>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 09:29:30 +0200
X-Google-Sender-Auth: JSw7Ac3WKo6NymtgimguWiByWYA
Message-ID: <CAK8P3a0xJnVfXfUtP+JXGNgc2-LuHUmZCMq-SnEQw3wu3azemA@mail.gmail.com>
Subject: Re: [PATCH 14/15] ARM: pxa: change SSP devices allocation
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 8:51 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> I'm still unable to follow through that code, but I understand now that
>> the device you pass to dma_request_slave_channel() is not the one
>> we'd like it to be here.
>>
>> Where exactly does that call to dma_request_chan() happen? Is this
>> the one in dmaengine_pcm_new()? Could we perhaps put a
>> pointer to the SSP device into snd_dmaengine_dai_dma_data?
> This is a sample stack I captured with an added WARN_ON(1), triggered by a
> userland "aplay Sultans_Of_Swing.wav" :)
>
> [  299.216743] [<c0012e80>] (unwind_backtrace) from [<c000f55c>] (show_stack+0x20/0x24)
> [  299.223986] [<c000f55c>] (show_stack) from [<c0529d68>] (dump_stack+0x20/0x28)
> [  299.231321] [<c0529d68>] (dump_stack) from [<c001de34>] (__warn+0xf0/0x11c)
> [  299.238183] [<c001de34>] (__warn) from [<c001df94>] (warn_slowpath_null+0x4c/0x58)
> [  299.245234] [<c001df94>] (warn_slowpath_null) from [<c02a2d38>] (dma_request_chan+0x40/0x228)
> [  299.252550] [<c02a2d38>] (dma_request_chan) from [<c02a2f38>] (dma_request_slave_channel+0x18/0x24)
> [  299.259855] [<c02a2f38>] (dma_request_slave_channel) from [<c03f76f0>] (__pxa2xx_pcm_open+0xf4/0x110)
> [  299.266789] [<c03f76f0>] (__pxa2xx_pcm_open) from [<c0409ed0>] (soc_pcm_open+0xf8/0x9c8)
> [  299.273932] [<c0409ed0>] (soc_pcm_open) from [<c03db9d4>] (snd_pcm_open_substream+0x9c/0x134)

Ok, so it seems we currently have a special case here that is only used by
pxa/mmp and omap, and you can simply open-code that by calling
dma_request_chan() from the pxa-specific __pxa2xx_pcm_open()
with any device pointer you like, it doesn't have to be the main audio
device.

I don't know exactly how the probing works, but I'd assume that we have
the correct device pointers in pxa2xx_ac97_dev_probe() and
asoc_ssp_probe(), or maybe in pxa2xx_ac97_*_startup() and
pxa_ssp_startup().

      Arnd

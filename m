Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDEGvb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 02:51:31 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:30026 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDEGv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 02:51:29 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 05 Apr 2018 08:51:28 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 14/15] ARM: pxa: change SSP devices allocation
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
        <20180402142656.26815-15-robert.jarzmik@free.fr>
        <CAK8P3a2hYWO2eweg3zpR7iJoqtH4uxJLAxJAno7L96G7nA2HxQ@mail.gmail.com>
        <87lge4485x.fsf@belgarion.home>
        <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 05 Apr 2018 08:51:13 +0200
In-Reply-To: <CAK8P3a1ko=YEwR2VOahH0OWHfeOyWAzDYah4DSohBcvTNq_MKQ@mail.gmail.com>
        (Arnd Bergmann's message of "Tue, 3 Apr 2018 17:53:25 +0200")
Message-ID: <87zi2i2ljy.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> I'm still unable to follow through that code, but I understand now that
> the device you pass to dma_request_slave_channel() is not the one
> we'd like it to be here.
>
> Where exactly does that call to dma_request_chan() happen? Is this
> the one in dmaengine_pcm_new()? Could we perhaps put a
> pointer to the SSP device into snd_dmaengine_dai_dma_data?
This is a sample stack I captured with an added WARN_ON(1), triggered by a
userland "aplay Sultans_Of_Swing.wav" :)

[  299.216743] [<c0012e80>] (unwind_backtrace) from [<c000f55c>] (show_stack+0x20/0x24)
[  299.223986] [<c000f55c>] (show_stack) from [<c0529d68>] (dump_stack+0x20/0x28)
[  299.231321] [<c0529d68>] (dump_stack) from [<c001de34>] (__warn+0xf0/0x11c)
[  299.238183] [<c001de34>] (__warn) from [<c001df94>] (warn_slowpath_null+0x4c/0x58)
[  299.245234] [<c001df94>] (warn_slowpath_null) from [<c02a2d38>] (dma_request_chan+0x40/0x228)
[  299.252550] [<c02a2d38>] (dma_request_chan) from [<c02a2f38>] (dma_request_slave_channel+0x18/0x24)
[  299.259855] [<c02a2f38>] (dma_request_slave_channel) from [<c03f76f0>] (__pxa2xx_pcm_open+0xf4/0x110)
[  299.266789] [<c03f76f0>] (__pxa2xx_pcm_open) from [<c0409ed0>] (soc_pcm_open+0xf8/0x9c8)
[  299.273932] [<c0409ed0>] (soc_pcm_open) from [<c03db9d4>] (snd_pcm_open_substream+0x9c/0x134)
[  299.281290] [<c03db9d4>] (snd_pcm_open_substream) from [<c03dbb28>] (snd_pcm_open+0xbc/0x22c)
[  299.288255] [<c03dbb28>] (snd_pcm_open) from [<c03dbd58>] (snd_pcm_playback_open+0x50/0x88)
[  299.295468] [<c03dbd58>] (snd_pcm_playback_open) from [<c03c9708>] (snd_open+0x124/0x144)
[  299.302897] [<c03c9708>] (snd_open) from [<c0117de4>] (chrdev_open+0x1a0/0x1f0)
[  299.310296] [<c0117de4>] (chrdev_open) from [<c010f4cc>] (do_dentry_open.constprop.0+0x1d4/0x31c)
[  299.317345] [<c010f4cc>] (do_dentry_open.constprop.0) from [<c011061c>] (vfs_open+0x7c/0x80)
[  299.324597] [<c011061c>] (vfs_open) from [<c0123080>] (path_openat+0xbe8/0xf90)
[  299.332003] [<c0123080>] (path_openat) from [<c0124240>] (do_filp_open+0x80/0xe4)
[  299.339044] [<c0124240>] (do_filp_open) from [<c0110a08>] (do_sys_open+0x148/0x1f8)
[  299.346225] [<c0110a08>] (do_sys_open) from [<c0110ae4>] (SyS_open+0x2c/0x30)
[  299.353505] [<c0110ae4>] (SyS_open) from [<c0009000>] (ret_fast_syscall+0x0/0x28)

Cheers.

-- 
Robert

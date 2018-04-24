Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758132AbeDXN1g (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:27:36 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45630 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758046AbeDXN13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:27:29 -0400
X-Google-Smtp-Source: AB8JxZraXtDfOL8GHlRhXBADiGIPJYR8acDhab4tE0lthzsc8Yiz68FJBybYZ96OM7nOR4Nzww7DW7KLAzQxzfq86o0=
MIME-Version: 1.0
In-Reply-To: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org> <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Apr 2018 15:27:27 +0200
X-Google-Sender-Auth: 9vGTGqnLeertsfqkaocHVDPomWY
Message-ID: <CAK8P3a2Os66+iwQYf97qh05W2JP8rmWao8zmKoHiXqVHvyYAJA@mail.gmail.com>
Subject: Re: [PATCH 8/8] ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Ingo Molnar <mingo@kernel.org>,
        SF Markus Elfring <elfring@users.sourceforge.net>,
        Dan Carpenter <dan.carpenter@oracle.com>, jeeja.kp@intel.com,
        Vinod Koul <vinod.koul@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        subhransu.s.prusty@intel.com, Bhumika Goyal <bhumirks@gmail.com>,
        gudishax.kranthikumar@intel.com, Naveen M <naveen.m@intel.com>,
        hardik.t.shah@intel.com, Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Fabian Frederick <fabf@skynet.be>, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 2:06 PM, Baolin Wang <baolin.wang@linaro.org> wrote:

> @@ -544,6 +543,8 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
>         case SNDRV_PCM_IOCTL_XRUN:
>         case SNDRV_PCM_IOCTL_LINK:
>         case SNDRV_PCM_IOCTL_UNLINK:
> +       case __SNDRV_PCM_IOCTL_SYNC_PTR32:
> +       case __SNDRV_PCM_IOCTL_SYNC_PTR64:
>                 return snd_pcm_common_ioctl(file, substream, cmd, argp);
>         case SNDRV_PCM_IOCTL_HW_REFINE32:
>                 return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
> @@ -555,8 +556,6 @@ static long snd_pcm_ioctl_compat(struct file *file, unsigned int cmd, unsigned l
>                 return snd_pcm_status_user32(substream, argp, false);
>         case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT32:
>                 return snd_pcm_status_user32(substream, argp, true);
> -       case SNDRV_PCM_IOCTL_SYNC_PTR32:
> -               return snd_pcm_ioctl_sync_ptr_compat(substream, argp);
>         case SNDRV_PCM_IOCTL_CHANNEL_INFO32:
>                 return snd_pcm_ioctl_channel_info_compat(substream, argp);
>         case SNDRV_PCM_IOCTL_WRITEI_FRAMES32:

I found a bug here while doing some more testing on my own patch:
__SNDRV_PCM_IOCTL_SYNC_PTR64 has the same value as
SNDRV_PCM_IOCTL_SYNC_PTR_X32, so we get a duplicate case
error when CONFIG_X86_X32 is enabled. We still need both handlers,
so the fix I came up with is:

diff --git a/sound/core/pcm_compat.c b/sound/core/pcm_compat.c
index 51a9447442f3..dbeeae50fb8d 100644
--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -543,8 +543,13 @@ static long snd_pcm_ioctl_compat(struct file
*file, unsigned int cmd, unsigned l
        case SNDRV_PCM_IOCTL_XRUN:
        case SNDRV_PCM_IOCTL_LINK:
        case SNDRV_PCM_IOCTL_UNLINK:
-       case __SNDRV_PCM_IOCTL_SYNC_PTR32:
        case __SNDRV_PCM_IOCTL_SYNC_PTR64:
+#ifdef CONFIG_X86_X32
+               if (in_x32_syscall())
+                       return snd_pcm_ioctl_sync_ptr_x32(substream, argp);
+               /* fallthru */
+#endif /* CONFIG_X86_X32 */
+       case __SNDRV_PCM_IOCTL_SYNC_PTR32:
                return snd_pcm_common_ioctl(file, substream, cmd, argp);
        case SNDRV_PCM_IOCTL_HW_REFINE32:
                return snd_pcm_ioctl_hw_params_compat(substream, 1, argp);
@@ -577,8 +582,6 @@ static long snd_pcm_ioctl_compat(struct file
*file, unsigned int cmd, unsigned l
        case SNDRV_PCM_IOCTL_STATUS_EXT_COMPAT64:
                return snd_pcm_status_user_compat64(substream, argp, true);
 #ifdef CONFIG_X86_X32
-       case SNDRV_PCM_IOCTL_SYNC_PTR_X32:
-               return snd_pcm_ioctl_sync_ptr_x32(substream, argp);
        case SNDRV_PCM_IOCTL_CHANNEL_INFO_X32:
                return snd_pcm_ioctl_channel_info_x32(substream, argp);
 #endif /* CONFIG_X86_X32 */

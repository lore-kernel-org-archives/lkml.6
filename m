Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756631AbeDZPPC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 11:15:02 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34633 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755698AbeDZPPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 11:15:01 -0400
X-Google-Smtp-Source: AB8JxZpB3YxX770EAHaVbV44WuMScsR2I+zgctXK5W6LxAwfmDCz7R2rxd1xtoN6rh/qutW38NShAkzoKZZZPt5eo8s=
MIME-Version: 1.0
In-Reply-To: <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
References: <cover.1524570852.git.baolin.wang@linaro.org> <e7d7ed852943b5a35c5d494071f522465620371b.1524570852.git.baolin.wang@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 17:14:59 +0200
X-Google-Sender-Auth: nYo1NyvbATjaLowW7b_gg9sdGaU
Message-ID: <CAK8P3a24UW4FTJ=Ak7vB++uQZhLj+0LTqgbwpxpHbDVL+8HsLA@mail.gmail.com>
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

> -struct snd_pcm_mmap_status {
> +/*
> + * For mmap operations, we need the 64-bit layout, both for compat mode,
> + * and for y2038 compatibility. For 64-bit applications, the two definitions
> + * are identical, so we keep the traditional version.
> + */
> +#ifdef __SND_STRUCT_TIME64
> +#define __snd_pcm_mmap_status64                snd_pcm_mmap_status
> +#define __snd_pcm_mmap_control64       snd_pcm_mmap_control
> +#define __snd_pcm_sync_ptr64           snd_pcm_sync_ptr
> +#else
> +#define __snd_pcm_mmap_status          snd_pcm_mmap_status
> +#define __snd_pcm_mmap_control         snd_pcm_mmap_control
> +#define __snd_pcm_sync_ptr             snd_pcm_sync_ptr
> +#endif
> +
> +struct __snd_pcm_mmap_status {
>         snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_XXXX */
>         int pad1;                       /* Needed for 64 bit alignment */
>         snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */

One more thing here: this definition is slightly suboptimal because in
an alsa-lib that gets built with 64-bit time_t, we end up with an unusable
__snd_pcm_mmap_status structure (__snd_pcm_mmap_status64 works
fine, and that would be the normal thing to use). Just in case we want
to be able to build an alsa-lib that is capable of running both on
new kernels with 64-bit time_t interfaces exposed to applications and
also on old kernels that don't have the new ioctls, we probably want
another fixup merged in:

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 18fbdcb2c7b6..638c717d3eb9 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -496,19 +496,30 @@ struct snd_pcm_status {
 #define __snd_pcm_mmap_status64                snd_pcm_mmap_status
 #define __snd_pcm_mmap_control64       snd_pcm_mmap_control
 #define __snd_pcm_sync_ptr64           snd_pcm_sync_ptr
+#define __snd_timespec64               timespec
+struct __snd_timespec {
+       __s32 tv_sec;
+       __s32 tv_nsec;
+};
 #else
 #define __snd_pcm_mmap_status          snd_pcm_mmap_status
 #define __snd_pcm_mmap_control         snd_pcm_mmap_control
 #define __snd_pcm_sync_ptr             snd_pcm_sync_ptr
+#define __snd_timespec                 timespec
+struct __snd_timespec64 {
+       __s64 tv_sec;
+       __s64 tv_nsec;
+};
+
 #endif

 struct __snd_pcm_mmap_status {
        snd_pcm_state_t state;          /* RO: state - SNDRV_PCM_STATE_XXXX */
        int pad1;                       /* Needed for 64 bit alignment */
        snd_pcm_uframes_t hw_ptr;       /* RO: hw ptr (0...boundary-1) */
-       struct timespec tstamp;         /* Timestamp */
+       struct __snd_timespec tstamp;   /* Timestamp */
        snd_pcm_state_t suspended_state; /* RO: suspended stream state */
-       struct timespec audio_tstamp;   /* from sample counter or wall clock */
+       struct __snd_timespec audio_tstamp; /* from sample counter or
wall clock */
 };

 struct __snd_pcm_mmap_control {
@@ -532,11 +543,6 @@ struct __snd_pcm_sync_ptr {
        } c;
 };

-struct __snd_timespec64 {
-       __s64 tv_sec;
-       __s64 tv_nsec;
-};
-
 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN :
defined(__BIG_ENDIAN)
 typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
 typedef char __pad_after_uframe[0];

With this change, alsa-lib can either access whichever structure
matches the glibc 'timespec' definition, or it can ask for
__struct __snd_pcm_mmap_status and struct __snd_pcm_mmap_status64
explicitly, regardless of the time_t definition.

         Arnd

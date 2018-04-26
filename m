Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755861AbeDZNbL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:31:11 -0400
Received: from mail1.perex.cz ([77.48.224.245]:60900 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754847AbeDZNbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:31:10 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E41D7A0042
Subject: Re: [PATCH 0/4] ALSA: Fix year 2038 issue for sound subsystem,
 alternative
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc: tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        Baolin Wang <baolin.wang@linaro.org>
References: <20180426124422.2921744-1-arnd@arndb.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <6aa760e5-390a-b7ba-62f1-dc01308031fa@perex.cz>
Date: Thu, 26 Apr 2018 15:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180426124422.2921744-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 26.4.2018 v 14:44 Arnd Bergmann napsal(a):
> I've tried the suggestion from Jaroslaw, doing a minimal change to the
> UAPI headers to keep the existing binary interface. As he predicted,
> this is a much simpler set of kernel changes, but we will pay for that
> with added complexity in alsa-lib.
> 
> The first two patches in this series are taken from Baolin's patch
> set, with a small bugfix folded in to avoid a compile-time regression.
> 
> The other two patches are to redefine the UAPI and to deprecate
> the support for CLOCK_REALTIME time stamps, which we can no longer
> allow with user space that we expect to survive beyond 2038.
> 
> Overall, I'd still be happier with Baolin's approach since it allows
> us to keep compatiblity with CLOCK_REALTIME users and requires
> fewer changes in user space, but this would work as well.

Hi Arnd,

  Thanks for your work. I proposed a bit different implementation. Example:

struct snd_example {
  struct snd_native_timespec tstamp;
  ....
  u64 tstamp_sec64; /* use the reserved[] array for this */
};

  So tstamp contains the current 32-bit tv_sec/tv_nsec and the full
64-bit value is in tstamp_sec64. In this way, we can transfer any type
of the timespec64 values and it's backward compatible to retain the
binary compatibility. The protocol versions should be increased to let
the userspace know about the new 64-bit fields.

  The timer read protocol must be updated, because the stream will
change, so I am fine to add new ioctl (like originally proposed).

  The alsa-lib defines timespec only if posix defines are not set so
glibc's time.h does not define the timespec structure - it may be improved.

					Jaroslav

> 
> 	Arnd
> 
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: tiwai@suse.com
> Cc: lgirdwood@gmail.com
> Cc: broonie@kernel.org
> Cc: o-takashi@sakamocchi.jp
> Cc: y2038@lists.linaro.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Baolin Wang <baolin.wang@linaro.org>
> 
> Arnd Bergmann (2):
>   ALSA: replace timespec types in uapi headers
>   ALSA: Deprecate CLOCK_REALTIME timestamps
> 
> Baolin Wang (2):
>   ALSA: Replace timespec with timespec64
>   ALSA: Avoid using timespec for struct snd_ctl_elem_value
> 
>  include/sound/asound.h            |  8 +++++
>  include/sound/pcm.h               | 22 +++++++-----
>  include/sound/timer.h             |  4 +--
>  include/uapi/sound/asound.h       | 53 +++++++++++++++++++++--------
>  sound/core/Kconfig                | 11 ++++++
>  sound/core/compat.h               | 11 ++++++
>  sound/core/pcm.c                  |  3 ++
>  sound/core/pcm_compat.c           | 70 ++++++++++++++++++++++-----------------
>  sound/core/pcm_lib.c              | 36 ++++++++++++--------
>  sound/core/pcm_native.c           | 25 ++++++++++----
>  sound/core/rawmidi_compat.c       | 12 +++----
>  sound/core/timer.c                | 28 ++++++++--------
>  sound/core/timer_compat.c         |  4 ++-
>  sound/pci/hda/hda_controller.c    | 14 +++++---
>  sound/soc/intel/skylake/skl-pcm.c |  4 +--
>  15 files changed, 203 insertions(+), 102 deletions(-)
>  create mode 100644 sound/core/compat.h
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

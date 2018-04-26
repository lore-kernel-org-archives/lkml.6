Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756590AbeDZOcE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:32:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46793 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756262AbeDZOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:32:02 -0400
X-Google-Smtp-Source: AB8JxZopCd7K+TLJKQnWA8F9HFfyHq6bxQmt1i128gxii1pQ1KXJC3BEx53J3LLvOU8bSwdaAgVxiglHcY+zY5Sp2Zs=
MIME-Version: 1.0
In-Reply-To: <6aa760e5-390a-b7ba-62f1-dc01308031fa@perex.cz>
References: <20180426124422.2921744-1-arnd@arndb.de> <6aa760e5-390a-b7ba-62f1-dc01308031fa@perex.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 16:32:01 +0200
X-Google-Sender-Auth: hXjvxt_oZfJtvTpGkoRxvURoclo
Message-ID: <CAK8P3a3hugjuOvHCKY-8Ny02Ww8RJAeCxUc4hG8SPJBxqPG0Tw@mail.gmail.com>
Subject: Re: [PATCH 0/4] ALSA: Fix year 2038 issue for sound subsystem, alternative
To: Jaroslav Kysela <perex@perex.cz>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, Baolin Wang <baolin.wang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 3:30 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> Dne 26.4.2018 v 14:44 Arnd Bergmann napsal(a):
>> I've tried the suggestion from Jaroslaw, doing a minimal change to the
>> UAPI headers to keep the existing binary interface. As he predicted,
>> this is a much simpler set of kernel changes, but we will pay for that
>> with added complexity in alsa-lib.
>>
>> The first two patches in this series are taken from Baolin's patch
>> set, with a small bugfix folded in to avoid a compile-time regression.
>>
>> The other two patches are to redefine the UAPI and to deprecate
>> the support for CLOCK_REALTIME time stamps, which we can no longer
>> allow with user space that we expect to survive beyond 2038.
>>
>> Overall, I'd still be happier with Baolin's approach since it allows
>> us to keep compatiblity with CLOCK_REALTIME users and requires
>> fewer changes in user space, but this would work as well.
>
> Hi Arnd,
>
>   Thanks for your work. I proposed a bit different implementation. Example:
>
> struct snd_example {
>   struct snd_native_timespec tstamp;
>   ....
>   u64 tstamp_sec64; /* use the reserved[] array for this */
> };
>
>   So tstamp contains the current 32-bit tv_sec/tv_nsec and the full
> 64-bit value is in tstamp_sec64. In this way, we can transfer any type
> of the timespec64 values and it's backward compatible to retain the
> binary compatibility. The protocol versions should be increased to let
> the userspace know about the new 64-bit fields.

Right, I went in a slightly different way since the intention was to keep
the interface simple. I think we can either force the use of monotonic
times or extend it to 64-bit CLOCK_REALTIME stamps, but the
monotonic stamps seem much better for multiple reasons (i.e. skipping)
if you want to avoid introducing new ioctls.

The added complexity of having two timestamps in a single structure
means we don't end up with much simpler code that what Baolin
proposed, which mostly just moves the existing compat_ioctl()
to the native 32-bit handler but not add anything new that requires
library changes.

His tread patch and my mmap patch both do add some complexity
but then we also need some of that with your suggestions for
tread.

>   The timer read protocol must be updated, because the stream will
> change, so I am fine to add new ioctl (like originally proposed).

With forced monotonic times, we can skip that update and keep
using the existing stream format.

>   The alsa-lib defines timespec only if posix defines are not set so
> glibc's time.h does not define the timespec structure - it may be improved.

Yes, we definitely need to improve that, since any application that
relies on the timespec definition to come from alsa would otherwise
get a structure with a 64-bit tv_sec but incorrect padding on tv_nsec
(no padding on i386, padding on the wrong side for big-endian
architectures).

One way out would be to define snd_timestamp_t and
snd_htimestamp_t in terms of snd_monotonic_timestamp
from the kernel header and let it still have the traditional layout
even for applications built with 64-bit time_t.

The downside is again that applications may break when they
cast between snd_htimestamp_t and timespec pointers.

         Arnd

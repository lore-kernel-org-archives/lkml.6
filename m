Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934657AbeDXNhe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:37:34 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41462 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934178AbeDXNha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:37:30 -0400
X-Google-Smtp-Source: AB8JxZpBIsglH46MUR6gsjNdn1yTrm/MwCHwUvSPFbjCokm+3Yb/MwwPHYRxRmMg5omdohTXNIIkJfuyIHnKqswgnYw=
MIME-Version: 1.0
In-Reply-To: <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
References: <cover.1524570852.git.baolin.wang@linaro.org> <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Apr 2018 15:37:28 +0200
X-Google-Sender-Auth: fPBAGge0nKgKHjIA3BMvRaiMi_0
Message-ID: <CAK8P3a0SKAAJMUDOJBjHKCnvprqOTjTnX9Ju3W_q1avzdU7EnA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Fix year 2038 issue for sound subsystem
To: Jaroslav Kysela <perex@perex.cz>
Cc: Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.com>,
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

On Tue, Apr 24, 2018 at 3:29 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> Dne 24.4.2018 v 14:06 Baolin Wang napsal(a):
>> Since many structures will use timespec type variables to record time stamp
>> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
>> tries to introduce new structures removing timespec type to compatible native
>> mode and compat mode.
>>
>> Moreover this patchset also converts the internal structrures to use timespec64
>> type and related APIs.
>
> Thanks for your patchset. A few comments:
>
> It might be more nice to reuse the existing structures and put
> timespec64 to the reserved field and duplicate information (with the
> 32-bit wrapping for the old fields). It means that we do not need new
> ioctls and old libraries will be fine.

The current approach is intended to make any user space work
without source-level changes, i.e. you can still build an old alsa-lib
package against a new glibc as long as you have the latest kernel
headers (which the glibc requires for using 64-bit time_t).

If we try to extend the structures in a different way, that requires
user space changes, and existing source code would silently
break on a future glibc.
IMHO changing the source-level interface should only be done
as a last resort for y2038.

Note that most of the work is not required to keep working beyond
2038, but actually is required just to keep working with an
updated glibc that redefines time_t to 64 bit. The audio timestamps
should be in CLOCK_MONOTONIC for new user space anyway,
and that doesn't overflow a 32-bit type.

> It may make sense to define private snd_timespec32 and snd_timespec64
> with s32/s64 types instead separate sec/usec fields.

Right, I have some ideas there as well as I saw one remaining issue
in my patch for the status mmap: when building a program with
64-bit time_t, we still see a copy of the old structure but with an\
impossible layout.

       ARnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753710AbeDYL03 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:26:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35507 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeDYL0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:26:24 -0400
X-Google-Smtp-Source: AIpwx4/o5EeO0y6D9FMSwmhYoq0VTng+MvzCSj7g5S5qFYqV0m6ayvOdVmsKA0rozmk4xQ1oaVT0pi10xogqXO9ZPoM=
MIME-Version: 1.0
In-Reply-To: <1b6a0710-7bc1-08d1-49a5-f1bed7bf3f84@perex.cz>
References: <cover.1524570852.git.baolin.wang@linaro.org> <66b26dc6-9139-80cc-0b49-28ff68169b5c@perex.cz>
 <CAK8P3a0SKAAJMUDOJBjHKCnvprqOTjTnX9Ju3W_q1avzdU7EnA@mail.gmail.com> <1b6a0710-7bc1-08d1-49a5-f1bed7bf3f84@perex.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Apr 2018 13:26:23 +0200
X-Google-Sender-Auth: fOeoMpYbYwVzJD94oxiVf-WV5IM
Message-ID: <CAK8P3a1P8+DDmqSZquFVUn7C7F7+8M=Xft+wbY_H7a6ptfXJeA@mail.gmail.com>
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

On Wed, Apr 25, 2018 at 9:23 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> Dne 24.4.2018 v 15:37 Arnd Bergmann napsal(a):
>> On Tue, Apr 24, 2018 at 3:29 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>> Dne 24.4.2018 v 14:06 Baolin Wang napsal(a):
>>>> Since many structures will use timespec type variables to record time stamp
>>>> in uapi/asound.h, which are not year 2038 safe on 32bit system. This patchset
>>>> tries to introduce new structures removing timespec type to compatible native
>>>> mode and compat mode.
>>>>
>>>> Moreover this patchset also converts the internal structrures to use timespec64
>>>> type and related APIs.
>>>
>>> Thanks for your patchset. A few comments:
>>>
>>> It might be more nice to reuse the existing structures and put
>>> timespec64 to the reserved field and duplicate information (with the
>>> 32-bit wrapping for the old fields). It means that we do not need new
>>> ioctls and old libraries will be fine.
>>
>> The current approach is intended to make any user space work
>> without source-level changes, i.e. you can still build an old alsa-lib
>> package against a new glibc as long as you have the latest kernel
>> headers (which the glibc requires for using 64-bit time_t).
>>
>> If we try to extend the structures in a different way, that requires
>> user space changes, and existing source code would silently
>> break on a future glibc.
>> IMHO changing the source-level interface should only be done
>> as a last resort for y2038.
>
> We have almost everything hidden in the alsa-lib code for the
> applications and there is the protocol versioning, so we can detect the
> changes easily and handle the new fields in the library.

I think we are both misunderstanding each other here, let's try
to work out what changes are required in alsa-lib. The idea of
Baolin's patches that you can simply rebuild alsa-lib (or any other
library using the alsa kernel interface, if any exist) against a new
C library and still have working audio.

Unfortunately I had not looked at the alsa-lib source code before,
so I missed the fact that it uses its own copy of the kernel headers,
and that it also defines an incompatible 'timespec' structure itself,
so it seems it's not as easy.

The earlier patches that Baolin posted last November tried to
work with unmodified kernel headers, which would have avoided
breaking alsa-lib, but after discussing with Takashi, Baolin simplified
them to remove the special cases for i386 structure alignment,
and I added back the support for mmap(), which did not work
in the original series, and is impossible without updating at least
the header file.

> As you noted,
> the current code will be fine until 2038 even with my proposed change
> (which is more easy to be implemented in the kernel - less bloat) and
> there are 20 years to update alsa-lib remaining for the 32-bit systems.

I did not claim that it works fine -- in fact the current state is
completely broken once you upgrade your glibc. What I meant is that
there is no *overflow* of time_t as long as user space enforces the
use of monotonic timestamps.

>From what I can tell, we have to fix these areas:

1. The kernel-internal interfaces in ALSA should be changed to avoid
     using 'struct timespec' and use something else (nanoseconds,
     ktime_t, timespec64, ...) so we can completely remove timespec
     from the kernel for everything other than compatibility with old
     user space.
2. alsa-lib must be changed to no longer define a 'struct timespec'
    that is incompatible with the C library, to avoid silently breaking
    ABIs between structures used inside alsa-lib and those in
    code using alsa-lib with a 64-bit time_t.
3. We must create a change to either alsa-lib (and every other
    implementation) or the kernel (including the uapi header) to
    avoid breaking SNDRV_TIMER_IOCTL_TREAD, which
    currently expects a 'timespec' to be read from a file descriptor
4. on 32-bit x86 and powerpc, we need to do something about
    about the mmap() for status and control structures to
    avoid breaking. My current patch implements a new binary
    layout to avoid most problems, including the issue of compat
    mode that never worked.
5. For all other ioctls we have the choice between fixing the
    kernel to provide an interface that is compatible with
    a future glibc, or to change the uapi header to move away
    from timespec to a structure with a different name but
    same binary layout and have alsa-lib convert between the
    two. I still see Baolin's series as preferred because it matches
    what we do for all other subsytems, implementing the
    native ioctls using the 64-bit version of timespec that
    match what the both kernel and future glibc use, and only
    providing the 32-bit interfaces for compatibility with existing
    binaries.
6. For completeness, it might be helpful to have alsa-lib
    use symbol versioning for each exported API so a
    single alsa-lib binary can work with both 32-bit time_t
    and 64-bit time_t using applications. Without this, everything
    will still keep working as long as you rebuild the entire
    distro with 64-bit time_t at once, but it won't allow a gradual
    migration of applications.

> Only the binary compatibility for the older binaries should be taken
> into account.
>
> Also, you expect that tv_nsec will be changed to the 's64' type. Do you
> have that confirmed from the glibc developers? From the current
> specification, the tv_nsec type is 'long'. It may cause some binary
> compatibility issues, too.

This is a complex sub-topic. Yes, we've had long discussions with the
glibc developers about it. glibc (and any other C99 compliant C
library) will use 'long' for tv_nsec, but they also have to use padding
after (or before, depending on endianess) tv_nsec to ensure that
the binary layout of timespec matches what we use in a 64-bit kernel.

For timestamps sent from the kernel to user space, we must initialize
the upper 32 bits of tv_nsec even on 32-bit kernels to avoid leaking
kernel stack data in the padding bits, so all interfaces are defined
in terms of __s64/__s64 rather than __s64/long timespec structures,
while both the kernel and user space use __s64/long internally.

       Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeCZSpM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 14:45:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39736 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCZSpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 14:45:11 -0400
X-Google-Smtp-Source: AIpwx4/c9hawQmn5c7LIOAMff5/pMgdPLje6QLYkZcu69WqYhA50JKePQA+Ulgy3DU3Agp/GQaR87oyBapKznFqOrRY=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1XWK2AOBWmnc6LUZrvXqDWLK3uaw5eHgchwBmb9hMzoQ@mail.gmail.com>
References: <201803210054.aktDFRUf%fengguang.wu@intel.com> <CABeXuvqQfCYmz+md1tfEC3kiYWctSz7kBSjEu6+n1oOCAGGJzg@mail.gmail.com>
 <CAK8P3a37SqjhPPbOkhXBuaHhakS3T8tvejB9aA+ZO2m8ZRMsLg@mail.gmail.com>
 <CABeXuvqm2XHKKffHdo1CMUzQhCWkRzz9=+xbk_VXN9-t9i4duQ@mail.gmail.com> <CAK8P3a1XWK2AOBWmnc6LUZrvXqDWLK3uaw5eHgchwBmb9hMzoQ@mail.gmail.com>
From: Deepa Dinamani <deepa.kernel@gmail.com>
Date: Mon, 26 Mar 2018 11:45:10 -0700
Message-ID: <CABeXuvqZYf88tHW0to1Vbcu3X5qwoZnzDvcjfFn6KWdt5NHXZQ@mail.gmail.com>
Subject: Re: [linux-next:master 7357/9340] drivers/s390/char/fs3270.c:337:10:
 error: implicit declaration of function 'compat_ptr'; did you mean 'complete'?
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild test robot <fengguang.wu@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, kbuild-all@01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought of doing something like this earlier.
I think there is an easier fix by moving the defines in linux/compat.h
under CONFIG_32BIT_TIME.
Let me try to get that working also for comparison.
I will post it here.

Thanks,
Deepa


On Mon, Mar 26, 2018 at 8:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Mar 22, 2018 at 9:03 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> On Wed, Mar 21, 2018 at 12:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, Mar 21, 2018 at 2:37 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>>> This does not have the recent s390 patch I sent out to be applied on linux-next.
>>>> This is not yet in linux-next.
>>>>
>>>> ------
>>>>
>>>> s390: Use asm/compat.h instead of linux/compat.h
>>>>
>>>> Include asm/compat.h directly for uses of compat_ptr.
>>>> This includes the compat defines when CONFIG_COMPAT is
>>>> not on.
>>>>
>>>> Also make compat data structure definitions conditional on
>>>> CONFIG_COMPAT, to remove circular include dependencies in
>>>> elf.h
>>>>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: linux-s390@vger.kernel.org
>>>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>>>
>>> I have an increasingly bad feeling about this workaround, I think we need
>>> to try harder to make linux/compat.h contain whatever is expected and
>>> provide everything that asm/compat.h does.
>>
>> This is my plan, But, I was planning to get rid of this by posting
>> individual patches to specific architectures after this series was
>> merged to keep this series less complicated.
>> Problem comes from including compat code even when CONFIG_COMPAT is not on.
>>
>>> Generally it is expected that including linux/foo.h is a strict superset of
>>> asm/foo.h, and you should use the former in device drivers.
>>
>> Right. I was also hesitant about this change. But, in this particular
>> case, these are only s390 drivers that are not built on any other
>> architectures.
>> So I thought this should be okay. Also, I plan to clean this up in the
>> architecture specific patches.
>>
>> If you still prefer fixing these now rather than later, then I can
>> give it another try and post an update.
>
> I've applied a different fix for now, see below.
>
> I'll give it some more testing, but this solves both the arm64 and s390
> issues I saw earlier, and lets us always include linux/compat.h instead
> of having to include asm/compat.h.
>
> Let me know if you see a problem with that one.
>
>        Arnd
>
> commit d1a353a4a8cce86c7651a8011cc860a921b850bc
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Mon Mar 26 16:59:15 2018 +0200
>
>     compat: add an asm-generic/compat.h file
>
>     We have a couple of files that try to include asm/compat.h on
>     architectures where this is available. Those should generally use the
>     higher-level linux/compat.h file, but that in turn fails to include
>     asm/compat.h when CONFIG_COMPAT is disabled, unless we can provide
>     that header on all architectures.
>
>     This adds the asm/compat.h for all remaining architectures to
>     simplify the dependencies.
>
>     Architectures that are getting removed in linux-4.17 are not changed
>     here, to avoid needless conflicts with the removal patches. Those
>     architectures are broken by this patch, but we have already shown
>     that they have no users.
>
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
> index 9b68790013e2..0580cb8c84b2 100644
> --- a/arch/alpha/include/asm/Kbuild
> +++ b/arch/alpha/include/asm/Kbuild
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>
> +generic-y += compat.h
>  generic-y += exec.h
>  generic-y += export.h
>  generic-y += fb.h
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
> index 4bd5d4369e05..d51bc22e8795 100644
> --- a/arch/arc/include/asm/Kbuild
> +++ b/arch/arc/include/asm/Kbuild
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  generic-y += bugs.h
> +generic-y += compat.h
>  generic-y += device.h
>  generic-y += div64.h
>  generic-y += emergency-restart.h
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 873e3c189279..1d66db9c9db5 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -1,3 +1,4 @@
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += early_ioremap.h
>  generic-y += emergency-restart.h
> diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
> index fd4c840de837..24037486317c 100644
> --- a/arch/c6x/include/asm/Kbuild
> +++ b/arch/c6x/include/asm/Kbuild
> @@ -1,6 +1,7 @@
>  generic-y += atomic.h
>  generic-y += barrier.h
>  generic-y += bugs.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += device.h
>  generic-y += div64.h
> diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
> index 14bac06b7116..a5d0b2991f47 100644
> --- a/arch/h8300/include/asm/Kbuild
> +++ b/arch/h8300/include/asm/Kbuild
> @@ -3,6 +3,7 @@ generic-y += barrier.h
>  generic-y += bugs.h
>  generic-y += cacheflush.h
>  generic-y += checksum.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += delay.h
>  generic-y += device.h
> diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
> index e9743f689fb8..dd2fd9c0d292 100644
> --- a/arch/hexagon/include/asm/Kbuild
> +++ b/arch/hexagon/include/asm/Kbuild
> @@ -2,6 +2,7 @@
>  generic-y += barrier.h
>  generic-y += bug.h
>  generic-y += bugs.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += device.h
>  generic-y += div64.h
> diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
> index 6dd867873364..557bbc8ba9f5 100644
> --- a/arch/ia64/include/asm/Kbuild
> +++ b/arch/ia64/include/asm/Kbuild
> @@ -1,3 +1,4 @@
> +generic-y += compat.h
>  generic-y += exec.h
>  generic-y += irq_work.h
>  generic-y += mcs_spinlock.h
> diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
> index 88a9d27df1ac..4d8d68c4e3dd 100644
> --- a/arch/m68k/include/asm/Kbuild
> +++ b/arch/m68k/include/asm/Kbuild
> @@ -1,4 +1,5 @@
>  generic-y += barrier.h
> +generic-y += compat.h
>  generic-y += device.h
>  generic-y += emergency-restart.h
>  generic-y += exec.h
> diff --git a/arch/microblaze/include/asm/Kbuild
> b/arch/microblaze/include/asm/Kbuild
> index 3c80a5a308ed..fe6a6c6e5003 100644
> --- a/arch/microblaze/include/asm/Kbuild
> +++ b/arch/microblaze/include/asm/Kbuild
> @@ -2,6 +2,7 @@ generic-y += barrier.h
>  generic-y += bitops.h
>  generic-y += bug.h
>  generic-y += bugs.h
> +generic-y += compat.h
>  generic-y += device.h
>  generic-y += div64.h
>  generic-y += emergency-restart.h
> diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
> index d232da2cbb38..64ed3d656956 100644
> --- a/arch/nios2/include/asm/Kbuild
> +++ b/arch/nios2/include/asm/Kbuild
> @@ -4,6 +4,7 @@ generic-y += bitops.h
>  generic-y += bug.h
>  generic-y += bugs.h
>  generic-y += cmpxchg.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += device.h
>  generic-y += div64.h
> diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
> index f05c722a21f8..65964d390b10 100644
> --- a/arch/openrisc/include/asm/Kbuild
> +++ b/arch/openrisc/include/asm/Kbuild
> @@ -2,6 +2,7 @@ generic-y += barrier.h
>  generic-y += bug.h
>  generic-y += bugs.h
>  generic-y += checksum.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += device.h
>  generic-y += div64.h
> diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
> index 1efcce74997b..46dd82ab2c29 100644
> --- a/arch/sh/include/asm/Kbuild
> +++ b/arch/sh/include/asm/Kbuild
> @@ -1,3 +1,4 @@
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += delay.h
>  generic-y += div64.h
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index bb5a196c3061..b10dde6cb793 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -1,6 +1,7 @@
>  generic-y += barrier.h
>  generic-y += bpf_perf_event.h
>  generic-y += bug.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += delay.h
>  generic-y += device.h
> diff --git a/arch/unicore32/include/asm/Kbuild
> b/arch/unicore32/include/asm/Kbuild
> index 6f70c76c81fc..bfc7abe77905 100644
> --- a/arch/unicore32/include/asm/Kbuild
> +++ b/arch/unicore32/include/asm/Kbuild
> @@ -1,5 +1,6 @@
>  generic-y += atomic.h
>  generic-y += bugs.h
> +generic-y += compat.h
>  generic-y += current.h
>  generic-y += device.h
>  generic-y += div64.h
> diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> index 436b20337168..e5e1e61c538c 100644
> --- a/arch/xtensa/include/asm/Kbuild
> +++ b/arch/xtensa/include/asm/Kbuild
> @@ -1,4 +1,5 @@
>  generic-y += bug.h
> +generic-y += compat.h
>  generic-y += device.h
>  generic-y += div64.h
>  generic-y += dma-contiguous.h
> diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
> new file mode 100644
> index 000000000000..28819451b6d1
> --- /dev/null
> +++ b/include/asm-generic/compat.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/* This is an empty stub for 32-bit-only architectures */
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index e291096dc937..94291c3e67dc 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -17,8 +17,9 @@
>  #include <linux/aio_abi.h> /* for aio_context_t */
>  #include <linux/unistd.h>
>
> -#ifdef CONFIG_COMPAT
>  #include <asm/compat.h>
> +
> +#ifdef CONFIG_COMPAT
>  #include <asm/siginfo.h>
>  #include <asm/signal.h>
>  #endif

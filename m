Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeFEPTJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:19:09 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:39187 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeFEPTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:19:08 -0400
X-Google-Smtp-Source: ADUXVKLRbOA9ph1yg0kOdWkY0qWOIHf+vs9GRh4j+DPzqo9LOdC1vErb+7LDQydjxJyax6yMDZS/NMO56XBqJzPlVqA=
MIME-Version: 1.0
In-Reply-To: <201805290939.AjijeyJf%fengguang.wu@intel.com>
References: <201805290939.AjijeyJf%fengguang.wu@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 18:19:07 +0300
Message-ID: <CAHp75Ve-OjbeVjWUGkXbyh-PXn8L12Sb56EBq-n5z5sicUh7Sg@mail.gmail.com>
Subject: Re: include/linux/string.h:246:9: warning: '__builtin_strncpy' output
 truncated before terminating nul copying 4 bytes from a string of the same length
To: kbuild test robot <lkp@intel.com>,
        Michal Januszewski <spock@gentoo.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:35 AM, kbuild test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   786b71f5b754273ccef6d9462e52062b3e1f9877
> commit: 854e55ad289ef8888e7991f0ada85d5846f5afb9 objtool, perf: Fix GCC 8 -Wrestrict error
> date:   2 months ago
> config: x86_64-randconfig-s4-05290856 (attached as .config)
> compiler: gcc-8 (Debian 8.1.0-3) 8.1.0
> reproduce:
>         git checkout 854e55ad289ef8888e7991f0ada85d5846f5afb9
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>

I guess it's easy to fix by

--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -422,7 +422,7 @@ static int uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
       task->t.flags = TF_VBEIB;
       task->t.buf_len = sizeof(struct vbe_ib);
       task->buf = &par->vbe_ib;
-       strncpy(par->vbe_ib.vbe_signature, "VBE2", 4);
+       snprintf(par->vbe_ib.vbe_signature,
sizeof(par->vbe_ib.vbe_signature), "VBE2");

The question is do we want this to just shut up a compiler? It's
obviously false positive.

> All warnings (new ones prefixed by >>):
>
>    In file included from include/linux/bitmap.h:9,
>                     from include/linux/cpumask.h:12,
>                     from arch/x86/include/asm/cpumask.h:5,
>                     from arch/x86/include/asm/msr.h:11,
>                     from arch/x86/include/asm/processor.h:21,
>                     from arch/x86/include/asm/cpufeature.h:5,
>                     from arch/x86/include/asm/thread_info.h:53,
>                     from include/linux/thread_info.h:38,
>                     from arch/x86/include/asm/preempt.h:7,
>                     from include/linux/preempt.h:81,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/seqlock.h:36,
>                     from include/linux/time.h:6,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:10,
>                     from drivers/video/fbdev/uvesafb.c:12:
>    In function 'strncpy',
>        inlined from 'uvesafb_vbe_getinfo' at drivers/video/fbdev/uvesafb.c:425:2:
>>> include/linux/string.h:246:9: warning: '__builtin_strncpy' output truncated before terminating nul copying 4 bytes from a string of the same length [-Wstringop-truncation]
>      return __builtin_strncpy(p, q, size);
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +/__builtin_strncpy +246 include/linux/string.h
>
> 6974f0c4 Daniel Micay 2017-07-12  237
> 6974f0c4 Daniel Micay 2017-07-12  238  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> 6974f0c4 Daniel Micay 2017-07-12  239  __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
> 6974f0c4 Daniel Micay 2017-07-12  240  {
> 6974f0c4 Daniel Micay 2017-07-12  241   size_t p_size = __builtin_object_size(p, 0);
> 6974f0c4 Daniel Micay 2017-07-12  242   if (__builtin_constant_p(size) && p_size < size)
> 6974f0c4 Daniel Micay 2017-07-12  243           __write_overflow();
> 6974f0c4 Daniel Micay 2017-07-12  244   if (p_size < size)
> 6974f0c4 Daniel Micay 2017-07-12  245           fortify_panic(__func__);
> 6974f0c4 Daniel Micay 2017-07-12 @246   return __builtin_strncpy(p, q, size);
> 6974f0c4 Daniel Micay 2017-07-12  247  }
> 6974f0c4 Daniel Micay 2017-07-12  248
>
> :::::: The code at line 246 was first introduced by commit
> :::::: 6974f0c4555e285ab217cee58b6e874f776ff409 include/linux/string.h: add the option of fortified string.h functions
>
> :::::: TO: Daniel Micay <danielmicay@gmail.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
With Best Regards,
Andy Shevchenko

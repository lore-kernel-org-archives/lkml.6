Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeFEPbo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:31:44 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45096 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeFEPbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:31:43 -0400
X-Google-Smtp-Source: ADUXVKJkpiKLFCYsHJUssMEJ4VTfVBqUkgdDWOP/nFu0jCYFJYFiEd/GgK2U2QGxa9tMHSrG36YDFEfnyhYUQFOZtFc=
MIME-Version: 1.0
In-Reply-To: <20180605153003.epf37ivdbewv256i@treble>
References: <201805290939.AjijeyJf%fengguang.wu@intel.com> <CAHp75Ve-OjbeVjWUGkXbyh-PXn8L12Sb56EBq-n5z5sicUh7Sg@mail.gmail.com>
 <20180605153003.epf37ivdbewv256i@treble>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 18:31:42 +0300
Message-ID: <CAHp75VcMbgaCNFbisKhupV4z3U5hse7SGB1+UZkmMt4XJkj06w@mail.gmail.com>
Subject: Re: include/linux/string.h:246:9: warning: '__builtin_strncpy' output
 truncated before terminating nul copying 4 bytes from a string of the same length
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: kbuild test robot <lkp@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        kbuild-all@01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 6:30 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Tue, Jun 05, 2018 at 06:19:07PM +0300, Andy Shevchenko wrote:
>> On Tue, May 29, 2018 at 4:35 AM, kbuild test robot <lkp@intel.com> wrote:
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > head:   786b71f5b754273ccef6d9462e52062b3e1f9877
>> > commit: 854e55ad289ef8888e7991f0ada85d5846f5afb9 objtool, perf: Fix GCC 8 -Wrestrict error
>> > date:   2 months ago
>> > config: x86_64-randconfig-s4-05290856 (attached as .config)
>> > compiler: gcc-8 (Debian 8.1.0-3) 8.1.0
>> > reproduce:
>> >         git checkout 854e55ad289ef8888e7991f0ada85d5846f5afb9
>> >         # save the attached .config to linux build tree
>> >         make ARCH=x86_64
>> >
>>
>> I guess it's easy to fix by
>>
>> --- a/drivers/video/fbdev/uvesafb.c
>> +++ b/drivers/video/fbdev/uvesafb.c
>> @@ -422,7 +422,7 @@ static int uvesafb_vbe_getinfo(struct uvesafb_ktask *task,
>>        task->t.flags = TF_VBEIB;
>>        task->t.buf_len = sizeof(struct vbe_ib);
>>        task->buf = &par->vbe_ib;
>> -       strncpy(par->vbe_ib.vbe_signature, "VBE2", 4);
>> +       snprintf(par->vbe_ib.vbe_signature,
>> sizeof(par->vbe_ib.vbe_signature), "VBE2");
>>
>> The question is do we want this to just shut up a compiler? It's
>> obviously false positive.
>
> What about just changing it to a memcpy?  Seems like that would be
> cleaner anyway, since the whole point of strncpy is to add the
> terminating NULL, which isn't need here.

Agree.

Btw, Bartlomiej, it seems driver maintainer's address is bouncing.

-- 
With Best Regards,
Andy Shevchenko

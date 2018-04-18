Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbeDRBxS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 21:53:18 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28220 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeDRBxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 21:53:16 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w3I1r4ew019073
X-Nifty-SrcIP: [209.85.213.49]
X-Google-Smtp-Source: AIpwx4+24HNJTj44l56THcJNiymJ4YkVkLjkxX6dAQ8eZoK/Z1kmEJweJqS6JRVqp7DgERFd0GduMYrRF1EHxgnD4zM=
MIME-Version: 1.0
In-Reply-To: <20180417230921.GA29046@saruman>
References: <1523433019-17419-1-git-send-email-matt.redfearn@mips.com>
 <1523433019-17419-3-git-send-email-matt.redfearn@mips.com> <20180417230921.GA29046@saruman>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 18 Apr 2018 10:52:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASLPT4jiPiNJ5aDXg-kR70jN1zZbbLQqyO53DtsEgYVAw@mail.gmail.com>
Message-ID: <CAK7LNASLPT4jiPiNJ5aDXg-kR70jN1zZbbLQqyO53DtsEgYVAw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] MIPS: vmlinuz: Use generic ashldi3
To: James Hogan <jhogan@kernel.org>
Cc: Matt Redfearn <matt.redfearn@mips.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-18 8:09 GMT+09:00 James Hogan <jhogan@kernel.org>:
> On Wed, Apr 11, 2018 at 08:50:18AM +0100, Matt Redfearn wrote:
>> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
>> index adce180f3ee4..e03f522c33ac 100644
>> --- a/arch/mips/boot/compressed/Makefile
>> +++ b/arch/mips/boot/compressed/Makefile
>> @@ -46,9 +46,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>>
>>  vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>>
>> -extra-y += ashldi3.c bswapsi.c
>> -$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
>> -$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>> +extra-y += ashldi3.c
>> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
>> +     $(call cmd,shipped)
>> +
>> +extra-y += bswapsi.c
>> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
>>       $(call cmd,shipped)
>
> ci20_defconfig:
>
> arch/mips/boot/compressed/ashldi3.c:4:10: fatal error: libgcc.h: No such file or directory
>  #include "libgcc.h"
>            ^~~~~~~~~~
>
> It looks like it had already copied ashldi3.c from arch/mips/lib/ when
> building an older commit, and it hasn't been regenerated from lib/ since
> the Makefile changed, so its still using the old version.
>
> I think it should be using FORCE and if_changed like this:
>
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index e03f522c33ac..abe77add8789 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -47,12 +47,12 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>  vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>
>  extra-y += ashldi3.c
> -$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c
> -       $(call cmd,shipped)
> +$(obj)/ashldi3.c: $(obj)/%.c: $(srctree)/lib/%.c FORCE
> +       $(call if_changed,shipped)
>
>  extra-y += bswapsi.c
> -$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
> -       $(call cmd,shipped)
> +$(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c FORCE
> +       $(call if_changed,shipped)
>
>  targets := $(notdir $(vmlinuzobjs-y))
>
> That resolves the build failures when checking out old -> new without
> cleaning, since the .ashldi3.c.cmd is missing so it gets rebuilt.
>
> It should also resolve issues if the path it copies from is updated in
> future since the .ashldi3.c.cmd will get updated.
>
> If you checkout new -> old without cleaning, the now removed
> arch/mips/lib/ashldi3.c will get added which will trigger regeneration,
> so it won't error.
>
> However if you do new -> old -> new then the .ashldi3.cmd file isn't
> updated while at old, so you get the same error as above. I'm not sure
> there's much we can practically do about that, aside perhaps avoiding
> the issue in future by somehow auto-deleting stale .*.cmd files.
>
> Cc'ing kbuild folk in case they have any bright ideas.



I do not have any idea better than if_changed.




> At least the straightforward old->new upgrade will work with the above
> fixup though. If you're okay with it I'm happy to apply as a fixup.
>






-- 
Best Regards
Masahiro Yamada

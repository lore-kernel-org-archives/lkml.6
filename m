Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031921AbeCAPXk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:23:40 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42741 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031893AbeCAPXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:23:35 -0500
X-Google-Smtp-Source: AG47ELvsz8fi5X22+5mq9d4/NVjSGevKXq4dh/No29GRnAs2XvBnbKYXZ0PnMQuJjgKVeM9qkgRww0cUu6xmF45ogRE=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATrMVvjurGBLvCHH_5Vio_Xm83h8yaiLQPU0VUUvQLCuQ@mail.gmail.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
 <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
 <20180228051525.a2vouqs6djnd2cnf@huvuddator> <CAK7LNATWRmYf7nfGcFiGe2DF2PSkE9mrS51GytzWEz5DYToN0w@mail.gmail.com>
 <20180301111801.gdhoam4kqrbqnasv@huvuddator> <CAK7LNATrMVvjurGBLvCHH_5Vio_Xm83h8yaiLQPU0VUUvQLCuQ@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 1 Mar 2018 16:23:33 +0100
Message-ID: <CAFkk2KS=Z2qHgh5X_W9uTPPG1qHop_m7ZoHYQy5Ss9PpBTJd6Q@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove redundant streamline_config.pl prerequisite
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 3:39 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-03-01 20:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> The local{yes,mod}config targets currently have streamline_config.pl as
>> a prerequisite. This is redundant, because streamline_config.pl is a
>> checked-in file with no prerequisites.
>>
>> Remove the prerequisite and reference streamline_config.pl directly in
>> the recipe of the rule instead.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  scripts/kconfig/Makefile | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>> index 1f74336d4e23..58be52cb464d 100644
>
>
> Thanks! Almost good.
>
> Just small nits.
>
>
>> --- a/scripts/kconfig/Makefile
>> +++ b/scripts/kconfig/Makefile
>> @@ -77,9 +77,9 @@ silentoldconfig: $(obj)/conf
>>             touch   include/generated/autoksyms.h
>>         $< $(silent) --$@ $(Kconfig)
>>
>> -localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf
>> +localyesconfig localmodconfig: $(obj)/conf
>>         $(Q)mkdir -p include/config include/generated
>> -       $(Q)perl $< --$@ $(srctree) $(Kconfig) > .tmp.config
>> +       $(Q)perl $(obj)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
>
>
>
> '$(src)/streamline_config.pl' is better than '$(obj)/streamline_config.pl'
> since it is a checked-in file.
>
> '$(src)' and '$(obj)' are always the same.
> (https://github.com/torvalds/linux/blob/master/scripts/Makefile.build#L6)
>
>
> So, there is no effective difference.
> It is just a coding convention to use $(obj)/ for generated files,
> and $(src)/ for source files.
>
> The original code already used $(obj)/, so this is not your fault
> but I want to fix it while we are here.
>
>
>
> One more nit.
>
> $(obj)/conf $(silent) --silentoldconfig $(Kconfig);
>
> can be
>
> $< $(silent) --silentoldconfig $(Kconfig);
>
>
> I guess you did not touch this line to avoid
> conflict with my patch.

Yep, plus I wanted to keep the patch focused.

>
>
>
> If you agree those two, shall I fix it up
> when I apply it?

That's fine by me. I'll assume less sanity from the existing code from
now on. :)

>
>
>
>
>
>>         $(Q)if [ -f .config ]; then                                     \
>>                         cmp -s .tmp.config .config ||                   \
>>                         (mv -f .config .config.old.1;                   \
>> --
>> 2.14.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Masahiro Yamada

Thanks,
Ulf

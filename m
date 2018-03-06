Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753402AbeCFJtL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:49:11 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:29854 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeCFJtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:49:09 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w269n5J9021712
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELtdXlB52roeab6jQ7lMSm1SAIdUEqQQOMo7qiA6gbT0pyMou8bGFiizO9LEQ34HnmyUX/ace0jI7Rh+XOjBj3U=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KS=Z2qHgh5X_W9uTPPG1qHop_m7ZoHYQy5Ss9PpBTJd6Q@mail.gmail.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
 <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
 <20180228051525.a2vouqs6djnd2cnf@huvuddator> <CAK7LNATWRmYf7nfGcFiGe2DF2PSkE9mrS51GytzWEz5DYToN0w@mail.gmail.com>
 <20180301111801.gdhoam4kqrbqnasv@huvuddator> <CAK7LNATrMVvjurGBLvCHH_5Vio_Xm83h8yaiLQPU0VUUvQLCuQ@mail.gmail.com>
 <CAFkk2KS=Z2qHgh5X_W9uTPPG1qHop_m7ZoHYQy5Ss9PpBTJd6Q@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 18:48:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCDtPJMcZ0uz4UR1kNaqVBfGSejDLXyBLP=30-SWAfwQ@mail.gmail.com>
Message-ID: <CAK7LNATCDtPJMcZ0uz4UR1kNaqVBfGSejDLXyBLP=30-SWAfwQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove redundant streamline_config.pl prerequisite
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 0:23 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Thu, Mar 1, 2018 at 3:39 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-03-01 20:18 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>> The local{yes,mod}config targets currently have streamline_config.pl as
>>> a prerequisite. This is redundant, because streamline_config.pl is a
>>> checked-in file with no prerequisites.
>>>
>>> Remove the prerequisite and reference streamline_config.pl directly in
>>> the recipe of the rule instead.
>>>
>>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>>> ---
>>>  scripts/kconfig/Makefile | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>>> index 1f74336d4e23..58be52cb464d 100644
>>
>>
>> Thanks! Almost good.
>>
>> Just small nits.
>>
>>
>>> --- a/scripts/kconfig/Makefile
>>> +++ b/scripts/kconfig/Makefile
>>> @@ -77,9 +77,9 @@ silentoldconfig: $(obj)/conf
>>>             touch   include/generated/autoksyms.h
>>>         $< $(silent) --$@ $(Kconfig)
>>>
>>> -localyesconfig localmodconfig: $(obj)/streamline_config.pl $(obj)/conf
>>> +localyesconfig localmodconfig: $(obj)/conf
>>>         $(Q)mkdir -p include/config include/generated
>>> -       $(Q)perl $< --$@ $(srctree) $(Kconfig) > .tmp.config
>>> +       $(Q)perl $(obj)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
>>
>>
>>
>> '$(src)/streamline_config.pl' is better than '$(obj)/streamline_config.pl'
>> since it is a checked-in file.
>>
>> '$(src)' and '$(obj)' are always the same.
>> (https://github.com/torvalds/linux/blob/master/scripts/Makefile.build#L6)
>>
>>
>> So, there is no effective difference.
>> It is just a coding convention to use $(obj)/ for generated files,
>> and $(src)/ for source files.
>>
>> The original code already used $(obj)/, so this is not your fault
>> but I want to fix it while we are here.
>>
>>
>>
>> One more nit.
>>
>> $(obj)/conf $(silent) --silentoldconfig $(Kconfig);
>>
>> can be
>>
>> $< $(silent) --silentoldconfig $(Kconfig);
>>
>>
>> I guess you did not touch this line to avoid
>> conflict with my patch.
>
> Yep, plus I wanted to keep the patch focused.




Applied to linux-kbuild/kconfig.  Thanks!


I changed

[1]  $(obj)/streamline_config.pl
    -> $(srctree)/$(src)/streamline_config.pl

    Mandatory change to avoid out-of-tree build error

[2]  $(obj)/conf   ->  $<

    Clean-up




-- 
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031656AbeCAOvg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:51:36 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:30692 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031642AbeCAOve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:51:34 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w21EpBne010651
X-Nifty-SrcIP: [209.85.213.47]
X-Google-Smtp-Source: AG47ELsQv1ZuP+3XjfRjlr6988tQuJu1ErxrRhhVDmbun8ZvwU1GZJiTMlySAG9on4fAS6rhvI51MP0WdMD2bAZGmNE=
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQRc_WCw1kSQs3YDjtX=eRKQXtkixifR3hdz1kz2Gt1+A@mail.gmail.com>
References: <1519776926-30459-1-git-send-email-yamada.masahiro@socionext.com>
 <1519776926-30459-6-git-send-email-yamada.masahiro@socionext.com>
 <20180228051525.a2vouqs6djnd2cnf@huvuddator> <CAK7LNATWRmYf7nfGcFiGe2DF2PSkE9mrS51GytzWEz5DYToN0w@mail.gmail.com>
 <20180301111801.gdhoam4kqrbqnasv@huvuddator> <CAK7LNATrMVvjurGBLvCHH_5Vio_Xm83h8yaiLQPU0VUUvQLCuQ@mail.gmail.com>
 <CAK7LNAQRc_WCw1kSQs3YDjtX=eRKQXtkixifR3hdz1kz2Gt1+A@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 1 Mar 2018 23:50:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATKrkkRCZofZi7cLyG2gjetsUsZ=Fh-CkJ2vT1LgNzjxQ@mail.gmail.com>
Message-ID: <CAK7LNATKrkkRCZofZi7cLyG2gjetsUsZ=Fh-CkJ2vT1LgNzjxQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: remove redundant streamline_config.pl prerequisite
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>, Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 23:44 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> 2018-03-01 23:39 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
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
>
>
> No.
>
> This is not a matter of taste,
> but a bug that must be fixed.
>
>
> This patch breaks out-of-tree build.
>
> If O=... is given, it is error.
>
>
> $ make O=foo  localyesconfig
> make[1]: Leaving directory '/home/masahiro/workspace/linux-yamada/foo'
> masahiro@grover:~/workspace/linux-yamada$ make O=foo  localyesconfig
> make[1]: Entering directory '/home/masahiro/workspace/linux-yamada/foo'
>   GEN     ./Makefile
> Can't open perl script "scripts/kconfig/streamline_config.pl": No such
> file or directory
> ../scripts/kconfig/Makefile:46: recipe for target 'localyesconfig' failed
> make[2]: *** [localyesconfig] Error 2
> /home/masahiro/workspace/linux-yamada/Makefile:521: recipe for target
> 'localyesconfig' failed
> make[1]: *** [localyesconfig] Error 2
> make[1]: Leaving directory '/home/masahiro/workspace/linux-yamada/foo'
> Makefile:146: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
>
>
>
> The right fix is $(srctree)/$(src)/streamline_config.pl
>
>




For somebody wondering why the current code works
for out-of-tree building.


Kbuild sets VPATH
(https://github.com/torvalds/linux/blob/master/Makefile#L208)


So, Make searches for pre-requisites in both objtree and srctree
when building out-of-tree.

VPATH does not work for recipe lines.
So, we need to specify the exact path to streamline_config.pl



-- 
Best Regards
Masahiro Yamada

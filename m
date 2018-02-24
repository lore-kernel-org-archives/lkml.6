Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeBXO5P (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 09:57:15 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55972 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeBXO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 09:57:13 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1OEv1Hu014596
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: AG47ELsxem9b8sLMKaIphnxzUro8BA12AG/DrAfRl3IhFvtn49eVYY5j/7H4AVerjON0L/t37Gx3PI1j0hvnNvailIM=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KTS4ZAXWdhnDTH+-VcPzUEin=6iZ=YVCm0Hbz1Lu5trNw@mail.gmail.com>
References: <20180213075821.24499-1-ulfalizer@gmail.com> <CAK7LNAT+FDWeg5MSjx0wNE6vpCN-ZZZ7fSA6L-hND2Jxgefn6g@mail.gmail.com>
 <CAFkk2KTS4ZAXWdhnDTH+-VcPzUEin=6iZ=YVCm0Hbz1Lu5trNw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 24 Feb 2018 23:56:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARAZdPEvd13KgYy8aPcrmPY+=yxOGo-34UQfwzYjLKh7Q@mail.gmail.com>
Message-ID: <CAK7LNARAZdPEvd13KgYy8aPcrmPY+=yxOGo-34UQfwzYjLKh7Q@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: Fix lying comment re. silentoldconfig
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-19 8:45 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Mon, Feb 19, 2018 at 12:37 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-13 16:58 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>>> The comment above the silentoldconfig invocation is outdated.
>>> 'make oldconfig' updates just .config and doesn't touch the
>>> include/config/ tree.
>>>
>>> This came up in https://lkml.org/lkml/2018/2/12/415.
>>>
>>> While fixing the comment, make it more informative by explaining the
>>> purpose of the unfortunately named silentoldconfig.
>>>
>>> I can't make sense of the comment re. auto.conf.cmd and a cleaned tree.
>>> include/config/auto.conf and include/config/auto.conf.cmd are both
>>> created simultaneously by silentoldconfig (in
>>> scripts/kconfig/confdata.c, by conf_write_autoconf()), and nothing seems
>>> to remove auto.conf.cmd that wouldn't remove auto.conf. Remove that part
>>> of the comment rather than blindly copying it. It might be a leftover
>>> from an older way of doing things.
>>>
>>> The include/config/auto.conf.cmd prerequisite might be there to ensure
>>> that silentoldconfig gets rerun if conf_write_autoconf() fails between
>>> writing out auto.conf.cmd and auto.conf (a comment in the function
>>> indicates that auto.conf is deliberately written out last to mark
>>> completion of the operation). It seems the Makefile dependency between
>>> include/config/auto.conf and .config would already take care of that
>>> though, since include/config/auto.conf would still be out of date re.
>>> .config if the operation fails.
>>>
>>> Cop out and leave the prerequisite in for now.
>>>
>>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>>> ---
>>> Changes in v2:
>>> include/config/auto.conf depends on .config, not the other way around, so swap
>>> them in some places in the commit message to make it less confusing.
>>>
>>>  Makefile | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 79ad2bfa24b6..61ed99ad4b1b 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -579,10 +579,13 @@ ifeq ($(KBUILD_EXTMOD),)
>>>  # To avoid any implicit rule to kick in, define an empty command
>>>  $(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
>>>
>>> -# If .config is newer than include/config/auto.conf, someone tinkered
>>> -# with it and forgot to run make oldconfig.
>>> -# if auto.conf.cmd is missing then we are probably in a cleaned tree so
>>> -# we execute the config step to be sure to catch updated Kconfig files
>>> +# The actual configuration files used during the build are stored in
>>> +# include/generated/ and include/config/. Update them if .config is newer than
>>> +# include/config/auto.conf (which mirrors .config).
>>
>>
>> Yes, the first paragraph perfectly explains the code.
>>
>>
>>> +# The include/config/ tree manages dependencies between source files and
>>> +# Kconfig symbols and lets us avoid doing a full rebuild whenever the
>>> +# configuration is changed. See scripts/basic/fixdep.c
>>
>> Do you insist on this paragraph?
>>
>> I know silentoldconfig touches include/config/* for extra cleverness,
>> but, to me, this looks unnecessary information to
>> understand the following code.
>>
>>>  include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
>>>         $(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
>>>  else
>
> I think it's information that many people digging into the Makefiles
> to figure out how the build works would find helpful, and my test is
> more "is it helpful?" than "does it minimally describe just this
> code?"
>
> I'm not hardcore about it though. Remove it if you think it's
> irrelevant or might become outdated. :)
>
> Cheers,
> Ulf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Applied to linux-kbuild.

I removed the second paragraph due to my preference of brief comments.
:)


-- 
Best Regards
Masahiro Yamada

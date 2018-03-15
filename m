Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbeCOIBX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 04:01:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:47367 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbeCOIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 04:01:21 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2F817h1000761
X-Nifty-SrcIP: [209.85.217.174]
X-Google-Smtp-Source: AG47ELsOiVbdxztpK1j7E0vaD9njYNTia8nDRuwOx3ec88o+F76Sc1tyjT3GNk5eMujhbKdVRRdNcFLEmadB/TS2hbA=
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1803141448330.28583@knanqh.ubzr>
References: <1521045861-22418-1-git-send-email-yamada.masahiro@socionext.com>
 <1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com> <nycvar.YSQ.7.76.1803141448330.28583@knanqh.ubzr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 15 Mar 2018 17:00:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATANL6Lfa6=05g9fCfj0ZLNHu_XnPEfurrOBQ8YXqUc4w@mail.gmail.com>
Message-ID: <CAK7LNATANL6Lfa6=05g9fCfj0ZLNHu_XnPEfurrOBQ8YXqUc4w@mail.gmail.com>
Subject: Re: [PATCH 7/7] kbuild: link vmlinux just once for CONFIG_TRIM_UNUSED_KSYMS
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jarod Wilson <jarod@redhat.com>, Prarit Bhargava <prarit@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-15 4:06 GMT+09:00 Nicolas Pitre <nicolas.pitre@linaro.org>:
> On Thu, 15 Mar 2018, Masahiro Yamada wrote:
>
>> If CONFIG_TRIM_UNUSED_KSYMS is enabled and the kernel is built from
>> a pristine state, the vmlinux is linked twice.
>>
>> [1] A user runs "make"
>>
>> [2] First build with empty autoksyms.h
>>
>> [3] adjust_autoksyms.sh updates autoksyms.h and recurses "make vmlinux"
>>
>>   --------(begin sub-make)--------
>>   [4] Second build with new autoksyms.h
>>
>>   [5] link-vmlinux.sh is invoked because "vmlinux" is missing
>>   ---------(end sub-make)---------
>>
>> [6] link-vmlinux.sh is invoked again despite "vmlinux" is up-to-date.
>>
>> The reason of [6] is probably because Make already decided to update
>> "vmlinux" at the time of [2] because "vmlinux" was missing when Make
>> generated the dependency list.
>
> But the dependency list for vmlinux contains FORCE so the target is
> always remade in (2) anyway. The decision to actually invoke
> link-vmlinux.sh comes from "if_changed". Why is $(call if_changed,...)
> in (6) not noticing that vmlinux is up to date?

if_changed (more specifically 'any-prereq')
is implemented based on '$?'.

So, this problem can be narrowed down to
how Make decides '$?'.


If you apply the first 6 patches, and put the following
debug code, you will see what has happened to $?


@@ -1024,6 +1026,7 @@ cmd_link-vmlinux =
                  \
        $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)

 vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
+       @echo newer deps: $?
        +$(call if_changed,link-vmlinux)

 # Build samples along the rest of the kernel



I am not familiar with Make internal, but
I can test it with simple code.


[Test Makefile]
A: B
        cp B A
        echo $?

B: C
        cp C B
        touch A

[Result]
$ rm -rf A B C
$ touch C
$ make
cp C B
touch A
cp B A
echo B
B


In the recipe of 'B', 'A' is touched,
so the dependency 'A: B' has already been met
before the recipe of 'A' is executed,
but Make does not notice that fact,
then tries to update 'A'.


The situation is the same.
vmlinux has been updated in the recursed sub-make,
but it is not noticed.




>>
>> link-vmlinus.sh is costly, so it is better to not run it when unneeded.
>> Split CONFIG_TRIM_UNUSED_KSYMS handling to a dedicated target.
>>
>> The reason of commit 2441e78b1919 ("krbuild: better abstract vmlinux
>> sequential prerequisites") was to cater to CONFIG_BUILD_DOCSRC, but
>> it was later removed by commit 184892925118 ("samples: move blackfin
>> gptimers-example from Documentation").
>>
>> I also changed adjust_autoksyms.sh to simply exit with 1 or 0 to make
>> it look straightforward.
>
> That is wrong. If the script fails for some reason (it runs with -e set)
> then this will trigger an endless recursive make instead of failing the
> build.

Sorry, I missed this case.  You are right.

I will restore the original code.



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BC7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F820834
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 07:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="B7nOAXl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81F820834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeGNHpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 03:45:23 -0400
Received: from services.gouders.net ([141.101.32.176]:45159 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeGNHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 03:45:22 -0400
Received: from localhost (ltea-047-067-156-155.pools.arcor-ip.net [47.67.156.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6E7C2LZ006162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jul 2018 09:12:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1531552324; bh=i3nO+odkBmz1EmKC5hLCvfHGhu8GbkM2/sKSbVMdMp8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=B7nOAXl7+DaLs1OYxP1FvN+uBZGqCxIEy6AINzxTGDd7KVdNwWxK3YoBVWK0XBYbU
         Jm96P9CfgCWS3XCZj1Zr8lxiwVCO4XjMM1rm6lIwdC56KR3Arg0T2Yl4j3YWYHfUY6
         wAgJMC38PM9f1nWrMiwycl7nvimHdc+IT9F/YgcQ=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 05/12] kconfig: make syncconfig update .config regardless of sym_change_count
In-Reply-To: <CAK7LNASN6_TM6a8ciVdgOH19d+CypMP+RQBnDsCSCtqub5co=g@mail.gmail.com>
        (Masahiro Yamada's message of "Fri, 13 Jul 2018 23:57:17 +0900")
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
        <1530758389-30862-6-git-send-email-yamada.masahiro@socionext.com>
        <ghva9simch.fsf@lena.gouders.net> <ghbmbk0wbj.fsf@quad.gouders.net>
        <ghwou4prif.fsf@lena.gouders.net>
        <CAK7LNAT9WjCMVqtq1ivxOqNERVbnC5fQbzrPrGCfz0aAbk_DEQ@mail.gmail.com>
        <gh36wo1ygh.fsf@lena.gouders.net>
        <CAK7LNASN6_TM6a8ciVdgOH19d+CypMP+RQBnDsCSCtqub5co=g@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Sat, 14 Jul 2018 09:12:03 +0200
Message-ID: <ghefg6ffzw.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> 2018-07-12 20:32 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>
>>> 2018-07-09 20:39 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
>>>> Dirk Gouders <dirk@gouders.net> writes:
>>>>
>>>> I think, I solved the puzzle and perhaps, that saves others some time:
>>>>
>>>> The problem is that "if_changed" was not designed for multiple use
>>>> inside a recipe and in the case of compressed/vmlinux, the 2-fold use
>>>> created a kind of flip-flop for situations when nothing has to be done
>>>> to build the target.
>>>>
>>>> Because each of the two users of "if_changed" stores it's footprint in
>>>> .vmlinux.cmd but that file then isn't re-read, one of the two
>>>> "if_changed" calculates that nothing has to be done wheras the other one
>>>> recognizes a change in the commandline, because it sees the command-line
>>>> for the other part of the reciepe.
>>>>
>>>> In the next make, the roles flip, because the previously satisfied
>>>> "if_changed" now sees the command-line of the other one.  And so on...
>>>>
>>>> I am not a Kbuild expert but the attached patch fixes that problem by
>>>> introducing "if_changed_multi" that accepts two commands -- one whose
>>>> commandline should be checked and a second one that should be
>>>> executed.
>>>
>>>
>>> if_changed should not appear multiple times in one target.
>>>
>>> I think the simplest fix-up is to
>>> create a new command that combines
>>> 'cmd_check_data_rel' and 'cmd_ld'.
>>>
>>>
>>> quiet_cmd_link-vmlinux = LD      $@
>>>       cmd_link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
>>>
>>> $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>>         $(call if_changed,link-vmlinux)
>>>
>>> Kbuild also supports if_changed_rule,
>>> but the usage is more complex.
>>>
>>> There are only a few usages:
>>> https://github.com/torvalds/linux/blob/v4.17/scripts/Makefile.build#L288
>>
>> Just for completeness I will copy in part of a reply from Kees that
>> shows how double-colon rules can also avoid multiple use of if_changed
>> for one target:
>>
>> -$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>> -       $(call if_changed,check_data_rel)
>> +$(obj)/vmlinux:: $(vmlinux-objs-y)
>> +       $(call cmd,check_data_rel)
>> +$(obj)/vmlinux:: $(vmlinux-objs-y) FORCE
>>         $(call if_changed,ld)
>
> It is difficult to use double-colon rules in a _sane_ way.
>
> The first one just checks data_rel,
> but does not actually generate anything.
>
> Such targets should be marked as .PHONY,
> but $(obj)/vmlinux is not a phony target.
> This is strange.
>
>> The combined command seems to have the advantage that every command to
>> build the target gets recorded in the .cmd file
>>
>> A search showed me that we have two more users that use if_changed more
>> than once for a single target:
>>
>>           arch/microblaze/boot/Makefile                 (fourfold)
>>           arch/sparc/boot/Makefile               (2 times twofold)
>>
>> The sparc case seems to apply to any of the two suggested fixes,
>
> Neither is correct.
>
>
> $(obj)/uImage: $(obj)/image.gz
>         $(call if_changed,uimage)
>         $(call if_changed,uimage.o)
>
>
> should be split into two targets.
>
>
> $(obj)/uImage: $(obj)/image.gz FORCE
>         $(call if_changed,uimage)
>
> $(obj)/uImage.o: $(obj)/uImage FORCE
>         $(call if_changed,uimage.o)
>
>
> It is wrong in multiple ways.  FORCE is missing too.
>
>  but
>> microblaze uses if_changed in a pattern rule and also makes use of
>> parameter arguments in the sub-commands:
>>
>> $(obj)/simpleImage.%: vmlinux FORCE
>>         $(call if_changed,cp,.unstrip)
>>         $(call if_changed,objcopy)
>>         $(call if_changed,uimage)
>>         $(call if_changed,strip,.strip)
>>         @echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
>
>
> Probably, this is the same.
>
> Create a target for each step.
>
>
>> In this case, double colons would have a different meaning and the
>> combined command solution would result in a change of the sub-commands,
>> as well.  I note this in case Michal perhaps has other preferences.
>>
>>
>> In addition to extend the documentation, we could modify if_changed to
>> warn about it is being used more than once for a target:
>>
>> # Execute command if command has changed or prerequisite(s) are updated.
>> if_changed = $(if $(filter-out undefined,$(origin if_changed_$@)),           \
>>         @set -e;                                                             \
>>         echo "Warning: $@: multiple use of if_changed!" >&2; ,               \
>>         @set -e $(eval if_changed_$@ := 1) ; )                               \
>>         $(if $(strip $(any-prereq) $(arg-check)),                            \
>>         $(echo-cmd) $(cmd_$(1));                                             \
>>         printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, :)
>>
>> But this fires only if if_changed is actually called and it defines many
>> variables for just that purpose, so this is perhaps not what we want...
>>
>
> I do not want to mess up Makefile.
>
>
> Please do this check in scripts/checkpatch.pl
> if you want.

Thank you for spending your time in the detailed explanation.
I will use it to assemble that all to a fix and then send it for review.

Dirk

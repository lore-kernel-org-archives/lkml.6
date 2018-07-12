Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0EECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14574213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="OD3EcFA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14574213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbeGLVcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:32:51 -0400
Received: from services.gouders.net ([141.101.32.176]:38810 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbeGLVcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:32:51 -0400
Received: from localhost (ltea-047-067-156-155.pools.arcor-ip.net [47.67.156.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w6CL6Icp019338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 23:06:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1531429579; bh=S75PNocf/Da8drrKbrQuhzSIdsxie1oaZEB+lxknLFo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=OD3EcFA7KKEpTvlTDlg1RFcdmmVhtCAz6cz3aw1B0VEG0r1Ofrq6/1MtQoafDLnZs
         9tL6EA4IWJnKeXc+fSQU61gG/WM8crILYcg6FIM2gArEDMisdbm7LGHvUMtrPNrfws
         sSaUxOtj1I/UD9aO8ZefSxMFDHgNuT+ENMIVH9/Q=
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
In-Reply-To: <gh36wo1ygh.fsf@lena.gouders.net> (Dirk Gouders's message of
        "Thu, 12 Jul 2018 13:32:30 +0200")
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
        <1530758389-30862-6-git-send-email-yamada.masahiro@socionext.com>
        <ghva9simch.fsf@lena.gouders.net> <ghbmbk0wbj.fsf@quad.gouders.net>
        <ghwou4prif.fsf@lena.gouders.net>
        <CAK7LNAT9WjCMVqtq1ivxOqNERVbnC5fQbzrPrGCfz0aAbk_DEQ@mail.gmail.com>
        <gh36wo1ygh.fsf@lena.gouders.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Thu, 12 Jul 2018 23:06:19 +0200
Message-ID: <gh1sc8w4dw.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Dirk Gouders <dirk@gouders.net> writes:

> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
>> 2018-07-09 20:39 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
>>> Dirk Gouders <dirk@gouders.net> writes:
>>>
>>>> Dirk Gouders <dirk@gouders.net> writes:
>>>>
>>>>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>>>
>>>>>> syncconfig updates the .config only when sym_change_count > 0, i.e.
>>>>>> any change in config symbols has been detected.
>>>>>>
>>>>>> Not only symbols but also comments are contained in the .config file.
>>>>>> If only comments are updated, they are not fed back to the .config,
>>>>>> then the stale comments are left-over.  Of course, this is just a
>>>>>> matter of comments, but why not fix it.
>>>>>
>>>>> Hello Masahiro,
>>>>>
>>>>> I am currently looking at and testing this series.
>>>>>
>>>>> First: For this patch I would suggest to also edit the syncconfig
>>>>>        section of "conf --help".
>>>>>
>>>>> Further, on a slow laptop, I was suspecting, this patch to cause full
>>>>> rebuilds of everything, each time I ran "make syncconfig" followed by
>>>>> "make" but could not verify this on another machine, so perhaps I am
>>>>> just (for testing purposes) removing the wrong files (modules.builtin
>>>>> for example) -- I am still testing.
>>>>>
>>>>> But, what irritates me with testing is that (also without your
>>>>> patches) two consecutive "make" produce different output, one of them
>>>>> always shows a warning and this is reproducable.  I just want to make
>>>>> sure there is no other problem that influences my testing:
>>>>>
>>>>> $ make
>>>>>   CALL    scripts/checksyscalls.sh
>>>>>   DESCEND  objtool
>>>>>   CHK     include/generated/compile.h
>>>>>   DATAREL arch/x86/boot/compressed/vmlinux
>>>>> Kernel: arch/x86/boot/bzImage is ready  (#15)
>>>>>   Building modules, stage 2.
>>>>>   MODPOST 211 modules
>>>>>
>>>>> $ make
>>>>>   CALL    scripts/checksyscalls.sh
>>>>>   DESCEND  objtool
>>>>>   CHK     include/generated/compile.h
>>>>>   LD      arch/x86/boot/compressed/vmlinux
>>>>> ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
>>>>> ld: warning: creating a DT_TEXTREL in object.
>>>>>   ZOFFSET arch/x86/boot/zoffset.h
>>>>>   AS      arch/x86/boot/header.o
>>>>>   LD      arch/x86/boot/setup.elf
>>>>>   OBJCOPY arch/x86/boot/setup.bin
>>>>>   OBJCOPY arch/x86/boot/vmlinux.bin
>>>>>   BUILD   arch/x86/boot/bzImage
>>>>> Setup is 15580 bytes (padded to 15872 bytes).
>>>>> System is 8069 kB
>>>>> CRC e01d75ec
>>>>> Kernel: arch/x86/boot/bzImage is ready  (#15)
>>>>>   Building modules, stage 2.
>>>>>   MODPOST 211 modules
>>>>
>>>> I spent some more time with the behaviour described above and bisected
>>>> to the commit after that two consecutive invocations of "make" (on an
>>>> already compiled tree) seem to do different things.  That commit is
>>>> 98f78525371b55cc (x86/boot: Refuse to build with data relocations), so I
>>>> put Kees and Ingo on CC.
>>>>
>>>> I did the bisecting on another system, so I'll provide the output of two
>>>> consecutive "make" on an already compiled tree on that machine:
>>>>
>>>> $ make
>>>>   CALL    scripts/checksyscalls.sh
>>>>   DESCEND  objtool
>>>>   CHK     include/generated/compile.h
>>>>   DATAREL arch/x86/boot/compressed/vmlinux
>>>> Kernel: arch/x86/boot/bzImage is ready  (#48)
>>>>   Building modules, stage 2.
>>>>   MODPOST 165 modules
>>>>
>>>> $ make
>>>>   CALL    scripts/checksyscalls.sh
>>>>   DESCEND  objtool
>>>>   CHK     include/generated/compile.h
>>>>   LD      arch/x86/boot/compressed/vmlinux
>>>>   ZOFFSET arch/x86/boot/zoffset.h
>>>>   AS      arch/x86/boot/header.o
>>>>   LD      arch/x86/boot/setup.elf
>>>>   OBJCOPY arch/x86/boot/setup.bin
>>>>   OBJCOPY arch/x86/boot/vmlinux.bin
>>>>   BUILD   arch/x86/boot/bzImage
>>>> Setup is 15644 bytes (padded to 15872 bytes).
>>>> System is 6663 kB
>>>> CRC 3eb90f40
>>>> Kernel: arch/x86/boot/bzImage is ready  (#48)
>>>>   Building modules, stage 2.
>>>>   MODPOST 165 modules
>>>>
>>>> If I comment out $(call if_changed,check_data_rel) in
>>>> arch/x86/boot/compressed/Makefile, two consecutive "make" produce
>>>> identical output i.e. seem to not do different things:
>>>>
>>>> $ make
>>>>   CALL    scripts/checksyscalls.sh
>>>>   DESCEND  objtool
>>>>   CHK     include/generated/compile.h
>>>> Kernel: arch/x86/boot/bzImage is ready  (#49)
>>>>   Building modules, stage 2.
>>>>   MODPOST 165 modules
>>>>
>>>> $ make
>>>>   CALL    scripts/checksyscalls.sh
>>>>   DESCEND  objtool
>>>>   CHK     include/generated/compile.h
>>>> Kernel: arch/x86/boot/bzImage is ready  (#49)
>>>>   Building modules, stage 2.
>>>>   MODPOST 165 modules
>>>>
>>>> So, I guess this different behaviour of two consecutive "make" is not
>>>> intentional but I am failing to understand why it happens.
>>>
>>> I think, I solved the puzzle and perhaps, that saves others some time:
>>>
>>> The problem is that "if_changed" was not designed for multiple use
>>> inside a recipe and in the case of compressed/vmlinux, the 2-fold use
>>> created a kind of flip-flop for situations when nothing has to be done
>>> to build the target.
>>>
>>> Because each of the two users of "if_changed" stores it's footprint in
>>> .vmlinux.cmd but that file then isn't re-read, one of the two
>>> "if_changed" calculates that nothing has to be done wheras the other one
>>> recognizes a change in the commandline, because it sees the command-line
>>> for the other part of the reciepe.
>>>
>>> In the next make, the roles flip, because the previously satisfied
>>> "if_changed" now sees the command-line of the other one.  And so on...
>>>
>>> I am not a Kbuild expert but the attached patch fixes that problem by
>>> introducing "if_changed_multi" that accepts two commands -- one whose
>>> commandline should be checked and a second one that should be
>>> executed.
>>
>>
>> if_changed should not appear multiple times in one target.
>>
>> I think the simplest fix-up is to
>> create a new command that combines
>> 'cmd_check_data_rel' and 'cmd_ld'.
>>
>>
>> quiet_cmd_link-vmlinux = LD      $@
>>       cmd_link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
>>
>> $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>>         $(call if_changed,link-vmlinux)
>>
>> Kbuild also supports if_changed_rule,
>> but the usage is more complex.
>>
>> There are only a few usages:
>> https://github.com/torvalds/linux/blob/v4.17/scripts/Makefile.build#L288
>
> Just for completeness I will copy in part of a reply from Kees that
> shows how double-colon rules can also avoid multiple use of if_changed
> for one target:
>
> -$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> -       $(call if_changed,check_data_rel)
> +$(obj)/vmlinux:: $(vmlinux-objs-y)
> +       $(call cmd,check_data_rel)
> +$(obj)/vmlinux:: $(vmlinux-objs-y) FORCE
>         $(call if_changed,ld)
>
> The combined command seems to have the advantage that every command to
> build the target gets recorded in the .cmd file
>
> A search showed me that we have two more users that use if_changed more
> than once for a single target:
>
>           arch/microblaze/boot/Makefile                 (fourfold)
>           arch/sparc/boot/Makefile               (2 times twofold)
>
> The sparc case seems to apply to any of the two suggested fixes, but
> microblaze uses if_changed in a pattern rule and also makes use of
> parameter arguments in the sub-commands:
>
> $(obj)/simpleImage.%: vmlinux FORCE
> 	$(call if_changed,cp,.unstrip)
> 	$(call if_changed,objcopy)
> 	$(call if_changed,uimage)
> 	$(call if_changed,strip,.strip)
> 	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
>
> In this case, double colons would have a different meaning and the
> combined command solution would result in a change of the sub-commands,
> as well.  I note this in case Michal perhaps has other preferences.
>
>
> In addition to extend the documentation, we could modify if_changed to
> warn about it is being used more than once for a target:
>
> # Execute command if command has changed or prerequisite(s) are updated.
> if_changed = $(if $(filter-out undefined,$(origin if_changed_$@)),           \
> 	@set -e;                                                             \
> 	echo "Warning: $@: multiple use of if_changed!" >&2; ,               \
> 	@set -e $(eval if_changed_$@ := 1) ; )                               \
>         $(if $(strip $(any-prereq) $(arg-check)),                            \
> 	$(echo-cmd) $(cmd_$(1));                                             \
> 	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, :)
>
> But this fires only if if_changed is actually called and it defines many
> variables for just that purpose, so this is perhaps not what we want...

Short addition: it seems, we can use target-specific variables,
reducing the mass of additional valiables to just one
(more correctly: the number of targets created in parallel):

# Execute command if command has changed or prerequisite(s) are updated.
if_changed = $(if $(filter-out undefined,$(origin if_changed_cnt)),          \
	@set -e;                                                             \
	echo "Warning: $@: multiple use of if_changed!" >&2; ,               \
	@set -e $(eval $@: if_changed_cnt := 1) ; )                          \
        $(if $(strip $(any-prereq) $(arg-check)),                            \
	$(echo-cmd) $(cmd_$(1));                                             \
	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, :)

The documentation for make says that target-specific variables are also
in effect for all prerequisites of this target but as far as I examined
(see attached Makefile and target "check") not for the example above.

In my understanding this is because the variable is created when the
recipe for the target is executed, i.e. all prerequisites are already
done.

I did a "quick" measurement for an allnoconfig configuration on my slow
laptop:

Without additional check:

real    14m45.477s
user    14m10.775s
sys     0m42.997s


With additional check:

real    14m45.562s
user    14m12.045s
sys     0m41.844s

Dirk


--=-=-=
Content-Disposition: inline; filename=Makefile
Content-Description: Test target-specific variable

-include .check.cmd

comma   := ,
quote   := "
squote  := '
empty   :=
space   := $(empty) $(empty)
space_escape := _-_SPACE_-_
pound := \#

quiet_cmd_a = A
cmd_a = echo "doing a"
quiet_cmd_b = B
cmd_b = echo "doing b"

###
# Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
dot-target = $(dir $@).$(notdir $@)

###
# Escape single quote for use in echo statements
escsq = $(subst $(squote),'\$(squote)',$1)

ifneq ($(KBUILD_NOCMDDEP),1)
# Check if both arguments are the same including their order. Result is empty
# string if equal. User may override this check using make KBUILD_NOCMDDEP=1
arg-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
                         $(subst $(space),$(space_escape),$(strip $(cmd_$1))))
else
arg-check = $(if $(strip $(cmd_$@)),,1)
endif

# Replace >$< with >$$< to preserve $ when reloading the .cmd file
# (needed for make)
# Replace >#< with >$(pound)< to avoid starting a comment in the .cmd file
# (needed for make)
# Replace >'< with >'\''< to be able to enclose the whole string in '...'
# (needed for the shell)
make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))

# Find any prerequisites that is newer than target or that does not exist.
# PHONY targets skipped in both cases.
any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)

quiet = quiet_
# echo command.
# Short version is used, if $(quiet) equals `quiet_', otherwise full one.
echo-cmd = $(if $($(quiet)cmd_$(1)),\
	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)

cmd = @$(echo-cmd) $(cmd_$(1))

# Execute command if command has changed or prerequisite(s) are updated.
if_changed = $(if $(filter-out undefined,$(origin if_changed_cnt)),          \
	@set -e;                                                             \
	echo "Warning: $@: multiple use of if_changed!" >&2; ,               \
	@set -e $(eval $@: if_changed_cnt := 1) ; )                          \
        $(if $(strip $(any-prereq) $(arg-check)),                            \
	$(echo-cmd) $(cmd_$(1));                                             \
	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, :)

PHONY += FORCE
FORCE:

a.o: Makefile
	@printf 'if_change_cnt: -%s-\n' '$(origin if_change_cnt)'
	@touch a.o

check: a.o FORCE
	$(call if_changed,a)
	$(call if_changed,b)
	@touch check

--=-=-=--

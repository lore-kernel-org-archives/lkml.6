Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932425AbeCFJV6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:21:58 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:47876 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753210AbeCFJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:21:54 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w269LkUF011307
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AG47ELtLPlRcbibnCtkvWxr0KJ+HTlIq7wOfsZV3gUTptWMZUpbCFv15zHpH/jldm8JdwJcEKGWYdNys6ysaYUrBI8s=
MIME-Version: 1.0
In-Reply-To: <CAFkk2KSxdvHD+k_xusJ5pzohOSk9VF=Frk-ED6bLJnuyLZBAzQ@mail.gmail.com>
References: <1519965121-12017-1-git-send-email-yamada.masahiro@socionext.com>
 <1519965121-12017-9-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KSxdvHD+k_xusJ5pzohOSk9VF=Frk-ED6bLJnuyLZBAzQ@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 6 Mar 2018 18:21:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT=aMDThLLV5O2pD-PfuQs6_aGr5hdLB+JAn8rzM0+Yaw@mail.gmail.com>
Message-ID: <CAK7LNAT=aMDThLLV5O2pD-PfuQs6_aGr5hdLB+JAn8rzM0+Yaw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] kconfig: unittest: test defconfig when two
 choices interact
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-02 19:41 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Fri, Mar 2, 2018 at 5:31 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Commit fbe98bb9ed3d ("kconfig: Fix defconfig when one choice menu
>> selects options that another choice menu depends on") fixed defconfig
>> when two choices interact (i.e. calculating the visibility of a choice
>> requires to calculate another choice).
>>
>> The test code in that commit log was based on the real world example,
>> and complicated.  So, I shrunk it down to the following:
>>
>> defconfig.choice:
>> ---8<---
>> CONFIG_CHOICE_VAL0=y
>> ---8<---
>>
>> ---8<---
>> config MODULES
>>         bool "Enable loadable module support"
>>         option modules
>>         default y
>>
>> choice
>>         prompt "Choice"
>>
>> config CHOICE_VAL0
>>         tristate "Choice 0"
>>
>> config CHOICE_VAL1
>>         tristate "Choice 1"
>>
>> endchoice
>>
>> choice
>>         prompt "Another choice"
>>         depends on CHOICE_VAL0
>>
>> config DUMMY
>>         bool "dummy"
>>
>> endchoice
>> ---8<---
>>
>> Prior to commit fbe98bb9ed3d,
>>
>>   $ scripts/kconfig/conf --defconfig=defconfig.choice Kconfig.choice
>>
>> resulted in:
>>
>>   CONFIG_MODULES=y
>>   CONFIG_CHOICE_VAL0=m
>>   # CONFIG_CHOICE_VAL1 is not set
>>   CONFIG_DUMMY=y
>>
>> where the expected result would be:
>>
>>   CONFIG_MODULES=y
>>   CONFIG_CHOICE_VAL0=y
>>   # CONFIG_CHOICE_VAL1 is not set
>>   CONFIG_DUMMY=y
>>
>> Roughly, this weird behavior happened like this:
>>
>> Symbols are calculated a couple of times.  First, all symbols are
>> calculated in conf_read().  The first 'choice' is evaluated to 'y'
>> due to the SYMBOL_DEF_USER flag, but sym_calc_choice() clears it
>> unless all of its choice values are explicitly set by the user.
>>
>> conf_set_all_new_symbols() clears all SYMBOL_VALID flags.  Then, only
>> choices are calculated.  At this point, the SYMBOL_DEF_USER for the
>> first choice is unset, so, it is evaluated to 'm'.  (this is weird)
>
> This is because tristate choices start out in m mode btw (they have an
> implicit select of 'm && <visibibility>' on them, added add the end of
> menu_finalize()).

Ah, right.  But indeed weird to forget SYMBOL_DEF_USER.


>> set_all_choice_values() sets SYMBOL_DEF_USER again to choice symbols.
>>
>> When calculating the second choice, due to 'depends on CHOICE_VAL0',
>> it triggers the calculation of CHOICE_VAL0.  As a result, SYMBOL_VALID
>> is set for CHOICE_VAL0.
>>
>> Symbols except choices get the final chance of re-calculation in
>> conf_write().  In a normal case, CHOICE_VAL0 would be re-caluculated,
>> then the first choice would be indirectly re-calculated with the
>> SYMBOL_DEF_USER which has been set by set_all_choice_values(), which
>> would be evaluated to 'y'.  But, in this case, CHOICE_VAL0 has been
>> marked SYMBOL_VALID, so it is simply skipped.  Then, =m is written out
>> to the .config file.
>>
>> Add a unit test for this naive case.
>
> At a high level, I think the problem is that the choice mode is
> forgotten. It should be y because of the CONFIG_CHOICE_VAL0=y
> assignment, but reverts back to m temporarily, and during that window
> a choice symbol is evaluated and gets the wrong value.
>
> I wonder if all this twisty code and the weird flags
> (SYMBOL_NEED_SET_CHOICE_VALUES... hmm) are required. Perhaps an extra
> invalidation or the like would be enough.


Agree.

Probably, 5d09598d488f and fbe98bb9ed3d fixed issues in a bad way.

I believe SYMBOL_DEF_USER should be set only in
conf_read(_simple) and conf_set_all_new_symbols().

It is strange to set and clear SYMBOL_DEF_USER
while calculating symbols.




>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - Newly added
>>
>>  scripts/kconfig/tests/inter_choice/Kconfig         | 24 ++++++++++++++++++++++
>>  scripts/kconfig/tests/inter_choice/__init__.py     | 14 +++++++++++++
>>  scripts/kconfig/tests/inter_choice/defconfig       |  1 +
>>  scripts/kconfig/tests/inter_choice/expected_config |  4 ++++
>>  4 files changed, 43 insertions(+)
>>  create mode 100644 scripts/kconfig/tests/inter_choice/Kconfig
>>  create mode 100644 scripts/kconfig/tests/inter_choice/__init__.py
>>  create mode 100644 scripts/kconfig/tests/inter_choice/defconfig
>>  create mode 100644 scripts/kconfig/tests/inter_choice/expected_config
>>
>> diff --git a/scripts/kconfig/tests/inter_choice/Kconfig b/scripts/kconfig/tests/inter_choice/Kconfig
>> new file mode 100644
>> index 0000000..57d55c4
>> --- /dev/null
>> +++ b/scripts/kconfig/tests/inter_choice/Kconfig
>> @@ -0,0 +1,24 @@
>> +config MODULES
>> +       bool "Enable loadable module support"
>> +       option modules
>> +       default y
>> +
>> +choice
>> +       prompt "Choice"
>> +
>> +config CHOICE_VAL0
>> +       tristate "Choice 0"
>> +
>> +config CHOIVE_VAL1
>> +       tristate "Choice 1"
>> +
>> +endchoice
>> +
>> +choice
>> +       prompt "Another choice"
>> +       depends on CHOICE_VAL0
>> +
>> +config DUMMY
>> +       bool "dummy"
>> +
>> +endchoice
>> diff --git a/scripts/kconfig/tests/inter_choice/__init__.py b/scripts/kconfig/tests/inter_choice/__init__.py
>> new file mode 100644
>> index 0000000..5c7fc36
>> --- /dev/null
>> +++ b/scripts/kconfig/tests/inter_choice/__init__.py
>> @@ -0,0 +1,14 @@
>> +"""
>> +Do not affect user-assigned choice value by another choice.
>> +
>> +Handling of state flags for choices is complecated.  In old days,
>> +the defconfig result of a choice could be affected by another choice
>> +if those choices interact by 'depends on', 'select', etc.
>> +
>> +Related Linux commit: fbe98bb9ed3dae23e320c6b113e35f129538d14a
>> +"""
>> +
>> +
>> +def test(conf):
>> +    assert conf.defconfig('defconfig') == 0
>> +    assert conf.config_contains('expected_config')
>> diff --git a/scripts/kconfig/tests/inter_choice/defconfig b/scripts/kconfig/tests/inter_choice/defconfig
>> new file mode 100644
>> index 0000000..162c414
>> --- /dev/null
>> +++ b/scripts/kconfig/tests/inter_choice/defconfig
>> @@ -0,0 +1 @@
>> +CONFIG_CHOICE_VAL0=y
>> diff --git a/scripts/kconfig/tests/inter_choice/expected_config b/scripts/kconfig/tests/inter_choice/expected_config
>> new file mode 100644
>> index 0000000..5dceefb
>> --- /dev/null
>> +++ b/scripts/kconfig/tests/inter_choice/expected_config
>> @@ -0,0 +1,4 @@
>> +CONFIG_MODULES=y
>> +CONFIG_CHOICE_VAL0=y
>> +# CONFIG_CHOIVE_VAL1 is not set
>> +CONFIG_DUMMY=y
>> --
>> 2.7.4
>>
>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> This reminded me of a bug I reported ages ago, which afaict hasn't
> been fixed: https://lkml.org/lkml/2012/12/5/458 (in retrospect,
> sym_clear_all_valid() is cheap).

Fixed by fbe98bb9ed3dae23e320c6b113e35f129538d14a
a.k.a v3.10-rc1-1-gfbe98bb

The root cause is the same.


> When manually patching all defconfig files in the kernel to disable
> modules and running the Kconfiglib test suite, that bug triggers for a
> few defconfigs. It has previously triggered for a few unpatched
> defconfig files too -- see
> https://github.com/ulfalizer/Kconfiglib#notes.
>
> I just add an extra sym_clear_all_valid() at the end of
> conf_set_all_new_symbols() to fix it. It'd be worth checking if that
> fixes this problem too.
>
> Cheers,
> Ulf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

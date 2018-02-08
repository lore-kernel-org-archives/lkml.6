Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x2273/UMiwuFQrnKC2NDWkalOw9PPaiWVZjl5RFVstnoNyMUwA9h4BWax/wBOHIv0JvFwH3UU
ARC-Seal: i=1; a=rsa-sha256; t=1518057795; cv=none;
        d=google.com; s=arc-20160816;
        b=iIK4uCtUQMy/wWt8+n41JjqdnkAsiJJvChVS+5Tw5Reh01P700f0KvanX5Z0BuhA0K
         AOycvq/4duRFaEFIyzfTOR0pjGpMxbYdEuSy2r/b40411WO/ZADEWIwHA0SieZ7pDjaH
         zUNeC3aOme2bwELDDrAftQC88XD3izouhhthuYs0SIKo6vkT8JkEV8hsf2n1ufrebMsR
         KukpnwPYXTNjE0hnCKnldsoD/4Zbk1LOvKiusXXoqn0FHnJcwXUy3mh+wVa//53JMOIn
         wj/VcMMz6UDUUQVyurCR3kQenUucH+AR4bLionIXXrRyIDOdnL7gxarLXKSlKn4EHidV
         VkEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=yap983M9UEA9YfZ2etakViDM2fA9I/vL5crctb77zzs=;
        b=RtPHj6GM6k5nVKqe58IC4voXXQodmY/DMsBWNT4InTxEI7LfoAtoAAMzcxWhiqm8jQ
         vhTZmPqcnhXNofkUGqWRf9GbvGcq5Ro3z81eu1PiLv99csw3xcRxMoxDk0WwQkDQRsMZ
         tMGsvVAgxoy+LQY5fZlyiGoXb7xVGXqn24IQBM9rjSE0SYSXkdCaV1qlXeOawK6NR7z6
         HiPuMzQMa1sQADcxZwmLAozUMbxip673gcwRY2Pp8bFRPanM6J2S8FLr0DcpMNWorCSg
         oozZP3K5uRVROJLDghYa/TS+4uRaJzRmRAv7HQe0WvZfSZ7knaGAZjcys1D0ar041R3I
         FxUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=SvzQmyRB;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=SvzQmyRB;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w182h0Xm019278
X-Nifty-SrcIP: [209.85.213.46]
MIME-Version: 1.0
In-Reply-To: <20180207225551.imdp6gqbdwzyvhwm@huvuddator>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-3-git-send-email-yamada.masahiro@socionext.com> <20180207225551.imdp6gqbdwzyvhwm@huvuddator>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 11:42:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARVT6cHhFCAGrwL=qEqqSBmJU-pwq02R9M0VSfCiF_RsQ@mail.gmail.com>
Message-ID: <CAK7LNARVT6cHhFCAGrwL=qEqqSBmJU-pwq02R9M0VSfCiF_RsQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] kconfig: do not write choice values when their
 dependency becomes n
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778627076775?=
X-GMAIL-MSGID: =?utf-8?q?1591798970991381030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-08 7:55 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Tue, Feb 06, 2018 at 09:34:42AM +0900, Masahiro Yamada wrote:
>> "# CONFIG_... is not set" for choice values are wrongly written into
>> the .config file if they are once visible, then become invisible later.
>>
>>   Test case
>>   ---------
>>
>> ---------------------------(Kconfig)----------------------------
>> config A
>>       bool "A"
>>
>> choice
>>       prompt "Choice ?"
>>       depends on A
>>
>> config CHOICE_B
>>       bool "Choice B"
>>
>> config CHOICE_C
>>       bool "Choice C"
>>
>> endchoice
>> ----------------------------------------------------------------
>>
>> ---------------------------(.config)----------------------------
>> CONFIG_A=y
>> ----------------------------------------------------------------
>>
>> With the Kconfig and .config above,
>>
>>   $ make config
>>   scripts/kconfig/conf  --oldaskconfig Kconfig
>>   *
>>   * Linux Kernel Configuration
>>   *
>>   A (A) [Y/n] n
>>   #
>>   # configuration written to .config
>>   #
>>   $ cat .config
>>   #
>>   # Automatically generated file; DO NOT EDIT.
>>   # Linux Kernel Configuration
>>   #
>>   # CONFIG_A is not set
>>   # CONFIG_CHOICE_B is not set
>>   # CONFIG_CHOICE_C is not set
>>
>> Here,
>>
>>   # CONFIG_CHOICE_B is not set
>>   # CONFIG_CHOICE_C is not set
>>
>> should not be written into the .config file because their dependency
>> "depends on A" is unmet.
>>
>> Currently, there is no code that clears SYMBOL_WRITE of choice values.
>>
>> Clear SYMBOL_WRITE for all symbols in sym_calc_value(), then set it
>> again after calculating visibility.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
>>  scripts/kconfig/symbol.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
>> index c9123ed..5d6f6b1 100644
>> --- a/scripts/kconfig/symbol.c
>> +++ b/scripts/kconfig/symbol.c
>> @@ -371,8 +371,7 @@ void sym_calc_value(struct symbol *sym)
>>               sym->curr.tri = no;
>>               return;
>>       }
>> -     if (!sym_is_choice_value(sym))
>> -             sym->flags &= ~SYMBOL_WRITE;
>> +     sym->flags &= ~SYMBOL_WRITE;
>>
>>       sym_calc_visibility(sym);
>>
>> @@ -385,6 +384,7 @@ void sym_calc_value(struct symbol *sym)
>>               if (sym_is_choice_value(sym) && sym->visible == yes) {
>>                       prop = sym_get_choice_prop(sym);
>>                       newval.tri = (prop_get_symbol(prop)->curr.val == sym) ? yes : no;
>> +                     sym->flags |= SYMBOL_WRITE;
>>               } else {
>>                       if (sym->visible != no) {
>>                               /* if the symbol is visible use the user value
>> --
>> 2.7.4
>>
>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> There's a possible simplification here:
>
> All defined symbols, regardless of type, and regardless of whether
> they're choice value symbols or not, always get written out if they have
> non-n visibility. Therefore, the sym->visible != no check for
> SYMBOL_WRITE can be moved to before the symbol type check, which gets
> rid of two SYMBOL_WRITE assignments and makes it clear that the logic is
> the same for all paths.
>
> This is safe for symbols defined without a type (S_UNKNOWN) too, because
> conf_write() skips those (plus they already generate a warning).
>
> This matches how I do it in the tri_value() function in Kconfiglib:
> https://github.com/ulfalizer/Kconfiglib/blob/master/kconfiglib.py#L2574.
> SYMBOL_WRITE corresponds to _write_to_conf.
>
> I've included a patch below. I tested it with the Kconfiglib test suite,
> which verifies that the C implementation still generates the same
> .config file for all defconfig files as well as for
> all{no,yes,def}config, for all ARCHes.
>
> (The Kconfiglib test suite runs scripts/kconfig/conf and compares its
> output against it, which means it doubles as a regression test for the C
> tools.)

Thank you for this.  This is simpler, and please let me take it.

I confirmed the same results were produced.




-- 
Best Regards
Masahiro Yamada

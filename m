Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227mWdxXkBpI7MZp0z1npu2D2FWdAIR0RQ+wBXeZSSOb8pRHhSbs10q6215tHNGiN+eLvpsg
ARC-Seal: i=1; a=rsa-sha256; t=1519146334; cv=none;
        d=google.com; s=arc-20160816;
        b=mqzBWGk3CyVVUyXsZC4esX6WZKcQIkJnMrsmb1F2fmc5k8qX9Mu+7Y0mDB8tyj8t/w
         me8MW10PkzPkboj3x44+6l2RXFbnuQoCU8J4V0Ks+kqG0y5QbsEiCpEcHNGYfkpKXfob
         DkCZGPN5Z1dXaSBmerSpg3crZmAlGe2kGfTXhAH/5xzslwM4NW6q/j364XHMrabRAKdA
         po6ljJQL0SN5tqDfCr67vrh4WLTgtFJqGKFTNEKFyIakAALk9WNxpPsZ7afHxg5imF3m
         2Ma0GPe+CvUWOULMKh0TgPsklGp+Q5VbiKQax/7hfAnw0WdyOHl1drRVJK4/TJbwUgCo
         EPXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=E3pHp07n53EbNTd08xVJ31lT41/QK320x9nEcVlXu4Y=;
        b=g9wI+8/iD96Yd0le4/sdcRC+PkqkdCnqruALcozLmga0DVaqCLsxXn6CiuR9uWL0Vm
         Os7ycDA/PyCCf6T0Nv+kyhJGzqBnzD7G8yl5na0iNUoX/A3zw/BpAvosfWeh7GzY4xAf
         cXLE87oYs/heVyKYasvRixf5yELTSOM3gs5DgxZazL5uantsablBvhQl6xTX8WQkyPVd
         pdcbp9GdlP5xEMKoExc8Mp9gQjzImc4EU5lAJU27KWTtTjBTKHA9XIStR5wFfWvIGHCd
         9gXH+KXCCThmm3ARAA6cjhRGxOL/HhXbr+pg6Kkyk39dRTyejcjDBrPCjZGrvElwtNU9
         kXAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=si/3I16F;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=si/3I16F;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.81 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w1KH571U027629
X-Nifty-SrcIP: [209.85.217.170]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0DAu1q3jLMN=JjrNAd4a4UVFcEcLF2h1VgSvXjZsU++g@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-3-arnd@arndb.de>
 <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com> <CAK8P3a0DAu1q3jLMN=JjrNAd4a4UVFcEcLF2h1VgSvXjZsU++g@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 02:04:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2GO21TMP=viR1sni_17zFZ+03TUh8pak1etVYEF8kTQ@mail.gmail.com>
Message-ID: <CAK7LNAR2GO21TMP=viR1sni_17zFZ+03TUh8pak1etVYEF8kTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config
 fragments
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E. MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1592940387070348083?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-20 18:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 20, 2018 at 10:26 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>
>>> @@ -621,14 +622,24 @@ int main(int ac, char **av)
>>>                 case randconfig:        name = "allrandom.config"; break;
>>>                 default: break;
>>>                 }
>>> -               if (conf_read_simple(name, S_DEF_USER) &&
>>> -                   conf_read_simple("all.config", S_DEF_USER)) {
>>> -                       fprintf(stderr,
>>> -                               _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
>>> -                               name);
>>> -                       exit(1);
>>> +               /* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
>>> +               if (!conf_read_simple(name, S_DEF_USER))
>>> +                       break;
>>> +               arch = getenv("ARCH");
>>> +               if (arch) {
>>> +                       snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
>>> +                                arch, name);
>>> +                       if (!conf_read_simple(fullname, S_DEF_USER))
>>> +                               break;
>>>                 }
>>
>>
>> I am not a big fan of hard-coding the kernel directory structure.
>>
>> We already do this [1], but I am thinking of kicking this out.
>> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/confdata.c#L33
>
> Ok, I see. How about adding a way to detect that we are build-testing
> with randconfig instead?


How about implementing something in scripts/kconfig/Makefile?

merge_config collects config fragments into 'configfiles'

I was thinking of a similar thing.


If KCONFIG_ALLCONFIG is 1,
scripts/kconfig/Makefile searches
'./', '$srctree/', 'arch/$(SRCARCH)/configs/', 'kernel/configs/'
and sets the found file in it,

If KCONFIG_ALLCONFIG already contains a file name, it is used as-is.

scripts/kconfig/conf.c will be simplified.



>> BTW, I am trying to compiler capability check to Kconfig.
>> If this work is done, I hope some "depends on !COMPILE_TEST" will go
>> away (but not all?)
>> https://patchwork.kernel.org/patch/10225375/
>
> I think most of the 'depends on !COMPILE_TEST' are for cases that
> impact compile-testing in some way (more false-positive warnings,
> fewer real warnings, much slower compile speed), rather than a lack
> of check for a specific compiler version.
>
> We might be able to replace the CONFIG_STANDALONE and
> CONFIG_PREVENT_FIRMWARE_BUILD with Kconfig $(shell)
> checks if you think that leads to an improvement.
>

OK, then your kernel/configs/allrandom.config approach will be useful.



-- 
Best Regards
Masahiro Yamada

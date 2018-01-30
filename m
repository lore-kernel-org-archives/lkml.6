Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753590AbeA3Tdy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:33:54 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41847 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbeA3Tdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:33:52 -0500
X-Google-Smtp-Source: AH8x226t1WAUCsglXQ7FUikzhPsdyRlC4BgPbUPJO03dE4v6j7/wiSW8GfPT9QBirafNFiyDqwoal1UndAAH8qq3wq0=
MIME-Version: 1.0
In-Reply-To: <1517337292.2230.15.camel@tiscali.nl>
References: <20180130181853.32512-1-ulfalizer@gmail.com> <1517337292.2230.15.camel@tiscali.nl>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 30 Jan 2018 20:33:51 +0100
Message-ID: <CAFkk2KSUpEvCCt0fUzCN+r7Lz9CuyN3jKV6atpPR92zPRK4f-w@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Warn if help text is blank
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 7:34 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Tue, 2018-01-30 at 19:18 +0100, Ulf Magnusson wrote:
>> Print a warning if a 'help' token is given but the help text is blank.
>> Personal pet peeve.
>>
>> Example warnings:
>>
>>       net/sched/Kconfig:860: warning: 'NET_IFE_SKBMARK' defined with blank help text
>>       net/sched/Kconfig:865: warning: 'NET_IFE_SKBPRIO' defined with blank help text
>>       net/sched/Kconfig:870: warning: 'NET_IFE_SKBTCINDEX' defined with blank help text
>>       drivers/video/fbdev/Kconfig:1159: warning: 'FB_I810_I2C' defined with blank help text
>>       drivers/mmc/host/Kconfig:877: warning: 'MMC_TOSHIBA_PCI' defined with blank help text
>>       drivers/staging/rtl8192u/Kconfig:8: warning: 'RTL8192U' defined with blank help text
>>       drivers/staging/rtl8192e/rtl8192e/Kconfig:9: warning: 'RTL8192E' defined with blank help text
>>       lib/Kconfig.debug:354: warning: 'ARCH_WANT_FRAME_POINTERS' defined with blank help text
>>
>> A separate patchset will be sent to fix all current instances of blank
>> help texts for all arches. I added the same warning to Kconfiglib.
>
> If you do this it would be better to first fix or remove those help texts

I agree that this shouldn't go in until/unless a significant portion
of those empty help texts get removed first.

> and only then add this warning. Ie, add the warning in the last patch of a cleanup
> series.

Might have been better to arrange it like that, yeah. The patchset
that removes the empty help texts is at
https://lkml.org/lkml/2018/1/30/574. I could make another one if you'd
prefer that.

>
>> --- a/scripts/kconfig/zconf.y
>> +++ b/scripts/kconfig/zconf.y
>> @@ -436,6 +436,12 @@ help: help_start T_HELPTEXT
>>               zconfprint("warning: '%s' defined with more than one help text -- only the last one will be used",
>>                          current_entry->sym->name ?: "<choice>");
>>       }
>> +
>> +     /* Is the help text empty or all whitespace? */
>> +     if ($2[strspn($2, " \f\n\r\t\v")] == '\0')
>> +             zconfprint("warning: '%s' defined with blank help text",
>> +                        current_entry->sym->name ?: "<choice>");
>> +
>
> Does this go to stderr?

Yep - goes to stderr. zconfprint() is the standard error reporting
function during parsing, and also prints the parsing location.

>
> Another fix would be to ignore empty help texts and not render them at all. Is
> that possible?

I haven't even checked how they are rendered to be honest. I was more
concerned with the Kconfig mess.

> Thanks,
>
>
> Paul Bolle

Cheers,
Ulf

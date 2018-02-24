Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbeBXPS1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 10:18:27 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30101 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeBXPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 10:18:25 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w1OFI7TU021835
X-Nifty-SrcIP: [209.85.213.53]
X-Google-Smtp-Source: AG47ELsGoyZ4IJUT6RvD7CTnhHQ4ahgqkzzFF/SxW7aYbsib6BZqjnqa4K88/X/Qw4d0BXuOVUrdeonMjGf0+IMdbhQ=
MIME-Version: 1.0
In-Reply-To: <20180221111447.ki7v66azmfgch5om@dell5510>
References: <1519114728-1084-1-git-send-email-yamada.masahiro@socionext.com> <20180221111447.ki7v66azmfgch5om@dell5510>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 25 Feb 2018 00:17:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7n2Qwvo83XGHNJLu1WeE8W8y2CZkSG=vsNKjYD0z_LQ@mail.gmail.com>
Message-ID: <CAK7LNAS7n2Qwvo83XGHNJLu1WeE8W8y2CZkSG=vsNKjYD0z_LQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: clean-up reverse dependency help implementation
To: Petr Vorel <petr.vorel@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Paul Bolle <pebolle@tiscali.nl>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-21 20:14 GMT+09:00 Petr Vorel <petr.vorel@gmail.com>:
> Hi Masahiro,
>
>> This commit splits out the special E_OR handling ('-' instead of '||')
>> into a dedicated helper expr_print_revdev().
>
>> Restore the original expr_print() prior to commit 1ccb27143360
>> ("kconfig: make "Selected by:" and "Implied by:" readable").
>
>> This makes sense because:
>
>>   - We need to chop those expressions only when printing the reverse
>>     dependency, and only when E_OR is encountered
>
>>   - Otherwise, it should be printed as before, so fall back to
>>     expr_print()
>
>> This also improves the behavior; for a single line, it was previously
>> displayed in the same line as "Selected by", like this:
>
>>   Selected by: A [=n] && B [=n]
>
>> This will be displayed in a new line, consistently:
>
>>   Selected by:
>>   - A [=n] && B [=n]
>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> ---
>
> <snip>
>
>>       get_symbol_props_str(r, sym, P_SELECT, _("  Selects: "));
>>       if (sym->rev_dep.expr) {
>> -             str_append(r, _("  Selected by: "));
>> +             str_append(r, _("  Selected by: \n"));
>                                        ^
> I'd remove unnecessary whitespace here ^.


I decided to not touch the text inside _( ... ) in this patch
although I do not think anybody translated "  Selected by: ".

I just moved str_append(r, "\n");

Anyway, this line will be removed soon.


Applied to linux-kbuild/kconfig.







>                 str_append(r, _("  Selected by:\n"));
>>               expr_gstr_print_revdep(sym->rev_dep.expr, r);
>> -             str_append(r, "\n");
>>       }
>
>>       get_symbol_props_str(r, sym, P_IMPLY, _("  Implies: "));
>>       if (sym->implied.expr) {
>> -             str_append(r, _("  Implied by: "));
>> +             str_append(r, _("  Implied by: \n"));
> The same here.
>
>>               expr_gstr_print_revdep(sym->implied.expr, r);
>> -             str_append(r, "\n");
>>       }
>
>>       str_append(r, "\n\n");
>
>
> Kind regards,
> Petr
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

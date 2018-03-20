Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeCTD6s (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 23:58:48 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:26525 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeCTD6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 23:58:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w2K3wRix022236
X-Nifty-SrcIP: [209.85.217.176]
X-Google-Smtp-Source: AG47ELtEmFGJgqSN0sRQZghSGDVH0o3EPGjOYgRmpG5iMZ1uUjxSwIIxKYjikxgXhcnNZi7WqQVVeRhugPqurf/u9Ww=
MIME-Version: 1.0
In-Reply-To: <20180318221737.GA25547@example.com>
References: <1520934968-30406-1-git-send-email-yamada.masahiro@socionext.com> <20180318221737.GA25547@example.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 20 Mar 2018 12:57:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNASu48Gbe0Ch6f1t235xA2Nhxdz3fN1-ht07xst636+mgg@mail.gmail.com>
Message-ID: <CAK7LNASu48Gbe0Ch6f1t235xA2Nhxdz3fN1-ht07xst636+mgg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kconfig: warn unmet direct dependency of tristate
 symbols selected by y
To: Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Petr Vorel <petr.vorel@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-19 7:17 GMT+09:00 Eugeniu Rosca <roscaeugeniu@gmail.com>:
> Hi Masahiro,
>
> On Tue, Mar 13, 2018 at 06:56:07PM +0900, Masahiro Yamada wrote:
>> Commit 246cf9c26bf1 ("kbuild: Warn on selecting symbols with unmet
>> direct dependencies") forcibly promoted ->dir_dep.tri to yes from mod.
>> So, the unmet direct dependencies of tristate symbols are not reported.
>>
>> [Test Case]
>>
>>   config MODULES
>>           def_bool y
>>           option modules
>>
>>   config A
>>           def_bool y
>>           select B
>>
>>   config B
>>           tristate "B"
>>           depends on m
>>
>> This causes unmet dependency because 'B' is forced 'y' ignoring
>> 'depends on m'.  This should be warned.
>>
>> On the other hand, the following case ('B' is bool) should not be
>> warned, so 'depends on m' for bool symbols should be naturally treated
>> as 'depends on y'.
>>
>> [Test Case2 (not unmet dependency)]
>>
>>   config MODULES
>>           def_bool y
>>           option modules
>>
>>   config A
>>           def_bool y
>>           select B
>>
>>   config B
>>           bool "B"
>>           depends on m
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v4:
>>   - newly added
>>
>>
>>  scripts/kconfig/symbol.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
>> index 0f7eba7..def860b 100644
>> --- a/scripts/kconfig/symbol.c
>> +++ b/scripts/kconfig/symbol.c
>> @@ -243,7 +243,7 @@ static void sym_calc_visibility(struct symbol *sym)
>>       tri = yes;
>>       if (sym->dir_dep.expr)
>>               tri = expr_calc_value(sym->dir_dep.expr);
>> -     if (tri == mod)
>> +     if (sym->type == S_BOOLEAN && tri == mod)
>
> This seems to be very close to one of the issues fixed in the old
> v2.6.5 commit 5a87d187fce1 ("[PATCH] config: choice fix") accessible at
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?h=5a87d187fce1
>
> IMHO you could probably use (not tested!):
> +       if (tri == mod && sym_get_type(sym) == S_BOOLEAN)
>
> instead of
> +       if (sym->type == S_BOOLEAN && tri == mod)
>
> to be consistent with the rest of sym_calc_visibility().


I tested it, and probably OK.

I will squash the diff.

Thanks.




> Also, since after this commit there will be a great amount of symmetry
> between how dirdep/revdep/weak-revdep are calculated inside
> sym_calc_visibility(), somebody could probably unify the implementations
> in future (not subject of this patch).
>
>>               tri = yes;
>>       if (sym->dir_dep.tri != tri) {
>>               sym->dir_dep.tri = tri;
>> @@ -414,7 +414,7 @@ void sym_calc_value(struct symbol *sym)
>>                               }
>>                       }
>>               calc_newval:
>> -                     if (sym->dir_dep.tri == no && sym->rev_dep.tri != no) {
>> +                     if (sym->dir_dep.tri < sym->rev_dep.tri) {
>
> Looks good.
>
>>                               struct expr *e;
>>                               e = expr_simplify_unmet_dep(sym->rev_dep.expr,
>>                                   sym->dir_dep.expr);
>> --
>> 2.7.4
>>
>
> Best regards,
> Eugeniu.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF8EC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD17216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MLDqOQrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD17216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeHOJS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:18:57 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:52137 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOJS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:18:57 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w7F6RsTW000827;
        Wed, 15 Aug 2018 15:27:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w7F6RsTW000827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534314475;
        bh=K80/BNiyU8YZTzXF/2TNrK7m5Vui/3ln8yp0ZUhZrVM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=MLDqOQrUMHXh5iDxnQC4Z8RFJkl8lwbJRa8AjFPkNplQHu3+iH7IECJzKa7VdKG4c
         dext3FybiBXDbpHexii8Awo/CV5ggB46nIZsIfHERWyKHWRK85wSQf/+ErFlH6J5Vz
         WqX0E9yo/FPaJLom4l64GyG5nnrY2N8m7RvbV5FYdIaHi4zZPi0ppGbLS7O6+Znl+X
         zK7G9tH+3tskHZQcUp/0uEFCSXgS5prdtElsDoX8p3lCeLMnP27W5I7wkzTUFJ6RcD
         +UZhYsuF3vtAROQjmW+XYoxvyDmXmAsTk5SQHxRLfYuyLjT9VgC+42qW52It43UYaZ
         /PAjNUWKngtBA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id h1-v6so220464uao.8;
        Tue, 14 Aug 2018 23:27:54 -0700 (PDT)
X-Gm-Message-State: AOUpUlFTGu4tH59gvOEQZy1PHyExR5R4h87szcyjnw/90PS/+OEwenZz
        QsJWwQ8OyCC6JVehJg13s51wuA/m3ZS8LMKsCLU=
X-Google-Smtp-Source: AA+uWPwHY84p1/nxhT5Gx3rzAGZ3zwW+LwC7lELFvOEU895pW8ESHsJ8UwXuQ1Mcqfm3Cl1VXJd0p5+XdNEqbj3McTQ=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr1089948ual.141.1534314473707;
 Tue, 14 Aug 2018 23:27:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 23:27:13
 -0700 (PDT)
In-Reply-To: <gh8t59utb2.fsf@lena.gouders.net>
References: <1534229021-8056-1-git-send-email-yamada.masahiro@socionext.com> <gh8t59utb2.fsf@lena.gouders.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 15 Aug 2018 15:27:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQBu47aB56wpK29Aixnw9vEDVc2V8zwstVBrusBwuz6Gg@mail.gmail.com>
Message-ID: <CAK7LNAQBu47aB56wpK29Aixnw9vEDVc2V8zwstVBrusBwuz6Gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: report recursive dependency involving 'imply'
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-14 19:38 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>
>> Currently, Kconfig does not report anything about the recursive
>> dependency where 'imply' keywords are involved.
>>
>> [Test Code]
>>
>>   config A
>>           bool "a"
>>
>>   config B
>>           bool "b"
>>           imply A
>>           depends on A
>
> Hello Masahiro,
>
> obviously, it is hard to find a reason why one wants to use dependencies
> like above but I also wonder how e.g. menuconfig handles this case:
>
> First, only "a" is visible, if I then select "a", "b" does not become
> visible but when I then reset "a" to "n", "b" becomes visible.  If I then
> try to select "b", it becomes invisible...
>
> Perhaps it would be better to just error out instead of giving users the
> impression, Kconfig thinks such questionable behavior is OK.


Taking closer look at the code, the intention is 'recursive dependency
is error',
but the behavior changed probably by an accident.

I fixed this:
https://patchwork.kernel.org/patch/10566301/

> Side note: perhaps, the documentation could be better when it comes to
>            recursive dependencies.  The documentation says "select" and
>            "imply" can be used to specify lower limits whereas direct
>            dependencies specify upper limits for symbol values and with
>            this in mind, one might wonder why it is a problem to work
>            with both limits in a recursive way.
>
>            Not very unlikely that it is just me who still has to
>            understand recursive dependencies or problems with reading
>            English text, though.


To avoid confusion, two things should be discussed separately:

[1] Unmet dependency
   This is caused by a conflict between the upper limit from 'depends on'
   and the lower limit from 'select'.

    This issue does not happen for 'imply' because the upper limit
    specified by 'imply' is weaker.


[2] Recursive depenency

   This can happen for any combination of 'depends on',
   'select', 'imply', 'if', 'default', etc.


> What definitely seems to get void with your patches is item c) in
> "Practical solutions to kconfig recursive issue" in
> Documentation/kbuild/kconfig-language:
>
>         c) Consider the use of "imply" instead of "select"


I do not know why commit 237e3ad0f195d8 added this line.


Actually, I was also confused.

I sent v2 based on your feedback.

Thanks.



> Dirk
>
>> In the code above, Kconfig cannot calculate the symbol values correctly
>> due to the circular dependency.  For example, allyesconfig followed by
>> syncconfig results in an odd behavior because CONFIG_B becomes visible
>> in syncconfig.
>>
>>   $ make allyesconfig
>>   scripts/kconfig/conf  --allyesconfig Kconfig
>>   #
>>   # configuration written to .config
>>   #
>>   $ cat .config
>>   #
>>   # Automatically generated file; DO NOT EDIT.
>>   # Main menu
>>   #
>>   CONFIG_A=y
>>   $ make syncconfig
>>   scripts/kconfig/conf  --syncconfig Kconfig
>>   *
>>   * Restart config...
>>   *
>>   *
>>   * Main menu
>>   *
>>   a (A) [Y/n/?] y
>>     b (B) [N/y/?] (NEW)
>>
>> To report this correctly, sym_check_expr_deps() should recurse to
>> not only sym->rev_dep.expr but also sym->implied.expr .
>>
>> At this moment, sym_check_print_recursive() cannot distinguish
>> 'select' and 'imply' since it does not know the precise context
>> where the recursive dependency is hit.  This will be solved by
>> the next commit.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  scripts/kconfig/symbol.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
>> index 4ec8b1f..7de7463a 100644
>> --- a/scripts/kconfig/symbol.c
>> +++ b/scripts/kconfig/symbol.c
>> @@ -1098,7 +1098,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
>>                               sym->name ? sym->name : "<choice>",
>>                               next_sym->name ? next_sym->name : "<choice>");
>>               } else {
>> -                     fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
>> +                     fprintf(stderr, "%s:%d:\tsymbol %s is selected or implied by %s\n",
>>                               prop->file->name, prop->lineno,
>>                               sym->name ? sym->name : "<choice>",
>>                               next_sym->name ? next_sym->name : "<choice>");
>> @@ -1161,8 +1161,13 @@ static struct symbol *sym_check_sym_deps(struct symbol *sym)
>>       if (sym2)
>>               goto out;
>>
>> +     sym2 = sym_check_expr_deps(sym->implied.expr);
>> +     if (sym2)
>> +             goto out;
>> +
>>       for (prop = sym->prop; prop; prop = prop->next) {
>> -             if (prop->type == P_CHOICE || prop->type == P_SELECT)
>> +             if (prop->type == P_CHOICE || prop->type == P_SELECT ||
>> +                 prop->type == P_IMPLY)
>>                       continue;
>>               stack.prop = prop;
>>               sym2 = sym_check_expr_deps(prop->visible.expr);



-- 
Best Regards
Masahiro Yamada

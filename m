Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B99C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E97215A5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="gic2eMkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E97215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeHOQJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:09:46 -0400
Received: from services.gouders.net ([141.101.32.176]:47101 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeHOQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:09:46 -0400
Received: from localhost ([193.175.198.193])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w7FDAliB021479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 15:10:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1534338648; bh=FHg4/y7xVD56OyVteRzwNlPakKdS1NgiTK8/xaG4iKk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=gic2eMkRWPY9DCruxIKqBPpkxW3eKJY2KsufGG9S0UnUCwY4N3lgi0fkHtXuHPN/q
         uXr65iEp4ik5l1eU3txjE6eskEEE/tJfunL7f/o4y20/FwLph0n8ZSkrcm/KJbWbU2
         UwRdX33/eNxy5R+DpKcCKMlflBSzY/Ptr8N4jaV0=
From:   Dirk Gouders <dirk@gouders.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kconfig: report recursive dependency involving 'imply'
In-Reply-To: <CAK7LNAQBu47aB56wpK29Aixnw9vEDVc2V8zwstVBrusBwuz6Gg@mail.gmail.com>
        (Masahiro Yamada's message of "Wed, 15 Aug 2018 15:27:13 +0900")
References: <1534229021-8056-1-git-send-email-yamada.masahiro@socionext.com>
        <gh8t59utb2.fsf@lena.gouders.net>
        <CAK7LNAQBu47aB56wpK29Aixnw9vEDVc2V8zwstVBrusBwuz6Gg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Wed, 15 Aug 2018 15:10:47 +0200
Message-ID: <ghh8jv22so.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> 2018-08-14 19:38 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>
>>> Currently, Kconfig does not report anything about the recursive
>>> dependency where 'imply' keywords are involved.
>>>
>>> [Test Code]
>>>
>>>   config A
>>>           bool "a"
>>>
>>>   config B
>>>           bool "b"
>>>           imply A
>>>           depends on A
>>
>> Hello Masahiro,
>>
>> obviously, it is hard to find a reason why one wants to use dependencies
>> like above but I also wonder how e.g. menuconfig handles this case:
>>
>> First, only "a" is visible, if I then select "a", "b" does not become
>> visible but when I then reset "a" to "n", "b" becomes visible.  If I then
>> try to select "b", it becomes invisible...
>>
>> Perhaps it would be better to just error out instead of giving users the
>> impression, Kconfig thinks such questionable behavior is OK.
>
>
> Taking closer look at the code, the intention is 'recursive dependency
> is error',
> but the behavior changed probably by an accident.
>
> I fixed this:
> https://patchwork.kernel.org/patch/10566301/
>
>> Side note: perhaps, the documentation could be better when it comes to
>>            recursive dependencies.  The documentation says "select" and
>>            "imply" can be used to specify lower limits whereas direct
>>            dependencies specify upper limits for symbol values and with
>>            this in mind, one might wonder why it is a problem to work
>>            with both limits in a recursive way.
>>
>>            Not very unlikely that it is just me who still has to
>>            understand recursive dependencies or problems with reading
>>            English text, though.
>
>
> To avoid confusion, two things should be discussed separately:
>
> [1] Unmet dependency
>    This is caused by a conflict between the upper limit from 'depends on'
>    and the lower limit from 'select'.
>
>     This issue does not happen for 'imply' because the upper limit
>     specified by 'imply' is weaker.
>
>
> [2] Recursive depenency
>
>    This can happen for any combination of 'depends on',
>    'select', 'imply', 'if', 'default', etc.

Yes, this is probably just a subject that I still have to get a deeper
understanding for, hence I am easyly confused when faced with
contradicting information.

>> What definitely seems to get void with your patches is item c) in
>> "Practical solutions to kconfig recursive issue" in
>> Documentation/kbuild/kconfig-language:
>>
>>         c) Consider the use of "imply" instead of "select"
>
>
> I do not know why commit 237e3ad0f195d8 added this line.
>
>
> Actually, I was also confused.
>
> I sent v2 based on your feedback.

Thanks for your responses, making that all more understandable.

Dirk

>
>
>> Dirk
>>
>>> In the code above, Kconfig cannot calculate the symbol values correctly
>>> due to the circular dependency.  For example, allyesconfig followed by
>>> syncconfig results in an odd behavior because CONFIG_B becomes visible
>>> in syncconfig.
>>>
>>>   $ make allyesconfig
>>>   scripts/kconfig/conf  --allyesconfig Kconfig
>>>   #
>>>   # configuration written to .config
>>>   #
>>>   $ cat .config
>>>   #
>>>   # Automatically generated file; DO NOT EDIT.
>>>   # Main menu
>>>   #
>>>   CONFIG_A=y
>>>   $ make syncconfig
>>>   scripts/kconfig/conf  --syncconfig Kconfig
>>>   *
>>>   * Restart config...
>>>   *
>>>   *
>>>   * Main menu
>>>   *
>>>   a (A) [Y/n/?] y
>>>     b (B) [N/y/?] (NEW)
>>>
>>> To report this correctly, sym_check_expr_deps() should recurse to
>>> not only sym->rev_dep.expr but also sym->implied.expr .
>>>
>>> At this moment, sym_check_print_recursive() cannot distinguish
>>> 'select' and 'imply' since it does not know the precise context
>>> where the recursive dependency is hit.  This will be solved by
>>> the next commit.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  scripts/kconfig/symbol.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
>>> index 4ec8b1f..7de7463a 100644
>>> --- a/scripts/kconfig/symbol.c
>>> +++ b/scripts/kconfig/symbol.c
>>> @@ -1098,7 +1098,7 @@ static void sym_check_print_recursive(struct symbol *last_sym)
>>>                               sym->name ? sym->name : "<choice>",
>>>                               next_sym->name ? next_sym->name : "<choice>");
>>>               } else {
>>> -                     fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
>>> +                     fprintf(stderr, "%s:%d:\tsymbol %s is selected or implied by %s\n",
>>>                               prop->file->name, prop->lineno,
>>>                               sym->name ? sym->name : "<choice>",
>>>                               next_sym->name ? next_sym->name : "<choice>");
>>> @@ -1161,8 +1161,13 @@ static struct symbol *sym_check_sym_deps(struct symbol *sym)
>>>       if (sym2)
>>>               goto out;
>>>
>>> +     sym2 = sym_check_expr_deps(sym->implied.expr);
>>> +     if (sym2)
>>> +             goto out;
>>> +
>>>       for (prop = sym->prop; prop; prop = prop->next) {
>>> -             if (prop->type == P_CHOICE || prop->type == P_SELECT)
>>> +             if (prop->type == P_CHOICE || prop->type == P_SELECT ||
>>> +                 prop->type == P_IMPLY)
>>>                       continue;
>>>               stack.prop = prop;
>>>               sym2 = sym_check_expr_deps(prop->visible.expr);

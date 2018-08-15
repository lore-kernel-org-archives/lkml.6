Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A81AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C55216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rGgpeY7g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C55216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeHOJVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 05:21:42 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:60764 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeHOJVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 05:21:41 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7F6UT1c028659;
        Wed, 15 Aug 2018 15:30:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7F6UT1c028659
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534314630;
        bh=8pq0qH632nrPaVUMHTY084BcG81AbGyw5nuPWKvz1fY=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rGgpeY7gy4OfP6D77V9TrwCG8jYputAHfcS97BQgRMzMyEYyLhEE7S15O3UqJiMfr
         3QPTMXEXbAnKhaAa+jRODEdE0s7HAmPJ2VX22ugd604/+Dq3X+7f7mUD17PqRRIg1t
         mFH4st3fr4Z6yiwmgTr11zQrdGEqAlyONETXFaCjrV0A6CziFEAjaxC4dqkn17TkBQ
         tfW9EuxfuIiFIYvBGiRxqc8kg/weGF80gbAD1369cBmubkX0uT0+vJU94JbVyMWeRs
         vB0RCxsVwxMnYxuYPVqc7EnksW5LjsRqcAobouQFEaSPwwYeHuvTF/2GEkJt74tWiu
         EmNkVjqPJ9Ahg==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id k25-v6so218076uao.11;
        Tue, 14 Aug 2018 23:30:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlHgQJRhbTebOfCyn0KIL/hPz+ZvWvWIEAijP9Ith2DthOTVEM0f
        QpwoKf9MQnwMohK9p6u2C+1DvQCmAJ2QkqUfJ+w=
X-Google-Smtp-Source: AA+uWPzWRxk4zCQnE6gNRy4sCpLMVmRclXLMmhMv+t4NVVedyB1ROi+GcPldn1XDQ3a15vLURCksg0NA2S5kQ/Tc/Os=
X-Received: by 2002:ab0:4705:: with SMTP id h5-v6mr16139507uac.140.1534314628822;
 Tue, 14 Aug 2018 23:30:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 23:29:48
 -0700 (PDT)
In-Reply-To: <gh4lfxukoo.fsf@lena.gouders.net>
References: <1534229021-8056-1-git-send-email-yamada.masahiro@socionext.com>
 <gh8t59utb2.fsf@lena.gouders.net> <gh4lfxukoo.fsf@lena.gouders.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 15 Aug 2018 15:29:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASjSXWYJpzkhqfMtVxTQO21Xwo2jXFLsBWLCGw5UTbWgg@mail.gmail.com>
Message-ID: <CAK7LNASjSXWYJpzkhqfMtVxTQO21Xwo2jXFLsBWLCGw5UTbWgg@mail.gmail.com>
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

2018-08-14 22:44 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
> Dirk Gouders <dirk@gouders.net> writes:
>
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
>>
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
>>
>> What definitely seems to get void with your patches is item c) in
>> "Practical solutions to kconfig recursive issue" in
>> Documentation/kbuild/kconfig-language:
>>
>>         c) Consider the use of "imply" instead of "select"
>
> Just some more information that adds to me feeling unsure about the
> correct definition of recursive dependencies:
>
> With commit 29c434f367ea (kconfig: tests: test if recursive dependencies
> are detected) a test case similar to the example above was introduced,
> explicitely stating it is _no_ recursive dependency:
>
> +# depends on and imply
> +# This is not recursive dependency
> +
> +config E1
> +       bool "E1"
> +       depends on E2
> +       imply E2
> +
> +config E2
> +       bool "E2"
>
>
> Dirk


For some reason, I added this
without thinking why.


I believe this should be recursive dependency.


Thanks.






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
>>>                              sym->name ? sym->name : "<choice>",
>>>                              next_sym->name ? next_sym->name : "<choice>");
>>>              } else {
>>> -                    fprintf(stderr, "%s:%d:\tsymbol %s is selected by %s\n",
>>> +                    fprintf(stderr, "%s:%d:\tsymbol %s is selected or implied by %s\n",
>>>                              prop->file->name, prop->lineno,
>>>                              sym->name ? sym->name : "<choice>",
>>>                              next_sym->name ? next_sym->name : "<choice>");
>>> @@ -1161,8 +1161,13 @@ static struct symbol *sym_check_sym_deps(struct symbol *sym)
>>>      if (sym2)
>>>              goto out;
>>>
>>> +    sym2 = sym_check_expr_deps(sym->implied.expr);
>>> +    if (sym2)
>>> +            goto out;
>>> +
>>>      for (prop = sym->prop; prop; prop = prop->next) {
>>> -            if (prop->type == P_CHOICE || prop->type == P_SELECT)
>>> +            if (prop->type == P_CHOICE || prop->type == P_SELECT ||
>>> +                prop->type == P_IMPLY)
>>>                      continue;
>>>              stack.prop = prop;
>>>              sym2 = sym_check_expr_deps(prop->visible.expr);



-- 
Best Regards
Masahiro Yamada

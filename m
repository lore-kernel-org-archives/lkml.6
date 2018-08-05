Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F107BC46471
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A194217BD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 09:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3lhsgd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A194217BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbeHELS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 07:18:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45646 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHELS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 07:18:29 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so6900205qkg.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 02:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DMBgAc0BBMC0jg9NAH1gjietP/z+Q42xR8U4qKp7TEc=;
        b=K3lhsgd5Jt9JEKaO6afeuDlIbJbw1iwqnA/jsZMtOi4q0CciFZlPM8vtniDpMETRVv
         9KZi6aaV8kciJ/F0IguefezifqBmQxuKpi41JcZcrXsgg9sOeonTlCBFL0nsMWN7GrOv
         sJIPF7F3O8X6jqq7oQ7xtac1vYuE1Ty7G6H3VNM8YPVDH3akATBywQmr/o7Fn8gvTIuj
         +pkyhh+qArYTszV+kNYcTsNimBeyueMrJuSp1BOVjeH/XtqQWt0ibUqX1zdHg672tBKK
         oqnf2fwkFOaNd1VOOc5Ixoi33hLWhyPx0I1tBp7iDAepAv9TfdgKoJDZOSIb9G0QC/NS
         NORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DMBgAc0BBMC0jg9NAH1gjietP/z+Q42xR8U4qKp7TEc=;
        b=IPmFWfdtHVxxgoGti/2TaZJ1rXyvwC95k/lotEHnELOLiAnpIUAWUm10WsdhlbnxsT
         yzPcKeDewc32wZn021r2vCgmlKPl2sF7idM+RBwXN6wcf035IgaVLP2wtDUD69HaTsDa
         vOgfIpUY18aNuNTseqOB6lFy/oo+iEiMLMCyxn4vLbrgPZk6yVIWWg7CLaTH7S5LgPL4
         8CXHCSRBeHhUFr08XbtoeuQBIhbb5MKAaiS8EECf2ABNnyDkyacqJZfTrqJsZc5t2jMa
         uDS8bmDyDoduleCdaz7nZVgewFGGYP/UTOu1OSZvp72yZZWY0J6hZLa6LHydDRsybcbz
         kiWA==
X-Gm-Message-State: AOUpUlHSfJPoYZhKQKmpZgRouYIST9O7sr+VYfv+G7ConNsuPOBWSPEr
        dKkjkeIrNHqf64YGwXEpTH34xBxd9klLPVdPm2k=
X-Google-Smtp-Source: AAOMgpfuf5m9BKzY5+SInKrxupgnAsCs7zrVzFDoPzrlk7DSICzjpcMbmDRoJ/5ANr/zx3fTMqw8YtOWPS9ak/lYW50=
X-Received: by 2002:a37:5942:: with SMTP id n63-v6mr9798808qkb.28.1533460476082;
 Sun, 05 Aug 2018 02:14:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 02:14:15 -0700 (PDT)
In-Reply-To: <3081c875c5c5854188288e80c4e1bf27651e1436.camel@perches.com>
References: <20180801175433.GA25298@gmail.com> <3081c875c5c5854188288e80c4e1bf27651e1436.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 5 Aug 2018 11:14:15 +0200
Message-ID: <CANiq72nyeu0ajnQPdpFch_5gdamCC2ManKZqFyb6VWar_QqjLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Support the nonstring variable attribute (gcc >= 8)
To:     Joe Perches <joe@perches.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Martin Sebor <msebor@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 3:38 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-08-01 at 19:54 +0200, Miguel Ojeda wrote:
>> From the GCC manual:
>>
>> The nonstring variable attribute specifies that an object or member
>> declaration with type array of char or pointer to char is intended to
>> store character arrays that do not necessarily contain a terminating NUL
>> character. This is useful in detecting uses of such arrays or pointers
>> with functions that expect NUL-terminated strings, and to avoid warnings
>> when such an array or pointer is used as an argument to a bounded string
>> manipulation function such as strncpy.
>>
>>   https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
>>
>> Some reports are already coming to the LKML regarding these
>> warnings. When they are false positives, like this one
>>
>>   https://lkml.org/lkml/2018/1/16/135
>>
>> we can use __nonstring to let gcc know a NUL character is not required.
>>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Martin Sebor <msebor@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>> ---
>> Re-sending this since a few months have passed, Martin has improved
>> GCC's feature and warnings are appearing in Geert's build bot.
>> Added an example in the second patch as requested by David.
>>
>>  include/linux/compiler-gcc.h   | 14 ++++++++++++++
>>  include/linux/compiler_types.h |  4 ++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index 573f5a7d42d4..fab4e904f1fe 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -343,6 +343,20 @@
>>  #define __designated_init __attribute__((designated_init))
>>  #endif
>>
>> +#if GCC_VERSION >= 80000
>> +/*
>> + * The nonstring variable attribute specifies that an object or member
>> + * declaration with type array of char or pointer to char is intended
>> + * to store character arrays that do not necessarily contain a terminating
>> + * NUL character. This is useful in detecting uses of such arrays or pointers
>> + * with functions that expect NUL-terminated strings, and to avoid warnings
>> + * when such an array or pointer is used as an argument to a bounded string
>> + * manipulation function such as strncpy.
>> + * https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
>> + */
>
> Please move this down to the already existing test
> for GCC_VERSION >= 80000 near the bottom of the
> file so that version number tests are always in
> increasing order in the file.

Ah, good catch! The test was added in the v1->v2 meantime. Will do, thanks!

By the way, the file is a mess... Some other tests go inside the big
"#if GCC_VERSION >= 40000", others go at the end. We should clean it
up and sort it. I might just do it...

Cheers,
Miguel

>
>> +#define __nonstring __attribute__((nonstring))
>> +#endif
>> +
>>  #endif       /* gcc version >= 40000 specific checks */
>>
>>  #if !defined(__noclone)
>> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
>> index a8ba6b04152c..9c07be36e86a 100644
>> --- a/include/linux/compiler_types.h
>> +++ b/include/linux/compiler_types.h
>> @@ -289,4 +289,8 @@ struct ftrace_likely_data {
>>  #define __diag_error(compiler, version, option, comment) \
>>       __diag_ ## compiler(version, error, option)
>>
>> +#ifndef __nonstring
>> +# define __nonstring
>> +#endif
>> +
>>  #endif /* __LINUX_COMPILER_TYPES_H */

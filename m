Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeEBQOn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:14:43 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:31346 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeEBQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:14:39 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w42GEH5S018552
X-Nifty-SrcIP: [209.85.213.52]
X-Google-Smtp-Source: AB8JxZook4qxcD0/Mz8+jpq/YsPF1mAjU0A49qa7inc6/8GZdmzvuL4y3aKG24ZYY52EPYb7OOyPKgOUnxnv+DlVbjg=
MIME-Version: 1.0
In-Reply-To: <CAAqcGHn+3HMC_tVsOsLB1Vycdv7SYZ=1SYc0Cg3Gx-Xe=sExMg@mail.gmail.com>
References: <20180423195055.26069-1-malat@debian.org> <CAAqcGHn+3HMC_tVsOsLB1Vycdv7SYZ=1SYc0Cg3Gx-Xe=sExMg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 May 2018 01:13:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbfOrqSb_n0q=q2-6JMAVfCfEzY4-ES3P-CL2y9UyUoA@mail.gmail.com>
Message-ID: <CAK7LNARbfOrqSb_n0q=q2-6JMAVfCfEzY4-ES3P-CL2y9UyUoA@mail.gmail.com>
Subject: Re: [PATCH] kbuild/debian: Use KBUILD_BUILD_* when set
To: Riku Voipio <riku.voipio@linaro.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-02 20:30 GMT+09:00 Riku Voipio <riku.voipio@linaro.org>:
> On 23 April 2018 at 22:50, Mathieu Malaterre <malat@debian.org> wrote:
>> Be nice to the user and check env vars KBUILD_BUILD_USER &
>> KBUILD_BUILD_HOST when those are set.
>
> mkdebian sets the maintainer address as "$name <$email>", but this
> patch only sets the email part. I also wonder about the precedence, I
> think KBUILD_* should be considered over the generic Debian variables.

How come?


If you see scripts/mkcompile_h,
KBUILD_BUILD_USER and KBUILD_BUILD_HOST are used
for overriding 'whoami' and 'hostname', respectively.

So, I think it is reasonable to put

  email=$KBUILD_BUILD_USER@$KBUILD_BUILD_HOST

over

  email=$(id -nu)@$(hostname -f 2>/dev/null || hostname)


But, it is questionable to put it even over $DEBEMAIL.



I think the intention of this patch is to support
another (a bit better) fallback in case DEBEMAIL is not set.



> Riku
>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  scripts/package/mkdebian | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
>> index 6adb3a16ba3b..05d58d3ae8a0 100755
>> --- a/scripts/package/mkdebian
>> +++ b/scripts/package/mkdebian
>> @@ -76,6 +76,8 @@ if [ -n "$DEBEMAIL" ]; then
>>         email=$DEBEMAIL
>>  elif [ -n "$EMAIL" ]; then
>>         email=$EMAIL
>> +elif [ -n "$KBUILD_BUILD_USER" ] && [ -n "$KBUILD_BUILD_HOST" ]; then
>> +       email=$KBUILD_BUILD_USER@$KBUILD_BUILD_HOST
>>  else
>>         email=$(id -nu)@$(hostname -f 2>/dev/null || hostname)
>>  fi
>> --
>> 2.11.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada

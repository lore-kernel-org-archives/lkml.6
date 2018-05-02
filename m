Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeEBT2C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:28:02 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43411 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeEBT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:27:59 -0400
X-Google-Smtp-Source: AB8JxZrUhJ7pISO1tAbqIHkI0c8ROTML/HT7LcOEsukl8jTzGiJKKriokaAU4LZFtD2RBZAfGEFFiEnBeD3lV6El96U=
MIME-Version: 1.0
In-Reply-To: <CAAqcGHn+3HMC_tVsOsLB1Vycdv7SYZ=1SYc0Cg3Gx-Xe=sExMg@mail.gmail.com>
References: <20180423195055.26069-1-malat@debian.org> <CAAqcGHn+3HMC_tVsOsLB1Vycdv7SYZ=1SYc0Cg3Gx-Xe=sExMg@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 2 May 2018 21:27:37 +0200
X-Google-Sender-Auth: 44VFr6oLNKeg3g5g1w1MElFzqtc
Message-ID: <CA+7wUswCFsW9Uf2i9gBkCffJO=yqgRORL0znBW50RojtdvRkew@mail.gmail.com>
Subject: Re: [PATCH] kbuild/debian: Use KBUILD_BUILD_* when set
To: Riku Voipio <riku.voipio@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 2, 2018 at 1:30 PM, Riku Voipio <riku.voipio@linaro.org> wrote:
> On 23 April 2018 at 22:50, Mathieu Malaterre <malat@debian.org> wrote:
>> Be nice to the user and check env vars KBUILD_BUILD_USER &
>> KBUILD_BUILD_HOST when those are set.
>
> mkdebian sets the maintainer address as "$name <$email>", but this
> patch only sets the email part. I also wonder about the precedence, I
> think KBUILD_* should be considered over the generic Debian variables.

I simply tried to re-use the KBUILD_* env vars whenever possible. This
did made sense, since:

$ dmesg|grep debian
                                                                  ~
[    0.000000] Linux version 4.14.0-0.bpo.3-amd64
(debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian
6.3.0-18)) #1 SMP Debian 4.14.13-1~bpo9+1 (2018-01-14)

and

$ apt-cache show linux-image-amd64| grep Main
                                                                  ~
Maintainer: Debian Kernel Team <debian-kernel@lists.debian.org>

I do not believe this should take precedence over DEBEMAIL.

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeEBTb7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 15:31:59 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40991 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeEBTbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 15:31:55 -0400
X-Google-Smtp-Source: AB8JxZpY2hgeliJOG9PMZGOcTTJJHGfnxl7pGsV08RPhmKlLdpZl9rxEDKLyh/sT4TwOUH15BWaJJeR+wnknCu55eBY=
MIME-Version: 1.0
In-Reply-To: <CA+7wUswCFsW9Uf2i9gBkCffJO=yqgRORL0znBW50RojtdvRkew@mail.gmail.com>
References: <20180423195055.26069-1-malat@debian.org> <CAAqcGHn+3HMC_tVsOsLB1Vycdv7SYZ=1SYc0Cg3Gx-Xe=sExMg@mail.gmail.com>
 <CA+7wUswCFsW9Uf2i9gBkCffJO=yqgRORL0znBW50RojtdvRkew@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 2 May 2018 21:31:33 +0200
X-Google-Sender-Auth: Q5j6Ipz8yMAkUvbOprfofa_S7BM
Message-ID: <CA+7wUsyNiOee5oxoPqU2HDWpfbCQZ-XUhWQjNb+rvFs5mGXsyA@mail.gmail.com>
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

On Wed, May 2, 2018 at 9:27 PM, Mathieu Malaterre <malat@debian.org> wrote:
> On Wed, May 2, 2018 at 1:30 PM, Riku Voipio <riku.voipio@linaro.org> wrote:
>> On 23 April 2018 at 22:50, Mathieu Malaterre <malat@debian.org> wrote:
>>> Be nice to the user and check env vars KBUILD_BUILD_USER &
>>> KBUILD_BUILD_HOST when those are set.
>>
>> mkdebian sets the maintainer address as "$name <$email>", but this
>> patch only sets the email part. I also wonder about the precedence, I
>> think KBUILD_* should be considered over the generic Debian variables.
>
> I simply tried to re-use the KBUILD_* env vars whenever possible. This
> did made sense, since:
>
> $ dmesg|grep debian
>                                                                   ~
> [    0.000000] Linux version 4.14.0-0.bpo.3-amd64
> (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian
> 6.3.0-18)) #1 SMP Debian 4.14.13-1~bpo9+1 (2018-01-14)
>
> and
>
> $ apt-cache show linux-image-amd64| grep Main
>                                                                   ~
> Maintainer: Debian Kernel Team <debian-kernel@lists.debian.org>
>
> I do not believe this should take precedence over DEBEMAIL.

It seems that the env var DEBEMAIL is now accepting a new syntax (at
least I was not aware of this syntax):

https://manpages.debian.org/unstable/devscripts/dch.1.en.html

[...]If the environment variable DEBEMAIL is set, this will be used
for the email address. If this variable has the form "name <email>",
then the maintainer name will also be taken from here[...]

I'll send a v2 that check DEBEMAIL does not contains '<>'.

>> Riku
>>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>>  scripts/package/mkdebian | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
>>> index 6adb3a16ba3b..05d58d3ae8a0 100755
>>> --- a/scripts/package/mkdebian
>>> +++ b/scripts/package/mkdebian
>>> @@ -76,6 +76,8 @@ if [ -n "$DEBEMAIL" ]; then
>>>         email=$DEBEMAIL
>>>  elif [ -n "$EMAIL" ]; then
>>>         email=$EMAIL
>>> +elif [ -n "$KBUILD_BUILD_USER" ] && [ -n "$KBUILD_BUILD_HOST" ]; then
>>> +       email=$KBUILD_BUILD_USER@$KBUILD_BUILD_HOST
>>>  else
>>>         email=$(id -nu)@$(hostname -f 2>/dev/null || hostname)
>>>  fi
>>> --
>>> 2.11.0
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

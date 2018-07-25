Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83127C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B3220671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EriKDrSM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QIsoyUxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B3220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbeGYUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:53:35 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:39937 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729836AbeGYUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:53:35 -0400
Received: by mail-yb0-f196.google.com with SMTP id y11-v6so3447849ybm.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s8iR1YNJ+sDOGvPnN2kr9+lQORIhLJWI/Wdhe7t2yaA=;
        b=EriKDrSMCuMG1FVCSKMBljlpB2ZNnMb7+ibbdn8m9WvL4RIHF67pw22SQSNLVvn4sI
         yfGUdODtvN0LJa9YtbWqmeSTnmrVBtAN7ngKBMiWjxQVY58GYZDvjwkF1U0jMb/88hhk
         sCBPJ7wCNKvhF8dfS5j7isvad0pk/dfYrPzpFYASZz0PpdP9oVz0swJuNx51DY0q/+Pp
         7eLSiTXnoJdHuS+EtMzYsZaWRpiEzFzEXeaFlMsXZPbCEs0By6Ncs1G9q4oVsXIqaYi1
         efvdZlyxB+T8K1VEqgMrbvxi/C/PLhjjB04rlGwE6xJfluAy9ItmEp4duV5QL21NbpRw
         fsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s8iR1YNJ+sDOGvPnN2kr9+lQORIhLJWI/Wdhe7t2yaA=;
        b=QIsoyUxqYQ68LbrM7jS7T3ZjYe7FNuaTFKTkgS/h/rwtJzvItR69w8Ia65hIZiyXFc
         fGeHCRKebGhOSf2JaNs3fjFEGH+SpzHDyTJEbKpwNnNe/CAEZW+nwxi8tDzQmauswDqi
         oZhN2+aZnl+qJoMjZK3IIAVrwl5kC1BQLUOOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=s8iR1YNJ+sDOGvPnN2kr9+lQORIhLJWI/Wdhe7t2yaA=;
        b=JuGjwPuDcCFfAhGmOp5bgoDjsYwV2FeyighWKbHuJXXODL+wx3bqFrkeYeKnwX1L/R
         jlel+28dgQwmlMZXiJ5VCyHo2gByDAIGqFF3lPpzY1GoggekfR6QDnfYPzIDNDO0nOjy
         Nj4MyvpShMDPjHkwZ5f1q8f4Yzn72Izu6Wuv+h31LixoRuFPNWZjAUtQkEw58SG1w8q5
         tCydJNus7/CwPTK3WoAq278gu9TiU4vQ/t6BBmZK4W1VYAiU1SBon2+t+R9fWj35nKu8
         2K/kmIomGzvs6anIjamPt7cktSjCmi92qpNHqJ4gXVt/a1McOvcAynTQDvMJ1zU7QQ3h
         7fvQ==
X-Gm-Message-State: AOUpUlGzqG+EiB7awz/PLa1GAXABv8pdhGl+DVN3SMAk0uh34QJxbEFU
        GAuZ9s/X32vWxY3JtFGtozpmgWQwt6mymLYnUFX/dw==
X-Google-Smtp-Source: AAOMgpeV3WYfJM/pvdL+j0p5kArPwWWmQ20DfHM7GF8VRfmomkX/oS1/yzPGDN/OG508zuVT7mxmHKqnZu10toUgWNM=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr12857885ybj.112.1532547627305;
 Wed, 25 Jul 2018 12:40:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 12:40:26
 -0700 (PDT)
In-Reply-To: <20180724092403.332125ff@mschwideX1>
References: <CA+55aFzMheDA-2z=MdGgJrz-REcrknb+4OEvRKaJipm+x6xEhw@mail.gmail.com>
 <20180723204617.GA14487@roeck-us.net> <CA+55aFyuaEGGksOxv3aAp0THYkAapap-JY65A0A81S0qUE0S+g@mail.gmail.com>
 <20180723212330.GA7441@roeck-us.net> <CA+55aFw3tRe70mUgV70oi6xBwSLx0h_supRGoNUHgrcSGxUgeg@mail.gmail.com>
 <20180724081845.1cc4c9d8@mschwideX1> <25151348-ce12-f754-876c-8b39b23d16a1@de.ibm.com>
 <20180724092403.332125ff@mschwideX1>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 25 Jul 2018 12:40:26 -0700
X-Google-Sender-Auth: -Zzhxz-cHyBqFbtZiua5wiFE5EU
Message-ID: <CAGXu5jJKFoCHvFxT-kc-O=fCUa3CKrErXUspxMfGNTAHAithOw@mail.gmail.com>
Subject: Re: Linux 4.18-rc6
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 12:24 AM, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 24 Jul 2018 09:15:58 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> On 07/24/2018 08:18 AM, Martin Schwidefsky wrote:
>> > On Mon, 23 Jul 2018 16:17:22 -0700
>> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> >
>> >> On Mon, Jul 23, 2018 at 2:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> >>>
>> >>>>
>> >>>> Martin - can we just remove the
>> >>>>
>> >>>>          select HAVE_GCC_PLUGINS
>> >>>>
>> >>>> from the s390 Kconfig file (or perhaps add "if BROKEN" or something to
>> >>>> disable it).
>> >>>>
>> >>>> Because if it's not getting fixed, it shouldn't be exposed.
>> >>>>
>> >>> The problem only affects 4.18 - the code has been rearranged in -next.
>> >>> Only, in my builders, I can't disable a flag for individual releases,
>> >>> so I just disabled it completely for s390.
>> >>
>> >> Well, I'm not going to release a 4.18 with a known problem, so in 4.18
>> >> this *will* be disabled if it's not fixed.
>> >>
>> >> The fact that it might be fixed in linux-next is entirely immaterial
>> >> to the release of 4.18.
>> >
>> > Ok, if gcc with the plugins and an allmodconfig is considered to be
>> > important enough to warrant a fix, it can be pulled from here:
>> >
>> > git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus
>> >
>> > Martin Schwidefsky (1):
>> >       s390: disable gcc plugins
>> >
>> > Once that is in I will create another patch to undo this one and place
>> > it after the early boot rework.
>>
>> On the list a different fix was proposed about 2 weeks ago,

https://lkml.kernel.org/r/CAGXu5jKyESyPD1MyM7BrVFPKDY9+HqRCpXcKG5ikCZwdGZLaSw@mail.gmail.com

>>
>> something like
>>
>> CFLAGS_als.o += $(DISABLE_LATENT_ENTROPY_PLUGIN)
>>
>> and I prefer that. Because your patch disables all gcc plugins.
>
> This change would cause trouble with patch dependencies as als.c is moved
> to a different directory. I would prefer to disable all gcc plugins for
> 4.18.

I don't understand why not just add it to the Makefile. For -next and
4.19, just drop the line again once you merge with 4.18? A CFLAGS_*.o
entry for a file that doesn't exist should be harmless...

Of course, if no one is actually using the gcc plugins on s390, then
okay, disabling them isn't a problem. :) But since it's been working
on s390 since 4.15, it seems weird to turn all of them off just for
4.18 when a trivial fix is available.

-Kees

-- 
Kees Cook
Pixel Security

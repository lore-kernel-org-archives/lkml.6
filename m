Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFABECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95CF21522
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCd44vD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95CF21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeITFhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:37:21 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32923 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeITFhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:37:21 -0400
Received: by mail-qt0-f193.google.com with SMTP id r37-v6so6898670qtc.0;
        Wed, 19 Sep 2018 16:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dj76hEpDBXXw41ekyCutyqXDS5jFPbo9UUQDF0r75Tw=;
        b=sCd44vD/naqV0HWpe91I5yW9p8BYAJBpFXPRkxPXKPofbEPJZWYCW7xEZUSpJviTTQ
         gh95RO7rv/WGI9zAq7+ORFmWT/fPHXs+kYN9gg1dYCQgRN5RHzQ0litqNTDSmORVVqEK
         g93keeSky1wNiOSqxBbHO105leElDdzMXvCV5wqBOu0V5Q9mCDHCH4gektpm+mt5ag/A
         KMFOKbJOOuVcQ9gv+7jBI7zONHoQpVn61fY86OzEmjalhjTYabR4qxyB1dQ1nnko+5De
         zjiODeeQpPit0Nwiu3v9feL2E5g4muzZKWMHg6hliZqw5RzDyK5urrtWv1Z1VmS9J/8n
         zm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dj76hEpDBXXw41ekyCutyqXDS5jFPbo9UUQDF0r75Tw=;
        b=iK/7Qg3xYwm+ZBbE7n9cwfaj0STNbRnE8DOkhY8gb8G50mBb1/BOdvMQ1rBdmiK4Y9
         0U8SjixRPhxHJ29Jjxdw739mbgMALZ0Be3FcBoI1XvcgYcCB+ASAfwIFdZxlXhCWUhew
         wR/KIjIXGxn1/IuFsoYzUjtY59JBxBVDvS7HXgAC6yp0zVoPu6vrQJxjIm/1Z6Ik1Joq
         7Ts0iALRlpZV7FiCqzCggK4CicuRS0ICKJf7LnysMwEggMfMk3n6gC9JFUzz1ONJBT7t
         5ErLNaaImELzJjf4S1/AitHd2rUUbynoQuBh5GCLVE8BZCjyB3F6EIT3upFTRWG1sFl2
         avtg==
X-Gm-Message-State: APzg51Dt+UIqZ1T1sn614+MgI1adMwv6R49PpF/7li0Kyp1v02gDdmxX
        dsxdPGZR9VgPL/qZdF+I0PoffO5J9nDKyXbeGzU=
X-Google-Smtp-Source: ANB0Vdb2/HpOF+OgClA7zwTfQD7QN+G0fB94F2G8FSUxishT9TsRnEKeTwa57g527q5onjTEHNL20ne3v1vjByO+bA4=
X-Received: by 2002:aed:2523:: with SMTP id v32-v6mr26961020qtc.107.1537401419001;
 Wed, 19 Sep 2018 16:56:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:6741:0:0:0:0:0 with HTTP; Wed, 19 Sep 2018 16:56:38
 -0700 (PDT)
In-Reply-To: <20180919230504.GA20280@nautica>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com> <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
 <20180919211458.GA8757@kroah.com> <20180919230504.GA20280@nautica>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Sep 2018 01:56:38 +0200
Message-ID: <CANiq72=C==Us7YjkzwVW7QHXnuGxHTowriYjX3Wsff19JO=uHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominique,

On Thu, Sep 20, 2018 at 1:05 AM, Dominique Martinet
<asmadeus@codewreck.org> wrote:
> Greg Kroah-Hartman wrote on Wed, Sep 19, 2018:
>> > > So, with this applied, does clang really build an arm32 kernel
>> > > successfully?  No other problem at all?  And this isn't really a
>> > > regression, arm32 never really worked with clang yet, right?
>> >
>> > To recap a bit: these two patches come from the "Compiler Attributes"
>> > series which is meant as a general improvement.
>>
>> Ok, so that's not for regressions, that's fine.
>
> I've not followed so closely, in particular I'm not sure if it's the
> only problem with arm32 right now, but that is a regression - the
> general serie is meant as an improvement, but these two patches fix
> 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually
> exclusive") which was taken in 4.19-rc1
>
> (Miguel, perhaps a Fixes: tag might help remember that?)

The commit is mentioned in the commit message, although not with the
Fixes: syntax -- is something now automatically parsing that? I guess
it is also easier for humans to parse :)

>
>> If these do not fix a regression, I don't see how they would be ready
>> for 4.19-final.
>
> So the rest of the series is not a regression and isn't ready for
> 4.19-final, these two would be, but only got tested by the handful of
> people in Cc here ; so ultimately it's your call.
>

To further clarify about the series: it is probably fine for 4.19 with
the latest tests/reviews we did (v4), but it is too late for such a
change in the cycle (and due to this I am taking the chance to merge
the nonstring series into the Compiler Attributes one).

>
>> > I am going to send a v5 of the entire series without these two
>> > patches, based on -rc4 (or -next, which one do you prefer? I would say
>> > these patches should be applied early in the -next branches, so that
>> > everyone is ready for the change, given it "touches" every translation
>> > unit).
>>
>> That's up to whomever takes these into their tree for linux-next
>> inclusion.  If you are about to break everything, then you might
>> consider changing your patches so they do not do that :)
>
> I think that was more or less his question, there is no maintainer for
> these files, so who should that whomever be? :)
> The thing is linux took this kind of patch directly last time, but
> ideally it really should sink in -next for a bit...

Yeah, Linus is (was...) aware of it, so initially I thought Linus
would pick this whenever he felt it was ready.

>
> (If no-one in Cc has anything included in -next I could take them in my
> 9p branch, but that is quite a bit out of scope from what I advertised
> this branch as so I think it would be confusing ; I think it might
> almost be best if Miguel will keep maintaining these in the future to do
> his own request to inclusion in -next?)

I can ask for my auxdisplay tree (or better, a new one) to be in -next
and use that (are non-kernel.org trees allowed to be in -next, by the
way?).

Cheers,
Miguel

Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97856C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A520664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iEJqGGt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1A520664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeJ2Fyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:54:41 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43713 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeJ2Fyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:54:40 -0400
Received: by mail-lf1-f52.google.com with SMTP id u18so4526653lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXb5G/RY5MufxffJiNp75G4gaa/Z/ahrjBbw6+KiKkk=;
        b=iEJqGGt9SYM7myVsOQ8NbLVzgrZn+9pYM9mvnScqZ8sPaubRO/yNoQvwqJNRwJbKFF
         ITWesccUe3HbJytXgIaP1bjo0FIQU1b8VTRgthSYZRWsz60Mhabi9hcwdFNVKejH0uvE
         OtFkISmoXklpDWmtNVKumYk9Xtwy2yHGVTsiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXb5G/RY5MufxffJiNp75G4gaa/Z/ahrjBbw6+KiKkk=;
        b=eKrpQG1o2PqODTr8mBgPRBtNtbqOUP1aluU99zR2zcSHQ/jlplzlNDdpedvxRJS+/e
         4dIaX0qd0k8twT+AwsfLgTiZgNUaYV10YxL3Tqh8tSeXOFInwAUvcedXB0P8pAhrMtvW
         XSUjGQO/Vm3wY0DwAwRuhtcspKatMAzmOvqcnYMgR1NH6YAGo7UJ3fFV9cT3mEumgb9a
         4Dc3PgLYcfrHlUT5AxXVDOg1XhpKEa5uReWKnbDaVaE+PB/2Cvy3PSm4ZGdqb5Q5tqkB
         9fuN7pRku7LfjP5yYryAyvSRH+5tui6EgkeoaecYwDuBRutCU4qHEINL0mHq0b6zbBJM
         JtIw==
X-Gm-Message-State: AGRZ1gIGiPi2d0u1rJOMOzj6rR2FQLQZFPBNf+2qDC1wqIUigUqTHcG9
        55Q1GnPpIGI2J0ypm8/9xC/odE83iKplMQ==
X-Google-Smtp-Source: AJdET5fMOXOq3sjxJEqTy4iwuCbmTbzBTrckWrjCEWzVCXo89JeiplgqJxmmfbbsgP2gWbnT8v83OA==
X-Received: by 2002:a19:7d55:: with SMTP id y82-v6mr6557453lfc.29.1540760928893;
        Sun, 28 Oct 2018 14:08:48 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y10-v6sm2969225lje.30.2018.10.28.14.08.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 14:08:48 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c4-v6so5855851lja.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 14:08:47 -0700 (PDT)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr1690219lji.133.1540760927078;
 Sun, 28 Oct 2018 14:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 14:08:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjisf8Bmgbtf3y0W+Lu58t3nSnvKGc0J=Zo=rmz3eA+Cw@mail.gmail.com>
Message-ID: <CAHk-=wjisf8Bmgbtf3y0W+Lu58t3nSnvKGc0J=Zo=rmz3eA+Cw@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     Harry Cutts <hcutts@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Cc:     linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 12:13 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So the recent change to enable the high-res scrolling really seems a
> bit *too* extreme.
>
> Is there some middle ground that turns the mouse from "look at it
> sideways and it starts scrolling" to something slightly more
> reasonable?

Actually, I think the bug may be in the generic HID high-resolution
scrolling code, and I only notice because the Logitech support means
that now I see it.

In particular, if you look at hid_scroll_counter_handle_scroll(),
you'll notice that it tries to turn a high-res scroll event into a
regular wheel event by using the resolution_multiplier.

But that code looks really broken. It tries to react to a "half
multiplier" thing:

        int threshold = counter->resolution_multiplier / 2;
   ..
        counter->remainder += hi_res_value;
        if (abs(counter->remainder) >= threshold) {

and that's absolutely and entirely wrong.

Imagine that the high-res wheel counter has just moved a bit up (by
one high-res) tick, so now it's at the half-way mark to the
resolution_multiplier, and we scroll up by one:

                low_res_scroll_amount =
                        counter->remainder / counter->resolution_multiplier
                        + (hi_res_value > 0 ? 1 : -1);
                input_report_rel(counter->dev, REL_WHEEL,
                                 low_res_scroll_amount);

and then correct for it:

                counter->remainder -=
                        low_res_scroll_amount * counter->resolution_multiplier;

now we went from "half resolution multiplier positive" to "half negative".

Which means that next time that the high-res event happens by even
just one high-resolution tick in the other direction, we'll now
generate a low-resolution scroll event in the other direction.

In other words, that function results in unstable behavior. Tiny tiny
movements back-and-forth in the high-res wheel events (which could be
just because either the sensor is unstable, or the wheel is wiggling
imperceptibly) can result in visible movement in the low-res
("regular") wheel reporting.

There is no "damping" function, in other words. Noise in the high
resolution reading can result in noise in the regular wheel reporting.

So that threshold handling needs to be fixed, I feel. Either get rid
of it entirely (you need to scroll a *full* resolution_multiplier to
get a regular wheel event), or the counter->remainder needs to be
*cleared* when a wheel event has been sent so that you don't get into
the whole "back-and-forth" mode.

Or some other damping model. I suspect there are people who have
researched what the right answer is, but I guarantee that the current
code is not the right answer.

I suspect this also explains why I *sometimes* see that "just moving
the mouse sends wheel events", and at other times don't. It needs to
get close to that "half a resolution multiplier" stage to get into the
bad cases, but then tiny tiny perturbations can cause unstable
behavior.

I can't be the only person seeing this, but I guess the Logitech mouse
is right now the only one that uses the new generic HID code, and I
guess not a lot of people have been *using* it.

Harry?

                 Linus

Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995CEC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600092080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DT0/tgxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600092080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbeJaBXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:23:46 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:45303 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeJaBXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:23:46 -0400
Received: by mail-lj1-f173.google.com with SMTP id j4-v6so11981210ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YPbRD6dB6SS1s+PycvtXLp86UTXWfULbQSXKkPNVAc=;
        b=DT0/tgxjAefK90JsmOG+bomtQpNvni1vG9A4E5OXM4vYr9SLdaMn2YEunWye3YNpbW
         3vloNm5LoRFbfMCekIA+owZV6yVb0pL5lTummZJtq6rMQDCyIbLpdERQKjcoty0FcqX0
         xvdUNrmRYiJ5ysfXijjw4CPszyEnJCJJ0vWn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YPbRD6dB6SS1s+PycvtXLp86UTXWfULbQSXKkPNVAc=;
        b=njqNc55zzTwyhlhDczk5r+ez6yGnRnaBCdNnYfZaRrEoxtNRm3uiysYS0JANtMBRR8
         A85pJrUm36GG1TIjH7IEk9nv/afG/jWxsHVMfn1Yd3XXv0h/A40XQLNz9EcRYXd/iwbu
         Lwk3dKDHbTdE0aDwDlBHP/j6DTRYJw4gKStC1imw+KTW87aWtCSf2UdKnnpUvNL7LNG4
         5SL94aWioI3sznjHv43PCg8K1eHIAY5EmpCrOaCxI26GFJ+sjvbmuw89Idvt/Z9dP4QU
         S0eSJ/2FWDna/XtgJRyTqYJq15GbO4VnvoL8nuMJ8BCdzCnkjF7mAWgp7JyvMofnDKkL
         xj5w==
X-Gm-Message-State: AGRZ1gJfFgMDTD90pXz2JGDoZ26msO2ZW4lmZzVk3B/BSuyzYllYJzBA
        4j6RdnQ1b9EsSY/AvqELlRC0Igf+M8biMQ==
X-Google-Smtp-Source: AJdET5e2OnXMAWZmXndkvQN/MkN6jFBF25yqndE9ZVA/cL9yLrqG2TPNcfd+/VtdBrwivKM2LuvhSA==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr13250815ljb.51.1540916974033;
        Tue, 30 Oct 2018 09:29:34 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u65sm1430964lff.54.2018.10.30.09.29.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 09:29:33 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id x3-v6so11982704lji.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:29:32 -0700 (PDT)
X-Received: by 2002:a2e:9f42:: with SMTP id v2-v6mr8175576ljk.80.1540916972013;
 Tue, 30 Oct 2018 09:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com>
 <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
 <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
 <CA+jURcvAQWP-fMLxNBF=PZ7moJZgorjO0SGXn8xSWKt=k+oe1w@mail.gmail.com> <20181030062657.GA5380@jelly>
In-Reply-To: <20181030062657.GA5380@jelly>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Oct 2018 09:29:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
Message-ID: <CAHk-=wg5m-zt0Kc0o1mOaZSKUsWbjud9xjZssoHAth=ZxoAhQg@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Harry Cutts <hcutts@chromium.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:27 PM Peter Hutterer
<peter.hutterer@who-t.net> wrote:
>
> Other issues I found with an MX Anywhere 2S is that on slow scroll and in
> ratchet mode we get some scroll jitter.  In ratchet mode  we can get this
> sequence if you scroll just past the notch and it snaps back:
>     [1, 1, 1, 1, 1, 1, 1, 1, -1]
> That's quite easy to trigger. In free-wheel mode we may get the same for
> slow motion due to human finger jitter (the Anywhere 2S didn't have HW
> jitter, but other devices may). So a perceived-consistent scroll motion may
> really look like this:
>     [1, 1, 1, 1, 1, -1, 1, 1]
> Hard to triggger but when it does, it feels like we're dropping events.
> The former isn't that much of an issue as long as the ratchet is enabled so
> you get the haptic feedback and we (usually) don't drop events.

Both of these actually argue that doing the reset on direction change
can be a real problem.

But equally clearly, _not_ doing the reset is unacceptable too.

I wonder if there's some docs on what Logitech does internally in the
mouse. It might involve a timeout (ie "if not moving for a while, do
the rounding _and_ reset), which would probably be too expensive to do
on the host side.

                    Linus

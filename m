Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34506C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2842082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GIgmNpCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2842082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbeJ3Gvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:51:36 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42983 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeJ3Gvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:51:36 -0400
Received: by mail-lj1-f179.google.com with SMTP id f3-v6so9386796ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xb00rV8W5FboYyxLcRQFquUw2L0pvaQJwpwyOnz6bVE=;
        b=GIgmNpCzsKOFMI9dAcZdxuxAcgsB9M7YYVv38+dS7zKb9yDp2HmJzui8+jzVuaEx+K
         FQPHRIwNSd2uvTjy4ZfD/TipOU3f77oi4sltR4jxPUv+t5DjhaW4APxyoTYp4zFCPF5w
         wEsoUHsuftiHmdjVqFzFQGAFec+9kjWOi1M+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xb00rV8W5FboYyxLcRQFquUw2L0pvaQJwpwyOnz6bVE=;
        b=bd2v+avj0q9SRzpsmnJuH4i2/Sn5vinCKl3uV+SCdBxeKfXYIdnFr9SQ6fYiIW4ROc
         8+2WoNNJdoai7f843rWr7Erf5AoLZIWeJvICDLupHmWnL9HXYai17bkysv3AhwUEebL2
         NH1Ih4QsLZIw9/BvZ6FKjecE/YKH3lYOgWCIrX1eeI/TtBF2J7JHkSrrA5wjqFW6NXeE
         s17fqEO14m6amajQSDRJlFuJbBzlmbDHcbG+NvjqmxRTDnXK2hZZ/og5Xz1yAI9OLKoQ
         6FKDXgxSoxQ2P2+bpTiwsJ0r6ZN9pUhpPHpP/xDvNEDbwsz7NBNYFmb5Hi5Wy218n7Xt
         wKRQ==
X-Gm-Message-State: AGRZ1gJLs5UwVxx+5sLM8EMIrQknK1j2ifL+vwJGSGBFmIdLwnnjdz6D
        6F3mu/CWDGNNdACh7b4vVoF852umyBhXAA==
X-Google-Smtp-Source: AJdET5e/bSIICG4JrQvtwwqwfhca+hmN19Ehl8Ys1SdsioxI6zhVOSertDCZK/E/8uXDyCzFWlptNA==
X-Received: by 2002:a2e:9355:: with SMTP id m21-v6mr10369409ljh.135.1540850458194;
        Mon, 29 Oct 2018 15:00:58 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t144sm538730lff.53.2018.10.29.15.00.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 15:00:57 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id f3-v6so9386688ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:00:56 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr10688502ljh.118.1540850456067;
 Mon, 29 Oct 2018 15:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjGKhoVaa60i5XZODEtzTUYVV3fouyYL4k=JsPY4K_xjQ@mail.gmail.com>
 <nycvar.YFH.7.76.1810291415570.23511@cbobk.fhfr.pm> <CAHk-=wgwgmcqxChVXQb66itd__qJOBc7LBsJ+nRAM86qJH-S2Q@mail.gmail.com>
 <CAHk-=wiRjotiAcy-=Jv5bMM2-r7KzWRGd84CwGmq1FLb1dWKcA@mail.gmail.com>
 <CA+jURcttJs05DFCuKCyOfe3oA9Q_KoiP3+g8-OVu4OPm9ufp6Q@mail.gmail.com>
 <CAHk-=wh3VO9hD9hUBS-H2d4jjGuYuVTudshHsPe9p-5sYhFfGg@mail.gmail.com> <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
In-Reply-To: <CA+jURcvVAJbwazWBByh=GTEV-wC75mZA0oaiX0x4_89F_byM6A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Oct 2018 15:00:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
Message-ID: <CAHk-=wihpgjONY2iw5mO9gHcQHxRyj+aQcaX2qd9Tjf-MdGNZg@mail.gmail.com>
Subject: Re: Logitech high-resolution scrolling..
To:     Harry Cutts <hcutts@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 2:42 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Ah, I see what you mean. So, if we move the threshold to (multiplier -
> 1)/multiplier (7/8) in this case, I think the equivalent scenario
> would be:

That would work, yes.

Except I think you *do* want the "reset on direction change" logic,
because otherwise we still end up having the:

> - we update remainder to -1

where it now gets easier to next time go the wrong way, for no good
reason.  So now you only need another 6/8ths the other way to get to
within 7/8ths of -8 and scroll back.

In other words, the whole "round partial scrolling" also causes that
whole "now the other direction is closer" issue.

At 7/8's it is less obviously a problem than it was at 1/2, but I
still think it's a sign of an unstable algorithm, where changes get
triggered too easily in the non-highres world.

Also, honestly, I'm not sure I see the point. *IF* you actually scroll
more in one direction, it doesn't matter one whit whether you pick
1/2, 7/8, or whole multipliers: the *next* step is still always going
to be one whole multiplier away.

So I think the whole rounding is actually misguided. I think it may
come from the very fact that you did *not* reset the remainder on
direction changes, so you could scroll in one direction to -3, and
then you change direction and go a "whole" tick the other way, but now
it's just at +5, so you think you need to round up.

With the whole "reset when changing direction", I don't think the
rounding is necessary, and I don't think it makes sense.

But I'm willing to test patches. I would suggest looking at the "oops,
direction changed" issue, though, because it really was very annoying.

> I tested these changes with 5 different Logitech mice (see the
> Logitech high-res support patch [0] for details), and did so mainly
> with applications that were *not* high-res aware, using a mix of
> clicky and smooth modes. Admittedly the MX Anywhere 2S was not one of
> my test devices; I had assumed that its behaviour would be
> sufficiently similar to that of the MX Anywhere 2 and the MX Master
> 2S.

I happen to have a MX Master 2S too, but I don't use it because I find
I like the smaller and lightweight "anywhere" mice.

I didn't try the broken case with it, but one thing I notice with the
Master 2S is that it seems to have a "heftier" feel to its wheel. It
may simply have more mass and not be as flighty, and thus show the
issue less.

But that's just a theory. It could just be something that is
individual to some mice.

                       Linus

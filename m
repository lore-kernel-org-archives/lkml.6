Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F9EC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A46266F3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A46266F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933897AbeFZKGa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:06:30 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39475 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbeFZKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:06:28 -0400
Received: by mail-vk0-f65.google.com with SMTP id n81-v6so3593407vke.6;
        Tue, 26 Jun 2018 03:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAqWdQHK6W7gcDcEF5Z5Waq9qnAC/zhNSM+nisi6ADM=;
        b=g0q3HX2Y/ZB75XXgm7DDGKJSE7FOmGk9eBkeg4zs3u/rzeLxZLbph2ZFtOjX5q+J1j
         CXpeB+3tiBrUlTND3371588qkyaltUep0uBmdV8gieK3aymikqkst3jXuB/zZq8P0cXZ
         XSP7elv+jgx6Xi0JOv0WisSNv+IUWXjRvtGShFb0gjkV9wdHfvJbOHorsl7HFup3IajK
         /l7wUqbrGLj1M8LiRotsPfGf01qB8gryywOHsODgRUBcu3o8YVe4Ud+6DbtVlZ6lZ+1O
         j6m2RZZeiyNpfCd0eB5OyaiEpMcSvfWon0pB6/k083Hx4G4DYwj9xE0M570SAz88CSx0
         8Wow==
X-Gm-Message-State: APt69E0WIPCUjeJYTGZc8VtnuBKpA8qkgj0nJMxeVvuQS30D+HCekGb5
        yHQc/4JVfFj4eiUki4KpXhQ/rTe0nzU67r75LuiIv08E
X-Google-Smtp-Source: AAOMgpfUGKayhxGINvD/gGgZQZpzovRTwxLUHcvksPeG7sGPRJ2gPcHia2uGFudp3S3wVT5UwaaEtPcUidwVXaC17SA=
X-Received: by 2002:a1f:2c0d:: with SMTP id s13-v6mr470255vks.106.1530007587939;
 Tue, 26 Jun 2018 03:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan> <20180620103558.GA6242@sirena.org.uk>
 <CAJZ5v0ju3F7qWxMUDuCyWBzFQGyrmxVo90yytFbKnCmENvRuew@mail.gmail.com> <20180620132507.GE6242@sirena.org.uk>
In-Reply-To: <20180620132507.GE6242@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jun 2018 12:06:16 +0200
Message-ID: <CAMuHMdXYL+=mBOofUqQ06Ld4zUF7BWqt+S2dFTw6AEAPuDsZPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:25 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 02:15:38PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 20, 2018 at 12:35 PM, Mark Brown <broonie@kernel.org> wrote:
>
> > > The flip side of that is that either suspend and resume or poweroff are
> > > broken for userspace unless they know about this magic sysfs file which
> > > isn't great either.
>
> > But to me that isn't that much different from an RTC wake alarm, say.
>
> > Enabling it to wake up the system in general isn't sufficient, you
> > also need to actually set the alarm using a different interface.

The RTC wake alarm time is indeed different, as it is not a simple boolean flag.
It is also more natural for the user, who expects to need to find some way to
configure the wake-up time.

> It seems more like hardware breakage we're trying to fix than a feature
> - it's not like it's adding something we didn't have already (like
> setting a time in an alarm where the alarm is an additional thing), more
> just trying to execute on an existing user interface successfully.  I
> can see that there's a case that it doesn't map very well onto the
> standard interfaces so perhaps we have to add something on the side as
> the hardware is just too horrible to fit in with the standard interfaces
> and we have to do that.

My main worry is usability: with a separate sysfs file, we need to document the
file, and the user needs to be aware of it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

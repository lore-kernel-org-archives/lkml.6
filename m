Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754891AbeD3TJf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:09:35 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34914 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754639AbeD3TJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:09:30 -0400
X-Google-Smtp-Source: AB8JxZqrSY0AhEmguSebpP4aXmqvOY+LBJ0ROGp3cv3T0pOhIzgLawXqx0TrNu9mcmwdBNCTmMniAPqdwSvNv7S1myw=
MIME-Version: 1.0
In-Reply-To: <20180430082750.GI2484@ulmo>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-2-git-send-email-wesley@sifive.com> <20180429055417.GA10221@mithrandir>
 <CAMgXwTgN26aKaSuVdSj2TDUgbR7bAmy4TdtOuKj_QC0kNNbphg@mail.gmail.com> <20180430082750.GI2484@ulmo>
From: Wesley Terpstra <wesley@sifive.com>
Date: Mon, 30 Apr 2018 12:09:29 -0700
Message-ID: <CAMgXwThTd32cyEBcbGnYw72x-P9_P8ks2J6QJV69RUUUDsT+3A@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: added new pwm-sifive driver documentation
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 1:27 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> I don't like the idea of specifying something in DT that is completely
> approximate because it doesn't give users any kind of control over what
> is considered acceptable. In some cases an approximation to within 10%
> might be acceptable, in other cases users may only want to allow 5%. In
> this case there's even no way to catch or report a deviation from the
> desired value.

My view was that you basically don't have period control on this IP.
You can give it a target that it tries to get as close to as possible,
but there's no guarantee of any kind wrt. the period.

I saw there were a couple other PWM drivers which had no period
control whatsoever. They just allowed duty cycle control. Because this
IP has such a broken period-control interface, I was essentially
trying to bin it in the same category as those drivers.

Perhaps I should just remove all pretense of supporting period and
just always default to the fastest period possible?

> How about you allow users to specify a valid frequency range with
> something like:
>
>         frequency-range = <MIN MAX>;
>
> or
>
>         period-range = <MIN MAX>;

Ok, but now you have to define what happens if a clock change prevents
you from staying within this range.

Rejecting the clock frequency change does not seem a good option for
the actual SoC for which I wrote this driver. There, all the PWM does
is drive an LED bank and clock changes are used to change the core
frequency.

> you could disable the PWM if it was fed with an invalid range.

Is that really desirable behavior? If the period is defined as being
best effort for this PWM IP, which is essentially what I've done, it's
clear you want the PWM to continue to operate. That's certainly the
behavior I want on the actual SoC with this IP.

I'll make all the DTS changes you guys suggested. ie: "-v0", clarified
clocks description, and remove unused interrupts comment.

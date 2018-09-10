Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E63C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01562086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01562086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeIKCg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:36:57 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45427 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeIKCg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:36:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so43156496oie.12;
        Mon, 10 Sep 2018 14:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzFln/EUqZunpr1sa7xZHGWx+DmmUoXw27hMFArTvJ4=;
        b=qcL+5SddnFfGP3HjCtTQL0Gd0G/dRr0+FHbHBkkyHySk0JnABIXAwPaizZ0aZKJzIi
         3UdpJF7jVnYMpy7o7WMyRKlqnI/ftrc1mPjd+s6UAWSn/VrzIa0FSaXd2h97S0PX+O4d
         KLdi1ZIR6JS0n7Q2OuNGsKaBc8t1EDvnnMlC/7CtbLTXoFBsqjgx3YB3tArxYjCHheLu
         TtKQENswUXaD5WTrnAUNvcheVpMfbaPuFo8H/7Zy6jtZgQ3U8WxZhr/xXGAaEHx6TVjT
         O0hyRnD+uxYCdnEXg2fv6BUNmIzPaYbIQuFzxYZ8B1c8FuK4TXj/6N6nsNTAoqPojz51
         MDFg==
X-Gm-Message-State: APzg51AK2sMm9BDg2VfemPyp2riwN7RrZFQuBLA+/5kuXp3gwOgy3On3
        emDj2KAObDZn+XnefUJaFQPJN0iYEtJ6E/rwvIE=
X-Google-Smtp-Source: ANB0VdZmixsRXRfqrTbaygZgoQPYRo6S4+8mNj8X2FCtg0YmOATMrQvjoCC+Fo99cj6+5htDY6jz1dexneEOjhrZryE=
X-Received: by 2002:aca:ef0a:: with SMTP id n10-v6mr24726207oih.326.1536615654843;
 Mon, 10 Sep 2018 14:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180910173953.10113-1-kw@fieahl.im> <CAJZ5v0ijVnhZ52GrVbCeRQMCTBzgpBgB7AYoqJegjSBEcXamSA@mail.gmail.com>
 <CACXwQcBUZkHDy3HZTPYR8+hsa3GZ=Ogyuimdow=y_8trbALNeA@mail.gmail.com>
In-Reply-To: <CACXwQcBUZkHDy3HZTPYR8+hsa3GZ=Ogyuimdow=y_8trbALNeA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Sep 2018 23:40:43 +0200
Message-ID: <CAJZ5v0jNf+of+XpRP8F0yvYyW20yHNs9NS02biuH5T0b6PcP3w@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: enter_state: Don't needlessly calculate diff time
To:     kw@fieahl.im
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:24 PM Fieah Lim <kw@fieahl.im> wrote:
>
> On Tue, Sep 11, 2018 at 4:17 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Sep 10, 2018 at 7:40 PM Fieah Lim <kw@fieahl.im> wrote:
> >>
> >> Currently we use ktime_us_delta() to calculate last residency and
> >> state usage unconditionally, it makes no sense to do this calculation
> >> when we fails to enter any idle state.
> >> It can be optimize by moving the calculation after entered_state >= 0
> >>
> >> While at it, merge those comment blocks into one and remove a
> >> space between type casting of diff.
> >>
> >> This patch has no functional changes.
> >>
> >> Signed-off-by: Fieah Lim <kw@fieahl.im>
> >> ---
> >> Changes from v1:
> >>  - Rewrite changelog as Rafael J. Wysocki suggested
> >> ---
> >>  drivers/cpuidle/cpuidle.c | 17 ++++++++---------
> >>  1 file changed, 8 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> >> index 6df894d65d9e..5f6b2c9b6555 100644
> >> --- a/drivers/cpuidle/cpuidle.c
> >> +++ b/drivers/cpuidle/cpuidle.c
> >> @@ -247,21 +247,20 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
> >>         if (!cpuidle_state_is_coupled(drv, index))
> >>                 local_irq_enable();
> >>
> >> -       diff = ktime_us_delta(time_end, time_start);
> >> -       if (diff > INT_MAX)
> >> -               diff = INT_MAX;
> >> -
> >> -       dev->last_residency = (int) diff;
> >> +       dev->last_residency = 0;
> >
> > You don't need this line if you retain the "else" branch below, do you?
> >
> You are right, should I make a v3?

Yes, please.

Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F98C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DDB214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DDB214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389672AbeKVHUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:20:42 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45642 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeKVHUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:20:42 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPZMa-0000tz-4H; Wed, 21 Nov 2018 21:44:44 +0100
Date:   Wed, 21 Nov 2018 21:44:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Muchun Song <smuchun@gmail.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timers: Make the lower-level timer function first call
 than higher-level
In-Reply-To: <CAPSr9jFVDaXUZw0LKEX81TrCmeQ+tw1bt0g_tK7J1s9qtOdEwg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811212143030.1665@nanos.tec.linutronix.de>
References: <20181119141003.6470-1-smuchun@gmail.com> <CALAqxLUUpGfDzOoDyPA4LFyzFyVmiT4wKLUWa5Tin8eypJBCDQ@mail.gmail.com> <CAPSr9jFVDaXUZw0LKEX81TrCmeQ+tw1bt0g_tK7J1s9qtOdEwg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1907336109-1542832995=:1665"
Content-ID: <alpine.DEB.2.21.1811212143220.1665@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1907336109-1542832995=:1665
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <alpine.DEB.2.21.1811212143221.1665@nanos.tec.linutronix.de>

Song,

On Tue, 20 Nov 2018, Muchun Song wrote:
> John Stultz <john.stultz@linaro.org> 于2018年11月20日周二 上午2:16写道：
> >
> > On Mon, Nov 19, 2018 at 6:10 AM, Muchun Song <smuchun@gmail.com> wrote:
> > > The elements of the heads array are a linked list of timer events that
> > > expire at the current time. And it can contain up to LVL_DEPTH levels
> > > and the lower the level represents the smaller the time granularity.
> > >
> > > Now the result is that the function, which will be called when the timer
> > > expires, in the higher-level is called first than the lower-level function.
> > > I think it might be better to call the lower-level timer function first
> > > than the higher-level function. Because the lower-level has the smaller
> > > granularity and delay has less impact on higher-level. So fix it.
> >
> > Interesting.
> >
> > Do you have any specific examples of where this was helpful?  Maybe
> > data on how much this helped the case your concerned about?
> >
> 
>                      heads(with HZ > 100)
> +-----+-----+-----+-----+-----+-----+-----+-----+-----+
> |  0  |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |
> +--+--+--+--+--+--+-----+-----+-----+-----+-----+-----+
>    |     |     |
>    |     |     |
>    |     |     +--->timer4--->timer5
>    |     +--->timer1--->timer2--->timer3
>    +--->timer0
> 
> If we have 6 timers that expire at the current time. And the heads array
> layout as shown above. The collect_expired_timers() will return 3. If timer0
> belong to the first wheel level(level 0), timer1-3 belong to level 2 and
> timer4-5 belong to level 5.
> 
> Follow the current code logic, the timer0 function is called until the
> function call of timer1-5 is completed. So the delay of timer0 is the time
> spent by other timer function calls. If we can call the timer function in
> the following order, this should be more friendly to lower-level timers.
> 
>         timer0->timer1->->timer2->->timer3->->timer4->->timer5
> 
> Although not friendly to higher-level timers, higher-level has larger
> granularity. Therefore the delay has less impact on higher-level.

Well yes, that's clear. But is it a problem in practice and if so, what is
the measurable benefit.

Thanks,

	tglx
--8323329-1907336109-1542832995=:1665--

Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58E620844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 07:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58E620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbeHAIzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:55:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33172 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733096AbeHAIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:55:18 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fklHd-0000ie-3q; Wed, 01 Aug 2018 09:10:57 +0200
Date:   Wed, 1 Aug 2018 09:10:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xu YiPing <xuyiping@hisilicon.com>
cc:     John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, anna-maria@linutronix.de
Subject: Re: [PATCH] timers: fix offset calculation when the expires align
 with LVL_GRAN
In-Reply-To: <86709eae-fa35-e36a-cafd-2c917d188276@hisilicon.com>
Message-ID: <alpine.DEB.2.21.1808010855500.1713@nanos.tec.linutronix.de>
References: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com> <alpine.DEB.2.21.1807301234310.2518@nanos.tec.linutronix.de> <c68d9944-1fcc-dcd5-1e3d-07f979323b8c@hisilicon.com> <alpine.DEB.2.21.1807311616480.1610@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807311633430.1610@nanos.tec.linutronix.de> <86709eae-fa35-e36a-cafd-2c917d188276@hisilicon.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Xu YiPing wrote:
> On 2018/7/31 22:34, Thomas Gleixner wrote:
> > 
> > 
> > On Tue, 31 Jul 2018, Thomas Gleixner wrote:
> > 
> >> On Tue, 31 Jul 2018, Xu YiPing wrote:
> >>> On 2018/7/30 19:03, Thomas Gleixner wrote:
> >>>>
> >>>> __internal_add_timer(base, timer)
> >>>> {  
> >>>>    idx = calc_wheel_index(1, 1)
> >>>>        {
> >>>>            delta = 1 - 1;	<-   0
> >>>>
> >>>>            if (0 < LVL_START(1))
> >>>>                idx = calc_index(1, 0)
> >>>>                     {
> >>>>                         expires = (1 + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
> >>>> 			----> expires = 0
> >>> 			
> >>> 			LVL_GRAN(0) = 1 and LVL_SHIFT(0) = 0
> >>> 			
> >>> 			after the calculation, expires = 1 ?
> >>
> >> Indeed. You're right. Math is hard... So the index would be 1 and still not
> >> fulfil the below:
> > 
> > Hmm, crap. Let me think about it some more. 34C is way too hot to think.
> > 
> 
> 	when the expire is aligned with LVL_GRAN(x), it could be triggered at expire,
> no need to wait another LVL_GRAN(x).
> 
> 	just a little improvement, useful when expire is small.

The expire early problem still persists:

schedule_timeout(x)
   expires = jiffies + x;
   mod_timer(timer, expires);

This will return _BEFORE_ X jiffies have elapsed in 99% of the cases, so it's
not a little improvement, it's a big regression.

Again for schedule_timeout(1):

   |-------------------|-------------------|--------------------|
  tick               tick                tick			
 jiffies           jiffies + 1        jiffies + 2

   |                   |
   |  Any timer armed  |                   ^
   |  here must be     |                   |
   |  queued here -------------------------|
                       |                   |
                       |  Any timer armed  |                   ^
                       |  here must be     |                   |
                       |  queued here -------------------------|

The only case where your change would be correct is if _all_ timers are
armed exactly at the jiffies boundary. Can you guarantee that? Not at all.

And even hrtiemrs suffer from this issue when high resolution mode is
disabled because then they are expired on the tick boundary as well and if
the expiry time is past the current time at the tick boundary then the
timer will be expired one tick later.

It's a fundamental property of timers which are driven by a periodic tick
and you can argue in circles it wont change.

Thanks,

	tglx


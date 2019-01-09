Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4235B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfAIRCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:02:10 -0500
Received: from muru.com ([72.249.23.125]:32818 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbfAIRCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:02:10 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 605A580C5;
        Wed,  9 Jan 2019 17:02:15 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:02:06 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Ladislav Michl <ladis@linux-mips.org>
Subject: Re: Regression in v5.0-rc1 with autosuspend hrtimers
Message-ID: <20190109170206.GS5544@atomide.com>
References: <20190108155354.GL5544@atomide.com>
 <CAKfTPtCoOK-cYLXJ--sOfpVa9RVmzOAEN1+zB2qHMCzkJN0qaQ@mail.gmail.com>
 <20190108213743.GN5544@atomide.com>
 <20190109014218.GA8363@linaro.org>
 <20190109015124.GO5544@atomide.com>
 <CAJZ5v0hi5sVESKPbZoniikOhNxdUDtJhQrs39Fib8B03MYoMMQ@mail.gmail.com>
 <20190109162846.GP5544@atomide.com>
 <CAKfTPtBzE9fqDgUOJ4uTj_Dtfe2KCp+R4FajAaQqpV02upQZJA@mail.gmail.com>
 <20190109165004.GQ5544@atomide.com>
 <CAKfTPtD4ZnRDKF6wG_AdX-5+R0cW0=uwj9Ww6y7O0xocuL+bkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtD4ZnRDKF6wG_AdX-5+R0cW0=uwj9Ww6y7O0xocuL+bkQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [190109 16:56]:
> On Wed, 9 Jan 2019 at 17:50, Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Vincent Guittot <vincent.guittot@linaro.org> [190109 16:48]:
> > > On Wed, 9 Jan 2019 at 17:28, Tony Lindgren <tony@atomide.com> wrote:
> > > >
> > > > * Rafael J. Wysocki <rafael@kernel.org> [190109 09:44]:
> > > > > On Wed, Jan 9, 2019 at 2:51 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > > >
> > > > > > * Vincent Guittot <vincent.guittot@linaro.org> [190109 01:42]:
> > > > > > > Le Tuesday 08 Jan 2019 à 13:37:43 (-0800), Tony Lindgren a écrit :
> > > > > > > > Lowering the autosuspend_delay_ms to 2100 ms makes things work again.
> > > > > > > > Anything higher than 2200 ms seems to somehow time out immediately
> > > > > > > > now :)
> > > > > > >
> > > > > > > This is quite close to the max ns of an int on arm 32bits
> > > > > > >
> > > > > > > Could you try the patch below ?
> > > > > >
> > > > > > Yup great thanks, that's it:
> > > > > >
> > > > > > Tested-by: Tony Lindgren <tony@atomide.com>
> > > > >
> > > > > Cool.  Thanks for getting to the bottom of this!
> > > >
> > > > No problem.
> > > >
> > > > One more thing I noticed: The 25% slack can get noticeable
> > > > for larger values. For things like a 3 second uart console
> > > > timeout slack of 750 ms is quite large variation.
> > > >
> > > > Should we have a limit of max 100 ms for the slack?
> > >
> > > Keep in mind that when jiffies were used, expires was rounded to a
> > > full second when delay was greater than a second. So you could already
> > > have difference of up 990ms on arm before this patch
> > > And i don't take into account the rework of timer infra which add
> > > another level of variation, something like up to 640 ms more when the
> > > timer is greater than 2880 ms for arm IIRC
> >
> > I think it was rounded up earlier.
> >
> > Don't we get rounded down now also?
> 
> We still round up. In hrtimer we have :
> timer->_softexpires = time;
> timer->node.expires = ktime_add_safe(time, delta);
> so the hrtimer will expire between "time" and "time+delta"

OK thanks for checking it. In that case we should be good to go :)

Tony

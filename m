Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C3C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EFF2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfA2RLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:11:55 -0500
Received: from muru.com ([72.249.23.125]:36626 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728379AbfA2RLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:11:55 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0AD1C8140;
        Tue, 29 Jan 2019 17:12:02 +0000 (UTC)
Date:   Tue, 29 Jan 2019 09:11:51 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Subject: Re: New underflow of regulator enable count warnings in v5.0-rc1
Message-ID: <20190129171151.GC5720@atomide.com>
References: <20190129164813.GA5720@atomide.com>
 <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VJWofeRbmdBkn1ZKhs302wE4Un_PVru-M2G2er4OpchQ@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Doug Anderson <dianders@chromium.org> [190129 17:05]:
> Hi,
> 
> On Tue, Jan 29, 2019 at 8:48 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > Looks like commit 5451781dadf8 ("regulator: core: Only count load for
> > enabled consumers") started showing new warnings with v5.0-rc cycle:
> >
> > regulator-dummy: Underflow of regulator enable count
> >
> > I'm seeing this at least with my pwm-vibra test case:
> >
> > # rumble-test /dev/input/by-path/platform-vibrator-event 0xffff
> > pwm-vibrator vibrator: vibrator supply vcc not found, using dummy regulator
> > input: pwm-vibrator as /devices/platform/vibrator/input/input4
> > regulator-dummy: Underflow of regulator enable count
> > Upload rumble effect... id=0
> > regulator-dummy: Underflow of regulator enable count
> >
> > Are these bogus warnings for dummy regulator or do we have
> > real unpaired regulator calls or somewhere?
> 
> My first guess is that there's a real unpaired regulator call somewhere.
> 
> I actually meant to include this in the commit message, but I'm an
> idiot and I used "--" to break up the parts of the commit message
> which confused git when Mark applied it.  Sigh.  For the full commit
> message, see:
> 
> https://lkml.kernel.org/r/20181120175255.227783-1-dianders@chromium.org

Oh I see, thanks for the link :)

> In that message I said:
> 
> > - We can (and will) spit errors out for code that used to be invalid
> >   but was never caught before.  Specifically if someone leaves a
> >   regulator enabled and calls regulator_put() we'll yell.  We'll also
> >   yell if a single consumer calls more disables than enables.
> 
> Looking quickly at 'pwm-vibra.c' it wouldn't surprise me at all if you
> call regulator_disable() more times than regulator_enable().  If
> that's true it should be fixed.

OK. Let's see if Sebastian spots where pwm_vibrator_start()
and pwm_vibrator_stop() might get called multiple times
or something similar.

Regards,

Tony

Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A24C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FF520870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfALMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:01:01 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:41654 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfALMBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:01:01 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 1982A20054;
        Sat, 12 Jan 2019 13:00:57 +0100 (CET)
Date:   Sat, 12 Jan 2019 13:00:56 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>,
        linux-amarula@amarulasolutions.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH V7 2/2] drm/panel: Add Sitronix ST7701 panel driver
Message-ID: <20190112120056.GA7374@ravnborg.org>
References: <20190111124714.19566-1-jagan@amarulasolutions.com>
 <20190111124714.19566-2-jagan@amarulasolutions.com>
 <20190111211931.GA29735@ravnborg.org>
 <CAMty3ZArGPf8+M5GVhkzoMDhtYwT3aUS9bNbKt8=gqeb6-b82Q@mail.gmail.com>
 <20190112101409.GA14273@ravnborg.org>
 <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZBUNeFvsHDRmBFUoZG=J+EfQuKtJDOhaezcfEOykhpOeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=h2XvLM43PzkowCm6i1cA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > > > +
> > > > > +     msleep(st7701->sleep_delay);
> > > > > +
> > > > > +     gpiod_set_value(st7701->reset, 0);
> > > > > +
> > > > > +     gpiod_set_value(st7701->reset, 1);
> > > > > +
> > > > > +     gpiod_set_value(st7701->reset, 0);
> > > > No timing constrains here? In prepare there are sleeps intermixed.
> > >
> > > Delay while doing unprare is not needed I suppose.
> >
> > If the purpose is alone to reset the display then a single write '0'
> > should do it I think
> 
> I even tried this just set 0, since prepare is doing a sequence, it
> good behavior to do the reverse during handoff. ie reason I just
> initiated this sequence.
> 
> > And there is a requirement that it must be low for a minimum of 10 us
> > which would be good to have here.
> 
> Sorry, I didn't get this requirement what is this for?
The st7701 will ignore reset pulse shorter than 10 us - see Trw in
table 9 reset timing (page 54).

But as we just assert reset (set it to 0), this timing constraint can be ignored.

> > I aslo found in chapter 9. (page 163 - second line) this statement:
> > "VDDA and VDDI must be powered down with minimum 120msec."
> 
> Yes unprepare is doing the same, it exit from sleep out mode and wait
> for 120msec and do the reset.
> 
> >
> > This is similar to the unprepare delay to be found in simple-panel.c
> > So an unprepare delay seems in order here.
> 
> Look like simple-panel.c is doing delay after reset initiated and
> regulator disabled.


	Sam


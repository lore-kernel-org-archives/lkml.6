Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE54C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06CF20869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfA3MDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:03:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbfA3MDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:03:34 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1gooaX-000466-AY; Wed, 30 Jan 2019 13:03:29 +0100
Message-ID: <1548849808.3939.7.camel@pengutronix.de>
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Jan 2019 13:03:28 +0100
In-Reply-To: <20190128145836.GA31317@ulmo>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
         <1548674808.6421.3.camel@pengutronix.de> <20190128145836.GA31317@ulmo>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On Mon, 2019-01-28 at 15:58 +0100, Thierry Reding wrote:
> On Mon, Jan 28, 2019 at 12:26:48PM +0100, Philipp Zabel wrote:
> > Hi Thierry,
> > 
> > On Fri, 2019-01-25 at 11:15 +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > When requesting a reset control for exclusive use that's already in use,
> > > an -EBUSY error code is returned. Users can react accordingly when they
> > > receive that error code, so there is no need to loudly complain.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/reset/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > index 9582efb70025..6b452f010b66 100644
> > > --- a/drivers/reset/core.c
> > > +++ b/drivers/reset/core.c
> > > @@ -416,7 +416,7 @@ static struct reset_control *__reset_control_get_internal(
> > >  
> > >  	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
> > >  		if (rstc->id == index) {
> > > -			if (WARN_ON(!rstc->shared || !shared))
> > > +			if (!rstc->shared || !shared)
> > >  				return ERR_PTR(-EBUSY);
> > >  
> > >  			kref_get(&rstc->refcnt);
> > 
> > Are you actually running into this somewhere?
> 
> Yeah. I'm running into this on Tegra. Let me give you a brief overview
> of how the resets work for better understanding. Most of the modules on
> Tegra have dedicated resets, some may have multiple ones to reset a
> subset of the hardware within a functional block. Typically the drivers
> for these hardware modules will control the reset explicitly, usually to
> make sure the hardware is in a known state at probe time. Some drivers
> also do this as part of runtime suspend/resume.
>
> Unfortunately we ran into issues when shared resets were introduced
> because we also have generic power domains implemented on most platforms
> and part of the programming sequence for power domains is to make sure a
> hardware module that is part of the domain has its reset asserted. So on
> one hand we need the reset for explicit control in the driver and on the
> other hand we need the reset control in the power domain driver to make
> sure the sequence requirements can be met.
> 
> This causes issues on chips such as Tegra210, where for example we need
> to reset the SOR (which is an output used to driver HDMI) before setting
> a mode to make sure we are in a proper state (the bootloader can have
> initialized the SOR) to make sure the rather complicated sequence for
> getting up the SOR can be completed.
> 
> The power domain for the SOR needs to control the reset for the SOR for
> power sequencing reasons and at the same time, the SOR driver needs to
> control the reset to get it into a proper state. In the past we were
> able to make this work by requesting the reset control in the SOR driver
> only if no power domain was attached to the SOR. This would avoid the
> shared usage between power domain and SOR driver. We obviously can't
> share the reset control because it wouldn't allow us to reset at the
> right time.
> 
> On Tegra210 this works fine because the SOR power domain will be powered
> off sometime during boot and in the process reset the SOR. This is
> because all devices that are part of the domain are runtime power
> managed and have a zero runtime PM refcount after ->probe(), so the PM
> domain will be allowed to be turned off at that point. This is likely
> only by accident, and break as well if the driver probe order changes
> for some reason.
> 
> The problem is more accute on Tegra186 where the SOR is in a much larger
> power domain that includes a bunch of other modules. Unfortunately, one
> side-effect of that is that the power domain will not be turned off
> during boot. I saw this happen when I added support for HDA support. The
> HDA module is also part of the same power domain as SOR and HDA keeps a
> runtime PM reference all the time. This is because it isn't runtime PM
> managed at this point, but even if it was, there are so many modules in
> the power domain that we can't guarantee that the power domain will at
> some point be powered off and the SOR reset at the time.
> 
> Fortunately the power domains on Tegra186 (and later) are no longer
> controlled by a Linux driver. Instead, there's now a firmware running on
> a microcontroller (called boot and power management processor, or BPMP)
> that Linux communicates with over an IPC mechanism. BPMP will internally
> control the resets as appropriate, which means that we can exclusively
> reset them again from Linux and explicitly reset the SOR when needed.
> 
> In order to support both Tegra210 and Tegra186 in the same driver, we no
> longer just check whether a power domain was attached to the SOR, but we
> just want to get the reset control and if we get -EBUSY we assume that
> we run on Tegra210 and earlier and don't have to use the reset (since
> the power domain will be able to reset the SOR). For later chips we get
> access to the reset control because Linux doesn't know that BPMP also
> has access to it.
> 
> So much for the "brief" overview... =)

Oh dear :) Thank you for the detailed description, much appreciated.
This is a problem that we currently have no good solution for. Let me
think about this for a bit.

First, conceptually these are exclusive (to one module each) reset
lines, but the control is temporarily yielded to the power domain.

I'm not at all saying we should do the following, but hypothetically, if
the SOR driver were to reset_control_put the reset line in its suspend
function and reset_control_get it again in resume, and the power domain
drivers would only reset_control_get the reset line right before a power
domain transition and reset_control_put it immediately afterwards, that
should work just fine, right?

If so, maybe this functionality should be added to the reset framework.
A possibility would be to have a "yielded" state for exclusive reset
controls, allow multiple reset controls to be requested for an exclusive
reset line at the same time, but only allow actions on one control at a
time.

> Now, after writing the above, I'm not sure if this is really the best
> approach. Technically we could run into the same problem on Tegra210
> where we can't explicitly control the reset because Linux already has
> it marked as exclusively used by the power domain provider.

I'm not quite sure either. With the above idea, and a pair of
reset_control_release/acquire functions, the SOR suspend/resume
functions could look something like this:

suspend() {
	reset_control_assert(rstc);
	/* ... */
	clk_disable(clk);
	delay();
	reset_control_release(rstc);
	/*
	 * ^ From this point on the SOR driver doesn't care about
	 * the state of the reset line anymore, the PM driver is
	 * free to manipulate it.
	 */
}

resume() {
	reset_control_acquire(rstc);
	/*
	 * ^ This should fail
while another exclusive reset control
	 * has acquired the reset
line. Alternatively, the acquire
	 * could be implicitly contained
in the following assert:
	 */
	reset_control_assert(rstc);
	
/*
	 * ^ From this point on the SOR driver again cares about the
	
 * state of the reset line.
	 */
	clk_enable(clk);
	de
lay();
	reset_control_deassert(rstc);
}

And while the SOR driver has released its reset control, the power
domain driver is free to acquire/IPC/release it (BPMP) or to
acquire/assert/deassert/release as necessary on Tegra210.
That would also mean we'd have to add a way for the power domain drivers
to request the reset control in the "released/don't care" state
initially.

> But then, I don't know if there's an alternative to just crossing our
> fingers and hoping that things will continue to work "by accident".

I'd prefer not to rely on that. It would be nice for the power domain
drivers to be able to temporarily acquire reset control from the
framework during power transitions, to make sure that the SOR driver is
in a state that is guaranteed not to be disturbed by activity on the
reset line. Or at least to be able to throw sane error messages when
this is not the case.

> For some devices it may not matter because they are less picky about their
> current state when you start programming them, but the SOR is very
> sensitive and I've never been able to make it work properly without
> involving the help of the reset at some point.
> 
> One alternative that could work for Tegra would be to somehow mark the
> resets as being safe to use multiple times. In our use-cases we always
> know that it is safe to reset the SOR because the power domains will be
> on at the time that we want to control it, so there won't be any
> conflicts. However, I suspect that that could set a precedent for other
> drivers.

Do you think the above makes sense? I wouldn't like to mark exclusive
reset controls as just "safe to use" from multiple controls generally,
but doing this temporarily seems to me to fit the use case quite well.

> > My reason for adding these warnings was that these point to either a DT
> > misconfiguration or a driver bug, and the verbose warning helps to
> > quickly identify the actual issue. This is not an error condition that
> > I would expect on a correctly configured system.
> 
> I generally agree with this approach, but given the above, I'm out of
> ideas of how to properly achieve what we need on Tegra. Even this patch
> seems like a bad idea in retrospect because we may very well run into a
> similar issue on Tegra210 where we can't hide the fact that we're using
> the reset from two places at the same time. I mean we could probably do
> a really ugly hack and access the reset controller registers directly
> from the power domain provider, but that's really not something I want
> to do. We already have to do something similar to work around a hardware
> bug on Tegra210, but that's about as much as I can endure.

I agree, and I really think this should be done out in the open, not
behind the frameworks' back. I'm sure Tegra is not the only platform
where this currently only works by accident. Just most of the time I
don't get as thorough an explanation.

> > I don't expect most drivers give a proper error message that contains
> > the -EBUSY return value. Usually it's just along the lines of "failed to
> > get reset control" without any further indication.
> 
> I understand your reluctance. And I'm certainly open to any new ideas
> that I haven't tried yet. I haven't tried reintroducing some sort of
> non-shared resets, but I've never seriously considered it because it
> effectively undoes most of the shared reset stuff.

The shared reset support really is orthognonal to this, it completely
changes how the reset_control_assert/deassert functions are interpreted
due to the internal refcounting.

> If you think that some form of this would be acceptable, I will be
> happy to come up with a proposal. Or perhaps there's a really simple
> solution to this problem and I simply can't see the wood for the trees
> anymore.

What do you think about my suggestion?

regards
Philipp

Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F018C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11820869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0uj4J7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfBAOAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:00:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38666 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbfBAOAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:00:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so7193528wrw.5;
        Fri, 01 Feb 2019 06:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oEi3BI3J7JjuNDTRDqP44WbMXE10q196YI1eIQ8ACCM=;
        b=k0uj4J7OjW5Dc3q91ABXgFvNKIMS/mZtleAoxClvUC9ehkPlDtKHOnX8VB3tJu2FWH
         Kt64gy4psXplbsB5v5BIMUAN7d7OhYigYyiZLaoJ9qdftxh4FSyZ4s3HcLPUPGXNjHsQ
         73XllEse/EoZGoCY8CQFaSW+pW7QeBFlf7NV2a0ZgxmgM/lL/fzkTMR/ari1gw/IqPjO
         a+Krc7bQBhqbe7YW+beiwQYTpDyUSdCB9b/YZTaBmwn5SxBl2w5jOnQYp9n1BTYNhiKA
         4Sw9YL+0FTuPsxfafINdd/dcqrEZ1KFYrvMkenK2ZBhV5qOy23XPx0qvTIWKfQcdVUkV
         7hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oEi3BI3J7JjuNDTRDqP44WbMXE10q196YI1eIQ8ACCM=;
        b=XWvKTloZeAj5rai4wRa2czb6ATsNFQN9p3xpLPDoflbkZY7/3Vc3c7QQQiuEGxyiRr
         N6yEFVF/WCJsThsh9/gmlY/W514ZFCDC6+qDHpRRjUqEOM04+kPbktaC8zSVwA60eT0h
         Eez3lvXE4QuWdwn7GEHtkOVxCH30yeUCMK6h+zuRs6KoBKvaGaXVN7wpjQIGJcLnryBT
         b33A6S04n9Xhll/C7sE3ifi65+MOcVwGkyVxyFqs1F1Z6kxSJmPAOD39nfJKkSBJvM99
         PiqTMbJfXAGY+47k+tYx5t1FuBWXAgz/MEX6j7FKg+6RV+rvaj2y9iEueq7Hm+MYxeWs
         9bDQ==
X-Gm-Message-State: AJcUukc9LhtI74yU+vUAOq5CLbwxy41OgXdJVF0QbbVzWmP4zM0bzD/A
        +ju9GN5oE4cfCYgVgVJy2NI=
X-Google-Smtp-Source: ALg8bN6WRLDlECrmSa+Xlcr6USg7REsB+m5lwzDj9MOrt42qASyWUrkFGyc01qCfVfn5nfOFPv0wzg==
X-Received: by 2002:adf:d146:: with SMTP id b6mr39221585wri.156.1549029628241;
        Fri, 01 Feb 2019 06:00:28 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id x3sm11197445wrd.19.2019.02.01.06.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:00:27 -0800 (PST)
Date:   Fri, 1 Feb 2019 15:00:25 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
Message-ID: <20190201140025.GB12829@ulmo>
References: <20190125101554.5947-1-thierry.reding@gmail.com>
 <1548674808.6421.3.camel@pengutronix.de>
 <20190128145836.GA31317@ulmo>
 <1548849808.3939.7.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <1548849808.3939.7.camel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 01:03:28PM +0100, Philipp Zabel wrote:
> Hi Thierry,
>=20
> On Mon, 2019-01-28 at 15:58 +0100, Thierry Reding wrote:
> > On Mon, Jan 28, 2019 at 12:26:48PM +0100, Philipp Zabel wrote:
> > > Hi Thierry,
> > >=20
> > > On Fri, 2019-01-25 at 11:15 +0100, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > When requesting a reset control for exclusive use that's already in=
 use,
> > > > an -EBUSY error code is returned. Users can react accordingly when =
they
> > > > receive that error code, so there is no need to loudly complain.
> > > >=20
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  drivers/reset/core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > > > index 9582efb70025..6b452f010b66 100644
> > > > --- a/drivers/reset/core.c
> > > > +++ b/drivers/reset/core.c
> > > > @@ -416,7 +416,7 @@ static struct reset_control *__reset_control_ge=
t_internal(
> > > > =20
> > > >  	list_for_each_entry(rstc, &rcdev->reset_control_head, list) {
> > > >  		if (rstc->id =3D=3D index) {
> > > > -			if (WARN_ON(!rstc->shared || !shared))
> > > > +			if (!rstc->shared || !shared)
> > > >  				return ERR_PTR(-EBUSY);
> > > > =20
> > > >  			kref_get(&rstc->refcnt);
> > >=20
> > > Are you actually running into this somewhere?
> >=20
> > Yeah. I'm running into this on Tegra. Let me give you a brief overview
> > of how the resets work for better understanding. Most of the modules on
> > Tegra have dedicated resets, some may have multiple ones to reset a
> > subset of the hardware within a functional block. Typically the drivers
> > for these hardware modules will control the reset explicitly, usually to
> > make sure the hardware is in a known state at probe time. Some drivers
> > also do this as part of runtime suspend/resume.
> >
> > Unfortunately we ran into issues when shared resets were introduced
> > because we also have generic power domains implemented on most platforms
> > and part of the programming sequence for power domains is to make sure a
> > hardware module that is part of the domain has its reset asserted. So on
> > one hand we need the reset for explicit control in the driver and on the
> > other hand we need the reset control in the power domain driver to make
> > sure the sequence requirements can be met.
> >=20
> > This causes issues on chips such as Tegra210, where for example we need
> > to reset the SOR (which is an output used to driver HDMI) before setting
> > a mode to make sure we are in a proper state (the bootloader can have
> > initialized the SOR) to make sure the rather complicated sequence for
> > getting up the SOR can be completed.
> >=20
> > The power domain for the SOR needs to control the reset for the SOR for
> > power sequencing reasons and at the same time, the SOR driver needs to
> > control the reset to get it into a proper state. In the past we were
> > able to make this work by requesting the reset control in the SOR driver
> > only if no power domain was attached to the SOR. This would avoid the
> > shared usage between power domain and SOR driver. We obviously can't
> > share the reset control because it wouldn't allow us to reset at the
> > right time.
> >=20
> > On Tegra210 this works fine because the SOR power domain will be powered
> > off sometime during boot and in the process reset the SOR. This is
> > because all devices that are part of the domain are runtime power
> > managed and have a zero runtime PM refcount after ->probe(), so the PM
> > domain will be allowed to be turned off at that point. This is likely
> > only by accident, and break as well if the driver probe order changes
> > for some reason.
> >=20
> > The problem is more accute on Tegra186 where the SOR is in a much larger
> > power domain that includes a bunch of other modules. Unfortunately, one
> > side-effect of that is that the power domain will not be turned off
> > during boot. I saw this happen when I added support for HDA support. The
> > HDA module is also part of the same power domain as SOR and HDA keeps a
> > runtime PM reference all the time. This is because it isn't runtime PM
> > managed at this point, but even if it was, there are so many modules in
> > the power domain that we can't guarantee that the power domain will at
> > some point be powered off and the SOR reset at the time.
> >=20
> > Fortunately the power domains on Tegra186 (and later) are no longer
> > controlled by a Linux driver. Instead, there's now a firmware running on
> > a microcontroller (called boot and power management processor, or BPMP)
> > that Linux communicates with over an IPC mechanism. BPMP will internally
> > control the resets as appropriate, which means that we can exclusively
> > reset them again from Linux and explicitly reset the SOR when needed.
> >=20
> > In order to support both Tegra210 and Tegra186 in the same driver, we no
> > longer just check whether a power domain was attached to the SOR, but we
> > just want to get the reset control and if we get -EBUSY we assume that
> > we run on Tegra210 and earlier and don't have to use the reset (since
> > the power domain will be able to reset the SOR). For later chips we get
> > access to the reset control because Linux doesn't know that BPMP also
> > has access to it.
> >=20
> > So much for the "brief" overview... =3D)
>=20
> Oh dear :) Thank you for the detailed description, much appreciated.
> This is a problem that we currently have no good solution for. Let me
> think about this for a bit.
>=20
> First, conceptually these are exclusive (to one module each) reset
> lines, but the control is temporarily yielded to the power domain.
>=20
> I'm not at all saying we should do the following, but hypothetically, if
> the SOR driver were to reset_control_put the reset line in its suspend
> function and reset_control_get it again in resume, and the power domain
> drivers would only reset_control_get the reset line right before a power
> domain transition and reset_control_put it immediately afterwards, that
> should work just fine, right?
>=20
> If so, maybe this functionality should be added to the reset framework.
> A possibility would be to have a "yielded" state=C2=A0for exclusive reset
> controls, allow multiple reset controls to be requested for an exclusive
> reset line at the same time, but only allow actions on one control at a
> time.
>=20
> > Now, after writing the above, I'm not sure if this is really the best
> > approach. Technically we could run into the same problem on Tegra210
> > where we can't explicitly control the reset because Linux already has
> > it marked as exclusively used by the power domain provider.
>=20
> I'm not quite sure either. With the above idea, and a pair of
> reset_control_release/acquire functions, the SOR suspend/resume
> functions could look something like this:
>=20
> suspend() {
> 	reset_control_assert(rstc);
> 	/* ... */
> 	clk_disable(clk);
> 	delay();
> 	reset_control_release(rstc);
> 	/*
> 	 * ^ From this point on the SOR driver doesn't care about
> 	 * the state of the reset line anymore, the PM driver is
> 	 * free to manipulate it.
> 	 */
> }
>=20
> resume() {
> 	reset_control_acquire(rstc);
> 	/*
> 	 * ^ This should fail
> while another exclusive reset control
> 	 * has acquired the reset
> line. Alternatively, the acquire
> 	 * could be implicitly contained
> in the following assert:
> 	 */
> 	reset_control_assert(rstc);
> =09
> /*
> 	 * ^ From this point on the SOR driver again cares about the
> =09
>  * state of the reset line.
> 	 */
> 	clk_enable(clk);
> 	de
> lay();
> 	reset_control_deassert(rstc);
> }
>=20
> And while the SOR driver has released its reset control, the power
> domain driver is free to acquire/IPC/release it (BPMP) or to
> acquire/assert/deassert/release as necessary on Tegra210.
> That would also mean we'd have to add a way for the power domain drivers
> to request the reset control in the "released/don't care" state
> initially.
>=20
> > But then, I don't know if there's an alternative to just crossing our
> > fingers and hoping that things will continue to work "by accident".
>=20
> I'd prefer not to rely on that. It would be nice for the power domain
> drivers to be able to temporarily acquire reset control from the
> framework during power transitions, to make sure that the SOR driver is
> in a state that is guaranteed not to be disturbed by activity on the
> reset line. Or at least to be able to throw sane error messages when
> this is not the case.
>=20
> > For some devices it may not matter because they are less picky about th=
eir
> > current state when you start programming them, but the SOR is very
> > sensitive and I've never been able to make it work properly without
> > involving the help of the reset at some point.
> >=20
> > One alternative that could work for Tegra would be to somehow mark the
> > resets as being safe to use multiple times. In our use-cases we always
> > know that it is safe to reset the SOR because the power domains will be
> > on at the time that we want to control it, so there won't be any
> > conflicts. However, I suspect that that could set a precedent for other
> > drivers.
>=20
> Do you think the above makes sense? I wouldn't like to mark exclusive
> reset controls as just "safe to use" from multiple controls generally,
> but doing this temporarily seems to me to fit the use case quite well.
>=20
> > > My reason for adding these warnings was that these point to either a =
DT
> > > misconfiguration=C2=A0or a driver bug, and the verbose warning helps =
to
> > > quickly identify the actual issue. This is not an error condition that
> > > I would expect on a correctly configured system.
> >=20
> > I generally agree with this approach, but given the above, I'm out of
> > ideas of how to properly achieve what we need on Tegra. Even this patch
> > seems like a bad idea in retrospect because we may very well run into a
> > similar issue on Tegra210 where we can't hide the fact that we're using
> > the reset from two places at the same time. I mean we could probably do
> > a really ugly hack and access the reset controller registers directly
> > from the power domain provider, but that's really not something I want
> > to do. We already have to do something similar to work around a hardware
> > bug on Tegra210, but that's about as much as I can endure.
>=20
> I agree, and I really think this should be done out in the open, not
> behind the frameworks' back. I'm sure Tegra is not the only platform
> where this currently only works by accident. Just most of the time I
> don't get as thorough an explanation.
>=20
> > > I don't expect most drivers give a proper error message that contains
> > > the -EBUSY return value. Usually it's just along the lines of "failed=
 to
> > > get reset control" without any further indication.
> >=20
> > I understand your reluctance. And I'm certainly open to any new ideas
> > that I haven't tried yet. I haven't tried reintroducing some sort of
> > non-shared resets, but I've never seriously considered it because it
> > effectively undoes most of the shared reset stuff.
>=20
> The shared reset support really is orthognonal to this, it completely
> changes how the reset_control_assert/deassert functions are interpreted
> due to the internal refcounting.
>=20
> > If you think that=C2=A0some form of this would be acceptable, I will be
> > happy to come up with a proposal. Or perhaps there's a really simple
> > solution to this problem and I simply can't see the wood for the trees
> > anymore.
>=20
> What do you think about my suggestion?

It sounds pretty good and elegant actually. Let me try to restate to see
if I understand correctly:

So basically what you're saying is that we would be changing the
definition of exclusive resets to make them exclusive in terms of usage
rather than rejecting to acquire them multiple times, right? So we would
reinstate the possibility to request exclusive resets from multiple
sources, but add an _acquire()/_release() protocol to make sure the
users don't get in each other's way.

I had initially thought that this would have to be some other type of
reset (something between exclusive and shared) to avoid suprising the
current users of exclusive resets. However, on second thought, I don't
think that would be necessary. Given the WARN_ON, all users of exclusive
resets should at this point be truly exclusive and would therefore
continue to work normally.

One problematic case that comes to mind is how currently exclusive reset
controls will know that reset_control_assert() is safe to use if they
don't use reset_control_acquire() first. Perhaps this is what you meant
when you said:

> That would also mean we'd have to add a way for the power domain drivers
> to request the reset control in the "released/don't care" state
> initially.

I don't think we actually need that for power domains, because they will
typically be enabled over the duration of a device's driver's probe
anyway. So I think this would work:

	power domains:

		power_off()
		{
			reset_control_acquire();
			reset_control_assert();
		}

		power_on()
		{
			reset_control_deassert();
			reset_control_release();
		}

	SOR:

		runtime_suspend()
		{
			reset_control_assert();
			reset_control_release();
		}

		runtime_resume()
		{
			reset_control_acquire();
			reset_control_deassert();
		}

Hm... actually this means that power domains would have to request the
reset controls and call reset_control_acquire() during probe. That way
when the domain is powered on it will release the reset and free it up
for the SOR driver to use.

This seems right because it also happens to work from a runtime PM
sequencing point of view.

I think the problem for single-user exclusive reset controls could be
solved by making use of the reference counting that's already used by
shared resets. We should be able to go ahead and use the reference
counting in general, and the acquire()/release() dance would only have
to be enforced when the reference count is > 1.

I'd probably have to prototype this to get a clearer picture of this,
but I think this is very promising.

Does the above sound about right?

Thierry

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxUUPcACgkQ3SOs138+
s6F7dQ//fYWzgcND/ZQZ+pSqcBErArhoEWqdDJQ7SEQyu0gmmYiDuFU7ex6GooEA
dXXdtkmWM6hgsRU/bdcKw5z3jlN29EW+ymriLly5yufnxU85UCDZLsRlbD2qCPua
Y3EKUGckcmd6+nNSxVy8LB0Lr+Pddt3MKdXsWI+7l/ZUF5tj7Rxtcz1OUGuAbThY
tiQMZVcp8JqgjSQ7RXNKrDtrs4sR1bKzvVLPGlPWoBz1UE5qp9EV0pWZ8npOaq4b
tiq0FC01vdndgOTDm64UUMqJnwtR4amxrAviGLNGzbAdn2AH48AYLxzFN5GYQoyt
wRLJw/Gn9OEX9ylRaBe7wp75ctI+9uqGQbfP5bm847q1CmDXDxdlEFsxJdW8GAAE
40UyuahRCsX/f3NRri66/PSGsn78QU616WGaHd7rzBRXnH/EcJMjBg79aWt4LW/G
34YDw3J98Im3Uf6hqOVVDmy90+3a9JO+6yiU9u80L54yrUmA03lRVkCx5yx3AJ3X
iEYnhpQ0X3ua3XvSAbnkMb5X4BzGgRHBiBohGWcgqrYuK1iUxoC6YpZyvoLV7maK
ejKW2VMy9S1UUF2mEosu7M5BsDI5WRiShko1XncP42+DsAJ9sdMM3RLzv/vELF8I
F56HYW4UuYBy8FtwH9d/h9ux8MeR+qRBGpodg74UL2YVWbIL03I=
=ARXp
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--

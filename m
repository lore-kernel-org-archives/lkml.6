Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0866DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965AF21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBnDvfer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfBTItO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:49:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34161 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfBTItO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:49:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so4154678wmd.1;
        Wed, 20 Feb 2019 00:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKxlfV+uXDkDdNFyyEqQqiY3VwxD/VDqhzLD0qKOAnk=;
        b=cBnDvferaUn1V012620RQQfls5rwDYbheYtjUtQwpnlJzEfQE4DXVPhcoQS+BHwM3f
         dw/ddxrX7qYNbXUAenoYIQ8D2qDC/M5uGdC4Mqi/hQbcbK+7vOxhtkaVHHltKAJQj9g3
         g7t+JSCtfJzIeZ4F93AjZgRvN+PmHDuXmpBQfXk4hevsSRm8oXT04W1Btqr8zSj02Gm9
         HAAYKiIqGMIVg7Owsiopbe6kQiIG74K1pugkZSIzcVuDmMp1R7TcMHtZwIKkYb//g2Kq
         NnDekHo4LO85YfV2reMycfYwDr6cTfun71ZOid8anUJSr3aI5+n6c1clIzvUjcyMP/kM
         v+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKxlfV+uXDkDdNFyyEqQqiY3VwxD/VDqhzLD0qKOAnk=;
        b=gQAxZmfoFjM/ne3oT1ikaf2ZwERbxjvaLX7hLQ/cbVcA1PAo4z6Vt6SzLszaHGBLvq
         HCenFYhFTftvCWn9rQhd5sXRhPEou3+SKMOmj7FIx8YHlVCzPrncd0mI14Wp17ig8cfr
         1Fi+Uegef06OjfV56CpVxehhAr/UA2igU9DqpigD0mIKQTSivug15TR0OPMtwdM6fMgp
         WC87ODx/XHkLIXSgOjZHLzQ0v7iSuj88wbPXMwHA6/J2tNQ6SyVDo2eI5FpTH3cMokpw
         R8YEia28ZpRLcAEP6H7iQ/thVxsSvdlGKq2XMrKahCEbc9Ok28oCxDs6ruqXt3O2SFiz
         Vtdg==
X-Gm-Message-State: AHQUAuarJ/Qm/sby9hp1EnpNf3tnhqd5J2Jr4krhxj4+xEbUMI5o4ATZ
        IGPum0aMgEuR7hFp3k4AMSs=
X-Google-Smtp-Source: AHgI3IYOfb86jVPN9tF+64pKPWhE/aqiI1LkBQrz3LtMJOeZwKwjSk9GvyBwuxI4LN9CY+2nLoBYbA==
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr5727908wme.135.1550652551135;
        Wed, 20 Feb 2019 00:49:11 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id r6sm6677467wrx.48.2019.02.20.00.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 00:49:10 -0800 (PST)
Date:   Wed, 20 Feb 2019 09:49:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reset: Don't WARN if trying to get a used reset control
Message-ID: <20190220084908.GA21299@ulmo>
References: <1548849808.3939.7.camel@pengutronix.de>
 <20190201140025.GB12829@ulmo>
 <1549389941.3929.14.camel@pengutronix.de>
 <20190205221300.GA1372@mithrandir>
 <1549448885.3338.4.camel@pengutronix.de>
 <20190206113849.GA21676@ulmo>
 <1549464390.3338.8.camel@pengutronix.de>
 <20190206160023.GA23805@ulmo>
 <1549476724.3338.10.camel@pengutronix.de>
 <20190207082751.GA29438@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190207082751.GA29438@ulmo>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 09:27:51AM +0100, Thierry Reding wrote:
> On Wed, Feb 06, 2019 at 07:12:04PM +0100, Philipp Zabel wrote:
> > On Wed, 2019-02-06 at 17:00 +0100, Thierry Reding wrote:
> [...]
> > > That way we operate on the same reset control, but we wouldn't need to
> > > iterate over all existing reset controls in order to determine whether
> > > we can acquire or not.
> >=20
> > How could we decide in reset_control_assert whether the provided rstc is
> > allowed to change the reset line if both rstc handles point to the same
> > struct reset_control?
>=20
> The idea was that acquire/release would basically act as lock/unlock for
> the reset control. So consumers would always have to call acquire()
> before assert()/deassert()/reset() and they would be allowed to continue
> only if acquire() returns success. Of course that's something you can
> only enforce during code review, but that's pretty much the same as with
> any type of locking.
>=20
> So basically the idea is that if a consumers acquire() call succeeds,
> the acquired flag gets set on the reset control and that consumer
> becomes the only user allowed to modify the reset control. Any other
> consumers would call acquire() and fail because the acquired is already
> true.
>=20
> But what you proposed works for me. We can always find constructive ways
> to optimize this later if we need or want to.
>=20
> Another possibility would be to keep an additional, separate list of the
> temporarily exclusive resets so that only that list would have to be
> iterated to find the ones that are relevant.
>=20
> > > >  			if (WARN_ON(!rstc->shared || !shared))
> > > >  				return ERR_PTR(-EBUSY);
> > >=20
> > > With the above I think we could just extend this list of conditions w=
ith
> > >=20
> > > 	|| acquired
> > >=20
> > > and things should work the same. Or perhaps I'm missing something.
> > >
> > > Other than that this really looks like a very nice solution.
> >=20
> > Well, apart from the API function names...
> > devm_reset_control_get_optional_exclusive_released(dev, "id");
> > would be a mouthful.
>=20
> Yeah, the combinations are somewhat awkward. However, I would expect the
> temporarily exclusive resets to be required in most cases, so that would
> at least make the name a little shorter.

Quick update: I finally had a bit of time to look at this and I've got
something that works. There were a couple of minor issues with the patch
and I had to extend support for acquire/release to reset arrays for this
particular use-case, but overall it seems to be working pretty well.

I'll clean up the patches that I have and then send out for review. It's
unfortunately going to be a bit of a mess staging these changes since
they are spread over three different subsystems and I think there can be
subtle failures between the PMC and SOR patches, so perhaps it'd be best
to apply those to one tree, or maybe even squash the changes into a
single commit to avoid any surprises.

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxtFIEACgkQ3SOs138+
s6H9EA/9FxY10esYYvhZTftxJATt89nBbxmjmWuk4f82O6/vmoJCVHL+eaxh1cFf
4z3W56tmppyzjsnXEXVJUlk/HeYrSyeYEy6smkIbf1INHbLRab9gQJUOxTRV7sv4
2vKVFkcClfEO0fu8pB/SgRKlhVIWdQSqjkK9s+yCEHAbF8DoaynRVfXUc7UJboUc
kFJbYkNTYR4RLHl3eEUudApEWMzJZFyVtXixZrtVjrICoMlMcQz6QKDnaFjGmirf
EmKRzfjY0+gUai/YuvS7xkxywY2/VMPN9L5RGTBmEvyCOEQcZCu5DPWq34HwMwen
hoBIXtBAOHWB5mqrdx3VbgveZA0d3SVnQq44brUFCc2/OAyLGtxvTASZZMxXimkp
YT0GPddHWSnBwqOv1RlM1XrmlcZZ/uf03vq1QbTLZk8K+wpn0uBEpi9ofxNmCElb
fkbmVTcXcQVpEiC3qrhIcHvPHbIoduvXTrMUKf1HFDkuD8+3mnoWZ76RszUBH8Uz
DcIP8gOhBcapdFzBT+T5yBQOEzZqF9q45ShuCZWRbuMofu/pocmLLwhvmJ5R1yxq
K6GBOdWUmECps9x3PJ8cIEH1qlzFVe+TqQlu0L3NP88tK5vw8iKMyoEpDWpybFJ2
2sg+s46e3NGgdmvY6FG7rtOKm54N/zaZdVUhu7sIa0e1YVXkX/c=
=/U/s
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

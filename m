Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76BDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDF121924
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390899AbeLUOu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:50:26 -0500
Received: from sauhun.de ([88.99.104.3]:43864 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387417AbeLUOu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:50:26 -0500
Received: from localhost (p54B334FA.dip0.t-ipconnect.de [84.179.52.250])
        by pokefinder.org (Postfix) with ESMTPSA id ABBF62E3542;
        Fri, 21 Dec 2018 15:50:22 +0100 (CET)
Date:   Fri, 21 Dec 2018 15:50:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Message-ID: <20181221145022.umsugdwadw5a5ag6@ninjato>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2jmrr4347zzegwl"
Content-Disposition: inline
In-Reply-To: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2jmrr4347zzegwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > I think this might be as simple as adding:
> > >=20
> > > 	if (WARN_ON(adap->dev.parent->power.is_suspended))
> > > 		return -ESHUTDOWN;

Peter, I think this should work for muxes, too, or? The i2c_transfer()
call to the mux will not be rejected, but it will be later when we reach
the root adapter. And then the error code will be pushed down the tree
until we arrive at the mux again. So, the rejection will not happen at
the earliest time, but it will happen. Is my understanding correct?

> > I have seen this flag but decided against it. One reason is because it
> > is marked as "PM core only".
>=20
> Right and we definitely should not be touching it, but reading it should
> be fine.

Seems like it. So far, no rejection from the other PM people :)

> No you are right, there is a race here, but I don't think we are likely to
> hit that race. Normally there won't be any ongoing i2c-transfers during
> a system suspend and more over, the goal of adding this check is to help
> find problems, so even if the check sometimes does not trigger because
> of the race that is not really a big deal.

You are right that the impact of a missed detection is not fatal. That
helps. The low likeliness was not an argument for me, though, because
detecting rare things is very important IMO. Because, well, they are
rare and especially hard to debug.

> I think we need to get really unlucky to have both a suspend ordering
> problem in the first case (already a somewhat rare thing) combined with
> hitting this race in such a way *each time* that we don't trigger the
> WARN_ON.

And here you convinced me: even if we miss a detection once, I agree it
is super super unlikely to hit the race every time.

> To me this seems a case of perfect being the enemy of good. When we
> first started discussing this you wanted to not have to modify the
> adapter/bus drivers for the check, using adap->dev.parent->power.is_suspe=
nded
> gives us that and it will also work for complex cases like
> the i2c-designware case, so I believe the benefits outway the downsides.

I'll try it.


--s2jmrr4347zzegwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwc/aoACgkQFA3kzBSg
Kbb5bQ//URYlNvbXXExtMF0qLfiMDARGWqfm2kgBo2NeAlG+mCOpUuKOdjzF2Xbc
32cnfKCyw1bvKLMTyLLdaEzuQihOCUlKSsc1le6qepNiOvedI6Tp9XfS17Q6Z73K
fJLIjImgM5ZHOEN0y2GnSfz3QxM265h5VUBqyZzfkAddi5QrDwDP1wniTXVrw0Z7
04q1EQ1ypXbgvkHgRtnzg/gv5OkmovUEV7QBFS9U8RchgiXmYOvlJZkR/l4ZW60K
PEqv6IuBgfC6ikHMaRyovnhVm2jiEm6bsLi/RgwJxxAWPwFJaFcF2hf4r6rnBSi4
sZrDP0jOQxKARqKaiRv/Szp2RlJY5f/PFsrmwDt/LD7F591vhVZdG8/mO4oYLphd
pKgnu2VBFENJVEMVZ76KbhAGz6J4mh+agjOlX0NKKXWO/au0+qFWVrcqJfP0VbiC
CL7Dux/fjMsBvmDwaawP0uR2dSsKgnL8YQhDDxjN9PXU/RmFzF1dpGaAa/nuXKVZ
8KsbZaricdNv+jrHLklZPTZi9a9hTJrOtjeTvbYt2DLpitZRdiTjtC6bds9sWisz
4SGO8KMgxm0tBMSwsTIYNmMA8d/5AdVMCtPxlrUXk7AgPFjzAhU/li+emcQ5pUO4
GkrPLtjbUll25du9Gr4O1I6qcq+x7hwgBr4uSClf63QizTK4L24=
=LQSI
-----END PGP SIGNATURE-----

--s2jmrr4347zzegwl--

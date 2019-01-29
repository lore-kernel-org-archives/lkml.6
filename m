Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A202175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548780121;
	bh=mTK6bKsVqPFWYZ6gksqc/vWAZYxKnqI6k/Z4AdfTk3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vc3vV2CK0/FSbCzLCLg9yUYowvNNYajEJRgnnABmZWpQMvM3HSDoRS71lhp8tuSJD
	 pYdDH9MrA4p56jL8LQGaSc+8xb8BHRnTBFzxMgVZ2eMM0PmEIUa3JjstZqGa+eYyV1
	 STsNMPT4Sn03Ux0wgXZ5m2UegYkji/QLCy9zLPfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfA2Ql7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:41:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49252 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2Ql6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=szjOlRlI7uBF/W5HaG9wUCokli/J7uBg1nefJhg9Kjs=; b=uHBlZn7WjNZF8Ww9wughdpM+q
        uXzkAQw0IgZHqob8ryXj6wxRRdN9ZrTFh3t6naWE0x8OTlxvuu4HADGSaO/LvAUG04w09a50csJyM
        1jNpp85n6Wm7jO+Bdh4QD95sWNSuc15/FRE0qZwz6MIg+o5WKqjFsaHcupoBIGa87nbuU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1goWSG-0000Zd-8d; Tue, 29 Jan 2019 16:41:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9847F1127D50; Tue, 29 Jan 2019 16:41:43 +0000 (GMT)
Date:   Tue, 29 Jan 2019 16:41:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Baolin Wang <baolin.wang@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>
Subject: Re: [PATCH v3 1/2] spi: support inter-word delay requirement for
 devices
Message-ID: <20190129164143.GF10524@sirena.org.uk>
References: <20190126163220.26421-1-jonas@norrbonn.se>
 <20190126163220.26421-2-jonas@norrbonn.se>
 <20190128181038.GF11699@sirena.org.uk>
 <1b9807aa-3e6e-16f2-a2c2-ebe5e186d904@norrbonn.se>
 <CAMz4kuK9HAmntmqG-_s6re854tK7UL6wwCh0Lm8=bzpFZsseaw@mail.gmail.com>
 <28617b72-fbc0-4274-d9d1-34c37f03f867@norrbonn.se>
 <CAMz4kuLOSx9mQ-RG9qqy9Qbor97Nj5oYdOgLg_dNfxFeT+XK5g@mail.gmail.com>
 <abb0749c-629f-5a81-1dba-0be260b0fb8d@norrbonn.se>
 <CAMuHMdXyuWMPUdipwW0oQUdPLDyZhssZ1NHQfMF9hWTtMkTZ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXyuWMPUdipwW0oQUdPLDyZhssZ1NHQfMF9hWTtMkTZ1A@mail.gmail.com>
X-Cookie: What foods these morsels be!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 29, 2019 at 11:07:50AM +0100, Geert Uytterhoeven wrote:
> On Tue, Jan 29, 2019 at 10:50 AM Jonas Bonn <jonas@norrbonn.se> wrote:

> > OK.  So the user (perhaps in userspace using spidev) has to know the
> > rate of the IO clock that the SPI controller sits behind and then has to
> > match this to the required delay of the slave device...  Doesn't sound
> > very portable.

I think if we're doing translation we should just do it in the core and
either say that clients should only set one or the other or pick what
looks like the higher value.

> I can see the value of having both:
> On some slaves, the delay may depend on a fixed internal or
> external clock[1] on the SPI slave, so it should be specified in time units.
> Some slaves may be clocked by the SPI clock[2], so the delay should be
> specified in SPI clock cycles.

Yes, they're definitely both useful.

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQgkYACgkQJNaLcl1U
h9BpcQf/ccdkXJ6vmh0isqva90NnEMmC8ctfpWCZ1lh5senmjaIQrllQrXgfsAkm
9V/XOGrByMBLbS1U5dBaA3CPcWuZjtph1axjDkhJy2GG5e+gDZNIFq4sTQvSmTCS
nb8DQgRtHbz/RGFuaW7frG9gCDbQb9T7FSvuLaGFrPABiUJKLKGkRgm3tpxrXXPd
Bo3UGsJgPiO9mjI7IZO60aXSgS46rsE+hnfiJ1v3fc/8ySa6w5zsU6bJh2g8hGj1
ti6kAIrk3dicYPzhSkfgwdNFeJ/din8SBITm04xLbUA4GAFxyWCnohbRDZdZPHHb
LBkls9P3mXpe3gV/9oxc5YGkE0kBzg==
=vhvC
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

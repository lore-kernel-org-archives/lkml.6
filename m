Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A83EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070EB218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="AQP2qlzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeL0UND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 15:13:03 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:60784 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729494AbeL0UNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 15:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tUF3Nc9Cy2Iu7AF/uNSRNI7ASH7L3YuDeGvyAj2YKbA=; b=AQP2qlzvsCbFeNC+yB7i65MAO
        olJy7Np4GGA7nZvCL5zSEtbVAOG7X/npOHMWEBVKwPHVrbJRFK0EWgeqh4EjnyoDCOd+9uL8Xch8a
        ptByLVC3mTMRDZJfnmqZmJ84uVqnlTVdMBnaV2txWE8SOUCHLxG54vNuVpW1yVJK0UEa4=;
Received: from p5dcc3f32.dip0.t-ipconnect.de ([93.204.63.50] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gcc1S-0006RY-Ed; Thu, 27 Dec 2018 21:12:50 +0100
Date:   Thu, 27 Dec 2018 21:12:22 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        bcousson@baylibre.com, letux-kernel@openphoenux.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Message-ID: <20181227211222.5996c356@aktux>
In-Reply-To: <20181204164556.GB6707@atomide.com>
References: <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
        <20181130071534.0a6cd455@kemnade.info>
        <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
        <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
        <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
        <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
        <20181130153729.GG53235@atomide.com>
        <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
        <20181203153910.GA6707@atomide.com>
        <20181203172246.0e767a16@kemnade.info>
        <20181204164556.GB6707@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TIvixuQ9bzfDR./7PwxIb2L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TIvixuQ9bzfDR./7PwxIb2L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 4 Dec 2018 08:45:57 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
> > On Mon, 3 Dec 2018 07:39:10 -0800
> > Tony Lindgren <tony@atomide.com> wrote: =20
> > > The consumer device stays active just fine with PM runtime
> > > calls. So yes, the problem is keeping a clock controller forced
> > > active for the period of consumer device reset. Other than
> > > that typically autoidle can be just kept enabled.
> > >  =20
> > Are we still talking about the same problem? Maybe I am losing track
> > here. Just to make sure.=20
> > The patch series was about disabling autoidle for devices which cannot
> > work with it during normal operation. Not during reset or something
> > like that.=20
> > Or is the keep-clock-active-during-reset just a requirement for bigger
> > restructuring ideas? =20
>=20
> Yeah there are two issues: The fix needed for the issue you brought up,
> and also how to let a reset driver to block autoidle for reset.
>=20
Hmm, is this set now waiting for the famous "somebody" fixing all
the stuff?
What are currently visible symptoms for the driver not blocking
autoidle for reset? Maybe I can at least test something there. I have
also omap5 here.

Regards,
Andreas

--Sig_/TIvixuQ9bzfDR./7PwxIb2L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlwlMiYACgkQfb1qx03i
kySS0xAArFtcBqNv3FgSHyXCkCfojx8xM1WGyVr+paQgNoOZtmThhgTTi1CEgQ4a
ElAK5Lp7sl1JeYmqIP/XYHBkFDRfavWRIGU1ZggahsP5gmalPZV1k7HtkCGaubua
5pVvpmNYy4txp7oatJ4FpQJKAiyXqz9u6on4t2uUdOxqDIJWpnP/3EHORjiXzel4
Ss4P712YS42TsKsCvdwNNXAMNtci1GyDZ0OWYITBgW+bqzIV+qWgaNAX6g2q+1rd
0lmqTllP2N9KRLQ8dteBYlDQiB2A7GSblynObVnaRWGN/1/gFgbQ87SoSbyaFvXT
4gmypEeB9Sh/vkg9Jjjxq7gkpV6v3STXIy8Dx7jY0I1/Wtd4KRhJYApOs2xQqZo0
iOZqSflhm3/np3ldpxkZYb0IEqFHPZzYzfjlmNxYojpJ8qInrMF1sVcvpRFPNh/p
mIx7bHF37KOmex/+H1GBHWTuAvEitrNHAYT3JdpKxVHfOJX/b7H0OhZXjnQ6Mvvm
VAqWEBkjueo0wEH4cfMz3yxftEpjAYgBnOb7KLfinc38gS4PQWMEun6YyWTg8Z4E
SSJvK3BYPXNZT1HLjlhB4W4JtzNtKbIqwJAOBahiK0KgHHNRg3FV+KE9ZdwMxX6O
T+z8EQLrsdFkS5vM6LNJn7JbgSix33pO9X20xE50sLvCmqEEfrw=
=5Sng
-----END PGP SIGNATURE-----

--Sig_/TIvixuQ9bzfDR./7PwxIb2L--

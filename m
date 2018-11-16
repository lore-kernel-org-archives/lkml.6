Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EF92086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EF92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389627AbeKPU70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:59:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43899 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbeKPU7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:59:25 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D66E720756; Fri, 16 Nov 2018 11:47:36 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 01D5B206D8;
        Fri, 16 Nov 2018 11:47:22 +0100 (CET)
Date:   Fri, 16 Nov 2018 11:47:22 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH] media: cedrus: Remove global IRQ spin lock from the
 driver
Message-ID: <20181116104722.akw7bz6zirsslh3s@flea>
References: <20181115143955.2645-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kshuqsjlqpdindje"
Content-Disposition: inline
In-Reply-To: <20181115143955.2645-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kshuqsjlqpdindje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 03:39:55PM +0100, Paul Kocialkowski wrote:
> We initially introduced a spin lock to ensure that the VPU registers
> are not accessed concurrently between our setup function and IRQ
> handler. Because the V4L2 M2M API only allows one job to run at a time
> and our jobs are completed following the IRQ handler, there is actually
> no chance of an interrupt happening while programming the VPU registers.

That's not entirely true. There's no chance that the interrupt
signaling the end of the frame decoding can happen.

However, spurious interrupts can happen at any point in time as soon
as you have the interrupts enabled.

> In addition, holding a spin lock is problematic when doing more than
> simply configuring the registers in the setup operation. H.265 support
> currently involves a CMA allocation in that step, which is not
> compatible with an atomic context.

That's not really true either. Any allocation can be done with
GFP_ATOMIC or GFP_NOWAIT, and be compatible with an atomic
context. Whether it's something we want is a different story :)

And since the h265 code isn't upstream, I'm not really sure it's
relevant to mention it here.

> As a result, remove the global IRQ spin lock.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--kshuqsjlqpdindje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW+6gOgAKCRDj7w1vZxhR
xZJKAQDma4sonvXJs2sfUHFmtEqAS17djF91zRNp0swAh6WiMQD/cOE0xcHX4IKN
ZYcsc/V3TPohLsKQb8TFXoM7oDo3FAw=
=jeNa
-----END PGP SIGNATURE-----

--kshuqsjlqpdindje--

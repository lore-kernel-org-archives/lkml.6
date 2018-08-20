Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD90C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DBA20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DBA20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeHTNL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:11:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35188 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbeHTNL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:11:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 18F7020DEE; Mon, 20 Aug 2018 11:56:57 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-85-9.w90-88.abo.wanadoo.fr [90.88.27.9])
        by mail.bootlin.com (Postfix) with ESMTPSA id DBFC920703;
        Mon, 20 Aug 2018 11:56:56 +0200 (CEST)
Date:   Mon, 20 Aug 2018 11:56:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] drm/sun4i: Avoid failing to init fbdev without any
 connector
Message-ID: <20180820095657.rcs3wxikxprty55d@flea>
References: <20180807193919.4800-1-contact@paulk.fr>
 <20180807201801.GF3008@phenom.ffwll.local>
 <230112e8b2ad4b4e53b54fe1446e7f71aa09e514.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="brph2bwq7h4vdshc"
Content-Disposition: inline
In-Reply-To: <230112e8b2ad4b4e53b54fe1446e7f71aa09e514.camel@paulk.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--brph2bwq7h4vdshc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 07, 2018 at 10:31:30PM +0200, Paul Kocialkowski wrote:
> Hi,
>=20
> Le mardi 07 ao=FBt 2018 =E0 22:18 +0200, Daniel Vetter a =E9crit :
> > On Tue, Aug 07, 2018 at 09:39:19PM +0200, Paul Kocialkowski wrote:
> > > Initializing and registering fbdev requires at least one DRM connector
> > > and will fail otherwise. In order to support headless setups (for
> > > instance for GPU rendering with the GBM backend, where a DRI card node
> > > is required to provide GEM memory reservation), add a check on the
> > > number of registered connectors before initializing fbdev.
> >=20
> > sun4i is a pure kms driver, why exactly do you need it for gbm backed
> > rendering? What exactly is rendering here, and why does it insist on a
> > display card node, even if that display card node is 100% defunct?
>=20
> The non-free Mali blobs provide GPU support with a GBM interface that
> takes a DRM fd in order to reserve the memory it needs for its rendering
> targets. This uses the GEM interface available through the DRI card node
> (and there is no render node with the non-free Mali driver). Allwinner
> has a minimalistic out-of-tree driver pretty much only for this purpose.
>=20
> I crafted this patch when someone on IRC tried to get the out-of-tree
> Mali GPU driver going with the mainline kernel in order to do rendering
> in a GBM buffer, since it's apparently the only option for headless
> rendering with the blob.
>=20
> In my opinion, supporting the pipeline of an out-of-tree GPU driver that
> only works with a non-free userspace blob is not a valid reason to do
> anything. Still, it felt like adding support for the headless use-case
> wouldn't hurt, whatever the underlying use case for it may be.

If you start considering the DMA constraints and the API in itself, it
does hurt. You'll get buffers that are not meant for the GPU, and
might not be accessible, and from another device without using
dma-buf, which again works because the hardware is dumb enough, but is
breaking a lot of expectations in the process.

If one wants to do headless rendering, mali-drm or lima looks like a
better solution.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--brph2bwq7h4vdshc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlt6kGgACgkQ0rTAlCFN
r3QvMw/+ONJADCO6KUornzlgOakDTKkCVgTK9/SouB4ykqlQulFygTjAkzUiZfbg
9A4E4DvU1DqJY+/ihqaoNZ1x3Stse7Ip/J3arWbs0lgn/5IxOXGMVFmxPr2EJ9XP
lthNuB8ufC++PiY3zUORqMgXDtfmxOEI962PtaqxuFnf3RYjf4GgZzkOzs+y9xwe
2RerAB54hM1h0f+NyVZVCNw7jxvlJLO61IvEp6xPBrRQxypq5AVcQR5zyzbuVfl+
6ITdRfeNPkFT0vHnSiCpBV/f8/9FFA+kjHxcTU7yR5Nd4KDGqsph84CtwaOvuJUP
+HC6TD+ahnlVyV80FWe/fbbvdXBH93W0akOqSlvzZT3RuouoWTz1LOXmePSHHap/
o+3B9xPbo3VXhoNxUhmy1S6akSkief/JAXPxYJbG1pZ+ZMwl+fAOoYEfKruI7Ka8
7BsQPKNPFQFJKgCm+9OhXHtC6AuYpmtZr9W0hRiVOt5YJSjBKIHt2QEJLncDBRSF
ZnP4O+wS0dtzu7s5UpISX6K1xmUTisTpN+kgR7H2J5+iFUe0RMpGXodi8peR61g8
s8r2S1a/AFSPx48ygPQH2LQ/2FczoIrJ6B9mrGeNcNGQKyDFZLqNSDAvMaJyZOCI
L57LVkvq5KKG1iBYdxWevLjRE3/PXMookUXBRZsTjfGKeAwgcEE=
=Oi5c
-----END PGP SIGNATURE-----

--brph2bwq7h4vdshc--

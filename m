Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B547EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9108C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733155AbeLQOGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:06:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55452 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbeLQOGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:06:36 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2DC4320CE3; Mon, 17 Dec 2018 15:06:33 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-89-7.w90-88.abo.wanadoo.fr [90.88.30.7])
        by mail.bootlin.com (Postfix) with ESMTPSA id EDFE820711;
        Mon, 17 Dec 2018 15:06:22 +0100 (CET)
Date:   Mon, 17 Dec 2018 15:06:23 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 0/5] phy: core: rework phy_set_mode to accept phy mode
 and submode
Message-ID: <20181217140623.2zze2kfclup7wjti@flea>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="553g4on6q5epsg5z"
Content-Disposition: inline
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--553g4on6q5epsg5z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Grygorii, Kishon,

On Mon, Nov 19, 2018 at 07:24:19PM -0600, Grygorii Strashko wrote:
> Thank you for your review.
> I've not added "Tested-by"/"Acked-by" tags due to code changes in v3.
>=20
> As was discussed in [1] I'm posting series which introduces rework of
> phy_set_mode to accept phy mode and submode. I've dropped TI specific pat=
ches as
> this change is pretty big by itself.
>=20
> Patch 1 is cumulative change which refactors PHY framework code to
> support dual level PHYs mode configuration - PHY mode and PHY submode. It
> extends .set_mode() callback to support additional parameter "int submode"
> and converts all corresponding PHY drivers to support new .set_mode()
> callback declaration.
> The new extended PHY API
>  int phy_set_mode_ext(struct phy *phy, enum phy_mode mode, int submode)
> is introduced to support dual level PHYs mode configuration and existing
> phy_set_mode() API is converted to macros, so PHY framework consumers do
> not need to be changed (~21 matches).
>=20
> Patches 2-4: Add new PHY's mode to be used by Ethernet PHY interface driv=
ers or
> multipurpose PHYs like serdes and convert ocelot-serdes and mvebu-cp110-c=
omphy
> PHY drivers to use recently introduced PHY_MODE_ETHERNET and phy_set_mode=
_ext().
>=20
> Patch 5 - removes unused, ethernet specific phy modes from enum phy_mode.
>=20
> Testing:
>  - series tested on TI am335x/am437x/am5(dra7) paltforms.
>  - other driver build tested.

I realise I'm a bit late to the party, but while working on the D-PHY
support, I noticed a few things that could be improved.

I guess the main issue is that the sub-mode is completely opaque to
the generic phy framework now. This might not be a big issue, and I
assume that it has been done that way because the net framework
already has a define for the submode it wants.

However, this creates a bunch of drawbacks at the phy framework level:

 - phy_set_mode will now pass a submode of 0, all the time. This means
   that the behaviour is undefined for all the modes not using the
   submodes at the moment, and phy_interface_t seems to have the value
   PHY_INTERFACE_MODE_NA matching 0, but I guess this could change in
   the future (or the guarantee is not documented anywhere).
 - on a similar note, there's no documentation for which value to pass
   to phy_set_mode_ext when used with something else than a
   PHY_MODE_ETHERNET.
 - at the provider level, if you're supporting a phy that isn't using
   the submodes, you have no way to filter out or reject any subnode,
   since you have no idea what the "no submode" value is.

I guess this can be addressed by:

A) defining a generic phy framework wide unused / invalid phy submode,
that wouldn't collide with the subnode values (such as -1?), and
making phy_set_mode_ext use that.

B) moving the phy submodes definition to the generic phy headers. This
would allow to have a documented, obvious link between a mode and its
subnodes, for all the actors involved (consumer, provider, and
framework) without prior knowledge.

C) Document what the submodes expectations are

What do you think?
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--553g4on6q5epsg5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXBetXwAKCRDj7w1vZxhR
xeUGAQCR50AQDteX+9l+EKki80/VMKbK438CYL7PPVfr3Qu84AEAjDNV9Y+LVbAp
XRC0B5OfKDq6wnecuDvlw4UyOlmKWAo=
=hd40
-----END PGP SIGNATURE-----

--553g4on6q5epsg5z--

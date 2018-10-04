Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8A5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD5120684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD5120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJDTrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:47:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37646 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbeJDTrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:47:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 71F14207B4; Thu,  4 Oct 2018 14:53:58 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1535620802;
        Thu,  4 Oct 2018 14:53:48 +0200 (CEST)
Date:   Thu, 4 Oct 2018 14:53:47 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 4/7] net: phy: mscc: add support for VSC8574 PHY
Message-ID: <20181004125347.p4hzna4rbanvgsbn@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <236ef7815c0bec6048e79ef06868719b65c63892.1536916714.git-series.quentin.schulz@bootlin.com>
 <bc95fae7-cf2f-5cf1-4e24-59fcc231fd64@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="33w5ejf5ircqd4gw"
Content-Disposition: inline
In-Reply-To: <bc95fae7-cf2f-5cf1-4e24-59fcc231fd64@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--33w5ejf5ircqd4gw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Fri, Sep 14, 2018 at 01:26:06PM -0700, Florian Fainelli wrote:
> On 09/14/2018 02:44 AM, Quentin Schulz wrote:
> > The VSC8574 PHY is a 4-ports PHY that is 10/100/1000BASE-T, 100BASE-FX,
> > 1000BASE-X and triple-speed copper SFP capable, can communicate with
> > the MAC via SGMII, QSGMII or 1000BASE-X, supports WOL, downshifting and
> > can set the blinking pattern of each of its 4 LEDs, supports SyncE as
> > well as HP Auto-MDIX detection.
> >=20
> > This adds support for 10/100/1000BASE-T, SGMII/QSGMII link with the MAC,
> > WOL, downshifting, HP Auto-MDIX detection and blinking pattern for its 4
> > LEDs.
> >=20
> > The VSC8574 has also an internal Intel 8051 microcontroller whose
> > firmware needs to be patched when the PHY is reset. If the 8051's
> > firmware has the expected CRC, its patching can be skipped. The
> > microcontroller can be accessed from any port of the PHY, though the CRC
> > function can only be done through the PHY that is the base PHY of the
> > package (internal address 0) due to a limitation of the firmware.
> >=20
> > The GPIO register bank is a set of registers that are common to all PHYs
> > in the package. So any modification in any register of this bank affects
> > all PHYs of the package.
> >=20
> > If the PHYs haven't been reset before booting the Linux kernel and were
> > configured to use interrupts for e.g. link status updates, it is
> > required to clear the interrupts mask register of all PHYs before being
> > able to use interrupts with any PHY. The first PHY of the package that
> > will be init will take care of clearing all PHYs interrupts mask
> > registers. Thus, we need to keep track of the init sequence in the
> > package, if it's already been done or if it's to be done.
> >=20
> > Most of the init sequence of a PHY of the package is common to all PHYs
> > in the package, thus we use the SMI broadcast feature which enables us
> > to propagate a write in one register of one PHY to all PHYs in the
> > package.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
>=20
> [snip]
>=20
> > +	reg =3D __mdiobus_read(bus, phy, MSCC_PHY_TEST_PAGE_8);
> > +	reg |=3D 0x8000;
>=20
> Having a define would be nice here? This looks like a write enable?
>=20

Same as for the SerDes muxing patch series, I'm sending a new version
without the suggested change. I've requested some information on this
bit but can't guarantee I'll get anything (and if anything, worthy).

I'll try not to forget to add a constant if and when I get a clue on
what this bit does.

Thanks,
Quentin

--33w5ejf5ircqd4gw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu2DVsACgkQhLiadT7g
8aN9Eg/+MxF91BbA3+0EjFO80hiu2B47CAKbO6ciF4dlldlX+VCVxC/QwebTa9OU
AuxWDzKktSnX50aORUb6VtQNMu/hSOzG6Ix+0Q9+HyuIhJiqNd8o17+GDqieGYDi
YR1JKdlwb9Dn7HWZzuFjjl7/1EEOP3Mn3uivSzRAtNgVFDse9xfxian0/twGBLWM
xmL/qTeb7EU0WUtqC6dwax0Cy2kOsuVai5BxhFueOf+yKZ+bY1q4wE0q1t33reD/
4/QPtgR0R3fV1+Uan6SbdNe7VkzANojZ5P/NsaEkYHmS63cuv2td9dO62iJx43To
KJtaaSNzfKF6HXKjI9fIXzoMA1rW9L2BlGmmleIT0YqeBpghc67lYrSmkVl/Bl/c
4ZUpr+5cs3tUtcVqqK82kJGIdJ9LsaKV49DEdB1zJPEywgC/4WilNWGv2Inihv2S
pii0T2Qkau2tu8Vt4C0b0gmoCgxuVpbA3QuAxF5ywrNcWnNp9n9SvESvPHoOkdI0
qFcTxFe9Iqi0p1j4GikxGq4T0S7J64+d9O6kWEBxJxZfiUcU7eEFUVYrVwhFKtnB
hszQfHvi4XB5x3zt3lKn3n/JZi5CNBve345xlR0T2DsZK9cN2U4JDKjDLo85KBOo
6AFIGHJepLXQ9baJbsoKasZ37Iu2AOJLMQQ63Nai7JXu78kv4ng=
=qxYo
-----END PGP SIGNATURE-----

--33w5ejf5ircqd4gw--

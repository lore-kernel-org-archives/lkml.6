Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4332C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750752147D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750752147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJDTNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:13:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35586 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbeJDTNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:13:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 09BC92072C; Thu,  4 Oct 2018 14:20:17 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8682E20618;
        Thu,  4 Oct 2018 14:20:16 +0200 (CEST)
Date:   Thu, 4 Oct 2018 14:20:16 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, allan.nielsen@microchip.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next v3 11/11] net: mscc: ocelot: make use of SerDes
 PHYs for handling their configuration
Message-ID: <20181004122016.udpugy65sam6m2si@qschulz>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <00989856964175eafbe1435a70862c2ac66cffc0.1536912834.git-series.quentin.schulz@bootlin.com>
 <0f762d63-a392-d2fe-a121-a013a13a8584@gmail.com>
 <20181001094245.cr4hdcechrqkjymq@qschulz>
 <228f9d74-be17-5157-9755-b265a6e234b8@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dys5m2n3k3cy45ea"
Content-Disposition: inline
In-Reply-To: <228f9d74-be17-5157-9755-b265a6e234b8@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dys5m2n3k3cy45ea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Mon, Oct 01, 2018 at 09:29:07AM -0700, Florian Fainelli wrote:
> On 10/01/2018 02:42 AM, Quentin Schulz wrote:
> > Hi Florian,
> >=20
> > On Sat, Sep 15, 2018 at 02:25:05PM -0700, Florian Fainelli wrote:
> >>
> >>
> >> On 09/14/18 01:16, Quentin Schulz wrote:
> >>> Previously, the SerDes muxing was hardcoded to a given mode in the MAC
> >>> controller driver. Now, the SerDes muxing is configured within the
> >>> Device Tree and is enforced in the MAC controller driver so we can ha=
ve
> >>> a lot of different SerDes configurations.
> >>>
> >>> Make use of the SerDes PHYs in the MAC controller to set up the SerDes
> >>> according to the SerDes<->switch port mapping and the communication m=
ode
> >>> with the Ethernet PHY.
> >>
> >> This looks good, just a few comments below:
> >>
> >> [snip]
> >>
> >>> +		err =3D of_get_phy_mode(portnp);
> >>> +		if (err < 0)
> >>> +			ocelot->ports[port]->phy_mode =3D PHY_INTERFACE_MODE_NA;
> >>> +		else
> >>> +			ocelot->ports[port]->phy_mode =3D err;
> >>> +
> >>> +		switch (ocelot->ports[port]->phy_mode) {
> >>> +		case PHY_INTERFACE_MODE_NA:
> >>> +			continue;
> >>
> >> Would not you want to issue a message indicating that the Device Tree
> >> must be updated here? AFAICT with your patch series, this should no
> >> longer be a condition that you will hit unless you kept the old DTB
> >> around, right?
> >>
> >=20
> > It'll occur for internal PHYs. On the PCB123[1], there are four of them,
> > so we need to be able to give no mode in the DT for those. For the
> > upcoming PCB120, there'll be 4 external PHYs that require a mode in the
> > DT and 4 internal PHYs that do not require any mode. I could put a debug
> > message that says this or that PHY is configured as an internal PHY but
> > I wouldn't put a message that is printed with the default log level.
> >=20
> > So I think we should keep it, shouldn't we?
>=20
> Internal PHYs either use a standard connection internally (e.g: GMII) or
> they are using a proprietary connection interface, in which case
> phy-mode =3D "internal" is what we defined to represent those.
>=20

Just to let you know that I'll send a new version in a few minutes that
does not contain the requested change. I don't have the information yet,
I know it's MII compatible but nothing more.
I haven't forgotten (yet; so don't hesitate to tell me if I do) your
suggestion.

Two thoughts:
1) Doing what you suggested is rather straightforward once I have the
information so it does not impact the actual overall behaviour of the
driver (reviewable as is),

2) The current behaviour aligns with the behaviour induced by the code
snippet above, so we don't break anything or introduce any change in
behaviour. Once I have an answer, I could always send a small patch for
this if the driver gets merged before, which would also change the DT
(to add the phy-mode property).

Thanks,
Quentin

--dys5m2n3k3cy45ea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu2BYAACgkQhLiadT7g
8aPTjA/6A1UsA2NoZ6pCfL9gEMekhK5C/6ZIvr3IY+u5A2Q2dGmIFbROpGF4U3Mj
od/QtZmKCGiG5v9O2ra4jOVTDunGslvv1u9rAQwIcFuNBPGEWrNV+h2HmXOWANly
V6DfiFF3D99cWLk89f3XeJKgJY1ad58A/lj03UnzGnW5WWGwACDu2VBP4tczC4JN
kVLrQx/eQSZZGfF5rUUXpOMc27n2DJ07nafQ9Cc0DZtuP003p3QnT0NtbIZxY4vV
UYM6fohjqtZH9MRFaxjZVFcTK5RdmdmwRXPwj1/2H59Fa20qSUkHvc+FoO81AUqk
9SgLcVr3u0XNScLiW1ayzz7UulN1LAqEuPdXmNF68I1xCyec1fkWoaSLx6iD6OiX
UfwF1zx2jEc0KGD1/fYyTVP6LEtzfTcSWhFPDboY/sZpHjTZA+hhNLx1oaAnDvMD
StSwlT/53psOHYzxCjo4H+fTSJSXubTTw96/rLjTeXt1G7n8rfa+VVg+gq180Vrj
bVrWqbh/Lq+tpVWdNG3WlTP+/qXTALTUJxMqZE2aA7FYxoO/DeehqkbGYewrwDi6
LXOQfVFnDLnKDtbpjciIrRTz8+FXLTJWnz1mfBJRexotHCZz3uQC4E/3scRPZWVj
ZA5ko1xmYM+D9tZxaZW/fuDeD8h/FiVtKinlLMGQC01z7fJKvEo=
=oKWs
-----END PGP SIGNATURE-----

--dys5m2n3k3cy45ea--

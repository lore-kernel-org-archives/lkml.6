Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A534AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75885206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 08:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75885206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408469AbeKWTBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 14:01:39 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47933 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbeKWTBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 14:01:39 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7EAF7207A8; Fri, 23 Nov 2018 09:18:27 +0100 (CET)
Received: from qschulz (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3C64D20510;
        Fri, 23 Nov 2018 09:18:17 +0100 (CET)
Date:   Fri, 23 Nov 2018 09:18:16 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net] net: phy: mscc: fix deadlock in
 vsc85xx_default_config
Message-ID: <20181123081816.vgtsx6fxdsrjjiza@qschulz>
References: <20181122131232.32032-1-quentin.schulz@bootlin.com>
 <20181122192837.GH10697@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wn6wlcx3elbdgyze"
Content-Disposition: inline
In-Reply-To: <20181122192837.GH10697@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wn6wlcx3elbdgyze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Nov 22, 2018 at 08:28:37PM +0100, Andrew Lunn wrote:
> On Thu, Nov 22, 2018 at 02:12:32PM +0100, Quentin Schulz wrote:
> > The vsc85xx_default_config function called in the vsc85xx_config_init
> > function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> > mistakenly calls phy_read and phy_write in-between phy_select_page and
> > phy_restore_page.
> >=20
> > phy_select_page and phy_restore_page actually take and release the MDIO
> > bus lock so __phy_write and __phy_read (which assume that you already
> > have the MDIO bus lock unlike phy_write and phy_read) should be used for
> > any call in between the two said functions.
> >=20
> > Let's fix this deadlock.
> >=20
> > Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_pag=
e functions")
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  drivers/net/phy/mscc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> > index 62269e578718..6856fe4d1a60 100644
> > --- a/drivers/net/phy/mscc.c
> > +++ b/drivers/net/phy/mscc.c
> > @@ -814,10 +814,10 @@ static int vsc85xx_default_config(struct phy_devi=
ce *phydev)
> >  	if (rc < 0)
> >  		goto out_unlock;
> > =20
> > -	reg_val =3D phy_read(phydev, MSCC_PHY_RGMII_CNTL);
> > +	reg_val =3D __phy_read(phydev, MSCC_PHY_RGMII_CNTL);
> >  	reg_val &=3D ~(RGMII_RX_CLK_DELAY_MASK);
> >  	reg_val |=3D (RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS);
> > -	phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
> > +	__phy_write(phydev, MSCC_PHY_RGMII_CNTL, reg_val);
>=20
> Hi Quentin
>=20
> You appear to be only accessing a single register, read/modify/write.
> I think you can use phy_modify_paged(), which will take care of all
> the locking for you.
>=20

Grmbl... Of course :)

Thanks,
Quentin

--wn6wlcx3elbdgyze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlv3t8gACgkQhLiadT7g
8aN41Q//bFHCWp9cGzK55QVOKurkK5Vfb2jEKqpX7ynNzIW6wLb+WOLaDHPhJ8vV
4WLh0Nr5djBrxNUPCRGb/oR0eFIRMAJPa+l1DmIfLYxDq6BPxEX7JHWU9flgrYqp
6ClXAzEKYm4eDB8WZvH9ByD0i2gD2qEgFRHeUiQ4o67jmQ6DgeP7xArR7SrR8ahR
ivwSNMD8L8Ak9a4TdwSasntkyk2MMnGIIjnu6cDNf/blZhv9MQE1xXx2KXMqL74+
GH3za49KlL3N5TNrSilxYxbTxAPO12Hv4KWHcunVzpxhDmmt4KQR6LqOQG/eLU8y
sDRH4oZTN/eQHCFCHyKdThYo9/lma9xgzFvGKAIb46TBOaaPlcwHiZIS9k/kFmOj
widnf3c3qqbAPmWV/JEhHl9f9S67tOBilAQAPuQKcEq8D/6vOFjB8xWAvmMgSHGj
wIQw7S4fO3mx6AgyPQqpXwVvnQFpgwbtSYEu9PC/cew747o5JgMBC6DtAvgPILha
yV2U/b2Pu240VJ0ZOZ2rXaUUAo0HGYncujggSimrDomiv7AMRLto7EIVTn856vIJ
aHsA6lVoDXzJSlyFLKKS2q+LPsVYaTGubinol0U7gUZniZihQI7tgTQpr0l57eH/
+tSdkXzf5GdqiSrZuhl34ugMP2kuvm0s5Ivsg8qWE7h5EHpg26U=
=4h72
-----END PGP SIGNATURE-----

--wn6wlcx3elbdgyze--

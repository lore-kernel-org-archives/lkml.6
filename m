Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D86C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD27920863
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD27920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441031AbeKXEnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:43:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:40348 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbeKXEnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:43:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 82E4620DB0; Fri, 23 Nov 2018 18:58:12 +0100 (CET)
Received: from qschulz (lfbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id 42C8020741;
        Fri, 23 Nov 2018 18:58:12 +0100 (CET)
Date:   Fri, 23 Nov 2018 18:58:11 +0100
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net v2] net: phy: mscc: fix deadlock in
 vsc85xx_default_config
Message-ID: <20181123175811.vjwv5krdrqdyq4ri@qschulz>
References: <20181123081636.18795-1-quentin.schulz@bootlin.com>
 <20181123150806.GB30913@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4is75yfylfai2im"
Content-Disposition: inline
In-Reply-To: <20181123150806.GB30913@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4is75yfylfai2im
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Nov 23, 2018 at 04:08:06PM +0100, Andrew Lunn wrote:
> On Fri, Nov 23, 2018 at 09:16:36AM +0100, Quentin Schulz wrote:
> > The vsc85xx_default_config function called in the vsc85xx_config_init
> > function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> > mistakenly calls phy_read and phy_write in-between phy_select_page and
> > phy_restore_page.
> >=20
> > phy_select_page and phy_restore_page actually take and release the MDIO
> > bus lock and phy_write and phy_read take and release the lock to write
> > or read to a PHY register.
> >=20
> > Let's fix this deadlock by using phy_modify_paged which handles
> > correctly a read followed by a write in a non-standard page.
> >=20
> > Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_pag=
e functions")
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >=20
> > v2:
> >  - use phy_modify_paged instead of
> >  phy_select_page -> __phy_read -> __phy_write -> phy_restore_page
> >=20
> >  drivers/net/phy/mscc.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> > index 62269e578718..4dcf7ad06259 100644
> > --- a/drivers/net/phy/mscc.c
> > +++ b/drivers/net/phy/mscc.c
> > @@ -810,17 +810,16 @@ static int vsc85xx_default_config(struct phy_devi=
ce *phydev)
> > =20
> >  	phydev->mdix_ctrl =3D ETH_TP_MDI_AUTO;
> >  	mutex_lock(&phydev->lock);
> > -	rc =3D phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED_2);
> > +
> > +	reg_val =3D RGMII_RX_CLK_DELAY_1_1_NS << RGMII_RX_CLK_DELAY_POS;
> > +
> > +	rc =3D phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_2,
> > +			      MSCC_PHY_RGMII_CNTL, RGMII_RX_CLK_DELAY_MASK,
> > +			      reg_val);
> >  	if (rc < 0)
> >  		goto out_unlock;
>=20
> Hi Quentin
>=20
> Isn't this goto now pointless. You are not jumping over anything.
>=20

Grmbl episode 2 :)

That's what you get from adding a line, taking the ones you're replacing
as reference and then remove the lines you've to replace without
checking what's left.

Sorry for the noise, I'll boot up my brain next time.

Thanks,
Quentin

--s4is75yfylfai2im
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlv4P7MACgkQhLiadT7g
8aNvQg//bA/bMiFqly4ETZGrpzdV1g0eRzrbrJcFC3ivJGojcrUETFnoi7fm7Cif
vsIBrvWWYEA+HK1FibL9lz+45XzkrvkisJJm7hZRQiFVLiD49bMAdRqZL9QAygmM
3KF6jA5ni7hvqak3ypega9jlGs74/jtMTBNIrQrA2ZlWh7WgNl/Xd7Qm1r7B05aw
rNvBnZ7i/o/zFb85swy4/Ks1s63ywsdU6Goz/AqSXxs1fwYaS1WsuvitFICNu/Q1
n2V2UlQiNDL3UbMleijp5yfnhQnYkqh3VShJxSHNR2xecCs13M1/YCykHLMM4Dll
a3L6hSL1pNb5SgSVn6iTwAMge1XltrE7Nvgk3YcVcetpnOn6E2brSf9usVVmOpwW
WD/dyg3V21yh3JvqMPqM71uXezMvAfOeIbMt0Lz4+Zq9yzhYaSshweDN1gOYUIR+
fxeQEeVsQVd461oydja6WtQT37TSwapQXfAP+mmAvn8Mfu1ekOzbZ8cLxzwqDkOr
R9tXX/AauYyYNeH2D+Yq3UL0wjYV+BR9Oxcjp227QHR4C21pzk7whPxkifEtb5fG
vu938G3noy1j3pvAH//2qJlinZIWuoYnt682loO3TcXMNUjyd0Q1DWZY9iQwqlUk
jdRvUJwEaQySDfzDC85/sALUXjp5bWe7JopPLkRFzAnd1fth3pg=
=EBtp
-----END PGP SIGNATURE-----

--s4is75yfylfai2im--

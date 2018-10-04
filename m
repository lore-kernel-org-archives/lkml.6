Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4EC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE21920652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE21920652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJDWvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:51:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44745 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbeJDWvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:51:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E20BC20734; Thu,  4 Oct 2018 17:57:27 +0200 (CEST)
Received: from qschulz (LFbn-1-10589-128.w90-89.abo.wanadoo.fr [90.89.181.128])
        by mail.bootlin.com (Postfix) with ESMTPSA id A9098206A1;
        Thu,  4 Oct 2018 17:57:17 +0200 (CEST)
Date:   Thu, 4 Oct 2018 17:57:17 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net-next v2 1/6] net: phy: mscc: migrate to
 phy_select/restore_page functions
Message-ID: <20181004155717.hw6ik4hdlgr4jddw@qschulz>
References: <20181004124728.9821-1-quentin.schulz@bootlin.com>
 <20181004124728.9821-2-quentin.schulz@bootlin.com>
 <20181004151630.GE4730@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lj4v4jheit6ohbsg"
Content-Disposition: inline
In-Reply-To: <20181004151630.GE4730@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lj4v4jheit6ohbsg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Oct 04, 2018 at 05:16:30PM +0200, Andrew Lunn wrote:
> On Thu, Oct 04, 2018 at 02:47:23PM +0200, Quentin Schulz wrote:
> > @@ -197,25 +199,30 @@ static int vsc85xx_mdix_set(struct phy_device *ph=
ydev, u8 mdix)
> >  	if (rc !=3D 0)
> >  		return rc;
> > =20
> > -	rc =3D vsc85xx_phy_page_set(phydev, MSCC_PHY_PAGE_EXTENDED);
> > -	if (rc !=3D 0)
> > -		return rc;
> > +	oldpage =3D phy_select_page(phydev, MSCC_PHY_PAGE_EXTENDED);
> > +	if (oldpage < 0) {
> > +		rc =3D oldpage;
> > +		goto out;
> > +	}
> > =20
> > -	reg_val =3D phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
> > +	reg_val =3D __phy_read(phydev, MSCC_PHY_EXT_MODE_CNTL);
> >  	reg_val &=3D ~(FORCE_MDI_CROSSOVER_MASK);
> >  	if (mdix =3D=3D ETH_TP_MDI)
> >  		reg_val |=3D FORCE_MDI_CROSSOVER_MDI;
> >  	else if (mdix =3D=3D ETH_TP_MDI_X)
> >  		reg_val |=3D FORCE_MDI_CROSSOVER_MDIX;
>=20
> Hi Quentin
>=20
> Could you use phy_modify_paged() here? This function only accesses a
> single register, so using the wrapper should not have any
> disadvantages. The same should apply for any function modifying a single
> register.
>=20

Sure, will do.

Thanks,
Quentin

--lj4v4jheit6ohbsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu2OF0ACgkQhLiadT7g
8aPZAw//RMMras9HJQhrsg/r0TCLo1e6Rs+lOJTzlsFPKP1KRvIur8r4CstMxAhC
mEI37aNWGG/vRKzM+0dvJ64Jfr9ROO2cQ/AhGrU5HAGPI+fec5SRoMyLgBkSMSz+
qQLMPfUBX89OglDurOaLYbEkKaam/bfXWu92FVCspGUr1zg1gEbgxoh3C3aZuZLA
LBFITISOmjTWKizmfgCz60tkfCXBdov0C3kiEBGznvsntJKQcjDuIdeYmxB9baJA
07zDXJreUxd0rbFNtesajG3HVrUcFbbJ7vsMr9sfl7x9LGpjl4zS4jcpic5Iqvp+
fSkScq6S2AyGmAiLGt5M3K4pbkJbGsWglq8MDOErb/BoK0aP51kaDsTL7/B5oU78
ZMjXThMTlRfLHjtXs+Zm1Nb+kgXOuGBn1abhmoIZyPVhbzpmSWtGUWyTpql/NoJ/
pBrTjVIIhf3ktfNF2H6vlYwaIAzvJ0j1ZprSv9A90cSNwkgG0Oo6kQ4MklrMrxT5
myXG6LRrPXI4BNwUjcTqsaB8EKpKBxdl5m8Kq6gsryVG/sLGBZoIPIc1t9x42X28
jKBBW3Jw6n219BLlDIGrW7o4Z6Uw8Mj1rQF+qPxIKNBQtvkKSzZkW1hLt8XwuEfh
3ddOJRLr5B6hWPoWUiKXWi2tmIW4lYGdpeEBA6ie/MMITKX2DbY=
=P82C
-----END PGP SIGNATURE-----

--lj4v4jheit6ohbsg--

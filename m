Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D792C204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D792C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbeJBUex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:34:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39087 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731403AbeJBUew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:34:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A1C512090A; Tue,  2 Oct 2018 15:51:21 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5F557208C2;
        Tue,  2 Oct 2018 15:51:11 +0200 (CEST)
Date:   Tue, 2 Oct 2018 15:51:11 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net-next 1/5] net: phy: mscc: add ethtool statistics
 counters
Message-ID: <20181002135111.b4ykicst5ipp4o74@qschulz>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
 <20180914130156.GB14865@lunn.ch>
 <20180914131645.64k4w4h7ir3u5yuk@qschulz>
 <20180914132959.GH14865@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gjv45ertnpioqog3"
Content-Disposition: inline
In-Reply-To: <20180914132959.GH14865@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gjv45ertnpioqog3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russel,

Adding you to the discussion as you're the author and commiter of the
patch adding support for all the paged access in the phy core.

On Fri, Sep 14, 2018 at 03:29:59PM +0200, Andrew Lunn wrote:
> > When you change a page, you basically can access only the registers in
> > this page so if there are two functions requesting different pages at
> > the same time or registers of different pages, it won't work well
> > indeed.
> >=20
> > > phy_read_page() and phy_write_page() will do the needed locking if
> > > this is an issue.
> > >=20
> >=20
> > That's awesome! Didn't know it existed. Thanks a ton!
> >=20
> > Well, that means I should migrate the whole driver to use
> > phy_read/write_paged instead of the phy_read/write that is currently in
> > use.
> >=20
> > That's impacting performance though as per phy_read/write_paged we read
> > the current page, set the desired page, read/write the register, set the
> > old page back. That's 4 times more operations.
>=20
> You can use the lower level locking primatives. See m88e1318_set_wol()
> for example.
>=20

I'm converting the drivers/net/phy/mscc.c driver to make use of the
paged accesses but I'm hitting something confusing to me.

Firstly, just to be sure, I should use paged accesses only for read/write
outside of the standard page, right? I'm guessing that because we need
to be able to use the genphy functions which are using phy_write/read
and not __phy_write/read, thus we assume the mdio lock is not taken
(which is taken by phy_select/restore_page) and those functions
read/write to the standard page.

Secondly, I should refactor the driver to do the following:

oldpage =3D phy_select_page();
if (oldpage < 0) {
	phy_restore_page();
	error_path;
}

[...]
/* paged accesses */
__phy_write/read();
[...]

phy_restore_page();

I assume this is the correct way to handle paged accesses. Let me know
if it's not clear enough or wrong. (depending on the function, we could
of course put phy_restore_page in the error_path).

Now, I saw that phy_restore_page takes the phydev, the oldpage and a ret
parameters[1].

The (ret >=3D 0 && r < 0) condition of [2] seems counterintuitive to me.

ret being the argument passed to the function and r being the return of
__phy_write_page (which is phydev->drv->phy_write_page()).

In my understanding of C best practices, any return value equal to zero
marks a successful call to the function.

That would mean that with:
if (ret >=3D 0 && r < 0)
	ret =3D r;

If ret is greather than 0, if __phy_write_page is successful (r =3D=3D 0),
ret will be > 0, which would result in phy_restore_page not returning 0
thus signaling (IMO) an error occured in phy_restore_page.

One example is the following:
oldpage =3D phy_select_page(phydev, new_page);
[...]
return phy_restore_page(phydev, oldpage, oldpage);

If phy_select_page is successful, return phy_restore_page(phydev,
oldpage, oldpage) would return the value of oldpage which can be
different from 0.

This code could (I think) be working with `if (ret >=3D 0 && r <=3D 0)` (or
even `if (ret >=3D 0)`).

Now to have the same behaviour, I need to do:
oldpage =3D phy_select_page(phydev, new_page);
[...]
return phy_restore_page(phydev, oldpage, oldpage > 0 ? 0 : oldpage);

Another example is:
oldpage =3D phy_select_page(phydev, new_page);
ret =3D `any function returning a value > 0 in case of success and < 0 in
case of failure`().
return phy_restore_page(phydev, oldpage, ret);

Is there any reason for not wanting to overwrite the ret value when
__phy_write_page is successful in phy_restore_page?

I'd say that it could be more readable without the ternary condition in
the argument of phy_restore_page.

Let me know your thoughts on this.

Thanks,
Quentin

[1] https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy-core=
=2Ec#L444
[2] https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy-core=
=2Ec#L454

--gjv45ertnpioqog3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluzd84ACgkQhLiadT7g
8aMhSw/+LHoScr++3UaWA0oOi6zP7sL6wRR9AtpxiTKNSuGIr319Gk1tKffk3vJZ
nogBZcOqzPl8uqJ9cqMiVesrPjVJ8ADEJzk3N/A76/RQyKcjnSBvR+MAg0bssSvE
n8Eb7p+FGFEbqhvQW61K1xo9o1JdYIGAy8t2o20xtTG8wVO+5B1t0zIFQw1znA1r
lTD0Ha4XzAS2DpPlflpFZCXr5M5d3P+I1RT2OObLEXkZRNdg2Hu3758FFDVAzrxD
VN0RDrPKOzelQdgLW8r+A71uTaSk+bSMKJdEBHJAzIvl8PSeaxyTVxn+NGQzoF9V
fmCBFcALI6onQCOpH/1J/iX+vdDmAqtL0Wvw1mXu/ZLh9+1vZJqbzYP3/smKjcyo
hNI12wNCQgMst9SwdMtWV5glXBXsDiTk7n5CCQbPTtu0el9CguND5kk9xBa9ukle
GKZO5X+FQSVBHUgXTVbculxQ5ZEHbkXiLdqkHyuiImpWG/UZHNH+/g5Sh36pw9Vn
jiwf4lbThcvdCiuDq4SP0zqrHcI0skd4dMouLxQGlAbxcu5Un4oYm4d4yHnAUHv8
7cN1Ch6FTQ4Cd6+bFButj+/lYv9iTAqMW+kVLlHb3l53Zlc14Tx8ZrUWDDEd988B
o45KXsRkkL5ZWITh93Yg7Bidqj8CuOMzDVUxJriY2cfzjralEv8=
=D27P
-----END PGP SIGNATURE-----

--gjv45ertnpioqog3--

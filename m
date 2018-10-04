Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5726C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6398B20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6398B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJDVLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:11:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJDVLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:11:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C788E207F0; Thu,  4 Oct 2018 16:17:34 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8490C20719;
        Thu,  4 Oct 2018 16:17:34 +0200 (CEST)
Date:   Thu, 4 Oct 2018 16:17:34 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net-next 1/5] net: phy: mscc: add ethtool statistics
 counters
Message-ID: <20181004141734.6bnkj6zh3dbqefeo@qschulz>
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e220fe75053e200f91554b752905d84b14b76eb6.1536913944.git-series.quentin.schulz@bootlin.com>
 <20180914130156.GB14865@lunn.ch>
 <20180914131645.64k4w4h7ir3u5yuk@qschulz>
 <20180914132959.GH14865@lunn.ch>
 <20181002135111.b4ykicst5ipp4o74@qschulz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wzq5thssfw6ddsyy"
Content-Disposition: inline
In-Reply-To: <20181002135111.b4ykicst5ipp4o74@qschulz>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wzq5thssfw6ddsyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Russel,

On Tue, Oct 02, 2018 at 03:51:11PM +0200, Quentin Schulz wrote:
> Hi Russel,
>=20
> Adding you to the discussion as you're the author and commiter of the
> patch adding support for all the paged access in the phy core.
>=20
> On Fri, Sep 14, 2018 at 03:29:59PM +0200, Andrew Lunn wrote:
> > > When you change a page, you basically can access only the registers in
> > > this page so if there are two functions requesting different pages at
> > > the same time or registers of different pages, it won't work well
> > > indeed.
> > >=20
> > > > phy_read_page() and phy_write_page() will do the needed locking if
> > > > this is an issue.
> > > >=20
> > >=20
> > > That's awesome! Didn't know it existed. Thanks a ton!
> > >=20
> > > Well, that means I should migrate the whole driver to use
> > > phy_read/write_paged instead of the phy_read/write that is currently =
in
> > > use.
> > >=20
> > > That's impacting performance though as per phy_read/write_paged we re=
ad
> > > the current page, set the desired page, read/write the register, set =
the
> > > old page back. That's 4 times more operations.
> >=20
> > You can use the lower level locking primatives. See m88e1318_set_wol()
> > for example.
> >=20
>=20
> I'm converting the drivers/net/phy/mscc.c driver to make use of the
> paged accesses but I'm hitting something confusing to me.
>=20
> Firstly, just to be sure, I should use paged accesses only for read/write
> outside of the standard page, right? I'm guessing that because we need
> to be able to use the genphy functions which are using phy_write/read
> and not __phy_write/read, thus we assume the mdio lock is not taken
> (which is taken by phy_select/restore_page) and those functions
> read/write to the standard page.
>=20
> Secondly, I should refactor the driver to do the following:
>=20
> oldpage =3D phy_select_page();
> if (oldpage < 0) {
> 	phy_restore_page();
> 	error_path;
> }
>=20
> [...]
> /* paged accesses */
> __phy_write/read();
> [...]
>=20
> phy_restore_page();
>=20
> I assume this is the correct way to handle paged accesses. Let me know
> if it's not clear enough or wrong. (depending on the function, we could
> of course put phy_restore_page in the error_path).
>=20
> Now, I saw that phy_restore_page takes the phydev, the oldpage and a ret
> parameters[1].
>=20
> The (ret >=3D 0 && r < 0) condition of [2] seems counterintuitive to me.
>=20
> ret being the argument passed to the function and r being the return of
> __phy_write_page (which is phydev->drv->phy_write_page()).
>=20
> In my understanding of C best practices, any return value equal to zero
> marks a successful call to the function.
>=20
> That would mean that with:
> if (ret >=3D 0 && r < 0)
> 	ret =3D r;
>=20
> If ret is greather than 0, if __phy_write_page is successful (r =3D=3D 0),
> ret will be > 0, which would result in phy_restore_page not returning 0
> thus signaling (IMO) an error occured in phy_restore_page.
>=20
> One example is the following:
> oldpage =3D phy_select_page(phydev, new_page);
> [...]
> return phy_restore_page(phydev, oldpage, oldpage);
>=20
> If phy_select_page is successful, return phy_restore_page(phydev,
> oldpage, oldpage) would return the value of oldpage which can be
> different from 0.
>=20
> This code could (I think) be working with `if (ret >=3D 0 && r <=3D 0)` (=
or
> even `if (ret >=3D 0)`).
>=20
> Now to have the same behaviour, I need to do:
> oldpage =3D phy_select_page(phydev, new_page);
> [...]
> return phy_restore_page(phydev, oldpage, oldpage > 0 ? 0 : oldpage);
>=20
> Another example is:
> oldpage =3D phy_select_page(phydev, new_page);
> ret =3D `any function returning a value > 0 in case of success and < 0 in
> case of failure`().
> return phy_restore_page(phydev, oldpage, ret);
>=20

The whole point was there. We're trying to propagate return values
through phy_restore_page and only overwrite it if it's 0. However, there
are some functions that return something different from 0 (e.g. size of
something that is handled or returned) and are still valid and wanted to
be propagated. If we were to overwrite the return value with 0 if
__phy_write_page is returning 0, we would need to use a temporary
variable to not overwrite the return value before calling
phy_restore_page.

With my suggestion, we would need to use a temporary variable to keep a
> 0 return values while calling phy_restore_page but not when we want
phy_restore_page to return 0 even when the return value before calling
phy_restore_page is > 0.

With the current behaviour, we would need to use a temporary value (or a
ternary condition as given as an example in original mail) when we want
to return 0 only when no error happens in phy_restore_page and the
return value before calling phy_restore_page was >=3D 0. We would not need
to use a temporary variable when phy_restore_page finishes without error
and we want to keep the return value before calling phy_restore_page if
it's >=3D0.

So basically, that's down to a technical choice and none is perfect.
Sorry for bothering.

Thanks,
Quentin

--wzq5thssfw6ddsyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu2IP4ACgkQhLiadT7g
8aPZXA/+Jzs3+Gffbi/I1w/7hq4++rkBQG5S8Ayz8Lz7HJ1hdD3eiNM462fAyhSi
Usx26gCbPPMEarsripoeiNYbeZpnBsOC9cVSFhW4jNcMrG9wKqhfRMe6FFi8xYHn
Czr1JvEXL3n+AwYyAynSTn2rBF+JJ0+PQUM0dW0NU2LxSey5RGe9sHq+qBtpTcd+
fTfQMnvUD+wezxz2lzw20PNGn+Udx8G2vtujqJmc4SHzYf65BhW4Ijc0pC7xttyT
KSuePAT9RB4LqOB5/zk8mVSWisX63s+0wcleXb/z3O0xp2jm4kgWb6M+J8LSmDMQ
P/gcBCs29akPN2o5ksorxrHr0nzUhnhNeC4MYvtHZFzftu+LF2TKxa8ygDDMSTO1
UnZG7kqxLFXcB+R/4WSb6bqkfghMFklJDWzLGvDfZwMtA210esgO8F6wHSwNL4ef
uxFmje9rGIkPjP8t28kyn9RPZ2oC7NdM4xtNkkHgYcIBrPmk8WDwtVG0qrJuoZNB
agJMnmI64JzIcX27p+42v9i6rzQIOd4dMEJwlmPrwNUFoEztRgt/KQqUbQHeaA57
2lnmVYRmP3A5pPETL1RE20QyWQBt1t8MrZLjeyipY0zkZ6wBPtU4Cfue7675qpdx
t+XX03D96jiJLYs8QlhnIizI1lqZ+VqGEWBQrkrvbCELTFue4xg=
=4TiF
-----END PGP SIGNATURE-----

--wzq5thssfw6ddsyy--

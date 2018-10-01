Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747FCC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C422064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C422064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeJAPos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:44:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50058 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeJAPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:44:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 64C48208F4; Mon,  1 Oct 2018 11:07:59 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 085F0206FF;
        Mon,  1 Oct 2018 11:07:49 +0200 (CEST)
Date:   Mon, 1 Oct 2018 11:07:49 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
Subject: Re: [PATCH net-next 3/7] net: phy: mscc: split config_init in two
 functions for VSC8584
Message-ID: <20181001090749.p7hp4ccfkmmpx2es@qschulz>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <5daa7f3e467b218410238ef0fb97f01779f8f49f.1536916714.git-series.quentin.schulz@bootlin.com>
 <bc31175f-52eb-cb7d-669e-192aec79ac5c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4gudnnyb5hbh4us3"
Content-Disposition: inline
In-Reply-To: <bc31175f-52eb-cb7d-669e-192aec79ac5c@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4gudnnyb5hbh4us3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Fri, Sep 14, 2018 at 10:57:08AM -0700, Florian Fainelli wrote:
> On 09/14/2018 02:44 AM, Quentin Schulz wrote:
> > Part of the config init is common between the VSC8584 and the VSC8574,
> > so to prepare the upcoming support for VSC8574, separate config_init
> > PHY-specific code to config_pre_init function which is set in the probe
> > function of the PHY and used in config_init.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> > ---
> >  drivers/net/phy/mscc.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> > index b450489..69cc3cf 100644
> > --- a/drivers/net/phy/mscc.c
> > +++ b/drivers/net/phy/mscc.c
> > @@ -355,6 +355,7 @@ struct vsc8531_private {
> >  	u64 *stats;
> >  	int nstats;
> >  	bool pkg_init;
> > +	int (*config_pre_init)(struct mii_bus *bus, int phy);
>=20
> Is not this overkill given that you have a reference to the phy_device,
> you could check for the for phy_id to know which exact type you have and
> call the appropriate pre_init function?
>=20

Agreed. It just seemed "cleaner" to me to set config_pre_init in
separate probe functions which are pretty straightforward and short.
Thus not complexifying an already-not-so-straightforward config_init
function.

Anyway, I'll use the phy_id as suggested so that we don't overload the
vsc8531_private structure (since it's also only called once, in
config_init).

Thanks,
Quentin

--4gudnnyb5hbh4us3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlux4+QACgkQhLiadT7g
8aMJEBAAlB5jQxeFJjIbBjHlHZD8vHXRcJCi2lVac80w9rTL751EN8osh8uGg4oJ
N3SxA6vbE6YysjPbyIp5lWnLDri5teGL8uCOYMIeNTpsr6cRknJVy/GnWEps0r6d
cSF6ohqXxm93/UeAiieMyiLwYRwlhD8oXWF2vhxy7SIV6gj85Cgy3Qm1soEwr8pl
I2SREW1MmkzaJcg9vOYNPfme8M5QadCS4ED6/OdD9slYvhUZz0PLjr/VP8txdcz7
1pkrHqwUSiNiYi1IR/QRGbH43S3FmQsPuHdJwJtWG+rfcq9vPwJ2A9j1/rnv8fhU
B5yYIit0H+Y/GMAQGKQIwL3UOXSZ4OlAITRsZtyTi0Eto1S/RkoG+3Ef0OTuudoV
KH7JfsxZ2YKLO+w2yIeNQqBBuMOPzQqI9Kg+gbTZRV/2Lu1J3Dz4W3iVZIBPIZlu
iUf9KgXJqkzZtM6FIAqdGw4WI0bVLcE447Q5CDHaoiDC/PJ8ui87p6ithFJ2/Hb9
917oBA8enJSHHjBX+CWirtEx56RvspiXeicYCiFClLjY4lytUcv+Q8T8MTqKE2qV
t5yMZ5zVO8P7m5MVSenRRMQ4I/rjgmVd2mddEuPsycQo0gGE7M6clzl0tNKTmavG
2xKfDmhSTOOoocC7Kal0fXkQsC2tFfpPzjmXqVSz7ZjZGY4gWIY=
=YEHc
-----END PGP SIGNATURE-----

--4gudnnyb5hbh4us3--

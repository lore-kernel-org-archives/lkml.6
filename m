Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AC1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06580206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06580206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeIDLuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:50:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56648 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbeIDLuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:50:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CCE7720726; Tue,  4 Sep 2018 09:26:32 +0200 (CEST)
Received: from qschulz (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 86CFA203DC;
        Tue,  4 Sep 2018 09:26:32 +0200 (CEST)
Date:   Tue, 4 Sep 2018 09:26:30 +0200
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        f.fainelli@gmail.com, allan.nielsen@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        rf@opensource.wolfsonmicro.com
Subject: Re: [PATCH net-next v2 4/7] net: phy: mscc: read
 'vsc8531,edge-slowdown' as an u32
Message-ID: <20180904072630.zc6sdz2xdti5nku4@qschulz>
References: <20180903084853.18092-1-quentin.schulz@bootlin.com>
 <20180903084853.18092-4-quentin.schulz@bootlin.com>
 <20180903132756.GD4445@lunn.ch>
 <20180903133746.wsvezy3rbdivnjfs@qschulz>
 <20180903200554.GJ4445@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5cwu2hx3pzag7m4"
Content-Disposition: inline
In-Reply-To: <20180903200554.GJ4445@lunn.ch>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u5cwu2hx3pzag7m4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Sep 03, 2018 at 10:05:54PM +0200, Andrew Lunn wrote:
> > Just to be sure, we're talking here about making sure the value stored
> > in the DT is not bigger than the specified value (here an u8)? If so,
> > that isn't the reason why I'm suggesting those two patches.
> >=20
> > Without /bits 8/ in the DT property, whatever were the values I put in
> > the property, I'd always get a 0. So I need to fix it either in the DT
> > (but Rob does not really like it) or in the driver.
>=20
> Hi Quentin
>=20
> Ah, you are fixing endian issues. That was not clear to me from the
> commit message.
>=20
> I don't know enough about how DT stores values in the blob. Is there
> type info? Can the DT core tell if a value in the blob is a u8 or a
> u32?  It would be nice if it warned about reading a u8 from a u32
> blob.
>=20

=46rom my quick research, the lower bound checking is performed by
of_property_read_u* functions but not the higher bound checking (the
internal function of_find_property_value_of_size allows higher bound
checking but it seems it's never used by those functions (see 0 in
sz_max of of_property_read_variable_u*_array)).

sz_max is used by of_property_read_variable_u*_array to copy at a
maximum of sz_max values in the output buffer. If sz_max is 0, it takes
sz_min so it's an array of definite size.
So since sz_max is 0 for all calls to of_property_read_variable_u*_array
by of_property_read_u*_array, we basically know we'll get a buffer of
sz_min values but we don't actually make use of the higher bound
checking of of_find_property_value_of_size.

We could enforce this higher bound check by, instead of setting sz_max
to 0, setting sz_max to sz_min in calls to of_property_read_u*_array.

But I guess there is a reason for sz_max being 0. Rob, Richard (commit
signer of this code) do you know why? Could you explain?

> Anyway, this change still removes some bounds checking. Are they
> important? Do they need to be added back?
>=20

The edge-slowdown and the vddmac values are compared against a const
array so we=B4re fine with those ones.

For the led-X-mode, I added a constant for supported modes that gets
checked when retrieving the DT property. So we=B4re fine here too.

Quentin

--u5cwu2hx3pzag7m4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAluOM6YACgkQhLiadT7g
8aMXJhAAm/KvY4eM0D09WsqCDIoRlFTLMU8vcJu/e0+nRQla9IJ32QTIwkpKkn2A
x1ef9cWne+okY4C4iZ138D6dhkBLsx2uCWc8ABNA38xHNZBSFJJXGhApElgcYEW1
a5CCMBtnHu+PqLTnH9CHdbWQcgA83RZ3htfBPG1RDNVttG1amGMVQfqlRQSOaFPD
yHJO6zqLFsUvMInF7CMHOBb+NeJm0QM+pTRs+ABNjzmscEXfmqV9hz5rnAwYJWSW
IRzvsANh1BSY1B+ENh3omoCDSi05xZJlb6Ofz7t/eyMVjN4jbw5kUhba9YlI7V9E
9XBTS3Ci2CIc/eZsZyZzbYFKWL1RUuLFbtdlHUML3LRfDwu5MVhUGsBFALY6I4yg
abX+K+uIvA8cMqSlcw7CWUhUKnh3LXMZ3rJWodypdbykg7aLIqczCSlCt0omQUm3
W7d1wWcbzF0iiDMmvLZC7yqPlu2vU48H/rz3f3p+rkwuzTOMx2DGH0wRDgFjnFp6
mxaJtaKFbb9x6sb3xyvQZFjTVGiNlrfOkOIMR+SEJIyTvT8VpKPh6UoDKo4gAzm2
H59Ad1eIFJtux95MXUCyZ47PMts+OFr3PcVpvnEFOajWtkTYCYTWAgkdOlZ1Ftf7
DXXlrqiNeBfQ2Q3/KnJnXzTY5s2okhS5nc3ODhu+Ied0GIYJOm4=
=OGAP
-----END PGP SIGNATURE-----

--u5cwu2hx3pzag7m4--

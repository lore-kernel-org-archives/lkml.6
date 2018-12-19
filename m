Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C76C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6C820874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbeLSWdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:33:45 -0500
Received: from sauhun.de ([88.99.104.3]:57656 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbeLSWdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:33:45 -0500
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
        by pokefinder.org (Postfix) with ESMTPSA id 349E82E3542;
        Wed, 19 Dec 2018 23:33:42 +0100 (CET)
Date:   Wed, 19 Dec 2018 23:33:41 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Message-ID: <20181219223341.GA998@kunai>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lukas, Hans,

On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 19-12-18 18:22, Lukas Wunner wrote:
> > On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
> > > +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *ad=
ap)
> > > +{
> > > +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> > > +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
> > > +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> > > +}
> >=20
> > This looks like a duplication of the is_suspended flag in struct dev_pm=
_info.
> > Any reason why you can't use that?  If so, it would be good to document=
 the
> > reason in the commit message.
>=20
> Oh, that is a very good point and that one only gets set on system suspend
> and not on resume suspend, working around the problems with the i2c-desig=
nware

Just to make it clear: you mean runtime suspend, not resume suspend, or?

> driver.
>=20
> I think this might be as simple as adding:
>=20
> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
> 		return -ESHUTDOWN;

I have seen this flag but decided against it. One reason is because it
is marked as "PM core only". The other reason is that it doesn't know
about the adapter lock. It might get set while a transfer is on going.
Or even right after the suggested if-block above. The code from this
series gets the mutex first which ensures that on going transfers are
completed and no new ones are started in parallel.

Unless I am totally overlooking something...

Thanks,

   Wolfram


--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwax0EACgkQFA3kzBSg
KbZnhg/8C3yO6aH4r7ho2ge6VCdCHgidjIZUJUeKIhoL4fSUTvqNLhA4WgnbjkGX
5BIu4LZOdh5v8QAwNLiflt2UK81dUMYT2OplQkyO866VyZuFTXojh6+ZR2niBl2l
lfZNcM3F7Rl7Ec/MV5/0ltSA4Z2zfRQBB+nSQ79R2coFpJCBeAPz4Lqs3Tk/zyeT
htEIu2frSmvsNJVxZaJiG/qrM8H39xoDiPkiix4Lz72HhYMjL82ql/ZPn4iNUyuk
9+58s2LnnzDbime66NGKjZN2pYElYv6aoO62TJyLoxbOkod82+bqdLiFucz7Ssn/
A/006EUTdma5Tl7gbgZtW8SOJSdI3Emf+vU0vQ+MKzjHcmvWuNO+UmSJOlBbqDrO
dDbeAtOcus/p3nCneIu6H9VyYPRwntb66BEyu1wb0wNi4L2L12Ooi9W2fGPTM2cT
bj0hi7Q3SYkhcUarDdDAjgcNmZIdRu2FTYa9x33YGb39rpq+EnEVeyAhDBw36eH3
TPGsoknpPXEIecUQZSJOP8ZOoZ3HXf/4bjx0JuTM0yZY1J6kXrlkM5d36qw5Y811
eE96Xxx+VDuQB72keu5jLsTWuQFjARCW5frFN550cub/p0Ss7kTq925kUeGMQVL0
eggU8pBpQpeD0IklxMsub7vN6Nv3RGiKmbVaTmh81MeiivC+smk=
=CxxX
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--

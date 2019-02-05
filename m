Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB019C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C418420821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbfBEMOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:14:20 -0500
Received: from sauhun.de ([88.99.104.3]:56804 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfBEMOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:14:19 -0500
Received: from localhost (unknown [46.183.103.8])
        by pokefinder.org (Postfix) with ESMTPSA id BB53E4A16DD;
        Tue,  5 Feb 2019 13:14:07 +0100 (CET)
Date:   Tue, 5 Feb 2019 13:13:57 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Sperbeck <jsperbeck@google.com>,
        Ingo Molnar <mingo@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: core-smbus: don't trace smbus_reply data on errors
Message-ID: <20190205121353.GC1045@kunai>
References: <20190104004203.116155-1-jsperbeck@google.com>
 <20190103214927.2bf947ca@vmware.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20190103214927.2bf947ca@vmware.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 03, 2019 at 09:49:27PM -0500, Steven Rostedt wrote:
> On Thu,  3 Jan 2019 16:42:03 -0800
> John Sperbeck <jsperbeck@google.com> wrote:
>=20
> > If an smbus transfer fails, there's no guarantee that the output
> > buffer was written.  So, avoid copying from the output buffer when
> > tracing after an error.  This was 'mostly harmless', but would trip
> > up kasan checking if left-over cruft in byte 0 is a large length,
> > causing us to read from unwritten memory.
> >=20
> > Signed-off-by: John Sperbeck <jsperbeck@google.com>
> > ---
> >  drivers/i2c/i2c-core-smbus.c |  2 +-
> >  include/trace/events/smbus.h | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> > index 9cd66cabb84f..132119112596 100644
> > --- a/drivers/i2c/i2c-core-smbus.c
> > +++ b/drivers/i2c/i2c-core-smbus.c
> > @@ -585,7 +585,7 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u=
16 addr,
> >  trace:
> >  	/* If enabled, the reply tracepoint is conditional on read_write. */
> >  	trace_smbus_reply(adapter, addr, flags, read_write,
> > -			  command, protocol, data);
> > +			  command, protocol, data, res);
> >  	trace_smbus_result(adapter, addr, flags, read_write,
> >  			   command, protocol, res);
> > =20
> > diff --git a/include/trace/events/smbus.h b/include/trace/events/smbus.h
> > index d2fb6e1d3e10..b6376a7c7e74 100644
> > --- a/include/trace/events/smbus.h
> > +++ b/include/trace/events/smbus.h
> > @@ -138,8 +138,8 @@ TRACE_EVENT_CONDITION(smbus_reply,
> >  	TP_PROTO(const struct i2c_adapter *adap,
> >  		 u16 addr, unsigned short flags,
> >  		 char read_write, u8 command, int protocol,
> > -		 const union i2c_smbus_data *data),
> > -	TP_ARGS(adap, addr, flags, read_write, command, protocol, data),
> > +		 const union i2c_smbus_data *data, int res),
> > +	TP_ARGS(adap, addr, flags, read_write, command, protocol, data, res),
> >  	TP_CONDITION(read_write =3D=3D I2C_SMBUS_READ),
>=20
> Hmm, instead of tracing nothing, as this is already a "conditional
> trace event", why not add to that condition:
>=20
> 	TP_CONDITION(res >=3D 0 && read_write =3D=3D I2C_SMBUS_READ),
>=20
> Unless you want to still trace some data on failure.

John, any comment to this?


--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxZfgEACgkQFA3kzBSg
Kbb8Ng//bM9+CBUDuxVV1jEQm1tBwiH1+JclMxzabWd/btO/fwW8h4DQv25NEKI2
irYP2G0KSzUugfBnnJ0011e+CLOAaB/Txh9Ju/oXDwNX6wZqUeS9V6Hp9DI6oSR0
fogaBeZKvLvfyrYEt9XVNUPHRVyMHUoMUo8VRFaNaZX02bx9+RsgmXOV9yX2STAT
E1dZ9d7v74i3Fhrr2yrCTd7QpeT7ohNXJLalW68ZY/LgGG7rBTusRgAvPL1T/x4d
ifM4D/WBiw7JymainbUdm6SNpIGQkQ7qlD0uAJv+uUqUhU75s7tO1lcExtC049TN
MYHSMhycgk5338s/4Sp4izgh/2hl+HNdNgd5Mtwgw7M97N2Erm6FGMJLmpb9jZ0q
NalbqbxThIYBSGMTNxwHKGl20aUce2+uT9cNsaDjhpQav0IeGVDcj93dIMb+SFsn
AP6raxAhRgZM6Da5PhNtaetfULUF/wYnG+B+So5/TRCeMauhKGUn4qkFjGERyHIQ
JjSoeJPqeTbe0+zqWmpiKu11ldQeIuzd0L9K+696AiV5zRz64dw3TTBl9ayZiP3n
9bl9uPbwTP+SwyytzHNgx2Fi9qLMorQqzArMK1kC24Pjvx3tIDGcCn5i3lmMcUaj
HtO1uOL0gSdgjVf8qP4O33RVrGuwIEfvP8gV2P/fhSSK2399aHA=
=GMyX
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

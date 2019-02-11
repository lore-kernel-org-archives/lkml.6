Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087CFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EFA2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBKKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:24:31 -0500
Received: from sauhun.de ([88.99.104.3]:52922 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKKYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:24:31 -0500
Received: from localhost (p54B333B4.dip0.t-ipconnect.de [84.179.51.180])
        by pokefinder.org (Postfix) with ESMTPSA id 0DA142E3542;
        Mon, 11 Feb 2019 11:24:28 +0100 (CET)
Date:   Mon, 11 Feb 2019 11:24:24 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] i2c:ocores: stop transfer on timeout
Message-ID: <20190211102424.5xnzyxvfd2yhf6ui@ninjato>
References: <20190211083122.32485-1-federico.vaga@cern.ch>
 <20190211083122.32485-2-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k34seb4vqcvdmmff"
Content-Disposition: inline
In-Reply-To: <20190211083122.32485-2-federico.vaga@cern.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k34seb4vqcvdmmff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 09:31:18AM +0100, Federico Vaga wrote:
> Detecting a timeout is ok, but we also need to assert a STOP command on
> the bus in order to prevent it from generating interrupts when there are
> no on going transfers.
>=20
> Example: very long transmission.
>=20
> 1. ocores_xfer: START a transfer
> 2. ocores_isr : handle byte by byte the transfer
> 3. ocores_xfer: goes in timeout [[bugfix here]]
> 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> 5. I2C driver : it may clean up the i2c_msg memory
> 6. ocores_isr : receives another interrupt (pending bytes to be
>                 transferred) but the i2c_msg memory is invalid now
>=20
> So, since the transfer was too long, we have to detect the timeout and
> STOP the transfer.
>=20
> Another point is that we have a critical region here. When handling the
> timeout condition we may have a running IRQ handler. For this reason I
> introduce a spinlock.
>=20
> In order to make easier to understan locking I have:
> - added a new function to handle timeout
> - modified the current ocores_process() function in order to be protected
>   by the new spinlock
> Like this it is obvious at first sight that this locking serializes
> the execution of ocores_process() and ocores_process_timeout()
>=20
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>=20

Applied to for-next, thanks!


--k34seb4vqcvdmmff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxhTVQACgkQFA3kzBSg
KbbIzBAAk28yIbH11CCG/mU8YLcPZTJRQh7q2VqKZQkxV0pf0CCx+N0pAdlFrzSv
pzsLLeIpQPUZE37Alfacz+dKZRVimcPGJ4qvR7Gja1onWkSpzOhYPp8LiEBFhgtO
UTdjqeVLs+/Au35gdZ0vKNKOy62B9azsU11FpY5ygDYrF2KDlE3wIlzEoKrXnG37
cBhkwFi/xXZL+N9Ew1PIkr4qdPArARHXdvlrsiV48ZHp54byJ0VKTHp80Mvut4IW
Xs2AFLK+K7u2b6ZGGrbKst6xeRZBQ+lHMxCDzx1jiYMaGoltubOd45uk/Ujdb51r
de1/6tijFEvvInI1nWucbpLhY79bz7VRYH4rw+NJWwrTlqxGws0uytm3bSD3u6vJ
2q/5WtPC+vPFl/D42fQcJRwrzg62hls0RRjhO13YscobpCijohVtPLuZerXYAyTq
FoMcWdFj6H8BCwhB3tobjoDS7VajcN2Yj0H/mhxI8iqUiUSD/03aXYSzeidZzWDd
z7YYUvv/0fWrhv6MdXpYGZjvzfNoQE8aJVMZ3+ULUWSoeNZ1YfjIogXdYhdxlOBv
FB9JI0+TeVCgkJBD1AYmuC6GWf1UU7DkpeoLZkpx79ndvXn2XXYdMRs9wHIw242X
SB5jEQoST38O9F81MOPcGLfpuIFV08kmUcs36jtP1mFQ8ktYZtg=
=48TV
-----END PGP SIGNATURE-----

--k34seb4vqcvdmmff--

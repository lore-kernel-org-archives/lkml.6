Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757005AbeEJLRk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 07:17:40 -0400
Received: from sauhun.de ([88.99.104.3]:45550 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756793AbeEJLRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 07:17:38 -0400
Date: Thu, 10 May 2018 13:17:37 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] i2c: core-smbus: fix a potential uninitialization
 bug
Message-ID: <20180510111737.b6g7s2nnf6froote@ninjato>
References: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yzvxnptvnc5yk3wm"
Content-Disposition: inline
In-Reply-To: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzvxnptvnc5yk3wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 05, 2018 at 07:57:10AM -0500, Wenwen Wang wrote:
> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
> which are used to save a series of messages, as mentioned in the comment.
> According to the value of the variable 'size', msgbuf0 is initialized to
> various values. In contrast, msgbuf1 is left uninitialized until the
> function i2c_transfer() is invoked. However, msgbuf1 is not always
> initialized on all possible execution paths (implementation) of
> i2c_transfer(). Thus, it is possible that msgbuf1 may still be
> uninitialized even after the invocation of the function i2c_transfer(),
> especially when the return value of ic2_transfer() is not checked properl=
y.
> In the following execution, the uninitialized msgbuf1 will be used, such =
as
> for security checks. Since uninitialized values can be random and
> arbitrary, this will cause undefined behaviors or even check bypass. For
> example, it is expected that if the value of 'size' is
> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larg=
er
> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), t=
he
> value read from msgbuf1 is assigned to data->block[0], which can
> potentially lead to invalid block write size, as demonstrated in the error
> message.
>=20
> This patch initializes the first byte of msgbuf1 with 0 to avoid such
> undefined behaviors or security issues.
>=20
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>

=46rom what I can tell, this patch is not needed anymore after patch 2 is
applied. Correct?


--yzvxnptvnc5yk3wm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlr0KlAACgkQFA3kzBSg
KbZi7A/7BtcGxjOghY8/YIpx4tbsHcMmcxrlQrYA5fKekZ0dIzIooOK5XUJs7D6w
cyCNgkKJx2tLndhu9Qz0sbovsL97b2DNiCmRsZYTtKeM0w2j3g3vriDEWfrkh/Oq
m1wr0C9umH5NuJzy6s6Xm0uPA2q3YFx7MYSyWo17w+VCFLtbLVOUt8VMAh8xY6HU
r4FTAnJiWsnjGnelq36kiCL5pYnQ//5ZNwlgYj2JMBk5eMxflm4eP4KcC9hzdQB0
t/7Ot2C0GiV4y3LiM58O1oW7uCJIY6VRO8M3/ErOTSPT/qBGILyyB8uz+JKGqrco
i5qWYP8Rwbq4yUxH4TTrWBHO7Hif2FiIkA22Ly0wP9yOrfG21gIDs9ib+WyZvlIs
J0Tv+LCGVKAFA6x/TFmyTfInPNdRZGfyYO4IepCdB3BVGHDeSdsy2uQDzeZX/fnt
wcQHRTahNwRB65EYA25YyAoH/017gamNymolDAOY8JQzJ46n/VVyJ/lBjYgYiCJA
S/DstHEl5UooSwHuhoNGzjJ/qByGxDQ4+/6rwbIVs9JJAR7tr6+3xbPjMwFSDYpN
umurXqOpedn1nOKYPb1jLy6I2JASfWfK/0toEh9/ZWC54OwKecdUflF74P/9E2xK
ODne7+x31r85+TGOsZfTofPxbqkmSRvYppxYPdrmQvLLhnbfObU=
=x1N9
-----END PGP SIGNATURE-----

--yzvxnptvnc5yk3wm--

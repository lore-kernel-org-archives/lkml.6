Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeEEVpx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:45:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:47011 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeEEVpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:45:52 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 May 2018 07:45:43 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] rhashtable: use cmpxchg() to protect ->future_tbl.
In-Reply-To: <20180505092725.rlwn77d3yhknspdw@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605430.18473.11758878046224478232.stgit@noble> <20180505092725.rlwn77d3yhknspdw@gondor.apana.org.au>
Message-ID: <874ljlepyw.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, May 05 2018, Herbert Xu wrote:

> On Fri, May 04, 2018 at 01:54:14PM +1000, NeilBrown wrote:
>> Rather than borrowing one of the bucket locks to
>> protect ->future_tbl updates, use cmpxchg().
>> This gives more freedom to change how bucket locking
>> is implemented.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> This looks nice.
>
>> -	spin_unlock_bh(old_tbl->locks);
>> +	rcu_assign_pointer(tmp, new_tbl);
>
> Do we need this barrier since cmpxchg is supposed to provide memory
> barrier semantics?

It's hard to find documentation even for what cmpxchg() is meant do, let
alone what barriers is provides, but there does seem to be something
hidden in Documentation/core-api/atomic_ops.rst which suggests full
barrier semantics if the comparison succeeds.  I'll replace the
rcu_assign_pointer with a comment saying why it isn't needed.

Thanks,
NeilBrown

>
>> +	if (cmpxchg(&old_tbl->future_tbl, NULL, tmp) !=3D NULL)
>> +		return -EEXIST;
>
> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlruJgcACgkQOeye3VZi
gbmISg/+NHCEEUQlrCp/hbVMYz7ERruLcVe1s6QgnrywsLmbljF/BFKkDR0LU+Bs
OtKc14Jjztz3EJ9rWkUVDBFVDz5XSJN5Xv5V4E2uacTc3YEMELu0NvbLhpfVqUTD
FtJut6XPO88jkrfdq35ilWgxP7A9vPw/lgPZbzGgT8lE2cHaRJ6Ll5Tfx0l4jv1A
w+rSTcnrItRpdZrANEy9w5U4GRj+afkfavMlUSMfvLVWm3c7gfK9I4vx0eLZdBwk
7ZsylSBfiPT9X7+YVjR28RL7unMC8/KbqyNTJWcqICHrj82wI00nGx3WDSSgwklp
0pWAs7mBckvekvosop5es+GCpJuW9vrJOtLHNLsnlA5GbCV8xTFcMTDhBQdJP/j2
Urfvt5qYQCYMw2XjZ9zdXPnYh0oLptfzvdRQXrVUQz+Ef4BabRDPPjoZb6jvdnOV
7d68ynttF053wDcAFC5Yyg+RFt1ED2YWbhbW3x0PfD4em8LL+qkzG/jwD7Qnqv+z
dMZ5K30GvZmT6gPsrwhBhElqWV8qUtCH+SJXqvGwxiCIDF3+Q3SLR7rHSLL7o0NP
smBCrItfZ1+Pp7LNPgXrK5DViB0oYnwkVIUalwGucoQyRRIMMCJbIfaXy3zMG9lc
hjF0ANhb0mZvSHZHBhQV2ivqI7bF8k87mCH8CjRKWdVzfzsmi4Y=
=QD+2
-----END PGP SIGNATURE-----
--=-=-=--

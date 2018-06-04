Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeFDVhw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:37:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34867 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeFDVhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:37:50 -0400
From: NeilBrown <neilb@suse.com>
To: Simon Horman <simon.horman@netronome.com>
Date: Tue, 05 Jun 2018 07:37:40 +1000
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>, Thomas Graf <tgraf@suug.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 15a/18] rhashtables: add lockdep tracking to bucket bit-spin-locks.
In-Reply-To: <20180604181609.sssd4ao6wfwj3il6@netronome.com>
References: <152782754287.30340.4395718227884933670.stgit@noble> <152782824984.30340.1634082820568216846.stgit@noble> <20180602050322.liesw324q5kawcue@gondor.apana.org.au> <9bea77df-e7db-677a-31b2-710dc6d956ee@gmail.com> <871sdnqty4.fsf@notabene.neil.brown.name> <87po17p8jd.fsf@notabene.neil.brown.name> <20180604181609.sssd4ao6wfwj3il6@netronome.com>
Message-ID: <87bmcqp717.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04 2018, Simon Horman wrote:

> On Mon, Jun 04, 2018 at 12:52:54PM +1000, NeilBrown wrote:
>>=20
>> Native bit_spin_locks are not tracked by lockdep.
>>=20
>> The bit_spin_locks used for rhashtable buckets are local
>> to the rhashtable implementation, so there is little opportunity
>> for the sort of misuse that lockdep might detect.
>> However locks are held while a hash function or compare
>> function is called, and if one of these took a lock,
>> a misbehaviour is possible.
>>=20
>> As it is quite easy to add lockdep support this unlikely
>> possibility see to be enough justification.
>
> nit: s/see/seems/
>

Thanks :-)  I've made that change for when I formally submit.

Thanks,
NeilBrown

>>=20
>> So create a lockdep class for bucket bit_spin_lock as attach
>> through a lockdep_map in each bucket_table.
>>=20
>> With the 'nested' annotation in rhashtable_rehash_one(), lockdep
>> correctly reports a possible problem as this lock it taken
>> while another bucket lock (in another table) is held.  This
>> confirms that the added support works.
>> With the correct nested annotation in place, lockdep reports
>> no problems.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsVsSQACgkQOeye3VZi
gbmEww//cMQG+c3/pbeLG/h4fUrcJmCLEmAk3V41/BxPNKCmfjvvL3No063PNJ/6
9zW4PUJKRCOIh6eiuDaMzAo02oCeO6KLuBWUPcwJa3bkl1J3K8FHGcsh2yC6wKPy
8O1Z00ivQ/iP6X9vi4raG/s+wiqCrRas2Olcp9MU+XURPORiV2AqdTdeIco6mfuH
vr5HePpBIwdd3w4Z3Eb0Zgf2sanPIixJPwB1hmiUhV+rE1jiI5P3185QSFe63jny
RzDudmuMDs41PxUX6LKx+MS4lCfAHkJDtiW0W322rxgd6qdE8oha3iyveWKmXsLd
RqX9E1/XWxZBDICIKX467NCjyjjClY4eMNWrIeM6uQnHmI16lnoUUw7PqrUE3mqJ
rTWqAa6mhZnh79w2flPpi/GG5f1Rx59u86yf28X+PQXTmT7p/gVNdU3HlbSNV+v+
V4+24l5Ds5pLwk++2odzQFGDLTPSRcme1APoTfBoReiuA2uWHVlkfIjZw9LPFkhC
d2Y71PJsUkwkXX3ug0otG+dnttZoOWoWlfZmhYmJp0sqKvciOOJH/Ngq00iJ/xca
dpg55NYtGxz2ue2biaFh3Yc7dmTGbVX6+Yx+Rt8aVbtxhy5PAPz9f/V9i4inBJS5
G6mt8w+APDLh9FibOtfNgb1XtASSmAvHCoL8w4r1Zul3hHBnnm0=
=c8jk
-----END PGP SIGNATURE-----
--=-=-=--

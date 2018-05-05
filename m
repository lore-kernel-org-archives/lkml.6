Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeEEViD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 17:38:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:46783 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeEEVh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 17:37:59 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 06 May 2018 07:37:49 +1000
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] rhashtable: remove nulls_base and related code.
In-Reply-To: <20180505091208.tnsxi6hdpjn456yz@gondor.apana.org.au>
References: <152540595840.18473.11298241115621799037.stgit@noble> <152540605427.18473.12277050439942480863.stgit@noble> <20180505091208.tnsxi6hdpjn456yz@gondor.apana.org.au>
Message-ID: <877eoheqc2.fsf@notabene.neil.brown.name>
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
>> This "feature" is unused, undocumented, and untested and so
>> doesn't really belong.  If a use for the nulls marker
>> is found, all this code would need to be reviewed to
>> ensure it works as required.  It would be just as easy to
>> just add the code if/when it is needed instead.
>>=20
>> This patch actually fixes a bug too.  The table resizing allows a
>> table to grow to 2^31 buckets, but the hash is truncated to 27 bits -
>> any growth beyond 2^27 is wasteful an ineffective.
>>=20
>> This patch result in NULLS_MARKER(0) being used for all chains,
>> and leave the use of rht_is_a_null() to test for it.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> I disagree.  This is a fundamental requirement for the use of
> rhashtable in certain networking systems such as TCP/UDP.  So
> we know that there will be a use for this.

I can see no evidence that this is required for anything, as it isn't
use and I'm fairly sure that in it's current form - it cannot be used.

Based on my best guess about how you might intend to use it, I suspect
it would be simpler to store the address of the bucket head in the nuls
rather than the hash and a magic number.  This would make it just as
easy to detect when a search reaches the end of the wrong chain, which I
presume is the purpose.
I would find that useful myself - if the search would repeat when that
happened - as I could then use SLAB_TYPESAFE_BY_RCU.

Were we to take this approach, all the code I've removed here would
still need to be removed.

>
> As to the bug fix, please separate it out of the patch and resubmit.

I don't know how to do that.  I don't know what is safe to change
without "breaking" the nulls_base code because that code is undocumented and
unused, so unmaintainable.
In general the kernel has, I believe, a policy against keeping unused
interfaces.  While that isn't firm and universal, is seems to apply
particularly well to unusable interfaces.

Thanks,
NeilBrown


>
> Thanks,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlruJC0ACgkQOeye3VZi
gbkMohAAhXfoRwWCgDRqVNy0SaQP0Rn7E69Zw7ZID9bEYv6NC/yHNHSShs7YJ2Wn
tHpqDvaOwuwE19cSHmUdOqvg/yVdsO+RlX31I4iR7MnVqfB5pg7msNYq58uUV+NE
EAKEyxwgv1a+7npX4urd7+gpZ/bNIv7hOQRr+CPPOibqN2sjHdzLT4QbF/plb27e
V012V0tSHF3OquF7HWZjl1VvdbfkFrXcwXYZH9X8X2N18oyMHhu5CrouvuDxDqDs
XKH3F4/EWT5ybL0WUfIzLNN71Zx3i+L8bnTWyefW1UmiJL/omrYShn1MMDNPstRq
t1QB4zjn0oi1r6DWda3QwAbh3s9QBOusCbUudPhZKY/eH6bqJ6pBKMT31aKyGfb3
Gi2xRibuVkmRfTmF0Z1JEZQa4HvOlXzmSxDw3l2eC9+RbZds4kPpklTEL0IDnf6N
dMg3DllJtvEUo5EYi24JdO9tTTNdgMrl/JJQzJYHcJunYyx7EXpAMJdMpw+un4oX
LqMWfxeAvPBg8RdnUDAJe07faO4YEMyE9jHNBjY8KYJJr7ZD3JFwkwCmsH/eRckt
Dhf+uFtM8wBJ+j3nv+0ZxXUJuFw9IgBI3HJ5xIw+MRz/8tRfxGwWFn5epGknHA9R
ahiw9196F9vFhNiKfl5zfvXTaTqXi5WKwBIcdDmi8eupknCzlsU=
=E1IN
-----END PGP SIGNATURE-----
--=-=-=--

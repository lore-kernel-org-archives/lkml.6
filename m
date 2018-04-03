Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753033AbeDCDlj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 23:41:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751368AbeDCDli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 23:41:38 -0400
From: NeilBrown <neilb@suse.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 03 Apr 2018 13:41:26 +1000
Cc: cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Tom Herbert <tom@quantonium.net>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
In-Reply-To: <20180329170626.GA24218@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com> <20180329123544.GA22551@gondor.apana.org.au> <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com> <20180329154153.GA23562@gondor.apana.org.au> <CAHc6FU708-F-C_ihwBW-zKC7rZvfeuKYq7kTccZQU156UicjQA@mail.gmail.com> <20180329170626.GA24218@gondor.apana.org.au>
Message-ID: <871sfx0xeh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Fri, Mar 30 2018, Herbert Xu wrote:

> On Thu, Mar 29, 2018 at 06:52:34PM +0200, Andreas Gruenbacher wrote:
>>
>> Should rhashtable_walk_peek be kept around even if there are no more
>> users? I have my doubts.
>
> Absolutely.  All netlink dumps using rhashtable_walk_next are buggy
> and need to switch over to rhashtable_walk_peek.  As otherwise
> the object that triggers the out-of-space condition will be skipped
> upon resumption.

Do we really need a rhashtable_walk_peek() interface?
I imagine that a seqfile ->start function can do:

  if (*ppos == 0 && last_pos != 0) {
  	rhashtable_walk_exit(&iter);
        rhashtable_walk_enter(&table, &iter);
        last_pos = 0;
  }
  rhashtable_walk_start(&iter);
  if (*ppos == last_pos && iter.p)
  	return iter.p;
  last_pos = *ppos;
  return rhashtable_walk_next(&iter)


and the ->next function just does

  last_pos = *ppos;
  *ppos += 1;
  do p = rhashtable_walk_next(&iter); while (IS_ERR(p));
  return p;

It might be OK to have a function call instead of expecting people to
use iter.p directly.

static inline void *rhashtable_walk_prev(struct rhashtable_iter *iter)
{
	return iter->p;
}

Thoughts?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrC9+cACgkQOeye3VZi
gbm+Gg/9HrfwL/34+UdLALO+iHywnyIrA4C55+jnAWyMf93rosnaldFfPpWZmNgd
6DpWlPKSzDamziaxaaWOtDDIRy1ia4Ig1TgVWe0ZMrnIVqu75ffemzCVV3epHzfw
1ptFAIb0Vlgw1mLLMjcSRXgXO7NMFQV0laVFMnjeReeTBfMYoPhCx0xyTh9dISMl
BLMJXpJ6ne84eXqFtMyWCvi1sBdLjK+Xw3Og4nk1spPwiFA7dhfH6VEzImlMyxrL
WAD9vDiFFYjcB5wxH+gZ96wLEw2dTQmXEpcslYCQGsTaoTM1RNKfjXICetWiQO95
Jo/0rTozmtUxpcXhMfIyB9zMRpzNNLcKVgQom1tMEKhDiPAvRnfYxyfOkr9k8nd8
65sQqL6kphVRI1me+i3jgGgGdIGuobcM2AdsW2HRv79fr2JOtgkpT+8dTGTvkFHt
g51fJjxKCRN3ye6XzJ5oLu32AxZOMblkoIIUK3djLJ9eeNP44DaY5t3qxBUnmxLT
bat5oks/omLteabu/fj1PjWxftn2hNsEPwnPHMyylLUl7mqSH0iKdWhqxiZy49i/
ThzfzC9n8wRhBpbYd5+X7ZrJ2DWHh3TmMRiBWdpmqKn/MejLp9XMW2tRI4oI9fsA
97Vvsfi2m4kVvDPmtMmwuSuI5HDh7XMM3lrccLVaaj5cvJ4SG1I=
=lo6j
-----END PGP SIGNATURE-----
--=-=-=--

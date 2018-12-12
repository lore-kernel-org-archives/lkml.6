Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B94C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C541B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 06:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C541B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLLGll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 01:41:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:33902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbeLLGll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 01:41:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25E0BAFDC;
        Wed, 12 Dec 2018 06:41:38 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Wed, 12 Dec 2018 17:41:29 +1100
Cc:     Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rhashtable: further improve stability of rhashtable_walk
In-Reply-To: <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au>
References: <153086101070.2825.6850140624411927465.stgit@noble> <153086109256.2825.15329014177598382684.stgit@noble> <87zhtkeimx.fsf@notabene.neil.brown.name> <20181207053943.7zacyn5uvqkfnfoi@gondor.apana.org.au> <87k1kico1o.fsf@notabene.neil.brown.name> <20181211051755.modgomqzszkbiihe@gondor.apana.org.au> <87mupbvch0.fsf@notabene.neil.brown.name> <20181212054601.wbzpxjunnsfi62mz@gondor.apana.org.au>
Message-ID: <87efanuu06.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12 2018, Herbert Xu wrote:

> On Wed, Dec 12, 2018 at 11:02:35AM +1100, NeilBrown wrote:
>>=20
>> So I think this is a real bug - it is quite unlikely to hit, but
>> possibly.
>> You need a chain with at least 2 objects, you need
>> rhashtable_walk_stop() to be called after visiting an object other than
>> the last object, and you need some thread (this or some other) to remove
>> that object from the table.
>>=20
>> The patch that I posted aims to fix that bug, and only that bug.
>> The only alternative that I can think of is to document that this can
>> happen and advise that a reference should be held to the last visited
>> object when stop/start is called, or in some other way ensure that it
>> doesn't get removed.
>
> Thanks for reminding me of the issue you were trying to fix.
>
> So going back into the email archives, I suggested at the very
> start that we could just insert the walker objects into the actual
> hash table.  That would solve the issue for both rhashtable and
> rhlist.
>
> Could we do that rather than using this ordered list that only
> works for rhashtable?

No. that doesn't work.
When you remove the walker object from the hash chain, you need to wait
for the RCU grace period to expire before you can safely insert back
into the chain. Inserting into a different chain isn't quite so bad now
that the nulls-marker stuff is working, a lookup thread will notice the
move and retry the lookup.

So you would substantially slow down the rhashtable_walk_start() step.
I've tried to think of various ways to over come this problem, such as
walking backwards through each chain - it is fairly safe to move and
object earlier in the chain - but all the approaches I have tried make
the code much more complex.

Thanks,
NeilBrown


>
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwQrZoACgkQOeye3VZi
gbmV5g//bkJtiWIR+EH/pwBVgpR0vLOZAc19P0GXhARLjEuS1oI1eiLekpjHmxqc
0BIqWba2YJEg4G3+igBHrk6fviNf3flPJ2xMyo8ixuN0/YwgJLmx+Jc7t1Va++G9
zaYDnYCzLDjsqF8A/ncj8vhuA1sn9hn3gHJxb2/EXlbMuCwHVJRx912d5bzllMxh
2a3IX+deB+2MNGg5Rp/yos9a2vH689k7Tjt5k1spILclCj8usLRQACZfMHqxpXBR
qYOtRbgCfnDPRjS/tQSbeA+kGEivRlKGMZ07hFgqUdkf9cza+lPeNSB9mOpCA6Wv
iXo8rU2+Yju3ob229rToC9O6fMDVzSsHe+gM0TNNGEW7dyYX254tBuOHSXjMyOAA
7kabmicOODsQ361wROgr7xx7b3Ahzt6LiCs94msTW+C/efXDx0by7Uum1NjfFPC9
pCEYK3KoDME4/gOWa2kppLbTuKqidhZfKr2o8cxbl92volMHZJD1VI8YTDrE2F1Y
8F9Dt4buZWzMJMTm6808J2PAvsfHJ9CVnKpXf40me3P57RUQLGthWf3Oj37w87Qy
ReOXe87XVn87k8hbO9JLChmSxt0lQkVtA7JoCgi7nrq4C4WNkM+H3LK7Ahwst3l3
D+NTSo+Gf9J9Si0qCMm5QGrnmB+YL3f6UwQefYAcfwTYaeg6sao=
=MLM/
-----END PGP SIGNATURE-----
--=-=-=--

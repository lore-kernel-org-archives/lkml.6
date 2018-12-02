Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3680EC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0686D2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0686D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbeLBWUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:20:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:57828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbeLBWUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:20:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 976F7AF4D;
        Sun,  2 Dec 2018 22:20:39 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 03 Dec 2018 09:20:23 +1100
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH v3] rhashtable: detect when object movement between tables might have invalidated a lookup
In-Reply-To: <20181201084727.6mfh46yshxdoba4h@gondor.apana.org.au>
References: <87muqbtev6.fsf@notabene.neil.brown.name> <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au> <878t1tece0.fsf@notabene.neil.brown.name> <87pnuno479.fsf@notabene.neil.brown.name> <20181201084727.6mfh46yshxdoba4h@gondor.apana.org.au>
Message-ID: <878t17o9js.fsf@notabene.neil.brown.name>
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

On Sat, Dec 01 2018, Herbert Xu wrote:

> On Fri, Nov 30, 2018 at 10:26:50AM +1100, NeilBrown wrote:
>>
>> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
>> index 30526afa8343..852ffa5160f1 100644
>> --- a/lib/rhashtable.c
>> +++ b/lib/rhashtable.c
>> @@ -1179,8 +1179,7 @@ struct rhash_head __rcu **rht_bucket_nested(const =
struct bucket_table *tbl,
>>  					    unsigned int hash)
>>  {
>>  	const unsigned int shift =3D PAGE_SHIFT - ilog2(sizeof(void *));
>> -	static struct rhash_head __rcu *rhnull =3D
>> -		(struct rhash_head __rcu *)NULLS_MARKER(0);
>> +	static struct rhash_head __rcu *rhnull;
>>  	unsigned int index =3D hash & ((1 << tbl->nest) - 1);
>>  	unsigned int size =3D tbl->size >> tbl->nest;
>>  	unsigned int subhash =3D hash;
>> @@ -1198,8 +1197,11 @@ struct rhash_head __rcu **rht_bucket_nested(const=
 struct bucket_table *tbl,
>>  		subhash >>=3D shift;
>>  	}
>>=20=20
>> -	if (!ntbl)
>> +	if (!ntbl) {
>> +		if (!rhnull)
>> +			INIT_RHT_NULLS_HEAD(rhnull);
>>  		return &rhnull;
>> +	}
>
> I think you missed my earlier reply beause of bouncing emails.

Yeah, sorry about that.  I should have looked through an lkml archive
once I realized that was happening - I have now.

>
> I think this is unnecessary because
>
> 	RHT_NULLS_MARKER(RHT_NULLS_MARKER(0)) =3D RHT_NULLS_MARKER(0)
>

I don't understand how this is relevant.

I think you are saying that when rht_bucket_nested() finds that the
target page hasn't been allocated, it should return a pointer to a
static variable which contains RHT_NULLS_MARKER(0)

 static struct rhash_head *rhnull =3D RHT_NULLS_MARKER(0);

Then in __rhashtable_lookup(),
	head =3D rht_bucket(tbl, hash);

would result in 'head' having the value '&rhnull'.

Then
		rht_for_each_rcu_continue(he, *head, tbl, hash) {

would result in 'he' having the value RHT_NULLS_MARKER(0)

Then
	} while (he !=3D RHT_NULLS_MARKER(head));

will compare RHT_NULLS_MARKER(0) with RHT_NULLS_MARKED(&rhnull)
and they will be different, so it will loop indefinitely.

With respect to the shifting, you wrote:

> The top-bit is most likely to be fixed and offer no real value.

While this might be likely, it is not certain, so not relevant.
On a 32bit machine with more than 2GB of physical memory, some memory
addresses will have 0 in the msb, some will have 1.
It is possible (however unlikely) that two hash buckets in different
tables will have the same address except for the msb.  If we ignore the
msb, we might incorrectly determine that we have reached the end of the
chain from the first bucket, whereas we actually reached the end of the
chain from the second bucket.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwEWqsACgkQOeye3VZi
gbm+hw//TTRkiV4JY0ksig2gHFTyDTIjqyZajks5Tg3ZHyt2Ry3TWrAoYMoDd2+/
iyHbknxYy3zXBLC/QEhNsUvh/fZtCBSPGh/9qpnTNJm6d8+E+btnBIh1poWRyxoH
VCQu4+RyNwgLjtIAfw3v++ku1uj00OQ1R+whs1DXu9R+VVI3DRAJmRrHldgp5nDl
QNrtUP4wYZOTj7RCPIIcaTjaYJYK1eqzquEIB0rYzhDqT3mEkFGHHJoRy6ifkRTL
xMy6Z8PdsKAL0oWAOQ7xMXIdNPR9vuqmoSv0cLRExyYxqn9RhkYzVjWij2EdH0mB
acH3VTMFkpAIee2Ppp82gwMdwqIrQUhaJvKshab7nxQlW+Nd2RmylJMZfdnGV7bM
oF9WJuqEnWoAFAo1IlTz4DaamUYQHWYqvgQ4xq9gl204SHdwOfYrYNJGyV3+dgIX
/+bidcSjJM5ugYHQJQzgd3WSjjDS+jQsZ5IXwD3+qoxEw+xs11Z+cOr1OK482LVp
6gGkQLTD1feQnqZQo1OpWp9mcTZWff7CANMBdSjDIegtvXfsSYr92o8L4myjSmFA
48eU3/tTq4Xb3LkhW4Zh7VRYl6zXPwUVJ/3iQDuqNAC6g4bGTjqiBjJU4jPW1L3B
SOuQWEzSMckoi8BQSJAp+lABnhRdY9RrejSuWgfMHPrrJkZrP7s=
=y12K
-----END PGP SIGNATURE-----
--=-=-=--

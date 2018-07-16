Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C5DECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A09208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 03:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A09208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeGPDwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 23:52:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbeGPDwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 23:52:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F259ACD0;
        Mon, 16 Jul 2018 03:26:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Mon, 16 Jul 2018 13:26:42 +1000
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180716021653.xtbyetdfc2uzxub3@gondor.apana.org.au>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au> <87k1q8yh70.fsf@notabene.neil.brown.name> <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net> <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180716005134.q4rfkfn3m5zzwt62@gondor.apana.org.au> <874lh0t1ls.fsf@notabene.neil.brown.name> <20180716021653.xtbyetdfc2uzxub3@gondor.apana.org.au>
Message-ID: <871sc3uah9.fsf@notabene.neil.brown.name>
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

On Mon, Jul 16 2018, Herbert Xu wrote:

> On Mon, Jul 16, 2018 at 11:23:43AM +1000, NeilBrown wrote:
>>
>> kmem_cache_free() directly.  For this, I need rhashtable to be safe if
>> an object is deleted and immediately re-inserted into the same hash
>> chain.
>
> This means that
>
> 	rcu_read_lock();
> 	A =3D rhashtable_lookup();
> 	use(A);
> 	rcu_read_unlock();
>
> A can turn into object B when it is used.  That is just too strange
> for words.  Can we see some actual code on how this works?

Look in Documenation/RCU/rculist_nulls.txt.
The very first example is a typical lookup for a nulls list.
The above sample code would read:

	rcu_read_lock();
    begin:
        A =3D rhashtable_lookup(table, key);
        if (IS_ERR(A)) {
        	rcu_read_unlock();
        	goto not_found;
        }
        if (!try_get_ref(A))
        	goto again;
        if (A->key !=3D key) {
        	put_ref(A);
        	goto again;
        }
        rcu_read_unlock();
        use(A);

If you particularly need to see real code rather than sample code, I can
have something for you in a day or so.

Thanks,
NeilBrown

>
> For comparison, the existing net code where this happens A doesn't
> actually change and it simply moves from one hashtable to another.
>
> I'm relucant to add semantics that would restrain on how rhashtable
> works unless we have real and valid use-cases for it.
>
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltMEHIACgkQOeye3VZi
gbk5cxAAvpidPqQh63nN6GdyYYWEnwormiljs0uTGOlOplBwsJqWnBo0Nm08Epzt
09nKdLbUQXKsQcZMN8E0TPUBKk3q0rUYADMnMASjT79l2qt1VV+Rhyxw9L10Nd1i
2h/ScrDSW9XLFcINFgXKAhu3GCgH/NQvlIMffEQDc6Aol1q1wXxVlaI5CfdZAMt6
Br5k6M0VHGDTz0A3pakc9Rz+EkpedSO5ftW/658nZISkZ06tje4DNS5bccYPPwlw
99afEi0NNVhD21hDYsOezlZ9pk3XISe/2e8kWiE1Ann8fYfbxuwKV7E01w8YUcPE
vmWgtYZlFyygRJewdRE04VoMRtUVEr2vywGWNlhgMRzYFwlcAFDSVWiJ/JHIoNfM
Ni3nIMdTr7eZxD6AW4um7sgPSLhRGr4wfP4LTMWDF6NeJB5Hmn6hEhecfqCnaKIS
GescQIMVGkPLiElIVT2J7CDjiGcG59k312PjGutk0G/sncPmYkmuEAbJz4eNHZhm
oxcHlt1uA51dDfa5htjT0ek5FFA5IXiqCcmsA6jbDMxFuNy7I64ls3Ps6wBl8OCd
hvnYDbCWv1AlqT61F9XfnsX1fDvWeKCVl2Czo0sdlWci8QufXD7ZdDQsOrCDxPFW
cS3073e/ojrfCcRsfQNev1DN61ZXBKsItu1/54M4UzH5SmwNtnk=
=E5JH
-----END PGP SIGNATURE-----
--=-=-=--

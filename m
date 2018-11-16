Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174BAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DCD20818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 06:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DCD20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbeKPRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:10:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:39258 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727380AbeKPRKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:10:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7EA3AFD2;
        Fri, 16 Nov 2018 06:59:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Date:   Fri, 16 Nov 2018 17:59:19 +1100
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH] rhashtable: detect when object movement between tables might have invalidated a lookup
In-Reply-To: <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
References: <87muqbtev6.fsf@notabene.neil.brown.name> <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
Message-ID: <878t1tece0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

E
--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16 2018, Herbert Xu wrote:

> On Thu, Nov 15, 2018 at 10:32:13AM +1100, NeilBrown wrote:
>>
>> +#define	RHT_NULLS_MARKER(ptr)	\
>> +	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
>>  #define INIT_RHT_NULLS_HEAD(ptr)	\
>> -	((ptr) =3D (typeof(ptr)) NULLS_MARKER(0))
>> +	((ptr) =3D RHT_NULLS_MARKER(&(ptr)))
>
> Why are you shifting this by one?

NULLS_MARKER assumes a hash value in which the bottom bits are most
likely to be unique.  To convert this to a pointer which certainly not
valid, it shifts left by 1 and sets the lsb.
We aren't passing a hash value, but are passing an address instead.
In this case the bottom 2 bits are certain to be 0, and the top bit
could contain valuable information (on a 32bit system).
The best way to turn a pointer into a certainly-invalid pointer
is to just set the lsb.  By shifting right by one, we discard an
uninteresting bit, preserve all the interesting bits, and effectively
just set the lsb.

I could add a comment explaining that if you like.

>
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
>
> I don't understand why you can't continue to do NULLS_MARKER(0) or
> RHT_NULLS_MARKER(0).

Because then the test

+	} while (he !=3D RHT_NULLS_MARKER(head));

in __rhashtable_lookup() would always succeed, and it would loop
forever.

Thanks for the review.

NeilBrown


>
> Cheers,
> --=20
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlvuasgACgkQOeye3VZi
gbn6vQ//YwVZZrlltmReIxG9Zr77njxcVzPB947UE2RKEBllzaoMVMeFiXcwcTEx
iExleIGw+6myZeqb0cInUvh+rDZr7ohllSUNz859ABo2nmPgLr6qZGk1JkmV2jot
JaYiNP3oVi8rLElvPW064iX1NdCH7ebMjVW2GQ5bi0H0T/mz7WkJDKP5IIlxAV8G
pEEyNjMXlNrfntOdbbtYwJkOPCIBoHODtMrSeGx7K50ptXN8517hecL16aLrHkwf
y6//wpZeaUWtaPxS4CuXc/dFx2rcZAXRl2eS5zteTbMi769jvtwVdFlzI/wg9Sut
O8Ble1mTSSD1n4wyXtIO4xVuTkKqG6A0rVb5EPsBGDPxdsq07vLXPBaUPGrWWRn5
B7lCMBtXX5MqxlWwg+32EB/uxXmOL8kCqVslWl0L0Nw3S4yVvVrHWF71HVQVqBvc
JxhOBa4doWmZSBEn9PS80TDZrnHPHDf7SJiX87ySCdW+rYqV/11ryoOUwfCt0xjS
RI9A6lfI7aPIwpNsSxoF7wuqpiXC991qxMon85V3gpG4xRZqSbgETDjrwKVuCsBL
qJ8Q7Q9npwSu79F7lo50Y2nvg01C4qaX2MnYz6liTbyvxnO4X2QRSvsmhSQuh7LW
sJa7w+1B+2FfGundcMNdSaYWd0vT6HjjoUXqxB2bQzd/ioPxpWQ=
=YJub
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--

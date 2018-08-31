Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43237C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E410D2083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E410D2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbeIABZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:25:04 -0400
Received: from shelob.surriel.com ([96.67.55.147]:53920 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIABZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:25:04 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fvqlX-00079X-Si; Fri, 31 Aug 2018 17:15:39 -0400
Message-ID: <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
From:   Rik van Riel <riel@surriel.com>
To:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 31 Aug 2018 17:15:39 -0400
In-Reply-To: <20180831203450.2536-1-guro@fb.com>
References: <20180831203450.2536-1-guro@fb.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5zJmtvGhdpjMbqPTGgaf"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5zJmtvGhdpjMbqPTGgaf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2018-08-31 at 13:34 -0700, Roman Gushchin wrote:

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fa2c150ab7b9..c910cf6bf606 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -476,6 +476,10 @@ static unsigned long do_shrink_slab(struct
> shrink_control *shrinkctl,
>  	delta =3D freeable >> priority;
>  	delta *=3D 4;
>  	do_div(delta, shrinker->seeks);
> +
> +	if (delta =3D=3D 0 && freeable > 0)
> +		delta =3D min(freeable, batch_size);
> +
>  	total_scan +=3D delta;
>  	if (total_scan < 0) {
>  		pr_err("shrink_slab: %pF negative objects to delete
> nr=3D%ld\n",

I agree that we need to shrink slabs with fewer than
4096 objects, but do we want to put more pressure on
a slab the moment it drops below 4096 than we applied
when it had just over 4096 objects on it?

With this patch, a slab with 5000 objects on it will
get 1 item scanned, while a slab with 4000 objects on
it will see shrinker->batch or SHRINK_BATCH objects
scanned every time.

I don't know if this would cause any issues, just
something to ponder.

If nobody things this is a problem, you can give the
patch my:

Acked-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

--=-5zJmtvGhdpjMbqPTGgaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAluJr/sACgkQznnekoTE
3oORTwgAv23YdpXURejxj0dK5yd07yA/fu6+B4F3wMqsPJOkSoctfZUWvPjVoYaC
cFMh2AzoAg/nCn8hN7uetZKGbjYlLjNuKWAzSPEIn8Nay+H/erpYRKcdemCRHYg5
9CLxaxlFK/lBfuBEwjAvoiizmiuCOm+ZqtBSl5zO3k63TypAD9E8jYHKE02Inr3d
WCwgkh2pUc0h0aSZZK2wmHj5ori86UAyjEBmrPmtPfktUwUqtmhQ8ewilyFVLylE
N54npyirQF1/wxziYyFeaCZibE7vn8fjghAQmXzgJ8wXkd38FUyKUaUH7LT0KDXs
JCzeNs24VoGD/JGH8WyoqOLUtrnQiw==
=W3kT
-----END PGP SIGNATURE-----

--=-5zJmtvGhdpjMbqPTGgaf--


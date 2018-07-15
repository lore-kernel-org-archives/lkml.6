Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAECDECDFB3
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724132089D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 23:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724132089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeGPAUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 20:20:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:56550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727007AbeGPAUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 20:20:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4FD24AD23;
        Sun, 15 Jul 2018 23:56:00 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Mon, 16 Jul 2018 09:55:49 +1000
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH resend] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180711.224801.1129067473269289703.davem@davemloft.net>
References: <20180601160613.7ud25g2ux55k3bma@gondor.apana.org.au> <87k1q8yh70.fsf@notabene.neil.brown.name> <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net>
Message-ID: <87in5gt5oa.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 11 2018, David Miller wrote:

> From: David Miller <davem@davemloft.net>
> Date: Wed, 11 Jul 2018 22:46:58 -0700 (PDT)
>
>> From: NeilBrown <neilb@suse.com>
>> Date: Fri, 06 Jul 2018 17:08:35 +1000
>>=20
>>>=20
>>> Some users of rhashtable might need to change the key
>>> of an object and move it to a different location in the table.
>>> Other users might want to allocate objects using
>>> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
>>> being used for a different (type-compatible) purpose and similarly
>>> end up in a different hash-chain.
>>>=20
>>> To support these, we store a unique NULLS_MARKER at the end of
>>> each chain, and when a search fails to find a match, we check
>>> if the NULLS marker found was the expected one.  If not,
>>> the search is repeated.
>>>=20
>>> The unique NULLS_MARKER is derived from the address of the
>>> head of the chain.
>>>=20
>>> If an object is removed and re-added to the same hash chain, we won't
>>> notice by looking that the NULLS marker.  In this case we must be sure
>>> that it was not re-added *after* its original location, or a lookup may
>>> incorrectly fail.  The easiest solution is to ensure it is inserted at
>>> the start of the chain.  insert_slow() already does that,
>>> insert_fast() does not.  So this patch changes insert_fast to always
>>> insert at the head of the chain.
>>>=20
>>> Note that such a user must do their own double-checking of
>>> the object found by rhashtable_lookup_fast() after ensuring
>>> mutual exclusion which anything that might change the key, such as
>>> successfully taking a new reference.
>>>=20
>>> Signed-off-by: NeilBrown <neilb@suse.com>
>>=20
>> Applied to net-next.
>
> Actually, reverted, it doesn't even compile.
>
> lib/rhashtable.c: In function =E2=80=98rht_bucket_nested=E2=80=99:
> lib/rhashtable.c:1187:39: error: macro "INIT_RHT_NULLS_HEAD" passed 3 arg=
uments, but takes just 1
>     INIT_RHT_NULLS_HEAD(rhnull, NULL, 0);
>                                        ^
> lib/rhashtable.c:1187:4: error: =E2=80=98INIT_RHT_NULLS_HEAD=E2=80=99 und=
eclared (first use in this function); did you mean =E2=80=98INIT_LIST_HEAD=
=E2=80=99?
>     INIT_RHT_NULLS_HEAD(rhnull, NULL, 0);
>     ^~~~~~~~~~~~~~~~~~~
>     INIT_LIST_HEAD
> lib/rhashtable.c:1187:4: note: each undeclared identifier is reported onl=
y once for each function it appears in

How embarrassing :-(
I had tested a series, but not each individual patch.  Sorry about that.
I'll post the correct patch.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltL3wUACgkQOeye3VZi
gbmIkA/+JkJm/k2ft3NILwrjuuZeGAEUggPRr2Vnk3sk+Ba9UQmxNy7eTMjMfpH3
gMolyZrf3wb3Xqz9xUO/Eq+ajo6YGMPSkBAsctHvTpu/ueSI9T+8p5onaYf6+WQU
JLJdV3Ekk+8UyJKs5Vq7K8N24EAiqicXaDnsahK+dXbbdafFiO2Ar6sZLDr2LlfA
i3Sukta8viXj3ErXU1rJdlDqvEP1IlH06/hkuSAI/kMyTRsO3DwiocGCD9Pc10ab
NdutdJVid8lLrx6lJ1LznUq05BbjJywjgjkFEpSZ8O4pOgQCyslcbxZ5QJWE3Pzd
TntLHnXlp8UUXB+/lewZAemmzbn27dYUXghBUF8bg7EJC075pgwC6Q8A9u5G5fIs
IljBWOvSiq5hLpI6nvggX8v963KIgoJ59146EeOmSVJ1dc/o1iEca6m2vwuRCapp
FqbyC9coALXNSjBXCIfdk1ukYTyFUBf53/63cBwxFB878rxue639fX8OVm2SCdBh
tHL2TODsL3Rgq/dlEzzi8Tt6qeHt1Vw2a5YlX/mox53ASqrBbB1J3QI9GtM4hVJn
JOHDpvPAzwDJ2pO0BiWmRWdfskCfDPRTadR1wyqVNTjR2Quwm4CZiwDPlyMARvo4
pyQHIBhzTdQJyeOwbo7rl0wrEzy9bKEudZoQg819P4VkzSXQZhY=
=38sH
-----END PGP SIGNATURE-----
--=-=-=--

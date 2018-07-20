Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC87EECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA39720673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeGTHRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:17:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:59828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727103AbeGTHRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:17:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 542E9ADE7;
        Fri, 20 Jul 2018 06:30:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     David Miller <davem@davemloft.net>
Date:   Fri, 20 Jul 2018 16:30:34 +1000
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH - revised] rhashtable: detect when object movement might have invalidated a lookup
In-Reply-To: <20180719.051440.931407144963903326.davem@davemloft.net>
References: <20180711.224658.2077863065492745521.davem@davemloft.net> <20180711.224801.1129067473269289703.davem@davemloft.net> <87fu0kt5m0.fsf@notabene.neil.brown.name> <20180719.051440.931407144963903326.davem@davemloft.net>
Message-ID: <87va9aqv05.fsf@notabene.neil.brown.name>
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

On Thu, Jul 19 2018, David Miller wrote:

> From: NeilBrown <neilb@suse.com>
> Date: Mon, 16 Jul 2018 09:57:11 +1000
>
>> Some users of rhashtable might need to change the key
>> of an object and move it to a different location in the table.
>> Other users might want to allocate objects using
>> SLAB_TYPESAFE_BY_RCU which can result in the same memory allocation
>> being used for a different (type-compatible) purpose and similarly
>> end up in a different hash-chain.
>>=20
>> To support these, we store a unique NULLS_MARKER at the end of
>> each chain, and when a search fails to find a match, we check
>> if the NULLS marker found was the expected one.  If not,
>> the search is repeated.
>>=20
>> The unique NULLS_MARKER is derived from the address of the
>> head of the chain.
>>=20
>> If an object is removed and re-added to the same hash chain, we won't
>> notice by looking that the NULLS marker.  In this case we must be sure
>> that it was not re-added *after* its original location, or a lookup may
>> incorrectly fail.  The easiest solution is to ensure it is inserted at
>> the start of the chain.  insert_slow() already does that,
>> insert_fast() does not.  So this patch changes insert_fast to always
>> insert at the head of the chain.
>>=20
>> Note that such a user must do their own double-checking of
>> the object found by rhashtable_lookup_fast() after ensuring
>> mutual exclusion which anything that might change the key, such as
>> successfully taking a new reference.
>>=20
>> Signed-off-by: NeilBrown <neilb@suse.com>
>
> Neil I have to be honest with you.

Thank you.

>
> During this whole ordeal I was under the impression that this was all
> going to be used for something in-tree.  But now I see that you want
> to use all of this stuff for lustre which is out of tree.
>
> It would be extremely hard for me to accept adding this kind of
> complexity and weird semantics to an already extremely complicated
> and delicate piece of infrastructure if something in-tree would use
> it.
>
> But for something out-of-tree?  I'm sorry, no way.

That's unfortunate, but I can live with it.  null-list support is
just a nice-to-have for me.
I'll resend the patch with the unwanted complexity removed.

Does this ruling also apply to the bit-spin-lock changes and the
per-cpu-counter changes that I have proposed?
These improve scalability when updates dominate.  Not having these
in mainline would mean I need to carry a separate rhashtables
implementation for lustre, which means code diversion which isn't
healthy in the long run.

(Note that, in my mind, lustre is only temporarily out-of-tree.  It is
coming back, hopefully this year).

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltRgYoACgkQOeye3VZi
gbn8tRAAo363kUgnVbRsWfhBHeu2w9FGOaGOf0NXgNcDn7PByfecdX066JqQntVW
CWNJ6QpnWeVrQ0GOW6nsnyPzvzozI30VwXr+yunprQnfzWRfg/xwS8hiXpbtHt11
IOca1Lc9Jv2iF8MngDPiEcz70N/6EQ6K1Kn2MmH/23vWqER9wXev7db5PPWydHrF
uDhVykiL6I7xKo/5TZPUwz+FKVNgAIFL32jSdn4DPq7Cp6fkrOagAG+Z+QRTLiKV
Oe1qa23VCT8mH/gwTIB/YJY7Mut8XQx+fawAzxb15bm0c22hQ1WMaBKr8SdUlnly
5Of+N/6laxn37lpjmqr+N1bmmBwelZ21aCFl5Bw9Mf2H3bUEAYVSwa1Uqtd6UPKx
3qGyDuBM9JjEx9NCjSDiMsqb1YXs1z3UKjQMtgof34N9j5R2h95pBc4e0w+0dTq1
XrAtzfJRecINTpcEOhjH/PAZ3k6g0WdF7i7l6BcFrpZvWlsFHsNCgLubVYFNe+cL
KA/bxtiZHcQnCvP6X3Vcb11cpFTHKdG+R0W9re0rckuTsje8lkU1u0brDLLATy86
OrRIvtYujdc9tUP05BhdT8ISWYt6P/4F/pNGge2IMi7dABhsKGJxGzWS++/GLfx2
32yc3hqEm5hCH7GlXWEmUtghFJW0Jse302n+tUaJg8QcW1NIyPk=
=GPUD
-----END PGP SIGNATURE-----
--=-=-=--

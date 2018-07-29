Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD98FF05E1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7C020857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 12:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7C020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeG2NdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 09:33:11 -0400
Received: from shelob.surriel.com ([96.67.55.147]:46942 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeG2NdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 09:33:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjkPY-0004sE-AE; Sun, 29 Jul 2018 08:02:56 -0400
Message-ID: <1532865776.28585.4.camel@surriel.com>
Subject: Re: [PATCH 04/10] x86,mm: use on_each_cpu_cond for TLB flushes
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun, 29 Jul 2018 08:02:56 -0400
In-Reply-To: <CALCETrUPvja=MNOFkN7iK7Vs=r8QbP1Avwn_gsX3UpMS5qf__Q@mail.gmail.com>
References: <20180728215357.3249-1-riel@surriel.com>
         <20180728215357.3249-5-riel@surriel.com>
         <CALCETrUPvja=MNOFkN7iK7Vs=r8QbP1Avwn_gsX3UpMS5qf__Q@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XEwfSrrrHge77OiIjk6k"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XEwfSrrrHge77OiIjk6k
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-07-28 at 19:58 -0700, Andy Lutomirski wrote:
> On Sat, Jul 28, 2018 at 2:53 PM, Rik van Riel <riel@surriel.com>
> wrote:
> > Instead of open coding bitmap magic, use on_each_cpu_cond
> > to determine which CPUs to send TLB flush IPIs to.
> >=20
> > This might be a little bit slower than examining the bitmaps,
> > but it should be a lot easier to maintain in the long run.
>=20
> Looks good.
>=20
> i assume it's not easy to get the remove-tables case to do a single
> on_each_cpu_cond() instead of two?  Currently it's doing the lazy
> ones and the non-lazy ones separately.

Indeed. The TLB gather batch size means we need to send
IPIs to the non-lazy CPUs whenever we have gathered so
many pages that our tlb_gather data structure is full.

This could result in many IPIs during a large munmap.

The lazy CPUs get one IPI before page table freeing.

--=20
All Rights Reversed.
--=-XEwfSrrrHge77OiIjk6k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAltdrPAACgkQznnekoTE
3oOk0gf9EYPFeawFl4542FfuxfHknusccCZ+PtsSBKP8J+FbGotZ9DSoABWLT947
cuQ5VexITQJROybH50b2sQtFaQWOxStYthhJZKS2CIICksjx1hz9ijfFu4U7C/U8
EI7JHV7cRtDJUzkP5axcH6/ZEbIMRIvUhI+cHDOzgE13fXGE01wJJLJwvQ46askO
TQJGejYBwHH5QYxZE6sJOatWd+5JyGQlhDhF67m1he3AUyw2cgD4gVmvzXEOjdp9
qqceDBa7OgmGZG15/JSKDD+HLErIuKtktjNxANFsCQ9m5aeIRXE7tt5GJvLSHbN2
/YdYMaojIxU1y/6FbLLdwLErHHjd+A==
=gFXc
-----END PGP SIGNATURE-----

--=-XEwfSrrrHge77OiIjk6k--


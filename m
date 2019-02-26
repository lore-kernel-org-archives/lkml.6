Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CDDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5EF217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfBZOnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:43:00 -0500
Received: from shelob.surriel.com ([96.67.55.147]:42856 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfBZOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:42:59 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1gydwT-0002az-OQ; Tue, 26 Feb 2019 09:42:45 -0500
Message-ID: <63491909d5c7011b946a354000caace11d63cb84.camel@surriel.com>
Subject: Re: [PATCH 5/5] mm/vmscan: don't forcely shrink active anon lru list
From:   Rik van Riel <riel@surriel.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Date:   Tue, 26 Feb 2019 09:42:45 -0500
In-Reply-To: <ea0f769b-29e6-8787-7b18-cb7b24c1cda3@virtuozzo.com>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
         <20190222174337.26390-5-aryabinin@virtuozzo.com>
         <20190222182249.GC15440@cmpxchg.org>
         <ea0f769b-29e6-8787-7b18-cb7b24c1cda3@virtuozzo.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WS/NIoxTuxo0S9rJ9C/P"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WS/NIoxTuxo0S9rJ9C/P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-02-26 at 15:04 +0300, Andrey Ryabinin wrote:

> I think we should leave anon aging only for !SCAN_FILE cases.
> At least aging was definitely invented for the SCAN_FRACT mode which
> was the
> main mode at the time it was added by the commit:

> and I think would be reasonable to  avoid the anon aging in the
> SCAN_FILE case.
> Because if workload generates enough inactive file pages we never go
> to the SCAN_FRACT,
> so aging is just as useless as with no swap case.

There are a few different cases here.

If you NEVER end up scanning or evicting anonymous
pages, scanning them is indeed a waste of time.

However, if you occasionally end pushing something
into swap, it is very useful to know that the pages
that did get pushed to swap had been sitting on the
inactive list for a very long time, and had not been
used in that time.

To limit the amount of wasted work, only SWAP_CLUSTER_MAX
pages are moved from the active_anon list to the inactive_anon
list at a time.

I suppose that could be gated behind a check whether or
not the system has swap space configured, so no anon
pages are ever scanned if the system has no swap space.

--=20
All Rights Reversed.

--=-WS/NIoxTuxo0S9rJ9C/P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlx1UGUACgkQznnekoTE
3oOZwwgAkmPl1r/i+agIxCVMrx4XQvkeXk9zU3Cem8xsvmsAcq62iaA/hfJKEukA
N3I5NOYQp7ZqP0niwFBNt3koIerq/jahFHSdVEoF0GMdiV+p/Jykx4ntSU0IcEAq
+HRSd2JpMO9XcZyJc/ZdRTyrMPQj/6YbYvfSULbRpBceZ3tY3bGZd0/5lgJjL82c
YxqLNUiC7vS6lBZujMf+M5RE0IrhKkGewBs908aYQ1FY7HmYhqN4JzcTu6t4hDJ+
xKVdppUk6nhUTqPMv7RH8Gfg7px6XBkxGDTStuvHCQ/m35F6OxGpTRAPFa5iNFv1
+lqGz79wqx80ceDPB68CHqizXBoHpg==
=5brM
-----END PGP SIGNATURE-----

--=-WS/NIoxTuxo0S9rJ9C/P--


Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3179C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5727B20779
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5727B20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeGFREM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:04:12 -0400
Received: from shelob.surriel.com ([96.67.55.147]:50682 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeGFREL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:04:11 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fbU9E-0007QB-Iw; Fri, 06 Jul 2018 13:03:56 -0400
Message-ID: <1530896635.5350.25.camel@surriel.com>
Subject: mm,tlb: revert 4647706ebeee?
From:   Rik van Riel <riel@surriel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        kernel-team <kernel-team@fb.com>
Date:   Fri, 06 Jul 2018 13:03:55 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zb/vom+066eg5F7hihUM"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zb/vom+066eg5F7hihUM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

It looks like last summer, there were 2 sets of patches
in flight to fix the issue of simultaneous mprotect/madvise
calls unmapping PTEs, and some pages not being flushed from
the TLB before returning to userspace.

Minchan posted these patches:
56236a59556c ("mm: refactor TLB gathering API")
99baac21e458 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")

Around the same time, Mel posted:
4647706ebeee ("mm: always flush VMA ranges affected by zap_page_range")

They both appear to solve the same bug.

Only one of the two solutions is needed.

However, 4647706ebeee appears to introduce extra TLB
flushes - one per VMA, instead of one over the entire
range unmapped, and also extra flushes when there are
no simultaneous unmappers of the same mm.

For that reason, it seems like we should revert
4647706ebeee and keep only Minchan's solution in
the kernel.

Am I overlooking any reason why we should not revert
4647706ebeee?

kind regards,

Rik
--=20
All Rights Reversed.
--=-zb/vom+066eg5F7hihUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAls/oPsACgkQznnekoTE
3oOwCQf/fCp6/SmsfPwk5QdUpaiKb9p4zW3RmAuc3LZ3DPkduCTH1SPlJeW/5bDj
1n2bKWKRPF7oAbxc3gpcgLpraEteJIEB8uCibo3KB7pGlqm1ItQPg1Fme5FNZpOy
tTAcgvjiwKMkVNwQhpbjEoR0mYZ1GtuNe9waTIRSwYvMKGijVMTeQAhuty4mxY7Y
fGYrhNcw8YDfoa9iBmnG7mXVGNl7g2gDSJDfmijr9aCaAHNKwpnKo74A5Hj65gTy
nEuV64dz6WWpT9w00MTSORUVAYVfb9CHaZfTsigUc5MvcaI0Q6L+LDL2nx21Yqyb
h4nD+F21Gf2PQSQ2uZjWHdtwqVSBNw==
=/P1I
-----END PGP SIGNATURE-----

--=-zb/vom+066eg5F7hihUM--


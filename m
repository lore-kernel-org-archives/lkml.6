Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755451AbeD3Xa1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753252AbeD3Xa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:30:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DE722DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <15524dbe4fafbab833479f28b5c3f548a7fc7ad1.camel@kernel.org>
Subject: [GIT PULL] errseq_t fix for v4.17
From: Jeff Layton <jlayton@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>,
        Andres Freund <andres@anarazel.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 30 Apr 2018 19:30:17 -0400
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-nIJrzuGbLxvk7H3K5rUv"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nIJrzuGbLxvk7H3K5rUv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The following changes since commit 0644f186fc9d77bb5bd198369e59fb28927a3692=
:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ms=
t/vhost (2018-04-26 16:36:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/errs=
eq-v4.17

for you to fetch changes up to b4678df184b314a2bd47d2329feca2c2534aa12b:

  errseq: Always report a writeback error once (2018-04-27 08:51:26 -0400)

----------------------------------------------------------------
The PostgreSQL developers recently had a spirited discussion about the
writeback error handling in Linux, and reached out to us about a
behavoir change to the code that bit them when the errseq_t changes
were merged.

When we changed to using errseq_t for tracking writeback errors, we
lost the ability for an application to see a writeback error that
occurred before the open on which the fsync was issued. This was
problematic for PostgreSQL which offloads fsync calls to a completely
separate process from the DB writers.

This patch restores that ability. If the errseq_t value in the inode
does not have the SEEN flag set, then we just return 0 for the sample.
That ensures that any recorded error is always delivered at least once.

Note that we might still lose the error if the inode gets evicted from
the cache before anything can reopen it, but that was the case before
errseq_t was merged. At LSF/MM we had some discussion about keeping
inodes with unreported writeback errors around in the cache for longer
(possibly indefinitely), but that's really a separate problem.
----------------------------------------------------------------
Matthew Wilcox (1):
      errseq: Always report a writeback error once

 lib/errseq.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)
--=-nIJrzuGbLxvk7H3K5rUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEES8DXskRxsqGE6vXTAA5oQRlWghUFAlrnpwkACgkQAA5oQRlW
ghXcrw//RUubLSUYc9nocuy/CKedg2UWocI5TqGX69MG8ze/t+bzLAVmHPXx1koo
vYdzMPmJ2YE37SPk74E1bnpQ8qFzxSOU60BVANayPImppc0Iq2ykahihq50SNagY
uJydTLrmArsLVWyqDfCWjFBd5GxOZk3UjpeLtj6+YCBl2/aIEA3Lb6K5oFRSBEOH
JzqyTwAMFo/UDNTF2m0/vuvy0/G7x7FKbHnAG9HRyLZ3Iu8RJcdcgCiT3UbkNBdF
MJJCxixEHDUCmy51p7uzWlS4YfifUhYLKKfukqp1OAtxqWxPW2+k9IctS9xFL99g
3RrSYulzaTxhWdMmvIi8MIaMPI7ac+8kLOB265jEltjCXuEZFdIPP3s787qR3EhE
2AFJVYR/eQ3O8cxtnVpQoenIKg1sn2WDBECDq3ovjeP161mePTXZU9HGnsTg2bm1
J797zgGQd/N4RxANf4rNjeFDdFUkLlYn53sZ3qgxlol/B2tK2QA+nhpPM1e93Ws+
8UpE5+J99gDt/RenL51rs6yPtRidlFKphebm7tBAilcpr8jQGLJX9eiv/km9tvZo
4AcUfjlypBlJVou+IgFHrwWhDd8ncQQlHGBi+oZfkgBb1jOV9q08TC1rDq0NawFs
UF+0x4g3adzuiB5U+FIkqGMXhXJQ1Bp4xnvtxHnGftrRNyotYn8=
=VWkh
-----END PGP SIGNATURE-----

--=-nIJrzuGbLxvk7H3K5rUv--

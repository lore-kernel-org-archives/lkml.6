Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1B8ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FB621522
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 20:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FB621522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeIWCw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 22:52:59 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47618 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbeIWCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 22:52:58 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3oyY-000402-EM; Sat, 22 Sep 2018 21:58:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3oyT-0005Iq-7M; Sat, 22 Sep 2018 21:57:57 +0100
Message-ID: <70a0edd73c78c1610df0282704687ea2c896d4fa.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 52/63] xfs: validate cached inodes are free when
 allocated
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Dave Chinner <dchinner@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Wen Xu <wen.xu@gatech.edu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Date:   Sat, 22 Sep 2018 21:57:56 +0100
In-Reply-To: <20180922052659.GC19103@rh>
References: <lsq.1537575341.194909669@decadent.org.uk>
         <lsq.1537575342.534061407@decadent.org.uk> <20180922052659.GC19103@rh>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-jeGOF+P3q9mubOyUck56"
User-Agent: Evolution 3.29.92-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jeGOF+P3q9mubOyUck56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2018-09-22 at 15:26 +1000, Dave Chinner wrote:
> On Sat, Sep 22, 2018 at 01:15:42AM +0100, Ben Hutchings wrote:
> > 3.16.58-rc1 review patch.  If anyone has any objections, please let me =
know.
> >=20
> > ------------------
> >=20
> > From: Dave Chinner <dchinner@redhat.com>
> >=20
> > commit afca6c5b2595fc44383919fba740c194b0b76aff upstream.
> >=20
> > A recent fuzzed filesystem image cached random dcache corruption
> > when the reproducer was run. This often showed up as panics in
> > lookup_slow() on a null inode->i_ops pointer when doing pathwalks.
>=20
> .....
> > [bwh: Backported to 3.16:
> >  - Look up mode in XFS inode, not VFS inode
> >  - Use positive error codes, and EIO instead of EFSCORRUPTED]
>=20
> Again, why EIO?

I'll change this back to EFSCORRUPTED.

Ben.

> And ....
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> >  fs/xfs/xfs_icache.c | 73 +++++++++++++++++++++++++++++----------------
> >  1 file changed, 48 insertions(+), 25 deletions(-)
> >=20
> > --- a/fs/xfs/xfs_icache.c
> > +++ b/fs/xfs/xfs_icache.c
> > @@ -133,6 +133,46 @@ xfs_inode_free(
> >  }
> > =20
> >  /*
> > + * If we are allocating a new inode, then check what was returned is
> > + * actually a free, empty inode. If we are not allocating an inode,
> > + * then check we didn't find a free inode.
> > + *
> > + * Returns:
> > + *	0		if the inode free state matches the lookup context
> > + *	ENOENT		if the inode is free and we are not allocating
> > + *	EFSCORRUPTED	if there is any state mismatch at all
>=20
> You changed the code but not the comment.
>=20
> Cheers,
>=20
> Dave.
--=20
Ben Hutchings
Any sufficiently advanced bug is indistinguishable from a feature.



--=-jeGOF+P3q9mubOyUck56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlumrNQACgkQ57/I7JWG
EQk5whAA0seMSZbrpZZ255yHcqFKxMBSkJ8S/UypCYV58ebI4HYmQNiyUVkRL6Mo
rqCvxVA+BfeLOtEZKj9no8Tam73R7/byuQfoEbjcXWth6pZK6WRAq06+mfgzAJg8
+xFnRLTojvECG/68PNEkMX3lt2OmqevClUQZpXV/jWAhLCAehN3b7wK5xrulcWxi
VTHvm/7jPpvgenme7TeX2Ye0pKMDyyAKaJaoX2Och89IVcA948DDpPfvhrlZp1KV
xJvXGs7ne62ti68pCyWPGPCqdkowf3WP8D64mQUoxS+ucZSbEPPcDu/iHrERlynj
syq/3ORmPzxNW92ywaxaa7WhzieUAeBdp1VOT8fAhXmDgF/XIrYZtvko7bi4S3D3
u/t93NJ75CyHTocL0frEChNXgv2itoEpG61tgmh5WneapsbWbBci6unNksrYnbOe
20FsZ7ZZDuYl6tb3HBSSXzT5pzSwCYQm065pAJq5RUxTVY79Zva6RbRWTMfeCdo0
ThJBTMEmqs1CdwlTM2HaZPpiPSq5J+PJ7YVCUmwFilnEqTjN+MHGhMkIptBuzExO
xW+5CwGEawY+IpXiy/WEil7OFvRVrB6PSSNyH5J6hG5rL9q6jfvJtJg3fF6QHyQ5
kmMqevguDVdVpJdxYVx1UUFUII8DQWGCdt/za561S/ce85godnU=
=rDZm
-----END PGP SIGNATURE-----

--=-jeGOF+P3q9mubOyUck56--

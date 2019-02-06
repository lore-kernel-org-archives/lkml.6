Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F63CC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF282186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfBFScV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:32:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfBFScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:32:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF9EFC070142;
        Wed,  6 Feb 2019 18:32:18 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B25B600CC;
        Wed,  6 Feb 2019 18:32:16 +0000 (UTC)
Message-ID: <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
From:   Doug Ledford <dledford@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jan Kara <jack@suse.cz>, Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Wed, 06 Feb 2019 13:32:04 -0500
In-Reply-To: <20190206175233.GN21860@bombadil.infradead.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
         <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
         <20190206175233.GN21860@bombadil.infradead.org>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DH9hcUhnriJe4f5iVPKX"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 06 Feb 2019 18:32:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DH9hcUhnriJe4f5iVPKX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-02-06 at 09:52 -0800, Matthew Wilcox wrote:
> On Wed, Feb 06, 2019 at 10:31:14AM -0700, Jason Gunthorpe wrote:
> > On Wed, Feb 06, 2019 at 10:50:00AM +0100, Jan Kara wrote:
> >=20
> > > MM/FS asks for lease to be revoked. The revoke handler agrees with th=
e
> > > other side on cancelling RDMA or whatever and drops the page pins.=
=20
> >=20
> > This takes a trip through userspace since the communication protocol
> > is entirely managed in userspace.
> >=20
> > Most existing communication protocols don't have a 'cancel operation'.
> >=20
> > > Now I understand there can be HW / communication failures etc. in
> > > which case the driver could either block waiting or make sure future
> > > IO will fail and drop the pins.=20
> >=20
> > We can always rip things away from the userspace.. However..
> >=20
> > > But under normal conditions there should be a way to revoke the
> > > access. And if the HW/driver cannot support this, then don't let it
> > > anywhere near DAX filesystem.
> >=20
> > I think the general observation is that people who want to do DAX &
> > RDMA want it to actually work, without data corruption, random process
> > kills or random communication failures.
> >=20
> > Really, few users would actually want to run in a system where revoke
> > can be triggered.
> >=20
> > So.. how can the FS/MM side provide a guarantee to the user that
> > revoke won't happen under a certain system design?
>=20
> Most of the cases we want revoke for are things like truncate().
> Shouldn't happen with a sane system, but we're trying to avoid users
> doing awful things like being able to DMA to pages that are now part of
> a different file.

Why is the solution revoke then?  Is there something besides truncate
that we have to worry about?  I ask because EBUSY is not currently
listed as a return value of truncate, so extending the API to include
EBUSY to mean "this file has pinned pages that can not be freed" is not
(or should not be) totally out of the question.

Admittedly, I'm coming in late to this conversation, but did I miss the
portion where that alternative was ruled out?

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-DH9hcUhnriJe4f5iVPKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlxbKCQACgkQuCajMw5X
L920cRAAnglIz8v9Y3ddVGc1YP+7FZvhUcoRrnr3eDu92uCGxJ+IzXOIR+qrE1Ja
BFWj8XxJ0AyxugPnT4qCovPLf3qQtMD3mWQAnBqlvZDsGCla+9vLgTh39uUOgLjB
tCD3jXB0XSe3+mLiSGEze+I4fx+qbnRWJaQRJlkycdl86aMHIFs930fGmaGCChoY
JobkYZZh+5kVqpx4L632T9eSq4WxkpXnkSnxqgXx2kZxO2m3S1wd5SI8dMxxlwI8
rYGHTQAOSWlK4Z+GUuZhlimosmhvCWcFworCvR0PhtS47uyDp0S8DnrSdb4+hMOP
yYKbx9LkNxRqvgfMzhzAS6l4mrq8Sd7K3iHzCtSWqBOyxk7l5N7kWnEWI8GPMgtp
hDEjR3SRiltVyURQAe1HVIB3r5IAlqTFgw7cRYi7Z39xh5CG1JXiU5jcopoX0p0c
qTFt/tMwmg6qBLgKC3i7swQtZIzPfVrvNgLvVGUoikzGmXLikviZhPvB709diIXC
la90MeW0jxlXumEWYjSVoyxRrlsSWor+zMKhBvCKbK17TIB3H+OlMalElaXjHF7j
SG4pNjFXQSBoFkpWJjK5jhtKXJeikHBp0nLS6bFxkKnDoT7SKucLdt3eITV7JAY3
sozUj0Reu4fWLF/Y1aVIxRp+kgrlUnlBbO73inPHRpnpDgeNzPc=
=GR/4
-----END PGP SIGNATURE-----

--=-DH9hcUhnriJe4f5iVPKX--


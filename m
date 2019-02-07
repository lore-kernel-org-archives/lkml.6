Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB71DC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BD32190C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfBGPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:37:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBGPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:37:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E86AF87648;
        Thu,  7 Feb 2019 15:37:13 +0000 (UTC)
Received: from haswell-e.nc.xsintricity.com (ovpn-112-17.rdu2.redhat.com [10.10.112.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BACD762985;
        Thu,  7 Feb 2019 15:37:08 +0000 (UTC)
Message-ID: <f000f699219a8f636dccfbe1fde3e17acdc674a4.camel@redhat.com>
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
From:   Doug Ledford <dledford@redhat.com>
To:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Thu, 07 Feb 2019 10:37:06 -0500
In-Reply-To: <6b260348-966a-bc95-162b-44ae8265cf03@talpey.com>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
         <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
         <20190206175233.GN21860@bombadil.infradead.org>
         <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
         <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
         <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
         <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
         <20190207035258.GD6173@dastard> <20190207052310.GA22726@ziepe.ca>
         <CC414509-F046-49E3-9D0C-F66FD488AC64@oracle.com>
         <6b260348-966a-bc95-162b-44ae8265cf03@talpey.com>
Organization: Red Hat, Inc.
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-XOocD0Ij7qGOcZ0BPp21"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 07 Feb 2019 15:37:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XOocD0Ij7qGOcZ0BPp21
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-02-07 at 10:28 -0500, Tom Talpey wrote:
> On 2/7/2019 10:04 AM, Chuck Lever wrote:
> >=20
> > > On Feb 7, 2019, at 12:23 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >=20
> > > On Thu, Feb 07, 2019 at 02:52:58PM +1100, Dave Chinner wrote:
> > >=20
> > > > Requiring ODP capable hardware and applications that control RDMA
> > > > access to use file leases and be able to cancel/recall client side
> > > > delegations (like NFS is already able to do!) seems like a pretty
> > >=20
> > > So, what happens on NFS if the revoke takes too long?
> >=20
> > NFS distinguishes between "recall" and "revoke". Dave used "recall"
> > here, it means that the server recalls the client's delegation. If
> > the client doesn't respond, the server revokes the delegation
> > unilaterally and other users are allowed to proceed.
>=20
> The SMB3 protocol has a similar "lease break" mechanism, btw.
>=20
> SMB3 "push mode" has long-expected to allow DAX mapping of files
> only when an exclusive lease is held by the requesting client.
> The server may recall the lease if the DAX mapping needs to change.
>=20
> Once local (MMU) and remote (RDMA) mappings are dropped, the
> client may re-request that the server reestablish them. No
> connection or process is terminated, and no data is silently lost.

Yeah, but you're referring to a situation where the communication agent
and the filesystem agent are one and the same and they work
cooperatively to resolve the issue.  With DAX under Linux, the
filesystem agent and the communication agent are separate, and right
now, to my knowledge, the filesystem agent doesn't tell the
communication agent about a broken lease, it want's to be able to do
things 100% transparently without any work on the communication agent's
part.  That works for ODP, but not for anything else.  If the filesystem
notified the communication agent of the need to drop the MMU region and
rebuild it, the communication agent could communicate that to the remote
host, and things would work.  But there's no POSIX message for "your
file is moving on media, redo your mmap".

--=20
Doug Ledford <dledford@redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD

--=-XOocD0Ij7qGOcZ0BPp21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEErmsb2hIrI7QmWxJ0uCajMw5XL90FAlxcUKIACgkQuCajMw5X
L93NEg//eMt75ctTlSXXoDLfaCwYwi4aGY2XckUguecMYpDn5pZp8VJ36sAwQm+U
MismCekqTGqKzBnxvy465XuQKqCq+D6u1oVZX/Hbc+SAxsobzc3fCFu0hxjt3sOq
zrlOq/4rpT+ScSPvmfPRxpKUDjKXXkfVbGo/Qc4UYzuTzw2g6+UwWiKP32IavHCs
Kckw408KjH/Fh5S+oXLbt/q/p59Z7RXvLhVTbSx3L6CePi88G+YyZKr39tFLTbQq
OT7H/I4VD7sZ3fP7dXrEBVr2E7a81Tfmppg/Q/geNzfthsDTFn1JNuPYTgxIBSQR
luScrVT05YS3hN2MspTsYWQ3h9PbH9XycdNCAppzl/tPct8IwrKdJShDVpIsucLN
xbYQcdyf3UFjHmtBNvy1DfG8IDfAbyvOyU0WACjMenIi2Hzf5C2qkl5gCkYz1C7b
QHUYZTwW++zfTNB2azaxi8JC9kcKn4OckvAYi3psHwD24j3jXF1EC54TS+VKE5mS
AbbJMq5oGo6ntvR4XBSuIkssZl5ARfSjFb9ws8jzyd/FrAxgskTmm6hxRXxx1ekR
OfKAHdeCqA87l4QC55jpCzxMph3dL7CQJSC/7De4WzlVteEG0RPl9PJhyhro83la
3Oe6FQLTlv6b0FtKTT3iu6TXAGq9l3kKLyr028iv8Z7ftGC9XRk=
=VBGR
-----END PGP SIGNATURE-----

--=-XOocD0Ij7qGOcZ0BPp21--


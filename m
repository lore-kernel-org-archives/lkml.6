Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89CC82086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CC82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeLMLzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:55:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbeLMLzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:55:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD878DA34;
        Thu, 13 Dec 2018 11:55:16 +0000 (UTC)
Received: from localhost (ovpn-117-126.ams2.redhat.com [10.36.117.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FAA46062B;
        Thu, 13 Dec 2018 11:55:15 +0000 (UTC)
Date:   Thu, 13 Dec 2018 11:55:14 +0000
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        miklos@szeredi.hu, dgilbert@redhat.com, sweil@redhat.com,
        swhiteho@redhat.com, Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 15/52] fuse: map virtio_fs DAX window BAR
Message-ID: <20181213115514.GG23318@stefanha-x1.localdomain>
References: <20181210171318.16998-1-vgoyal@redhat.com>
 <20181210171318.16998-16-vgoyal@redhat.com>
 <0d127f4f-5ea6-0453-037a-6417cc8471ab@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yQbNiKLmgenwUfTN"
Content-Disposition: inline
In-Reply-To: <0d127f4f-5ea6-0453-037a-6417cc8471ab@de.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Dec 2018 11:55:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yQbNiKLmgenwUfTN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 05:37:35PM +0100, Christian Borntraeger wrote:
>=20
>=20
> On 10.12.2018 18:12, Vivek Goyal wrote:
> > From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> > +static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virt=
io_fs *fs)
> > +{
> > +	struct virtio_fs_memremap_info *mi;
> > +	struct dev_pagemap *pgmap;
> > +	struct pci_dev *pci_dev;
> > +	phys_addr_t phys_addr;
> > +	size_t len;
> > +	int ret;
> > +
> > +	if (!IS_ENABLED(CONFIG_DAX_DRIVER))
> > +		return 0;
> > +
> > +	/* HACK implement VIRTIO shared memory regions instead of
> > +	 * directly accessing the PCI BAR from a virtio device driver.
> > +	 */
> > +	pci_dev =3D container_of(vdev->dev.parent, struct pci_dev, dev);
> > +
> > +	/* TODO Is this safe - the virtio_pci_* driver doesn't use managed
> > +	 * device APIs? */
> > +	ret =3D pcim_enable_device(pci_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* TODO handle case where device doesn't expose BAR? */
> > +	ret =3D pci_request_region(pci_dev, VIRTIO_FS_WINDOW_BAR,
> > +				 "virtio-fs-window");
> > +	if (ret < 0) {
> > +		dev_err(&vdev->dev, "%s: failed to request window BAR\n",
> > +			__func__);
> > +		return ret;
> > +	}
>=20
> Can we please have a generic virtio interface to map the address (the def=
ault can then
> fall back to PCI) instead of mapping a PCI bar? This would make it easier=
 to implement
> virtio-ccw or virtio-mmio.

Yes, we'll define shared memory as a device resource in the VIRTIO
specification.  It will become part of the device model, alongside
virtqueues, configuration space, etc.  That means devices can use shared
memory without it being tied to PCI BARs explicitly.

But only the PCI transport will have a realization of shared memory
resources in the beginning.  We need to work together to add this
feature to the ccw and mmio transports.

Stefan

--yQbNiKLmgenwUfTN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEkiiAAoJEJykq7OBq3PI12MH/0ZlAXOIhmHJGcrdD8E3hgqk
OBnlZ2Qz/x0yyODah3ttDNVXgGsdPuA7Ya920I4xPYkSaPYDz6Y7I1GkaGHsOqW7
Zm7xV2jvAGDLue1vS79Z1idcqxLqa0jRB+RJtXg28M+Q2+8YQmG+X/qNcb5WfFb6
Lqslr3kp9ceCsRTz9vDIeP8spBvIuK0ZqklQs/2FUuoy5gUVCoYeQchHxCkm43AE
j3h5REzmDiWJR9jTTqc+ng8CRkuwLj02OmL2QmsRuh4LQd2LNNKyK5uCQ1Lefzl5
WYjI3ltVzj/Be4U1yNGq5UP4ZtYQm8xFNv+tkdJcYF2xbdj85wIcL31gD/5maQo=
=jY1L
-----END PGP SIGNATURE-----

--yQbNiKLmgenwUfTN--

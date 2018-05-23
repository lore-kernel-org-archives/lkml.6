Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeEWFDv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:03:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:26640 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbeEWFDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:03:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="asc'?scan'208";a="43486688"
Date: Wed, 23 May 2018 12:53:28 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, kwankhede@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 1/2] vfio/mdev: Check globally for duplicate devices
Message-ID: <20180523045328.ooyr2dxrd7hqxj6e@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180518190145.3187.7620.stgit@gimli.home>
 <20180518191025.3187.29141.stgit@gimli.home>
 <20180522101346.3442e1af.cohuck@redhat.com>
 <20180522095337.1a3043e6@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v75jf7jojcv2uvll"
Content-Disposition: inline
In-Reply-To: <20180522095337.1a3043e6@w520.home>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v75jf7jojcv2uvll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.05.22 09:53:37 -0600, Alex Williamson wrote:
> [Cc +GVT-g maintainers/lists]
>=20
> On Tue, 22 May 2018 10:13:46 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Fri, 18 May 2018 13:10:25 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >=20
> > > When we create an mdev device, we check for duplicates against the
> > > parent device and return -EEXIST if found, but the mdev device
> > > namespace is global since we'll link all devices from the bus.  We do
> > > catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
> > > with it comes a kernel warning and stack trace for trying to create
> > > duplicate sysfs links, which makes it an undesirable response.
> > >=20
> > > Therefore we should really be looking for duplicates across all mdev
> > > parent devices, or as implemented here, against our mdev device list.
> > > Using mdev_list to prevent duplicates means that we can remove
> > > mdev_parent.lock, but in order not to serialize mdev device creation
> > > and removal globally, we add mdev_device.active which allows UUIDs to
> > > be reserved such that we can drop the mdev_list_lock before the mdev
> > > device is fully in place.
> > >=20
> > > Two behavioral notes; first, mdev_parent.lock had the side-effect of
> > > serializing mdev create and remove ops per parent device.  This was
> > > an implementation detail, not an intentional guarantee provided to
> > > the mdev vendor drivers.  Vendor drivers can trivially provide this
> > > serialization internally if necessary.  Second, review comments note
> > > the new -EAGAIN behavior when the device, and in particular the remove
> > > attribute, becomes visible in sysfs.  If a remove is triggered prior
> > > to completion of mdev_device_create() the user will see a -EAGAIN
> > > error.  While the errno is different, receiving an error during this
> > > period is not, the previous implementation returned -ENODEV for the
> > > same condition.  Furthermore, the consistency to the user is improved
> > > in the case where mdev_device_remove_ops() returns error.  Previously
> > > concurrent calls to mdev_device_remove() could see the device
> > > disappear with -ENODEV and return in the case of error.  Now a user
> > > would see -EAGAIN while the device is in this transitory state.
> > >=20
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > ---
> > >  Documentation/vfio-mediated-device.txt |    5 ++
> > >  drivers/vfio/mdev/mdev_core.c          |  102 +++++++++++-----------=
----------
> > >  drivers/vfio/mdev/mdev_private.h       |    2 -
> > >  3 files changed, 42 insertions(+), 67 deletions(-) =20
> >=20
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> >=20
> > I think it is better to deal with any possible vendor driver
> > implications on top of this (I still believe that vfio-ccw is fine).
>=20
> Thanks Cornelia.  So if vfio-ccw is fine, presumably NVIDIA is fine,
> then this leaves GVT-g to see if there's any fallout.  Zhenyu & Zhi,
> I've linked the series under discussion here below[1].  The question to
> you is the first of the two behavioral notes listed above, does GVT-g
> have any dependency on the mdev core providing serialization per mdev
> parent device for the create and remove callbacks within the
> mdev_parent_ops?  This was never an intended feature of the
> implementation and as noted it should be trivial for for an mdev vendor
> driver to provide equivalent course grained serialization if
> necessary.  Of course it would be better to implement that sooner
> rather than later if required.
>=20
> I see that __intel_gvt_create_vgpu() makes use of gvt->lock, which
> would seem to already provide this level of per-parent locking. The
> remove path makes use of this same lock, so I think we're ok, but
> looking for an explicit ack so there are no surprises.  I'd like
> to queue this series for v4.18.  Thanks,
>=20

yeah, we don't expect mdev core for parent serialization for create and
remove of mdev device. Series look good to me.

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>


> Alex
>=20
> [1] https://lkml.org/lkml/2018/5/18/1035

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--v75jf7jojcv2uvll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCWwTzxwAKCRCxBBozTXgY
J3A/AJ48VYdCbUDjdMKSQRre97gNgOU5XgCcD1tsH5cVlDwzwoQvmz+sM3Ntfz8=
=a0aX
-----END PGP SIGNATURE-----

--v75jf7jojcv2uvll--

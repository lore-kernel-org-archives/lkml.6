Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752121AbeEVPxp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:53:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54375 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeEVPxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:53:39 -0400
Date: Tue, 22 May 2018 09:53:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhenyuw@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v4 1/2] vfio/mdev: Check globally for duplicate devices
Message-ID: <20180522095337.1a3043e6@w520.home>
In-Reply-To: <20180522101346.3442e1af.cohuck@redhat.com>
References: <20180518190145.3187.7620.stgit@gimli.home>
        <20180518191025.3187.29141.stgit@gimli.home>
        <20180522101346.3442e1af.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc +GVT-g maintainers/lists]

On Tue, 22 May 2018 10:13:46 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 18 May 2018 13:10:25 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > When we create an mdev device, we check for duplicates against the
> > parent device and return -EEXIST if found, but the mdev device
> > namespace is global since we'll link all devices from the bus.  We do
> > catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
> > with it comes a kernel warning and stack trace for trying to create
> > duplicate sysfs links, which makes it an undesirable response.
> > 
> > Therefore we should really be looking for duplicates across all mdev
> > parent devices, or as implemented here, against our mdev device list.
> > Using mdev_list to prevent duplicates means that we can remove
> > mdev_parent.lock, but in order not to serialize mdev device creation
> > and removal globally, we add mdev_device.active which allows UUIDs to
> > be reserved such that we can drop the mdev_list_lock before the mdev
> > device is fully in place.
> > 
> > Two behavioral notes; first, mdev_parent.lock had the side-effect of
> > serializing mdev create and remove ops per parent device.  This was
> > an implementation detail, not an intentional guarantee provided to
> > the mdev vendor drivers.  Vendor drivers can trivially provide this
> > serialization internally if necessary.  Second, review comments note
> > the new -EAGAIN behavior when the device, and in particular the remove
> > attribute, becomes visible in sysfs.  If a remove is triggered prior
> > to completion of mdev_device_create() the user will see a -EAGAIN
> > error.  While the errno is different, receiving an error during this
> > period is not, the previous implementation returned -ENODEV for the
> > same condition.  Furthermore, the consistency to the user is improved
> > in the case where mdev_device_remove_ops() returns error.  Previously
> > concurrent calls to mdev_device_remove() could see the device
> > disappear with -ENODEV and return in the case of error.  Now a user
> > would see -EAGAIN while the device is in this transitory state.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  Documentation/vfio-mediated-device.txt |    5 ++
> >  drivers/vfio/mdev/mdev_core.c          |  102 +++++++++++---------------------
> >  drivers/vfio/mdev/mdev_private.h       |    2 -
> >  3 files changed, 42 insertions(+), 67 deletions(-)  
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
> I think it is better to deal with any possible vendor driver
> implications on top of this (I still believe that vfio-ccw is fine).

Thanks Cornelia.  So if vfio-ccw is fine, presumably NVIDIA is fine,
then this leaves GVT-g to see if there's any fallout.  Zhenyu & Zhi,
I've linked the series under discussion here below[1].  The question to
you is the first of the two behavioral notes listed above, does GVT-g
have any dependency on the mdev core providing serialization per mdev
parent device for the create and remove callbacks within the
mdev_parent_ops?  This was never an intended feature of the
implementation and as noted it should be trivial for for an mdev vendor
driver to provide equivalent course grained serialization if
necessary.  Of course it would be better to implement that sooner
rather than later if required.

I see that __intel_gvt_create_vgpu() makes use of gvt->lock, which
would seem to already provide this level of per-parent locking. The
remove path makes use of this same lock, so I think we're ok, but
looking for an explicit ack so there are no surprises.  I'd like
to queue this series for v4.18.  Thanks,

Alex

[1] https://lkml.org/lkml/2018/5/18/1035

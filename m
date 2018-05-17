Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeEQDaj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 23:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbeEQDah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 23:30:37 -0400
Date: Wed, 16 May 2018 21:30:36 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cohuck@redhat.com>
Subject: Re: [PATCH v2] vfio/mdev: Check globally for duplicate devices
Message-ID: <20180516213036.1847082d@w520.home>
In-Reply-To: <2c45cf24-f67d-bae6-59bf-aedb434ee843@nvidia.com>
References: <20180516152228.12123.34883.stgit@gimli.home>
        <2c45cf24-f67d-bae6-59bf-aedb434ee843@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 01:01:40 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/16/2018 8:53 PM, Alex Williamson wrote:
> > When we create an mdev device, we check for duplicates against the
> > parent device and return -EEXIST if found, but the mdev device
> > namespace is global since we'll link all devices from the bus.  We do
> > catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
> > with it comes a kernel warning and stack trace for trying to create
> > duplicate sysfs links, which makes it an undesirable response.
> > 
> > Therefore we should really be looking for duplicates across all mdev
> > parent devices, or as implemented here, against our mdev device list.
> > 
> > Notably, mdev_parent.lock really only seems to be serializing device
> > creation and removal per parent.  I'm not sure if this is necessary,
> > mdev vendor drivers could easily provide this serialization if it
> > is required, but a side-effect of holding the mdev_list_lock to
> > protect the namespace is actually greater serialization across the
> > create and remove paths,  
> 
> Exactly for this reason more granular lock is used and that's the reason
> mdev_parent.lock was introduced. Consider the max supported config for
> vGPU: 8 GPUs in a system with 16 mdev devices on each GPUs, i.e. 128
> mdev devices need to be created in a system, and this count will
> increase in future, all mdev device creation/removal will get serialized
> with this change.
> I agree with your concern that if there are duplicates across parents,
> its not caught earlier.

Right, thus the concern, but how often are trying to simultaneously
create or remove all those mdev devices.  Anyway...
 
> > so mdev_parent.lock is removed.  If we can
> > show that vendor drivers handle the create/remove paths themselves,
> > perhaps we can refine the locking granularity.
> >   
> 
> Here lock is not for create/remove routines of vendor driver, its about
> mdev device creation and device registration, which is a common code
> path, and so is part of mdev core module.

Ok, if mdev_parent.lock was only to protect the per parent device
namespace and not meant as a serialization guarantee to the vendor
drivers, then we can fix the bug and improve the parallelism.

> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > v2: Remove unnecessary ret init per Cornelia's review
> > 
> >  drivers/vfio/mdev/mdev_core.c    |   77 +++++++++-----------------------------
> >  drivers/vfio/mdev/mdev_private.h |    1 
> >  2 files changed, 19 insertions(+), 59 deletions(-)
> > 
> > diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> > index 126991046eb7..aaab3ef93e1c 100644
> > --- a/drivers/vfio/mdev/mdev_core.c
> > +++ b/drivers/vfio/mdev/mdev_core.c
> > @@ -66,34 +66,6 @@ uuid_le mdev_uuid(struct mdev_device *mdev)
> >  }
> >  EXPORT_SYMBOL(mdev_uuid);
> >  
> > -static int _find_mdev_device(struct device *dev, void *data)
> > -{
> > -	struct mdev_device *mdev;
> > -
> > -	if (!dev_is_mdev(dev))
> > -		return 0;
> > -
> > -	mdev = to_mdev_device(dev);
> > -
> > -	if (uuid_le_cmp(mdev->uuid, *(uuid_le *)data) == 0)
> > -		return 1;
> > -
> > -	return 0;
> > -}
> > -
> > -static bool mdev_device_exist(struct mdev_parent *parent, uuid_le uuid)
> > -{
> > -	struct device *dev;
> > -
> > -	dev = device_find_child(parent->dev, &uuid, _find_mdev_device);
> > -	if (dev) {
> > -		put_device(dev);
> > -		return true;
> > -	}
> > -
> > -	return false;
> > -}
> > -
> >  /* Should be called holding parent_list_lock */
> >  static struct mdev_parent *__find_parent_device(struct device *dev)
> >  {
> > @@ -221,7 +193,6 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
> >  	}
> >  
> >  	kref_init(&parent->ref);
> > -	mutex_init(&parent->lock);
> >  
> >  	parent->dev = dev;
> >  	parent->ops = ops;
> > @@ -304,7 +275,7 @@ static void mdev_device_release(struct device *dev)
> >  int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
> >  {
> >  	int ret;
> > -	struct mdev_device *mdev;
> > +	struct mdev_device *mdev, *tmp;
> >  	struct mdev_parent *parent;
> >  	struct mdev_type *type = to_mdev_type(kobj);
> >  
> > @@ -312,12 +283,14 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
> >  	if (!parent)
> >  		return -EINVAL;
> >  
> > -	mutex_lock(&parent->lock);
> > +	mutex_lock(&mdev_list_lock);
> >  
> >  	/* Check for duplicate */
> > -	if (mdev_device_exist(parent, uuid)) {
> > -		ret = -EEXIST;
> > -		goto create_err;
> > +	list_for_each_entry(tmp, &mdev_list, next) {
> > +		if (!uuid_le_cmp(tmp->uuid, uuid)) {
> > +			ret = -EEXIST;
> > +			goto create_err;
> > +		}
> >  	}
> >  
> Is it possible to use mdev_list_lock for as minimal portion as possible?
> By adding mdev device to mdev_list just after:
> 	memcpy(&mdev->uuid, &uuid, sizeof(uuid_le));
> and then unlock mdev_list_lock, but at the same time all later error
> cases need to be handled properly in this function.

We also need to differentiate a mdev device placeholder for namespace
protection for an active device such that we can't race a remove during
the creation, seems do-able.  v3...  Thanks,

Alex

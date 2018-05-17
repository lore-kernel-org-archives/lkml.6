Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeEQQUC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeEQQUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:20:01 -0400
Date: Thu, 17 May 2018 10:20:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v3] vfio/mdev: Check globally for duplicate devices
Message-ID: <20180517102000.50656267@w520.home>
In-Reply-To: <50191254-4437-8ff3-06db-8d6b2df20b65@nvidia.com>
References: <20180517031746.32242.17768.stgit@gimli.home>
        <20180517100928.5949b11e.cohuck@redhat.com>
        <50191254-4437-8ff3-06db-8d6b2df20b65@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 21:25:22 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:

> On 5/17/2018 1:39 PM, Cornelia Huck wrote:
> > On Wed, 16 May 2018 21:30:19 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> >> When we create an mdev device, we check for duplicates against the
> >> parent device and return -EEXIST if found, but the mdev device
> >> namespace is global since we'll link all devices from the bus.  We do
> >> catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
> >> with it comes a kernel warning and stack trace for trying to create
> >> duplicate sysfs links, which makes it an undesirable response.
> >>
> >> Therefore we should really be looking for duplicates across all mdev
> >> parent devices, or as implemented here, against our mdev device list.
> >> Using mdev_list to prevent duplicates means that we can remove
> >> mdev_parent.lock, but in order not to serialize mdev device creation
> >> and removal globally, we add mdev_device.active which allows UUIDs to
> >> be reserved such that we can drop the mdev_list_lock before the mdev
> >> device is fully in place.
> >>
> >> NB. there was never intended to be any serialization guarantee
> >> provided by the mdev core with respect to creation and removal of mdev
> >> devices, mdev_parent.lock provided this only as a side-effect of the
> >> implementation for locking the namespace per parent.  That
> >> serialization is now removed.  
> >   
> 
> mdev_parent.lock is to serialize create and remove of that mdev device,
> that handles race condition that Cornelia mentioned below.

Previously it was stated:

On Thu, 17 May 2018 01:01:40 +0530
Kirti Wankhede <kwankhede@nvidia.com> wrote:
> Here lock is not for create/remove routines of vendor driver, its about
> mdev device creation and device registration, which is a common code
> path, and so is part of mdev core module.

So the race condition was handled previously, but as a side-effect of
protecting the namespace, aiui.  I'm trying to state above that the
serialization of create/remove was never intended as a guarantee
provided to mdev vendor drivers.  I don't see that there's a need to
protect "mdev device creation and device registration" beyond conflicts
in the UUID namespace, which is done here.  Are there others?

> > This is probably fine; but I noted that documentation on the locking
> > conventions and serialization guarantees for mdev is a bit sparse, and
> > this topic also came up during the vfio-ap review.
> > 
> > We probably want to add some more concrete documentation; would the
> > kernel doc for the _ops or vfio-mediated-device.txt be a better place
> > for that?

I'll look to see where we can add a note withing that file, I suspect
that's the right place to put it.

> > [Dong Jia, Halil: Can you please take a look whether vfio-ccw is really
> > ok? I don't think we open up any new races, but I'd appreciate a second
> > or third opinion.]
> >   
> >>
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>
> >> v3: Rework locking and add a field to mdev_device so we can track
> >>     completed instances vs those added to reserve the namespace.
> >>
> >>  drivers/vfio/mdev/mdev_core.c    |   94 +++++++++++++-------------------------
> >>  drivers/vfio/mdev/mdev_private.h |    2 -
> >>  2 files changed, 34 insertions(+), 62 deletions(-)
> >>
> >> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> >> index 126991046eb7..55ea9d34ec69 100644
> >> --- a/drivers/vfio/mdev/mdev_core.c
> >> +++ b/drivers/vfio/mdev/mdev_core.c
> >> @@ -66,34 +66,6 @@ uuid_le mdev_uuid(struct mdev_device *mdev)
> >>  }
> >>  EXPORT_SYMBOL(mdev_uuid);
> >>  
> >> -static int _find_mdev_device(struct device *dev, void *data)
> >> -{
> >> -	struct mdev_device *mdev;
> >> -
> >> -	if (!dev_is_mdev(dev))
> >> -		return 0;
> >> -
> >> -	mdev = to_mdev_device(dev);
> >> -
> >> -	if (uuid_le_cmp(mdev->uuid, *(uuid_le *)data) == 0)
> >> -		return 1;
> >> -
> >> -	return 0;
> >> -}
> >> -
> >> -static bool mdev_device_exist(struct mdev_parent *parent, uuid_le uuid)
> >> -{
> >> -	struct device *dev;
> >> -
> >> -	dev = device_find_child(parent->dev, &uuid, _find_mdev_device);
> >> -	if (dev) {
> >> -		put_device(dev);
> >> -		return true;
> >> -	}
> >> -
> >> -	return false;
> >> -}
> >> -
> >>  /* Should be called holding parent_list_lock */
> >>  static struct mdev_parent *__find_parent_device(struct device *dev)
> >>  {
> >> @@ -221,7 +193,6 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
> >>  	}
> >>  
> >>  	kref_init(&parent->ref);
> >> -	mutex_init(&parent->lock);
> >>  
> >>  	parent->dev = dev;
> >>  	parent->ops = ops;
> >> @@ -304,7 +275,7 @@ static void mdev_device_release(struct device *dev)
> >>  int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
> >>  {
> >>  	int ret;
> >> -	struct mdev_device *mdev;
> >> +	struct mdev_device *mdev, *tmp;
> >>  	struct mdev_parent *parent;
> >>  	struct mdev_type *type = to_mdev_type(kobj);
> >>  
> >> @@ -312,21 +283,26 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
> >>  	if (!parent)
> >>  		return -EINVAL;
> >>  
> >> -	mutex_lock(&parent->lock);
> >> +	mutex_lock(&mdev_list_lock);
> >>  
> >>  	/* Check for duplicate */
> >> -	if (mdev_device_exist(parent, uuid)) {
> >> -		ret = -EEXIST;
> >> -		goto create_err;
> >> +	list_for_each_entry(tmp, &mdev_list, next) {
> >> +		if (!uuid_le_cmp(tmp->uuid, uuid)) {
> >> +			mutex_unlock(&mdev_list_lock);
> >> +			return -EEXIST;
> >> +		}
> >>  	}
> >>    
> 
> mdev_put_parent(parent) missing before return.
> 
> 
> >>  	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
> >>  	if (!mdev) {
> >> -		ret = -ENOMEM;
> >> -		goto create_err;
> >> +		mutex_unlock(&mdev_list_lock);
> >> +		return -ENOMEM;
> >>  	}
> >>  
> 
> mdev_put_parent(parent) missing here again.


Oops, will fix both.


> >>  	memcpy(&mdev->uuid, &uuid, sizeof(uuid_le));
> >> +	list_add(&mdev->next, &mdev_list);
> >> +	mutex_unlock(&mdev_list_lock);
> >> +
> >>  	mdev->parent = parent;
> >>  	kref_init(&mdev->ref);
> >>  
> >> @@ -352,21 +328,18 @@ int mdev_device_create(struct kobject *kobj, struct device *dev, uuid_le uuid)
> >>  	}
> >>  
> >>  	mdev->type_kobj = kobj;
> >> +	mdev->active = true;
> >>  	dev_dbg(&mdev->dev, "MDEV: created\n");
> >>  
> >> -	mutex_unlock(&parent->lock);
> >> -
> >> -	mutex_lock(&mdev_list_lock);
> >> -	list_add(&mdev->next, &mdev_list);
> >> -	mutex_unlock(&mdev_list_lock);
> >> -
> >> -	return ret;
> >> +	return 0;
> >>  
> >>  create_failed:
> >>  	device_unregister(&mdev->dev);
> >>  
> >>  create_err:
> >> -	mutex_unlock(&parent->lock);
> >> +	mutex_lock(&mdev_list_lock);
> >> +	list_del(&mdev->next);
> >> +	mutex_unlock(&mdev_list_lock);
> >>  	mdev_put_parent(parent);
> >>  	return ret;
> >>  }
> >> @@ -377,44 +350,43 @@ int mdev_device_remove(struct device *dev, bool force_remove)
> >>  	struct mdev_parent *parent;
> >>  	struct mdev_type *type;
> >>  	int ret;
> >> -	bool found = false;
> >>  
> >>  	mdev = to_mdev_device(dev);
> >>  
> >>  	mutex_lock(&mdev_list_lock);
> >>  	list_for_each_entry(tmp, &mdev_list, next) {
> >> -		if (tmp == mdev) {
> >> -			found = true;
> >> +		if (tmp == mdev)
> >>  			break;
> >> -		}
> >>  	}
> >>  
> >> -	if (found)
> >> -		list_del(&mdev->next);
> >> +	if (tmp != mdev) {
> >> +		mutex_unlock(&mdev_list_lock);
> >> +		return -ENODEV;
> >> +	}
> >>  
> >> -	mutex_unlock(&mdev_list_lock);
> >> +	if (!mdev->active) {
> >> +		mutex_unlock(&mdev_list_lock);
> >> +		return -EAGAIN;
> >> +	}  
> > 
> > I'm not sure whether this is 100% watertight. Consider:
> > 
> > - device gets registered, we have added it to the list, made it visible
> >   in sysfs and have added the remove attribute, but not yet the symlinks
> > - userspace can access the remove attribute and trigger removal
> > - we do an early exit here because not yet active
> > - ???
> > 
> > (If there's any problem, it's a very pathological case, and I don't
> > think anything really bad can happen. I just want to make sure we don't
> > miss anything.)

The presented scenario is exactly the use case that the -EAGAIN return
is intended to handle.  I can't put a mutex on the mdev_device to block
this path as the mdev creation might ultimately fail and the device
released (perhaps not possible in our code flow, but that would be a
very subtle detail to rely on).  So any sort of blocking approach would
require releasing mdev_list_lock and re-scanning in a busy loop.  Why
bother to do that when we can indicate the same to the user through
-EAGAIN.  AIUI, this is the purpose of -EAGAIN and it's up to userspace
to decide how they'd like to handle it, try again or abort.  Are there
suggestions for alternatives?  Thanks,

Alex

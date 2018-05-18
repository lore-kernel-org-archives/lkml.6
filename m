Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbeERHEV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:04:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10080 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeERHES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:04:18 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 18 May 2018 00:04:17 -0700
Subject: Re: [PATCH v3] vfio/mdev: Check globally for duplicate devices
To: Alex Williamson <alex.williamson@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        "Halil Pasic" <pasic@linux.ibm.com>
References: <20180517031746.32242.17768.stgit@gimli.home>
 <20180517100928.5949b11e.cohuck@redhat.com>
 <50191254-4437-8ff3-06db-8d6b2df20b65@nvidia.com>
 <20180517102000.50656267@w520.home>
 <3ab0fe44-9290-8c29-5e4c-2599ba0de373@nvidia.com>
 <20180517153737.74028a17@w520.home>
X-Nvconfidentiality: public
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <b07fa7ec-cdb5-ffdb-a969-db14a740d94a@nvidia.com>
Date: Fri, 18 May 2018 12:34:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180517153737.74028a17@w520.home>
X-Originating-IP: [10.24.70.199]
X-ClientProxiedBy: BGMAIL102.nvidia.com (10.25.59.11) To bgmail102.nvidia.com
 (10.25.59.11)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2018 3:07 AM, Alex Williamson wrote:
> On Fri, 18 May 2018 01:56:50 +0530
> Kirti Wankhede <kwankhede@nvidia.com> wrote:
> 
>> On 5/17/2018 9:50 PM, Alex Williamson wrote:
>>> On Thu, 17 May 2018 21:25:22 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:
>>>   
>>>> On 5/17/2018 1:39 PM, Cornelia Huck wrote:  
>>>>> On Wed, 16 May 2018 21:30:19 -0600
>>>>> Alex Williamson <alex.williamson@redhat.com> wrote:
>>>>>     
>>>>>> When we create an mdev device, we check for duplicates against the
>>>>>> parent device and return -EEXIST if found, but the mdev device
>>>>>> namespace is global since we'll link all devices from the bus.  We do
>>>>>> catch this later in sysfs_do_create_link_sd() to return -EEXIST, but
>>>>>> with it comes a kernel warning and stack trace for trying to create
>>>>>> duplicate sysfs links, which makes it an undesirable response.
>>>>>>
>>>>>> Therefore we should really be looking for duplicates across all mdev
>>>>>> parent devices, or as implemented here, against our mdev device list.
>>>>>> Using mdev_list to prevent duplicates means that we can remove
>>>>>> mdev_parent.lock, but in order not to serialize mdev device creation
>>>>>> and removal globally, we add mdev_device.active which allows UUIDs to
>>>>>> be reserved such that we can drop the mdev_list_lock before the mdev
>>>>>> device is fully in place.
>>>>>>
>>>>>> NB. there was never intended to be any serialization guarantee
>>>>>> provided by the mdev core with respect to creation and removal of mdev
>>>>>> devices, mdev_parent.lock provided this only as a side-effect of the
>>>>>> implementation for locking the namespace per parent.  That
>>>>>> serialization is now removed.    
>>>>>     
>>>>
>>>> mdev_parent.lock is to serialize create and remove of that mdev device,
>>>> that handles race condition that Cornelia mentioned below.  
>>>
>>> Previously it was stated:
>>>
>>> On Thu, 17 May 2018 01:01:40 +0530
>>> Kirti Wankhede <kwankhede@nvidia.com> wrote:  
>>>> Here lock is not for create/remove routines of vendor driver, its about
>>>> mdev device creation and device registration, which is a common code
>>>> path, and so is part of mdev core module.  
>>>
>>> So the race condition was handled previously, but as a side-effect of
>>> protecting the namespace, aiui.  I'm trying to state above that the
>>> serialization of create/remove was never intended as a guarantee
>>> provided to mdev vendor drivers.  I don't see that there's a need to
>>> protect "mdev device creation and device registration" beyond conflicts
>>> in the UUID namespace, which is done here.  Are there others?
>>>   
>>
>> Sorry not being elaborative in my earlier response to
>>
>>> If we can
>>> show that vendor drivers handle the create/remove paths themselves,
>>> perhaps we can refine the locking granularity.  
>>
>> mdev_device_create() function does :
>> - create mdev device
>> - register device
>> - call vendor driver->create
>> - create sysfs files.
>>
>> mdev_device_remove() removes sysfs files, unregister device and delete
>> device.
>>
>> There is common code in mdev_device_create() and mdev_device_remove()
>> independent of what vendor driver does in its create()/remove()
>> callback. Moving this code to each vendor driver to handle create/remove
>> themselves doesn't make sense to me.
> 
> I don't see where anyone is suggesting that, I'm not.
>  
>> mdev_parent.lock here does take care of race conditions that could occur
>> during mdev device creation and deletion in this common code path.
> 
> Exactly what races in the common code path is mdev_parent.lock
> preventing?  mdev_device_create() calls:
> 
> device_register()
> mdev_device_create_ops()
>   parent->ops->create()
>   sysfs_create_groups()
> mdev_create_sysfs_files()
>   sysfs_create_files()
>   sysfs_create_link()
>   sysfs_create_link()
> 
> mdev_parent.lock is certainly not serializing all calls across the
> entire kernel to device_register and sysfs_create_{groups,files,link}
> so what is it protecting other than serializing parent->ops->create()?
> Locks protect data, not code.  The data we're protecting is the shared
> mdev_list, there is no shared data once mdev_device_create() has its
> mdev_device with uuid reservation placed into that list.
> 

This lock prevents race condition that could occur due to sysfs entries
1. between write on 'create' and 'remove' sysfs file of mdev device
  As per current code without lock, mdev_create_sysfs_files() creates
'remove' sysfs, but before adding this mdev device to mdev_list, if
'remove' is called, that would return -ENODEV even if the device is seen
in sysfs

2. between write on 'remove' and 'create' sysfs file
  If 'remove' of a device is in progress (device is removed from
mdev_list but sysfs entries are not yet removed) and again 'create' of
same device with same parent is called, will hit duplicate entries error
for sysfs.

3. between multiple writes on 'create' with same uuid
 current code doesn't handle the case you are fixing here, if same uuid
is used to create mdev device on different parents.

Your change handles #1 and #3, but still there is a small gap for #2.
Even its a very small gap, but if such conditions are it in production
environment, it becomes difficult to debug.

>> What is the urge to remove mdev_parent.lock if that handles all race
>> conditions without bothering user to handle -EAGAIN?
> 
> Can you say why -EAGAIN is undesirable?  Note that the user is only
> going to see this error if they attempt to remove the device in the
> minuscule gap between the sysfs remove file being created and the
> completion of the write to the create sysfs file.  It seems like you're
> asking that I decrease the locking granularity, but not too much
> because mdev_parent.lock protects "things".  If the -EAGAIN is really
> so terrible, we can avoid it by spinning until the mdev_device is
> either not found in the list or becomes active, we don't need
> mdev_parent.lock to solve that, but I don't think that's the best
> solution and there's no concrete statement to back -EAGAIN being a
> problem. 

Does libvirt handles -EAGAIN error case? I don't know, may be someone
from libvirt can comment.

Thanks,
Kirti

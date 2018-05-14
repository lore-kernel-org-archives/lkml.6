Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZp2OsLdabP4r5JMeOXc9K9Og0OcfaCz3QiuHmx7OEOMqhlNHTAjexz2sLG2ut3MIqQDd/YL
ARC-Seal: i=1; a=rsa-sha256; t=1526331184; cv=none;
        d=google.com; s=arc-20160816;
        b=DUPj4tdl3j3Ea1x7hy1GSa63bKc8I6BhESeNBK3YcffO8NG79P9mAOsinLIkLIEYc/
         8k/FWT5YDG6MKkLadQDJM1Oq4FFOkho6knvdAgf1FsvFtH+ZXuskm9qkBwqxSwZuvFn5
         +O17pA1Kae7W0s2/hIYsMp76ocwPWt959Kd/sCFXXlnLY9UuNF9lUcD0XBKQ17txtSui
         mTzzGxmZM3pjMkRxz6g30QKYq0ndiC9C9y3T7UpeT0C1XFg+L6PFv10fdCgh9BVOFvLh
         LBU9d3UjZ3t5beWbef3LAvaQW7Vo+9TjuABp4PLxO619B6fMqCAQfifLL5svnqKwaq5q
         Tlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=huAIyzi8Q6NdUZCs7rtY43MNqjJSqyM/2jhQgL0yWSU=;
        b=nOhICA/5/9Bm2IH5bl1+0yB98QeTTjEEFGpKMdQIouwQl/AMjH8eGKAAfguWfUwk7L
         68ZiYmcp0UlJHuXFzCqKccXGn9utpx9/s5ykRUc60IUCCfZDootbVXnWZdHTh8xQ7Jkm
         uM105fjUuVjsFQX5A74k/lyQKjC5bkIY/6aQ0bYLiuMXkr07alvJFrpGGB/f2jndCqvA
         R9lRWonnhy9xA2AWbptWnpeDuqK0dcgHeWigSIIHDX3VSk5bZlQWaGgLIwdrNhUtY6Q8
         QSr25O4TmHMpPprVucltH3UsN2IJUR76M/hjgGeIoelz0u4BzcTA2NviTzemP++8EHmC
         AEUA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="199319611"
Date: Mon, 14 May 2018 13:55:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Message-ID: <20180514135548.4b95ab93@jacob-builder>
In-Reply-To: <5AF92622.2090902@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF92622.2090902@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363226135285?=
X-GMAIL-MSGID: =?utf-8?q?1600474246812823646?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 14 May 2018 14:01:06 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > Traditionally, device specific faults are detected and handled
> > within their own device drivers. When IOMMU is enabled, faults such
> > as DMA related transactions are detected by IOMMU. There is no
> > generic reporting mechanism to report faults back to the in-kernel
> > device driver or the guest OS in case of assigned devices.
> >
> > Faults detected by IOMMU is based on the transaction's source ID
> > which can be reported at per device basis, regardless of the device
> > type is a PCI device or not.
> >
> > The fault types include recoverable (e.g. page request) and
> > unrecoverable faults(e.g. access error). In most cases, faults can
> > be handled by IOMMU drivers internally. The primary use cases are as
> > follows:
> > 1. page request fault originated from an SVM capable device that is
> > assigned to guest via vIOMMU. In this case, the first level page
> > tables are owned by the guest. Page request must be propagated to
> > the guest to let guest OS fault in the pages then send page
> > response. In this mechanism, the direct receiver of IOMMU fault
> > notification is VFIO, which can relay notification events to QEMU
> > or other user space software.
> >
> > 2. faults need more subtle handling by device drivers. Other than
> > simply invoke reset function, there are needs to let device driver
> > handle the fault with a smaller impact.
> >
> > This patchset is intended to create a generic fault report API such
> > that it can scale as follows:
> > - all IOMMU types
> > - PCI and non-PCI devices
> > - recoverable and unrecoverable faults
> > - VFIO and other other in kernel users
> > - DMA & IRQ remapping (TBD)
> > The original idea was brought up by David Woodhouse and discussions
> > summarized at https://lwn.net/Articles/608914/.
> >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > ---
> >  drivers/iommu/iommu.c | 149
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> > include/linux/iommu.h |  35 +++++++++++- 2 files changed, 181
> > insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 3a49b96..b3f9daf 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -609,6 +609,13 @@ int iommu_group_add_device(struct iommu_group
> > *group, struct device *dev) goto err_free_name;
> >  	}
> >  
> > +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param),
> > GFP_KERNEL);
> > +	if (!dev->iommu_param) {
> > +		ret = -ENOMEM;
> > +		goto err_free_name;
> > +	}
> > +	mutex_init(&dev->iommu_param->lock);
> > +
> >  	kobject_get(group->devices_kobj);
> >  
> >  	dev->iommu_group = group;
> > @@ -639,6 +646,7 @@ int iommu_group_add_device(struct iommu_group
> > *group, struct device *dev) mutex_unlock(&group->mutex);
> >  	dev->iommu_group = NULL;
> >  	kobject_put(group->devices_kobj);
> > +	kfree(dev->iommu_param);
> >  err_free_name:
> >  	kfree(device->name);
> >  err_remove_link:
> > @@ -685,7 +693,7 @@ void iommu_group_remove_device(struct device
> > *dev) sysfs_remove_link(&dev->kobj, "iommu_group");
> >  
> >  	trace_remove_device_from_group(group->id, dev);
> > -
> > +	kfree(dev->iommu_param);
> >  	kfree(device->name);
> >  	kfree(device);
> >  	dev->iommu_group = NULL;
> > @@ -820,6 +828,145 @@ int iommu_group_unregister_notifier(struct
> > iommu_group *group,
> > EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier); 
> >  /**
> > + * iommu_register_device_fault_handler() - Register a device fault
> > handler
> > + * @dev: the device
> > + * @handler: the fault handler
> > + * @data: private data passed as argument to the handler
> > + *
> > + * When an IOMMU fault event is received, call this handler with
> > the fault event
> > + * and data as argument. The handler should return 0 on success.
> > If the fault is
> > + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also
> > complete
> > + * the fault by calling iommu_page_response() with one of the
> > following
> > + * response code:
> > + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> > + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
> > + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop
> > reporting
> > + *   page faults if possible.
> > + *
> > + * Return 0 if the fault handler was installed successfully, or an
> > error.
> > + */
> > +int iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!param)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&param->lock);
> > +	/* Only allow one fault handler registered for each device
> > */
> > +	if (param->fault_param) {
> > +		ret = -EBUSY;
> > +		goto done_unlock;
> > +	}
> > +
> > +	get_device(dev);
> > +	param->fault_param =
> > +		kzalloc(sizeof(struct iommu_fault_param),
> > GFP_KERNEL);
> > +	if (!param->fault_param) {
> > +		put_device(dev);
> > +		ret = -ENOMEM;
> > +		goto done_unlock;
> > +	}
> > +	mutex_init(&param->fault_param->lock);  
> 
> Do we really need this mutex lock? Is param->lock enough?
> 
I am trying to provide more fine locking granularity in that
iommu_param is meant to be expanded as the sole iommu data under struct
device, so the scope of param->lock may expand.
>  [...]  
> 
> Best regards,
> Lu Baolu

[Jacob Pan]

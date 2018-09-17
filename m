Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0FECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A09214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 16:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A09214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeIQWYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:24:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:15276 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeIQWYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 09:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,386,1531810800"; 
   d="scan'208";a="73703700"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 17 Sep 2018 09:56:37 -0700
Date:   Mon, 17 Sep 2018 09:57:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Jean Delvare <khali@linux-fr.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Message-ID: <20180917095758.589d44ec@jacob-builder>
In-Reply-To: <aea7a57f-e3d8-ed87-22ac-941f50c8e2b5@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <aea7a57f-e3d8-ed87-22ac-941f50c8e2b5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2018 15:24:41 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 5/11/18 10:54 PM, Jacob Pan wrote:
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
> > +	param->fault_param->handler = handler;
> > +	param->fault_param->data = data;
> > +	INIT_LIST_HEAD(&param->fault_param->faults);
> > +
> > +done_unlock:
> > +	mutex_unlock(&param->lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> > +
> > +/**
> > + * iommu_unregister_device_fault_handler() - Unregister the device
> > fault handler
> > + * @dev: the device
> > + *
> > + * Remove the device fault handler installed with
> > + * iommu_register_device_fault_handler().
> > + *
> > + * Return 0 on success, or an error.
> > + */
> > +int iommu_unregister_device_fault_handler(struct device *dev)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +	int ret = 0;
> > +
> > +	if (!param)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&param->lock);
> > +	/* we cannot unregister handler if there are pending
> > faults */
> > +	if (!list_empty(&param->fault_param->faults)) {
> > +		ret = -EBUSY;
> > +		goto unlock;
> > +	}
> > +
> > +	kfree(param->fault_param);
> > +	param->fault_param = NULL;
> > +	put_device(dev);  
> don't you need to test if (param->fault_param) is set first. Otherwise
> you may end up with an unpaired put_device()?
You are right, thanks.

I am also working on allowing multiple registrations per handler. i.e.
device can register the same fault handler with different data. Then I
will add refcount. The motivation is that for PCIe device with
sub-device partitioned at PASID granularity, fault reporting needs to
be at PCI device + PASID level.
> 
>  [...]  
> s/needs/need
> 
taken, thanks
> Thanks
> 
> Eric
> > + * @lock: protect pending PRQ event list
> >   */
> >  struct iommu_fault_param {
> >  	iommu_dev_fault_handler_t handler;
> > +	struct list_head faults;
> > +	struct mutex lock;
> >  	void *data;
> >  };
> >  
> > @@ -357,6 +362,7 @@ struct iommu_fault_param {
> >   *	struct iommu_fwspec	*iommu_fwspec;
> >   */
> >  struct iommu_param {
> > +	struct mutex lock;
> >  	struct iommu_fault_param *fault_param;
> >  };
> >  
> > @@ -456,6 +462,14 @@ extern int
> > iommu_group_register_notifier(struct iommu_group *group, struct
> > notifier_block *nb); extern int
> > iommu_group_unregister_notifier(struct iommu_group *group, struct
> > notifier_block *nb); +extern int
> > iommu_register_device_fault_handler(struct device *dev,
> > +					iommu_dev_fault_handler_t
> > handler,
> > +					void *data);
> > +
> > +extern int iommu_unregister_device_fault_handler(struct device
> > *dev); +
> > +extern int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt); +
> >  extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev); extern struct iommu_domain
> > *iommu_group_default_domain(struct iommu_group *); @@ -727,6
> > +741,23 @@ static inline int iommu_group_unregister_notifier(struct
> > iommu_group *group, return 0; }
> >  
> > +static inline int iommu_register_device_fault_handler(struct
> > device *dev,
> > +
> > iommu_dev_fault_handler_t handler,
> > +						void *data)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int iommu_unregister_device_fault_handler(struct
> > device *dev) +{
> > +	return 0;
> > +}
> > +
> > +static inline int iommu_report_device_fault(struct device *dev,
> > struct iommu_fault_event *evt) +{
> > +	return -ENODEV;
> > +}
> > +
> >  static inline int iommu_group_id(struct iommu_group *group)
> >  {
> >  	return -ENODEV;
> >   

[Jacob Pan]

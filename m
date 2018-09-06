Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28461C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFFFC20867
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFFC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeIFN7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:59:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727839AbeIFN7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:59:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D0A7804BBBC;
        Thu,  6 Sep 2018 09:25:07 +0000 (UTC)
Received: from [10.36.116.235] (ovpn-116-235.ams2.redhat.com [10.36.116.235])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AE011055460;
        Thu,  6 Sep 2018 09:25:01 +0000 (UTC)
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Jean Delvare <khali@linux-fr.org>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2094d667-5dbf-b4b8-8e19-c76d67b82362@redhat.com>
Date:   Thu, 6 Sep 2018 11:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 09:25:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 09:25:07 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 05/11/2018 10:54 PM, Jacob Pan wrote:
> Traditionally, device specific faults are detected and handled within
> their own device drivers. When IOMMU is enabled, faults such as DMA
> related transactions are detected by IOMMU. There is no generic
> reporting mechanism to report faults back to the in-kernel device
> driver or the guest OS in case of assigned devices.
> 
> Faults detected by IOMMU is based on the transaction's source ID which
> can be reported at per device basis, regardless of the device type is a
> PCI device or not.
> 
> The fault types include recoverable (e.g. page request) and
> unrecoverable faults(e.g. access error). In most cases, faults can be
> handled by IOMMU drivers internally. The primary use cases are as
> follows:
> 1. page request fault originated from an SVM capable device that is
> assigned to guest via vIOMMU. In this case, the first level page tables
> are owned by the guest. Page request must be propagated to the guest to
> let guest OS fault in the pages then send page response. In this
> mechanism, the direct receiver of IOMMU fault notification is VFIO,
> which can relay notification events to QEMU or other user space
> software.
> 
> 2. faults need more subtle handling by device drivers. Other than
> simply invoke reset function, there are needs to let device driver
> handle the fault with a smaller impact.
> 
> This patchset is intended to create a generic fault report API such
> that it can scale as follows:
> - all IOMMU types
> - PCI and non-PCI devices
> - recoverable and unrecoverable faults
> - VFIO and other other in kernel users
> - DMA & IRQ remapping (TBD)
> The original idea was brought up by David Woodhouse and discussions
> summarized at https://lwn.net/Articles/608914/.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/iommu.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/iommu.h |  35 +++++++++++-
>  2 files changed, 181 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3a49b96..b3f9daf 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -609,6 +609,13 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  		goto err_free_name;
>  	}
>  
> +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param), GFP_KERNEL);
> +	if (!dev->iommu_param) {
> +		ret = -ENOMEM;
> +		goto err_free_name;
> +	}
> +	mutex_init(&dev->iommu_param->lock);
> +
>  	kobject_get(group->devices_kobj);
>  
>  	dev->iommu_group = group;
> @@ -639,6 +646,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
>  	mutex_unlock(&group->mutex);
>  	dev->iommu_group = NULL;
>  	kobject_put(group->devices_kobj);
> +	kfree(dev->iommu_param);
>  err_free_name:
>  	kfree(device->name);
>  err_remove_link:
> @@ -685,7 +693,7 @@ void iommu_group_remove_device(struct device *dev)
>  	sysfs_remove_link(&dev->kobj, "iommu_group");
>  
>  	trace_remove_device_from_group(group->id, dev);
> -
> +	kfree(dev->iommu_param);
>  	kfree(device->name);
>  	kfree(device);
>  	dev->iommu_group = NULL;
> @@ -820,6 +828,145 @@ int iommu_group_unregister_notifier(struct iommu_group *group,
>  EXPORT_SYMBOL_GPL(iommu_group_unregister_notifier);
>  
>  /**
> + * iommu_register_device_fault_handler() - Register a device fault handler
> + * @dev: the device
> + * @handler: the fault handler
> + * @data: private data passed as argument to the handler
> + *
> + * When an IOMMU fault event is received, call this handler with the fault event
> + * and data as argument. The handler should return 0 on success. If the fault is
> + * recoverable (IOMMU_FAULT_PAGE_REQ), the handler can also complete
> + * the fault by calling iommu_page_response() with one of the following
iommu_page_response name looks too specific to PRI use case. why not
using iommu_fault_response.
> + * response code:
> + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
> + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
Same here s/IOMMU_PAGE_RESP/IOMMU_PAGE_RESP

That way I can easily reuse the API for SMMU nested stage handing.
> + *   page faults if possible.
> + *
> + * Return 0 if the fault handler was installed successfully, or an error.
> + */
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +	/* Only allow one fault handler registered for each device */
> +	if (param->fault_param) {
> +		ret = -EBUSY;
> +		goto done_unlock;
> +	}
> +
> +	get_device(dev);
> +	param->fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
> +	if (!param->fault_param) {
> +		put_device(dev);
> +		ret = -ENOMEM;
> +		goto done_unlock;
> +	}
> +	mutex_init(&param->fault_param->lock);
> +	param->fault_param->handler = handler;
> +	param->fault_param->data = data;
> +	INIT_LIST_HEAD(&param->fault_param->faults);
> +
> +done_unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
> +
> +/**
> + * iommu_unregister_device_fault_handler() - Unregister the device fault handler
> + * @dev: the device
> + *
> + * Remove the device fault handler installed with
> + * iommu_register_device_fault_handler().
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = 0;
> +
> +	if (!param)
> +		return -EINVAL;
> +
> +	mutex_lock(&param->lock);
> +	/* we cannot unregister handler if there are pending faults */
> +	if (!list_empty(&param->fault_param->faults)) {> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	kfree(param->fault_param);
> +	param->fault_param = NULL;
> +	put_device(dev);
> +unlock:
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
> +
> +
> +/**
> + * iommu_report_device_fault() - Report fault event to device
> + * @dev: the device
> + * @evt: fault event data
> + *
> + * Called by IOMMU model specific drivers when fault is detected, typically
> + * in a threaded IRQ handler.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	int ret = 0;
> +	struct iommu_fault_event *evt_pending;
> +	struct iommu_fault_param *fparam;
> +
> +	/* iommu_param is allocated when device is added to group */
> +	if (!dev->iommu_param | !evt)
> +		return -EINVAL;
> +	/* we only report device fault if there is a handler registered */
> +	mutex_lock(&dev->iommu_param->lock);
> +	if (!dev->iommu_param->fault_param ||
> +		!dev->iommu_param->fault_param->handler) {
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +	fparam = dev->iommu_param->fault_param;
> +	if (evt->type == IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> +		evt_pending = kmemdup(evt, sizeof(struct iommu_fault_event),
> +				GFP_KERNEL);
> +		if (!evt_pending) {
> +			ret = -ENOMEM;
> +			goto done_unlock;
> +		}
> +		mutex_lock(&fparam->lock);
> +		list_add_tail(&evt_pending->list, &fparam->faults);
same doubt as Yi Liu. You cannot rely on the userspace willingness to
void the queue and deallocate this memory.

SMMUv3 holds a queue of events whose size is implementation dependent.
I think such a queue should be available at SW level and its size should
be negotiated.

Note SMMU has separate queues for PRI and fault events. Here you use the
same queue for all events. I don't know if it would make sense to have
separate APIs?

Thanks

Eric

> +		mutex_unlock(&fparam->lock);
> +	}
> +	ret = fparam->handler(evt, fparam->data);
> +done_unlock:
> +	mutex_unlock(&dev->iommu_param->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_report_device_fault);
> +
> +/**
>   * iommu_group_id - Return ID for a group
>   * @group: the group to ID
>   *
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index aeadb4f..b3312ee 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -307,7 +307,8 @@ enum iommu_fault_reason {
>   * and PASID spec.
>   * - Un-recoverable faults of device interest
>   * - DMA remapping and IRQ remapping faults
> -
> + *
> + * @list pending fault event list, used for tracking responses
>   * @type contains fault type.
>   * @reason fault reasons if relevant outside IOMMU driver, IOMMU driver internal
>   *         faults are not reported
> @@ -324,6 +325,7 @@ enum iommu_fault_reason {
>   *                 sending the fault response.
>   */
>  struct iommu_fault_event {
> +	struct list_head list;
>  	enum iommu_fault_type type;
>  	enum iommu_fault_reason reason;
>  	u64 addr;
> @@ -340,10 +342,13 @@ struct iommu_fault_event {
>   * struct iommu_fault_param - per-device IOMMU fault data
>   * @dev_fault_handler: Callback function to handle IOMMU faults at device level
>   * @data: handler private data
> - *
> + * @faults: holds the pending faults which needs response, e.g. page response.
> + * @lock: protect pending PRQ event list
>   */
>  struct iommu_fault_param {
>  	iommu_dev_fault_handler_t handler;
> +	struct list_head faults;
> +	struct mutex lock;
>  	void *data;
>  };
>  
> @@ -357,6 +362,7 @@ struct iommu_fault_param {
>   *	struct iommu_fwspec	*iommu_fwspec;
>   */
>  struct iommu_param {
> +	struct mutex lock;
>  	struct iommu_fault_param *fault_param;
>  };
>  
> @@ -456,6 +462,14 @@ extern int iommu_group_register_notifier(struct iommu_group *group,
>  					 struct notifier_block *nb);
>  extern int iommu_group_unregister_notifier(struct iommu_group *group,
>  					   struct notifier_block *nb);
> +extern int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler,
> +					void *data);
> +
> +extern int iommu_unregister_device_fault_handler(struct device *dev);
> +
> +extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
> +
>  extern int iommu_group_id(struct iommu_group *group);
>  extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
> @@ -727,6 +741,23 @@ static inline int iommu_group_unregister_notifier(struct iommu_group *group,
>  	return 0;
>  }
>  
> +static inline int iommu_register_device_fault_handler(struct device *dev,
> +						iommu_dev_fault_handler_t handler,
> +						void *data)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int iommu_unregister_device_fault_handler(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_group_id(struct iommu_group *group)
>  {
>  	return -ENODEV;
> 

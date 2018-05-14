Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZrUECiKzkW2Mr9lt5X0aD/62c9rcjtQ0JwKKATD73Pn9iaoohTKdZbBAPLxr400bvF1slfe
ARC-Seal: i=1; a=rsa-sha256; t=1526277669; cv=none;
        d=google.com; s=arc-20160816;
        b=ut7DgxEjE3Tfmw6HJ2ZbJoqVNzIlk1WTzqs/W5EuEno+SlxtC2WZsJzX1K1IsnbrDF
         ezMYJj389r9IDRbjAyWHfOijmYdnWSrtOA7NRhoaXLWolX3HZi1aMIbHWJl0HhVZXE7c
         8yClwpAmEsZdD+KWz04VkeKN+jhvONGy9hnG4gd9U9s1WitLM6LLOSqy0RzKBg6GlLYG
         3KYXIo+Js9L2mdXouMBvnaN1s4AgEW0cER/BsSV8fuWOeYBEgXFGxm7fmYzRRMNojpSO
         JsWWseSf0igJ9umqH8cPVIRhYb5a/6yAcjWZX35zy7pqTvrcg7uwH9xvvmoUJYXUCaXb
         pdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=4Hn/KZAdNT4ZvV/8D+jWrCt8mcr1cqQl6nW4oid1FvA=;
        b=od+k/jxY0MbDYWpcFi6dU08qJY/sDpyUxxKNBOFTbbnh2G5gu4Q0QVP/opcyrp3/K6
         IEZjicLMT3TyL6j+iF+15+OtJLK24dxsB/ctjvYYCmpcRiYS1ZtWmuNPzSgas/CJl4E7
         DCYOWTnY1P1QABZQAHV9iedvbMX6zO1emUd5PFv5KzrTVksVlMTldKJz4Ttv26JZxXi8
         03y/0v+5syMPtqwQzdt9wYn+MjnP/nrnfpGS3vWyJQONUjaPUdzee0DWcVie4LtqzQmO
         N+ZnBZ7dSWkLfWgBkD70+43mX/Yq36icIN5Nv3JkbxVV4lDi7CCqDuKUWcnh2bjcrApA
         H6Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,398,1520924400";
   d="scan'208";a="55640250"
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF92622.2090902@linux.intel.com>
Date: Mon, 14 May 2018 14:01:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202363226135285?=
X-GMAIL-MSGID: =?utf-8?q?1600418133230911628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:54 AM, Jacob Pan wrote:
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
> + * response code:
> + * - IOMMU_PAGE_RESP_SUCCESS: retry the translation
> + * - IOMMU_PAGE_RESP_INVALID: terminate the fault
> + * - IOMMU_PAGE_RESP_FAILURE: terminate the fault and stop reporting
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

Do we really need this mutex lock? Is param->lock enough?

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
> +	if (!list_empty(&param->fault_param->faults)) {
> +		ret = -EBUSY;
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

Best regards,
Lu Baolu

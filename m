Return-Path: <baolu.lu@linux.intel.com>
X-Google-Smtp-Source: AB8JxZroxiddF+JOWj7vdIT9EY0HGGgitCk7b2VQPEWaZ9BjfUJvWsMmgqco/MvXlqIGIAT6jWL8
ARC-Seal: i=1; a=rsa-sha256; t=1526279994; cv=none;
        d=google.com; s=arc-20160816;
        b=rHJXe9ym3s0sTof73cyLSrb9ncYqh2OLEGKP2a3V+LlMQ2J4CxlsX3F3Jj0jzeEGR/
         IWliRPLtn9Q5oHrJxix4Ypdac+JbCEOnjLkxU8soi0b+x799CbHHti7WqIho4W40Ip6w
         goYr1Nw4XaMmqOPNruiLrD1GPoDgAZJnIfveOQVqoSY82ssedZG65vD+VVGaq9ZsXRn9
         tHeHFH+i287mTBFpePOaht9OC5CGODpr3rXRc8FPDgIxZT+acqNXRadhWU4FGCoehasD
         ZhUJBhlX0T4qYkb7aA4p21ErZeVfORb4Gg0SIkOVCgG7B1jmQJnxlZ02POWsxvu01ypH
         LsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=FwvJMQHPSKuvj9WAXvm6OrgJg44xPQ6dG8yh4uEdL+Q=;
        b=Sql7mNRDmew2mfnyqbTBoYJbsJeZ+hi6ebqeWJtOYseJlmI8eR/2h8v7KJRDLPqAtf
         kWHZyVuzf+vS3gCROIeU0ag40O9jOzsWMrixHrAcGCi5QQH7kgCMdk7zCp2KpmWl18LI
         LdPQE1uwRbjs5mUOH1LyxDUJ5T4tzSy3gmsfnBeYJzTANN2C0seEJIB0wBlafvHGJgek
         B15sMYxNFwBOVeP8q8o9FEVKCZTvobVj4FFrO6wlkx4NIRi/ik2E/ePd2GSfF58B/7sN
         HThqVNr7/RdYIK5GJhJ0vsLgkxjvTPdfpQPKDNSkVnLkwu+wANcZujd77kSFxtLA+jyP
         /RPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of baolu.lu@linux.intel.com designates 134.134.136.24 as permitted sender) smtp.mailfrom=baolu.lu@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="41562261"
Subject: Re: [PATCH v5 14/23] iommu: introduce page response function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1526072055-86990-15-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
 Christoph Hellwig <hch@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AF92F37.3050404@linux.intel.com>
Date: Mon, 14 May 2018 14:39:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1526072055-86990-15-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202362922375846?=
X-GMAIL-MSGID: =?utf-8?q?1600420571515139100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 04:54 AM, Jacob Pan wrote:
> IO page faults can be handled outside IOMMU subsystem. For an example,
> when nested translation is turned on and guest owns the
> first level page tables, device page request can be forwared
> to the guest for handling faults. As the page response returns
> by the guest, IOMMU driver on the host need to process the
> response which informs the device and completes the page request
> transaction.
>
> This patch introduces generic API function for page response
> passing from the guest or other in-kernel users. The definitions of
> the generic data is based on PCI ATS specification not limited to
> any vendor.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Link: https://lkml.org/lkml/2017/12/7/1725
> ---
>  drivers/iommu/iommu.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b3f9daf..02fed3e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1533,6 +1533,51 @@ int iommu_sva_invalidate(struct iommu_domain *domain,
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
>  
> +int iommu_page_response(struct device *dev,
> +			struct page_response_msg *msg)
> +{
> +	struct iommu_param *param = dev->iommu_param;
> +	int ret = -EINVAL;
> +	struct iommu_fault_event *evt;
> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +
> +	if (!domain || !domain->ops->page_response)
> +		return -ENODEV;
> +
> +	/*
> +	 * Device iommu_param should have been allocated when device is
> +	 * added to its iommu_group.
> +	 */
> +	if (!param || !param->fault_param)
> +		return -EINVAL;
> +
> +	/* Only send response if there is a fault report pending */
> +	mutex_lock(&param->fault_param->lock);
> +	if (list_empty(&param->fault_param->faults)) {
> +		pr_warn("no pending PRQ, drop response\n");
> +		goto done_unlock;
> +	}
> +	/*
> +	 * Check if we have a matching page request pending to respond,
> +	 * otherwise return -EINVAL
> +	 */
> +	list_for_each_entry(evt, &param->fault_param->faults, list) {
> +		if (evt->pasid == msg->pasid &&
> +		    msg->page_req_group_id == evt->page_req_group_id) {
> +			msg->private_data = evt->iommu_private;
> +			ret = domain->ops->page_response(dev, msg);
> +			list_del(&evt->list);
> +			kfree(evt);
> +			break;
> +		}
> +	}

Are above two checks duplicated? We won't find a matching
request if the list is empty. And we need to  printk a message
if we can't find the matching request.

Best regards,
Lu Baolu

> +
> +done_unlock:
> +	mutex_unlock(&param->fault_param->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_page_response);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b3312ee..722b90f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -163,6 +163,41 @@ struct iommu_resv_region {
>  #ifdef CONFIG_IOMMU_API
>  
>  /**
> + * enum page_response_code - Return status of fault handlers, telling the IOMMU
> + * driver how to proceed with the fault.
> + *
> + * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page tables
> + *	populated, retry the access. This is "Success" in PCI PRI.
> + * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
> + *	this device if possible. This is "Response Failure" in PCI PRI.
> + * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
> + *	access. This is "Invalid Request" in PCI PRI.
> + */
> +enum page_response_code {
> +	IOMMU_PAGE_RESP_SUCCESS = 0,
> +	IOMMU_PAGE_RESP_INVALID,
> +	IOMMU_PAGE_RESP_FAILURE,
> +};
> +
> +/**
> + * Generic page response information based on PCI ATS and PASID spec.
> + * @addr: servicing page address
> + * @pasid: contains process address space ID
> + * @resp_code: response code
> + * @page_req_group_id: page request group index
> + * @private_data: uniquely identify device-specific private data for an
> + *                individual page response
> + */
> +struct page_response_msg {
> +	u64 addr;
> +	u32 pasid;
> +	enum page_response_code resp_code;
> +	u32 pasid_present:1;
> +	u32 page_req_group_id;
> +	u64 private_data;
> +};
> +
> +/**
>   * struct iommu_ops - iommu ops and capabilities
>   * @capable: check capability
>   * @domain_alloc: allocate iommu domain
> @@ -195,6 +230,7 @@ struct iommu_resv_region {
>   * @bind_pasid_table: bind pasid table pointer for guest SVM
>   * @unbind_pasid_table: unbind pasid table pointer and restore defaults
>   * @sva_invalidate: invalidate translation caches of shared virtual address
> + * @page_response: handle page request response
>   */
>  struct iommu_ops {
>  	bool (*capable)(enum iommu_cap);
> @@ -250,6 +286,7 @@ struct iommu_ops {
>  				struct device *dev);
>  	int (*sva_invalidate)(struct iommu_domain *domain,
>  		struct device *dev, struct tlb_invalidate_info *inv_info);
> +	int (*page_response)(struct device *dev, struct page_response_msg *msg);
>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -470,6 +507,7 @@ extern int iommu_unregister_device_fault_handler(struct device *dev);
>  
>  extern int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt);
>  
> +extern int iommu_page_response(struct device *dev, struct page_response_msg *msg);
>  extern int iommu_group_id(struct iommu_group *group);
>  extern struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_group_default_domain(struct iommu_group *);
> @@ -758,6 +796,11 @@ static inline int iommu_report_device_fault(struct device *dev, struct iommu_fau
>  	return -ENODEV;
>  }
>  
> +static inline int iommu_page_response(struct device *dev, struct page_response_msg *msg)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int iommu_group_id(struct iommu_group *group)
>  {
>  	return -ENODEV;

Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A9EC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100372086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100372086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeIJWnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:43:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:58066 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeIJWno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:43:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 10:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="89237916"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 10 Sep 2018 10:48:29 -0700
Date:   Mon, 10 Sep 2018 10:50:31 -0700
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
Subject: Re: [PATCH v5 14/23] iommu: introduce page response function
Message-ID: <20180910105031.217a52c3@jacob-builder>
In-Reply-To: <b6743e3d-b8eb-ad44-9b13-c7231807b114@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-15-git-send-email-jacob.jun.pan@linux.intel.com>
        <b6743e3d-b8eb-ad44-9b13-c7231807b114@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018 16:52:24 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
Hi Eric,

Thanks for the review, please comments inline.
> On 05/11/2018 10:54 PM, Jacob Pan wrote:
> > IO page faults can be handled outside IOMMU subsystem. For an
> > example, when nested translation is turned on and guest owns the
> > first level page tables, device page request can be forwared  
> forwarded
> > to the guest for handling faults. As the page response returns
> > by the guest, IOMMU driver on the host need to process the  
> from the guest ...  host needs
> > response which informs the device and completes the page request
> > transaction.
> > 
> > This patch introduces generic API function for page response
> > passing from the guest or other in-kernel users. The definitions of
> > the generic data is based on PCI ATS specification not limited to
> > any vendor.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Link: https://lkml.org/lkml/2017/12/7/1725
> > ---
> >  drivers/iommu/iommu.c | 45
> > +++++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h
> > | 43 +++++++++++++++++++++++++++++++++++++++++++ 2 files changed,
> > 88 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index b3f9daf..02fed3e 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1533,6 +1533,51 @@ int iommu_sva_invalidate(struct iommu_domain
> > *domain, }
> >  EXPORT_SYMBOL_GPL(iommu_sva_invalidate);
> >  
> > +int iommu_page_response(struct device *dev,
> > +			struct page_response_msg *msg)
> > +{
> > +	struct iommu_param *param = dev->iommu_param;
> > +	int ret = -EINVAL;
> > +	struct iommu_fault_event *evt;
> > +	struct iommu_domain *domain =
> > iommu_get_domain_for_dev(dev); +
> > +	if (!domain || !domain->ops->page_response)
> > +		return -ENODEV;
> > +
> > +	/*
> > +	 * Device iommu_param should have been allocated when
> > device is
> > +	 * added to its iommu_group.
> > +	 */
> > +	if (!param || !param->fault_param)
> > +		return -EINVAL;
> > +
> > +	/* Only send response if there is a fault report pending */
> > +	mutex_lock(&param->fault_param->lock);
> > +	if (list_empty(&param->fault_param->faults)) {
> > +		pr_warn("no pending PRQ, drop response\n");
> > +		goto done_unlock;
> > +	}
> > +	/*
> > +	 * Check if we have a matching page request pending to
> > respond,
> > +	 * otherwise return -EINVAL
> > +	 */
> > +	list_for_each_entry(evt, &param->fault_param->faults,
> > list) {
> > +		if (evt->pasid == msg->pasid &&
> > +		    msg->page_req_group_id ==
> > evt->page_req_group_id) {
> > +			msg->private_data = evt->iommu_private;
> > +			ret = domain->ops->page_response(dev, msg);
> > +			list_del(&evt->list);  
> don't you need a list_for_each_entry_safe?
why? I am here exiting the loop.
> > +			kfree(evt);
> > +			break;
> > +		}
> > +	}
> > +
> > +done_unlock:
> > +	mutex_unlock(&param->fault_param->lock);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_page_response);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index b3312ee..722b90f 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -163,6 +163,41 @@ struct iommu_resv_region {
> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > + * enum page_response_code - Return status of fault handlers,
> > telling the IOMMU
> > + * driver how to proceed with the fault.
> > + *
> > + * @IOMMU_PAGE_RESP_SUCCESS: Fault has been handled and the page
> > tables
> > + *	populated, retry the access. This is "Success" in PCI
> > PRI.
> > + * @IOMMU_PAGE_RESP_FAILURE: General error. Drop all subsequent
> > faults from
> > + *	this device if possible. This is "Response Failure" in
> > PCI PRI.
> > + * @IOMMU_PAGE_RESP_INVALID: Could not handle this fault, don't
> > retry the
> > + *	access. This is "Invalid Request" in PCI PRI.
> > + */
> > +enum page_response_code {
> > +	IOMMU_PAGE_RESP_SUCCESS = 0,
> > +	IOMMU_PAGE_RESP_INVALID,
> > +	IOMMU_PAGE_RESP_FAILURE,
> > +};
> > +
> > +/**
> > + * Generic page response information based on PCI ATS and PASID
> > spec.
> > + * @addr: servicing page address
> > + * @pasid: contains process address space ID
> > + * @resp_code: response code  
> nit: @pasid_present doc missing although quite obvious
> > + * @page_req_group_id: page request group index
> > + * @private_data: uniquely identify device-specific private data
> > for an
> > + *                individual page response
> > + */
> > +struct page_response_msg {
> > +	u64 addr;
> > +	u32 pasid;
> > +	enum page_response_code resp_code;
> > +	u32 pasid_present:1;
> > +	u32 page_req_group_id;
> > +	u64 private_data;
> > +};  
> Doesn't it need to be part of iommu uapi header since the virtualizer
> will pass the response through VFIO?
> 
Right, that has been the same feedback from others as well. I am moving
it to uapi in the next rev.
> As mentioned in previous discussion this is really PRI related and
> does not really fit unrecoverable fault reporting. To me we should
> clarify if this API targets both use cases or only the PRI response
> use case.
Yes, I should clarify this is for PRI only. It is little bit asymmetric
in that per IOMMU device fault reporting covers both unrecoverable
faults and PRI, but only PRI needs page response.

> Also in the implementation we check pasid and PRGindex. As
> mentionned by Jean-Philippe, unrecoverable "traditional" faults do
> not require to manage a list in the iommu subsystem.
> 
I am not sure if that is a question. We support PRI with PASID only.
We keep the group ID for page responses.
> Have you considered using a kfifo instead of a list to manage the
> pending PRI requests?
> 
No, I will look into it. But we may need too traverse the list in case
of exceptions. e.g. dropping some pending requests if device faults or
process/vm terminates.

> Thanks
> 
> Eric
> > +
> > +/**
> >   * struct iommu_ops - iommu ops and capabilities
> >   * @capable: check capability
> >   * @domain_alloc: allocate iommu domain
> > @@ -195,6 +230,7 @@ struct iommu_resv_region {
> >   * @bind_pasid_table: bind pasid table pointer for guest SVM
> >   * @unbind_pasid_table: unbind pasid table pointer and restore
> > defaults
> >   * @sva_invalidate: invalidate translation caches of shared
> > virtual address
> > + * @page_response: handle page request response
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -250,6 +286,7 @@ struct iommu_ops {
> >  				struct device *dev);
> >  	int (*sva_invalidate)(struct iommu_domain *domain,
> >  		struct device *dev, struct tlb_invalidate_info
> > *inv_info);
> > +	int (*page_response)(struct device *dev, struct
> > page_response_msg *msg); 
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -470,6 +507,7 @@ extern int
> > iommu_unregister_device_fault_handler(struct device *dev); 
> >  extern int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt); 
> > +extern int iommu_page_response(struct device *dev, struct
> > page_response_msg *msg); extern int iommu_group_id(struct
> > iommu_group *group); extern struct iommu_group
> > *iommu_group_get_for_dev(struct device *dev); extern struct
> > iommu_domain *iommu_group_default_domain(struct iommu_group *); @@
> > -758,6 +796,11 @@ static inline int
> > iommu_report_device_fault(struct device *dev, struct iommu_fau
> > return -ENODEV; } 
> > +static inline int iommu_page_response(struct device *dev, struct
> > page_response_msg *msg) +{
> > +	return -ENODEV;
> > +}
> > +
> >  static inline int iommu_group_id(struct iommu_group *group)
> >  {
> >  	return -ENODEV;
> >   

[Jacob Pan]

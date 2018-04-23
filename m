Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx48mgGxto8Xh9K3tHmueZq9OSPJmcKn7cgpyIMpB0Lm3lMKObYm1txIiiTsd87CYUwPWGgV3
ARC-Seal: i=1; a=rsa-sha256; t=1524485655; cv=none;
        d=google.com; s=arc-20160816;
        b=Sy5tO2tVrWZ/JbXHkBNfe6GZJFtPCYrQjllPaA7wek9Ehd2RIrhZedXWpngN4VbFUS
         0EVN4iE96xwE5prSL3u2Ya8Rgdo2YxP0MLzZ/DzxNJpRSo72baUr/6xFtyB1U756yny+
         6+uVtdsDENto7s0mhgeKAVMDPyji4OBMQ+9HnQeRcAr9O2GAwptWlan6b/yZRITSB6UX
         dzL7BY1YDa6W8WMWkXMFI+pU1tvjQQ59J3+EoG9osMdi9PSY0UqkHcvdDm02hH9kKMxm
         Fba+9MoNWUpIK3nn5oLwfA6dFBUkspZSPxmROl4uphuCbdRXu50/Ck6TXeZ2TO1aV+wG
         1VZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=Lh4dC89H0k0l3BN+uJVTQ8lYD/wFRrjpZXkHDo7iphI=;
        b=SJgU+64dv1ANtCciu7gvqFDsHy7hWgwf9w8sJdPCk+a0YNvwliLBkY4Al1s7OEBuhM
         EQ3QnuHriRBQkp93YAXdIzrRZL8v9Sp88Vx2guzOeHpSlac/daqcW4xbBnAaexizTSx0
         VRUmN85m3LlqTDAEKyj9e1BuJM8WJPzaCBT/yVgRZkf/EDgrZvng/9C5M0/rzQu4qloL
         1SSPEviHulPrrwWAFCBUP9jCFtDuXdusaFkfKQEsFJckIW7H+tPIr83TshsDRNBdtGv7
         cWhBGPsotm60H/pw/qdq2bZDn690aPLjkne0y00nPy0/CT6mpnNqz9AHGerq1FGNF68K
         dmuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="45354557"
Date: Mon, 23 Apr 2018 05:16:49 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok
 <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>, Christoph Hellwig
 <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 13/22] iommu: introduce page response function
Message-ID: <20180423051649.63f0febd@jacob-builder>
In-Reply-To: <AM4PR0802MB23698019B80CCE6B083D1448A3890@AM4PR0802MB2369.eurprd08.prod.outlook.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-14-git-send-email-jacob.jun.pan@linux.intel.com>
	<AM4PR0802MB23698019B80CCE6B083D1448A3890@AM4PR0802MB2369.eurprd08.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910346286875?=
X-GMAIL-MSGID: =?utf-8?q?1598539070758717929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018 12:47:10 +0100
Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com> wrote:

> On Mon, Apr 16, 2018 at 10:49:02PM +0100, Jacob Pan wrote:
> [...]
> > +	/*
> > +	 * Check if we have a matching page request pending to
> > respond,
> > +	 * otherwise return -EINVAL
> > +	 */
> > +	list_for_each_entry_safe(evt, iter,
> > &param->fault_param->faults, list) {  
> 
> I don't think you need the "_safe" iterator if you're exiting the loop
> right after removing the event.
> 
you are right, good catch!
> > +		if (evt->pasid == msg->pasid &&
> > +		    msg->page_req_group_id ==
> > evt->page_req_group_id) {
> > +			msg->private_data = evt->iommu_private;  
> 
> Ah sorry, I missed this bit in my review of 10/22. I thought
> private_data would be for evt->device_private. In this case I guess we
> can drop device_private, or do you plan to use it?
> 
NP. vt-d still plan to use device_private for gfx device.
> > +			ret = domain->ops->page_response(dev, msg);
> > +			list_del(&evt->list);
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
> > index 32435f9..058b552 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -163,6 +163,55 @@ struct iommu_resv_region {
> >  #ifdef CONFIG_IOMMU_API
> >  
> >  /**
> > + * enum page_response_code - Return status of fault handlers,
> > telling the IOMMU
> > + * driver how to proceed with the fault.
> > + *
> > + * @IOMMU_FAULT_STATUS_SUCCESS: Fault has been handled and the
> > page tables
> > + *	populated, retry the access. This is "Success" in PCI
> > PRI.
> > + * @IOMMU_FAULT_STATUS_FAILURE: General error. Drop all subsequent
> > faults from
> > + *	this device if possible. This is "Response Failure" in
> > PCI PRI.
> > + * @IOMMU_FAULT_STATUS_INVALID: Could not handle this fault, don't
> > retry the
> > + *	access. This is "Invalid Request" in PCI PRI.
> > + */
> > +enum page_response_code {
> > +	IOMMU_PAGE_RESP_SUCCESS = 0,
> > +	IOMMU_PAGE_RESP_INVALID,
> > +	IOMMU_PAGE_RESP_FAILURE,
> > +};  
> 
> Field names aren't consistent with the comment. I'd go with
> IOMMU_PAGE_RESP_* 
> 
will do.
> > +
> > +/**
> > + * enum page_request_handle_t - Return page request/response
> > handler status
> > + *
> > + * @IOMMU_FAULT_STATUS_HANDLED: Stop processing the fault, and do
> > not send a
> > + *	reply to the device.
> > + * @IOMMU_FAULT_STATUS_CONTINUE: Fault was not handled. Call the
> > next handler,
> > + *	or terminate.
> > + */
> > +enum page_request_handle_t {
> > +	IOMMU_PAGE_RESP_HANDLED = 0,
> > +	IOMMU_PAGE_RESP_CONTINUE,  
> 
> Same here regarding the comment. Here I'd prefer
> "iommu_fault_status_t" for the enum and IOMMU_FAULT_STATUS_* for the
> fields, because they can be used for unrecoverable faults as well.
> 
> But since you're not using these values in your patches, I guess you
> can drop this enum? At the moment the return value of fault handler
> is 0 (as specified at iommu_register_device_fault_handler), meaning
> that the handler always takes ownership of the fault.
> 
> It will be easy to extend once we introduce multiple fault handlers
> that can either take the fault or pass it to the next one. Existing
> implementations will still return 0 - HANDLED, and new ones will
> return either HANDLED or CONTINUE.
> 
I shall drop these, only put in here to match your patch. i am looking
into converting vt-d svm prq to your queued fault patch. I think it will
give both functional and performance benefit.
> > +/**
> > + * Generic page response information based on PCI ATS and PASID
> > spec.
> > + * @addr: servicing page address
> > + * @pasid: contains process address space ID
> > + * @resp_code: response code
> > + * @page_req_group_id: page request group index
> > + * @type: group or stream/single page response  
> 
> @type isn't in the structure
> 
missed that, i move it to iommu private data since it is vtd only
> > + * @private_data: uniquely identify device-specific private data
> > for an
> > + *                individual page response  
> 
> IOMMU-specific? If it is set by iommu.c, I think we should comment
> about it, something like "This field is written by the IOMMU core".
> Maybe also rename it to iommu_private to be consistent with
> iommu_fault_event
> 
sounds good.
> > + */
> > +struct page_response_msg {
> > +	u64 addr;
> > +	u32 pasid;
> > +	enum page_response_code resp_code;
> > +	u32 pasid_present:1;
> > +	u32 page_req_group_id;
> > +	u64 private_data;
> > +};
> > +
> > +/**
> >   * struct iommu_ops - iommu ops and capabilities
> >   * @capable: check capability
> >   * @domain_alloc: allocate iommu domain
> > @@ -195,6 +244,7 @@ struct iommu_resv_region {
> >   * @bind_pasid_table: bind pasid table pointer for guest SVM
> >   * @unbind_pasid_table: unbind pasid table pointer and restore
> > defaults
> >   * @sva_invalidate: invalidate translation caches of shared
> > virtual address
> > + * @page_response: handle page request response
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -250,6 +300,7 @@ struct iommu_ops {
> >  				struct device *dev);
> >  	int (*sva_invalidate)(struct iommu_domain *domain,
> >  		struct device *dev, struct tlb_invalidate_info
> > *inv_info);
> > +	int (*page_response)(struct device *dev, struct
> > page_response_msg *msg); 
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -471,6 +522,7 @@ extern int
> > iommu_unregister_device_fault_handler(struct device *dev); 
> >  extern int iommu_report_device_fault(struct device *dev, struct
> > iommu_fault_event *evt); 
> > +extern int iommu_page_response(struct device *dev, struct
> > page_response_msg *msg);  
> 
> Please also define a -ENODEV function for !CONFIG_IOMMU_API, otherwise
> it doesn't build.
> 
> And I think struct page_response_msg and the enums should be declared
> outside #ifdef CONFIG_IOMMU_API. Same for struct iommu_fault_event and
> the enums in patch 10/22. Otherwise device drivers will have to add
> #ifdefs everywhere their code accesses these structures.
> 
> Thanks,
> Jean
> 
good point.
> >  extern int iommu_group_id(struct iommu_group *group);
> >  extern struct iommu_group *iommu_group_get_for_dev(struct device
> > *dev); extern struct iommu_domain
> > *iommu_group_default_domain(struct iommu_group *); -- 
> > 2.7.4
> >   

[Jacob Pan]

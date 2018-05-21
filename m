Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbeEUXNf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:13:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:49742 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbeEUXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:13:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="41136805"
Date: Mon, 21 May 2018 16:16:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 10/22] iommu: introduce device fault data
Message-ID: <20180521161621.0ae30c8d@jacob-builder>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BF3E05@SHSMSX104.ccr.corp.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1523915351-54415-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <A2975661238FB949B60364EF0F2C257439BF3E05@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 May 2018 08:17:43 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Jacob,
> 
> > From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> > Sent: Tuesday, April 17, 2018 5:49 AM
> >  include/linux/iommu.h | 102
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 100 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index e963dbd..8968933 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -49,13 +49,17 @@ struct bus_type;
> >  struct device;
> >  struct iommu_domain;
> >  struct notifier_block;
> > +struct iommu_fault_event;
> > 
> >  /* iommu fault flags */
> > -#define IOMMU_FAULT_READ	0x0
> > -#define IOMMU_FAULT_WRITE	0x1
> > +#define IOMMU_FAULT_READ		(1 << 0)
> > +#define IOMMU_FAULT_WRITE		(1 << 1)
> > +#define IOMMU_FAULT_EXEC		(1 << 2)
> > +#define IOMMU_FAULT_PRIV		(1 << 3)
> > 
> >  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
> >  			struct device *, unsigned long, int, void
> > *); +typedef int (*iommu_dev_fault_handler_t)(struct
> > iommu_fault_event *, void *);
> > 
> >  struct iommu_domain_geometry {
> >  	dma_addr_t aperture_start; /* First address that can be
> > mapped    */ @@ -264,6 +268,99 @@ struct iommu_device {
> >  	struct device *dev;
> >  };
> > 
> > +/*  Generic fault types, can be expanded IRQ remapping fault */
> > +enum iommu_fault_type {
> > +	IOMMU_FAULT_DMA_UNRECOV = 1,	/* unrecoverable fault
> > */
> > +	IOMMU_FAULT_PAGE_REQ,		/* page request fault
> > */ +};
> > +
> > +enum iommu_fault_reason {
> > +	IOMMU_FAULT_REASON_UNKNOWN = 0,
> > +
> > +	/* IOMMU internal error, no specific reason to report out
> > */
> > +	IOMMU_FAULT_REASON_INTERNAL,
> > +
> > +	/* Could not access the PASID table */
> > +	IOMMU_FAULT_REASON_PASID_FETCH,
> > +
> > +	/*
> > +	 * PASID is out of range (e.g. exceeds the maximum PASID
> > +	 * supported by the IOMMU) or disabled.
> > +	 */
> > +	IOMMU_FAULT_REASON_PASID_INVALID,
> > +
> > +	/* Could not access the page directory (Invalid PASID
> > entry) */
> > +	IOMMU_FAULT_REASON_PGD_FETCH,
> > +
> > +	/* Could not access the page table entry (Bad address) */
> > +	IOMMU_FAULT_REASON_PTE_FETCH,
> > +
> > +	/* Protection flag check failed */
> > +	IOMMU_FAULT_REASON_PERMISSION,
> > +};
> > +
> > +/**
> > + * struct iommu_fault_event - Generic per device fault data
> > + *
> > + * - PCI and non-PCI devices
> > + * - Recoverable faults (e.g. page request), information based on
> > PCI ATS
> > + * and PASID spec.
> > + * - Un-recoverable faults of device interest
> > + * - DMA remapping and IRQ remapping faults
> > +
> > + * @type contains fault type.
> > + * @reason fault reasons if relevant outside IOMMU driver, IOMMU
> > driver internal
> > + *         faults are not reported
> > + * @addr: tells the offending page address
> > + * @pasid: contains process address space ID, used in shared
> > virtual memory(SVM)
> > + * @rid: requestor ID
> > + * @page_req_group_id: page request group index
> > + * @last_req: last request in a page request group
> > + * @pasid_valid: indicates if the PRQ has a valid PASID
> > + * @prot: page access protection flag, e.g. IOMMU_FAULT_READ,
> > IOMMU_FAULT_WRITE
> > + * @device_private: if present, uniquely identify device-specific
> > + *                  private data for an individual page request.
> > + * @iommu_private: used by the IOMMU driver for storing
> > fault-specific
> > + *                 data. Users should not modify this field before
> > + *                 sending the fault response.
> > + */
> > +struct iommu_fault_event {
> > +	enum iommu_fault_type type;
> > +	enum iommu_fault_reason reason;
> > +	u64 addr;
> > +	u32 pasid;
> > +	u32 page_req_group_id;
> > +	u32 last_req : 1;
> > +	u32 pasid_valid : 1;
> > +	u32 prot;  
> 
> I think userspace also needs to know the fault type, reason, pasid,
> addr, goup_id, prot. So the definition should be included in
> uapi/Linux/iommu.h.
> 
> This comment also applies to "struct page_response_msg". Qemu also
> wants to pass the page response to host.
> 
sounds good. i assume vfio layer would reuse these data.
> > +	u64 device_private;
> > +	u64 iommu_private;  
> 
> These two seems to be in kernel driver specific data. May split the
> iommu_fault_event definition into two parts. One part for the data
> required by both driver and userspace. One part for in kernel driver
> specific data.
> 
even device and iommu private data can be potentially consumed by the
guest kernel for some special processing. But for now, we just copy
back to the response message. e.g. vt-d streaming page response
request is embedded in the iommu private data.

> Thanks,
> Yi Liu
> 

[Jacob Pan]

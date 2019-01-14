Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09F9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF2620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfANWaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:30:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:55534 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfANWaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:30:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:30:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="267103865"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 14 Jan 2019 14:30:19 -0800
Date:   Mon, 14 Jan 2019 14:32:08 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Eric Auger <eric.auger@redhat.com>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [RFC v3 14/21] iommu: introduce device fault data
Message-ID: <20190114143208.66eac25a@jacob-builder>
In-Reply-To: <63a19100-c3dd-9dbd-b37a-9dfbe254459e@arm.com>
References: <20190108102633.17482-1-eric.auger@redhat.com>
        <20190108102633.17482-15-eric.auger@redhat.com>
        <20190110104544.26f3bcb1@jacob-builder>
        <63a19100-c3dd-9dbd-b37a-9dfbe254459e@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 11:06:29 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> On 10/01/2019 18:45, Jacob Pan wrote:
> > On Tue,  8 Jan 2019 11:26:26 +0100
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>
> >> Device faults detected by IOMMU can be reported outside IOMMU
> >> subsystem for further processing. This patch intends to provide
> >> a generic device fault data such that device drivers can be
> >> communicated with IOMMU faults without model specific knowledge.
> >>
> >> The proposed format is the result of discussion at:
> >> https://lkml.org/lkml/2017/11/10/291
> >> Part of the code is based on Jean-Philippe Brucker's patchset
> >> (https://patchwork.kernel.org/patch/9989315/).
> >>
> >> The assumption is that model specific IOMMU driver can filter and
> >> handle most of the internal faults if the cause is within IOMMU
> >> driver control. Therefore, the fault reasons can be reported are
> >> grouped and generalized based common specifications such as PCI
> >> ATS.
> >>
> >> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >> Signed-off-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com> Signed-off-by: Liu, Yi L
> >> <yi.l.liu@linux.intel.com> Signed-off-by: Ashok Raj
> >> <ashok.raj@intel.com> Signed-off-by: Eric Auger
> >> <eric.auger@redhat.com> [moved part of the iommu_fault_event
> >> struct in the uapi, enriched the fault reasons to be able to map
> >> unrecoverable SMMUv3 errors] ---
> >>  include/linux/iommu.h      | 55 ++++++++++++++++++++++++-
> >>  include/uapi/linux/iommu.h | 83
> >> ++++++++++++++++++++++++++++++++++++++ 2 files changed, 136
> >> insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index 244c1a3d5989..1dedc2d247c2 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -49,13 +49,17 @@ struct bus_type;
> >>  struct device;
> >>  struct iommu_domain;
> >>  struct notifier_block;
> >> +struct iommu_fault_event;
> >>  
> >>  /* iommu fault flags */
> >> -#define IOMMU_FAULT_READ	0x0
> >> -#define IOMMU_FAULT_WRITE	0x1
> >> +#define IOMMU_FAULT_READ		(1 << 0)
> >> +#define IOMMU_FAULT_WRITE		(1 << 1)
> >> +#define IOMMU_FAULT_EXEC		(1 << 2)
> >> +#define IOMMU_FAULT_PRIV		(1 << 3)
> >>  
> >>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
> >>  			struct device *, unsigned long, int, void
> >> *); +typedef int (*iommu_dev_fault_handler_t)(struct
> >> iommu_fault_event *, void *); 
> >>  struct iommu_domain_geometry {
> >>  	dma_addr_t aperture_start; /* First address that can be
> >> mapped    */ @@ -255,6 +259,52 @@ struct iommu_device {
> >>  	struct device *dev;
> >>  };
> >>  
> >> +/**
> >> + * struct iommu_fault_event - Generic per device fault data
> >> + *
> >> + * - PCI and non-PCI devices
> >> + * - Recoverable faults (e.g. page request), information based on
> >> PCI ATS
> >> + * and PASID spec.
> >> + * - Un-recoverable faults of device interest
> >> + * - DMA remapping and IRQ remapping faults
> >> + *
> >> + * @fault: fault descriptor
> >> + * @device_private: if present, uniquely identify device-specific
> >> + *                  private data for an individual page request.
> >> + * @iommu_private: used by the IOMMU driver for storing
> >> fault-specific
> >> + *                 data. Users should not modify this field before
> >> + *                 sending the fault response.
> >> + */
> >> +struct iommu_fault_event {
> >> +	struct iommu_fault fault;
> >> +	u64 device_private;  
> > I think we want to move device_private to uapi since it gets
> > injected into the guest, then returned by guest in case of page
> > response. For VT-d we also need 128 bits of private data. VT-d
> > spec. 7.7.1  
> 
> Ah, I didn't notice the format changed in VT-d rev3. On that topic,
> how do we manage future extensions to the iommu_fault struct? Should
> we add ~48 bytes of padding after device_private, along with some
> flags telling which field is valid, or deal with it using a structure
> version like we do for the invalidate and bind structs? In the first
> case, iommu_fault wouldn't fit in a 64-byte cacheline anymore, but
> I'm not sure we care.
> 
IMHO, I like version and padding. I don't see a need for flags once we
have version.

> > For exception tracking (e.g. unanswered page request), I can add
> > timer and list info later when I include PRQ. sounds ok?  
> >> +	u64 iommu_private;  
> [...]
> >> +/**
> >> + * struct iommu_fault - Generic fault data
> >> + *
> >> + * @type contains fault type
> >> + * @reason fault reasons if relevant outside IOMMU driver.
> >> + * IOMMU driver internal faults are not reported.
> >> + * @addr: tells the offending page address
> >> + * @fetch_addr: tells the address that caused an abort, if any
> >> + * @pasid: contains process address space ID, used in shared
> >> virtual memory
> >> + * @page_req_group_id: page request group index
> >> + * @last_req: last request in a page request group
> >> + * @pasid_valid: indicates if the PRQ has a valid PASID
> >> + * @prot: page access protection flag:
> >> + *	IOMMU_FAULT_READ, IOMMU_FAULT_WRITE
> >> + */
> >> +
> >> +struct iommu_fault {
> >> +	__u32	type;   /* enum iommu_fault_type */
> >> +	__u32	reason; /* enum iommu_fault_reason */
> >> +	__u64	addr;
> >> +	__u64	fetch_addr;
> >> +	__u32	pasid;
> >> +	__u32	page_req_group_id;
> >> +	__u32	last_req;
> >> +	__u32	pasid_valid;
> >> +	__u32	prot;
> >> +	__u32	access;  
> 
> What does @access contain? Can it be squashed into @prot?
> 
I agreed.

how about this?
#define IOMMU_FAULT_VERSION_V1 0x1
struct iommu_fault {
	__u16 version;
	__u16 type;
	__u32 reason;
	__u64 addr;
	__u32 pasid;
	__u32 page_req_group_id;
	__u32 last_req : 1;
	__u32 pasid_valid : 1;
	__u32 prot;
	__u64 device_private[2];
	__u8 padding[48];
};


> Thanks,
> Jean
> 
> > relocated to uapi, Yi can you confirm?
> > 	__u64 device_private[2];
> >   
> >> +};
> >>  #endif /* _UAPI_IOMMU_H */  
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >   
> 

[Jacob Pan]

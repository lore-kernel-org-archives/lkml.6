Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B1C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CCB208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CCB208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbeH1JCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:02:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:24747 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1JCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:02:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 22:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="scan'208";a="78884947"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2018 22:12:28 -0700
Date:   Mon, 27 Aug 2018 22:14:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Yi L <yi.l.liu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Liu@mail.linuxfoundation.org, Jean Delvare <khali@linux-fr.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 01/23] iommu: introduce bind_pasid_table API function
Message-ID: <20180827221422.57e233df@jacob-builder>
In-Reply-To: <b6621306-fd32-7ede-ae88-7345898eb134@redhat.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <b6621306-fd32-7ede-ae88-7345898eb134@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 17:00:51 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 05/11/2018 10:53 PM, Jacob Pan wrote:
> > Virtual IOMMU was proposed to support Shared Virtual Memory (SVM)
> > use in the guest:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> > 
> > As part of the proposed architecture, when an SVM capable PCI
> > device is assigned to a guest, nested mode is turned on. Guest owns
> > the first level page tables (request with PASID) which performs
> > GVA->GPA translation. Second level page tables are owned by the
> > host for GPA->HPA translation for both request with and without
> > PASID.
> > 
> > A new IOMMU driver interface is therefore needed to perform tasks as
> > follows:
> > * Enable nested translation and appropriate translation type
> > * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> > 
> > This patch introduces new API functions to perform bind/unbind
> > guest PASID tables. Based on common data, model specific IOMMU
> > drivers can be extended to perform the specific steps for binding
> > pasid table of assigned devices.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c      | 19 +++++++++++++++++++
> >  include/linux/iommu.h      | 24 ++++++++++++++++++++++++
> >  include/uapi/linux/iommu.h | 33 +++++++++++++++++++++++++++++++++
> >  3 files changed, 76 insertions(+)
> >  create mode 100644 include/uapi/linux/iommu.h
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index d2aa2320..3a69620 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1325,6 +1325,25 @@ int iommu_attach_device(struct iommu_domain
> > *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +int iommu_bind_pasid_table(struct iommu_domain *domain, struct
> > device *dev,
> > +			struct pasid_table_config *pasidt_binfo)  
> As Jean-Philippe, I must confessed i am very confused by having both
> the iommu_domain and dev passed as argument.
> 
> I know this was discussed when the RFC was submitted and maybe I
> missed the main justification behind that choice. I understand that
> at the HW level we want to change the context entry or ARM CD in my
> case for a specific device. But on other hand, at the logical level,
> I understand the iommu_domain is representing a set of translation
> config & page tables shared by all the devices within the domain
> (hope this is fundamentally correct ?!). So to me we can't change the
> device translation setup without changing the whole iommu_device setup
> otherwise this would mean this device has a translation configuration
> that is not consistent anymore with the other devices in the same
> domain. Is that correct? So can't we only keep the iommu_domain arg?
> 
I agree with you on your understanding of HW and logical level. I think
there is a new twist to the definition of domain introduced by having
PASID and vSVA. Up until now, domain only means 2nd level mapping. In
that sense, bind guest PASID table does not alter domain. For VT-d 2.5
spec. implementation of the bind_pasid_table(), we needed some per
device data, also flags such as indication for IO page fault handling.

Anyway, for the new VT-d 3.0 spec. we no longer need this API. In
stead, I will introduce bind_guest_pasid() API, where per device PASID
table is allocated by the host.

> > +{
> > +	if (unlikely(!domain->ops->bind_pasid_table))
> > +		return -ENODEV;
> > +
> > +	return domain->ops->bind_pasid_table(domain, dev,
> > pasidt_binfo); +}
> > +EXPORT_SYMBOL_GPL(iommu_bind_pasid_table);
> > +
> > +void iommu_unbind_pasid_table(struct iommu_domain *domain, struct
> > device *dev) +{
> > +	if (unlikely(!domain->ops->unbind_pasid_table))
> > +		return;
> > +
> > +	domain->ops->unbind_pasid_table(domain, dev);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 19938ee..5199ca4 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -25,6 +25,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/err.h>
> >  #include <linux/of.h>
> > +#include <uapi/linux/iommu.h>
> >  
> >  #define IOMMU_READ	(1 << 0)
> >  #define IOMMU_WRITE	(1 << 1)
> > @@ -187,6 +188,8 @@ struct iommu_resv_region {
> >   * @domain_get_windows: Return the number of windows for a domain
> >   * @of_xlate: add OF master IDs to iommu grouping
> >   * @pgsize_bitmap: bitmap of all possible supported page sizes
> > + * @bind_pasid_table: bind pasid table pointer for guest SVM
> > + * @unbind_pasid_table: unbind pasid table pointer and restore
> > defaults */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -233,8 +236,14 @@ struct iommu_ops {
> >  	u32 (*domain_get_windows)(struct iommu_domain *domain);
> >  
> >  	int (*of_xlate)(struct device *dev, struct of_phandle_args
> > *args); +
> >  	bool (*is_attach_deferred)(struct iommu_domain *domain,
> > struct device *dev); 
> > +	int (*bind_pasid_table)(struct iommu_domain *domain,
> > struct device *dev,
> > +				struct pasid_table_config
> > *pasidt_binfo);
> > +	void (*unbind_pasid_table)(struct iommu_domain *domain,
> > +				struct device *dev);
> > +
> >  	unsigned long pgsize_bitmap;
> >  };
> >  
> > @@ -296,6 +305,10 @@ extern int iommu_attach_device(struct
> > iommu_domain *domain, struct device *dev);
> >  extern void iommu_detach_device(struct iommu_domain *domain,
> >  				struct device *dev);
> > +extern int iommu_bind_pasid_table(struct iommu_domain *domain,
> > +		struct device *dev, struct pasid_table_config
> > *pasidt_binfo); +extern void iommu_unbind_pasid_table(struct
> > iommu_domain *domain,
> > +				struct device *dev);
> >  extern struct iommu_domain *iommu_get_domain_for_dev(struct device
> > *dev); extern int iommu_map(struct iommu_domain *domain, unsigned
> > long iova, phys_addr_t paddr, size_t size, int prot);
> > @@ -696,6 +709,17 @@ const struct iommu_ops
> > *iommu_ops_from_fwnode(struct fwnode_handle *fwnode) return NULL;
> >  }
> >  
> > +static inline
> > +int iommu_bind_pasid_table(struct iommu_domain *domain, struct
> > device *dev,
> > +			struct pasid_table_config *pasidt_binfo)
> > +{
> > +	return -ENODEV;
> > +}
> > +static inline
> > +void iommu_unbind_pasid_table(struct iommu_domain *domain, struct
> > device *dev) +{
> > +}
> > +
> >  #endif /* CONFIG_IOMMU_API */
> >  
> >  #endif /* __LINUX_IOMMU_H */
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > new file mode 100644
> > index 0000000..cb2d625
> > --- /dev/null
> > +++ b/include/uapi/linux/iommu.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * IOMMU user API definitions
> > + *
> > + *
> > + * This program is free software; you can redistribute it and/or
> > modify
> > + * it under the terms of the GNU General Public License version 2
> > as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#ifndef _UAPI_IOMMU_H
> > +#define _UAPI_IOMMU_H
> > +
> > +#include <linux/types.h>
> > +
> > +/**
> > + * PASID table data used to bind guest PASID table to the host
> > IOMMU. This will
> > + * enable guest managed first level page tables.
> > + * @version: for future extensions and identification of the data
> > format
> > + * @bytes: size of this structure
> > + * @base_ptr:	PASID table pointer
> > + * @pasid_bits:	number of bits supported in the guest PASID
> > table, must be less
> > + *		or equal than the host supported PASID size.
> > + */
> > +struct pasid_table_config {
> > +	__u32 version;
> > +#define PASID_TABLE_CFG_VERSION_1 1
> > +	__u32 bytes;
> > +	__u64 base_ptr;
> > +	__u8 pasid_bits;
> > +};  
> Don't we need to index all structs with iommu_ to protect the naming
> spaces? Same comment on other patches impacting the uapi.
> 
yeah, it would be better to use iommu_ prefix, i was thinking vfio also
uses it and pasid itself is a industry standard.
> A question about the alignment. Don't we need to be 64b aligned? VFIO
> uapi structs are.
> 
I am not sure about the benefit, this is not a HW interface nor on
speed path.
> Thanks
> 
> Eric
> > +
> > +#endif /* _UAPI_IOMMU_H */
> >   

[Jacob Pan]

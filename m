Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AIpwx49oYCPx8aDthIiyniYOwQ8ZJmkf18MxmvbihPZP18SbWkWjJ8IurPOGMg1VdhHwyCfAEBc0
ARC-Seal: i=1; a=rsa-sha256; t=1524266428; cv=none;
        d=google.com; s=arc-20160816;
        b=V4jDOA+zfop1t+4QctdBkYiJ7MSF4BuTOF1b1e57LqXQI5RFppSqMWjNlBS5fT4wc4
         +TFp4sej9T2DObOpcXoRvaUbnGr6gMhmLBQLkSvkwg9zQT6YcRmI82NFgEgpcRMBescM
         5qZvM3aAxX/7LTtUkBUGBdWX3rF4uDiOGAV3zxZJmq/AsCv/q22vhKSRXV7Pxki8WeAA
         V4og84G46t80VZCzTvmhYsqBP2+0nBJi2ecdSc4T5hqd3+k3E87vG599DNoWIkOS5KWm
         qsMBrgPExoau5Z7LzX1llstjUZBPpnzJp6vuegDwW2LAUG/GTHWi89UHvpOv1H0E2sna
         ACbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=qA8gCh3s5Kuuai6S3IigKk2lGmO536IMQ3uaCV3ccgg=;
        b=KLRrMoRz6cODAp0chO/9VJJRz8I+5OfJD07EsgnVKPkmdSdEkRERD3IUYbwzDVvxUP
         MJrdZQ00n5y6bb2GYBPRcNaF25MSKltxr2tqsR6rlVg6rAiCNozURfY6CFEuCc17pS3+
         JznvPjUPMmrg2JcTPQlshAWXCSSFpmSc4bZUIJih7vZZNqRmFwqtZe/i0TC87NqKjpmZ
         oqSevNqhb2PTWYY9JDW1I63hODhsia7+UZvARuQ7Tv/hilq1COPCmpovreWEt/DTyXsB
         L3uyyaWK2JDnIPGdzY7HHwENqXQsO9krYrlxKxokY0O3A4jjGWuximPPMksP1q158PEi
         kDdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 192.55.52.120 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="35865780"
Date: Fri, 20 Apr 2018 16:22:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, "Christoph Hellwig" <hch@infradead.org>, "Lu
 Baolu" <baolu.lu@linux.intel.com>, Yi L <yi.l.liu@linux.intel.com>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 04/22] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180420162259.2d29659a@jacob-builder>
In-Reply-To: <20180417131047.0a9c310f@w520.home>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1523915351-54415-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<20180417131047.0a9c310f@w520.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940909380631347?=
X-GMAIL-MSGID: =?utf-8?q?1598309194441803150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018 13:10:47 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Mon, 16 Apr 2018 14:48:53 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Add Intel VT-d ops to the generic iommu_bind_pasid_table API
> > functions.
> > 
> > The primary use case is for direct assignment of SVM capable
> > device. Originated from emulated IOMMU in the guest, the request
> > goes through many layers (e.g. VFIO). Upon calling host IOMMU
> > driver, caller passes guest PASID table pointer (GPA) and size.
> > 
> > Device context table entry is modified by Intel IOMMU specific
> > bind_pasid_table function. This will turn on nesting mode and
> > matching translation type.
> > 
> > The unbind operation restores default context mapping.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c   | 119
> > ++++++++++++++++++++++++++++++++++++++++++
> > include/linux/dma_remapping.h |   1 + 2 files changed, 120
> > insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index a0f81a4..d8058be 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2409,6 +2409,7 @@ static struct dmar_domain
> > *dmar_insert_one_dev_info(struct intel_iommu *iommu,
> > info->ats_supported = info->pasid_supported = info->pri_supported =
> > 0; info->ats_enabled = info->pasid_enabled = info->pri_enabled = 0;
> > info->ats_qdep = 0;
> > +	info->pasid_table_bound = 0;
> >  	info->dev = dev;
> >  	info->domain = domain;
> >  	info->iommu = iommu;
> > @@ -5132,6 +5133,7 @@ static void
> > intel_iommu_put_resv_regions(struct device *dev, 
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> >  #define MAX_NR_PASID_BITS (20)
> > +#define MIN_NR_PASID_BITS (5)
> >  static inline unsigned long intel_iommu_get_pts(struct intel_iommu
> > *iommu) {
> >  	/*
> > @@ -5258,6 +5260,119 @@ struct intel_iommu
> > *intel_svm_device_to_iommu(struct device *dev) 
> >  	return iommu;
> >  }
> > +
> > +static int intel_iommu_bind_pasid_table(struct iommu_domain
> > *domain,
> > +		struct device *dev, struct pasid_table_config
> > *pasidt_binfo) +{  
> 
> Never validates pasidt_binfo->{version,bytes}
> 
good catch, will do.
> > +	struct intel_iommu *iommu;
> > +	struct context_entry *context;
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_domain_info *info;
> > +	struct pci_dev *pdev;
> > +	u8 bus, devfn, host_table_pasid_bits;
> > +	u16 did, sid;
> > +	int ret = 0;
> > +	unsigned long flags;
> > +	u64 ctx_lo;
> > +
> > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > +	if (!iommu)
> > +		return -ENODEV;
> > +	/* VT-d spec section 9.4 says pasid table size is encoded
> > as 2^(x+5) */
> > +	host_table_pasid_bits = intel_iommu_get_pts(iommu) +
> > MIN_NR_PASID_BITS;
> > +	if (!pasidt_binfo || pasidt_binfo->pasid_bits >
> > host_table_pasid_bits ||
> > +		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
> > +		pr_err("Invalid gPASID bits %d, host range %d -
> > %d\n",
> > +			pasidt_binfo->pasid_bits,
> > +			MIN_NR_PASID_BITS, host_table_pasid_bits);
> > +		return -ERANGE;
> > +	}
> > +	if (!ecap_nest(iommu->ecap)) {
> > +		dev_err(dev, "Cannot bind PASID table, no nested
> > translation\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}  
> 
> Gratuitous use of pr_err, some of these look user reachable, for
> instance can vfio know in advance the supported widths or can the user
> trigger that pr_err at will?
Yes, the current IOMMU sysfs for vt-d does show the content of
capability registers so user could know in advance whether the nested
mode is supported. But I think we are in need of some generic interface
to enumerate IOMMU features. Here I am trying to prepare for the worst.
Are you concerned about security if user can trigger that error at
will? Sorry I didn't get the point.

>  Some of these errno values are also
> maybe not as descriptive as they could be.  For instance if the iommu
> doesn't support nesting, that's not a calling argument error, that's
> an unsupported device error, right?
> 
your are right, that is not invalid argument. You mean use ENODEV?

> > +	pdev = to_pci_dev(dev);
> > +	sid = PCI_DEVID(bus, devfn);
> > +	info = dev->archdata.iommu;
> > +
> > +	if (!info) {
> > +		dev_err(dev, "Invalid device domain info\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +	if (info->pasid_table_bound) {
> > +		dev_err(dev, "Device PASID table already bound\n");
> > +		ret = -EBUSY;
> > +		goto out;
> > +	}
> > +	if (!info->pasid_enabled) {
> > +		ret = pci_enable_pasid(pdev, info->pasid_supported
> > & ~1);
> > +		if (ret) {
> > +			dev_err(dev, "Failed to enable PASID\n");
> > +			goto out;
> > +		}
> > +	}
> > +	spin_lock_irqsave(&iommu->lock, flags);
> > +	context = iommu_context_addr(iommu, bus, devfn, 0);
> > +	if (!context_present(context)) {
> > +		dev_err(dev, "Context not present\n");
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	/* Anticipate guest to use SVM and owns the first level,
> > so we turn
> > +	 * nested mode on
> > +	 */
> > +	ctx_lo = context[0].lo;
> > +	ctx_lo |= CONTEXT_NESTE | CONTEXT_PRS | CONTEXT_PASIDE;
> > +	ctx_lo &= ~CONTEXT_TT_MASK;
> > +	ctx_lo |= CONTEXT_TT_DEV_IOTLB << 2;
> > +	context[0].lo = ctx_lo;
> > +
> > +	/* Assign guest PASID table pointer and size order */
> > +	ctx_lo = (pasidt_binfo->base_ptr & VTD_PAGE_MASK) |
> > +		(pasidt_binfo->pasid_bits - MIN_NR_PASID_BITS);  
> 
> Where does this IOMMU API interface define that base_ptr is 4K
> aligned or the format of the PASID table?  Are these all standardized
> or do they vary by host IOMMU?  If they're standards, maybe we could
> note that and the spec which defines them when we declare base_ptr.
> If they're IOMMU specific then I don't understand how we'll match a
> user provided PASID table to the requirements and format of the host
> IOMMU. Thanks,
> 
follow up in the other thread with Jean.

Thanks for the review.

Jacob
> Alex
> 
> > +	context[1].lo = ctx_lo;
> > +	/* make sure context entry is updated before flushing */
> > +	wmb();
> > +	did = dmar_domain->iommu_did[iommu->seq_id];
> > +	iommu->flush.flush_context(iommu, did,
> > +				(((u16)bus) << 8) | devfn,
> > +				DMA_CCMD_MASK_NOBIT,
> > +				DMA_CCMD_DEVICE_INVL);
> > +	iommu->flush.flush_iotlb(iommu, did, 0, 0,
> > DMA_TLB_DSI_FLUSH);
> > +	info->pasid_table_bound = 1;
> > +out_unlock:
> > +	spin_unlock_irqrestore(&iommu->lock, flags);
> > +out:
> > +	return ret;
> > +}
> > +
> > +static void intel_iommu_unbind_pasid_table(struct iommu_domain
> > *domain,
> > +					struct device *dev)
> > +{
> > +	struct intel_iommu *iommu;
> > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > +	struct device_domain_info *info;
> > +	u8 bus, devfn;
> > +
> > +	info = dev->archdata.iommu;
> > +	if (!info) {
> > +		dev_err(dev, "Invalid device domain info\n");
> > +		return;
> > +	}
> > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > +	if (!iommu) {
> > +		dev_err(dev, "No IOMMU for device to unbind PASID
> > table\n");
> > +		return;
> > +	}
> > +
> > +	domain_context_clear(iommu, dev);
> > +
> > +	domain_context_mapping_one(dmar_domain, iommu, bus, devfn);
> > +	info->pasid_table_bound = 0;
> > +}
> >  #endif /* CONFIG_INTEL_IOMMU_SVM */
> >  
> >  const struct iommu_ops intel_iommu_ops = {
> > @@ -5266,6 +5381,10 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.domain_free		= intel_iommu_domain_free,
> >  	.attach_dev		= intel_iommu_attach_device,
> >  	.detach_dev		= intel_iommu_detach_device,
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +	.bind_pasid_table	= intel_iommu_bind_pasid_table,
> > +	.unbind_pasid_table	=
> > intel_iommu_unbind_pasid_table, +#endif
> >  	.map			= intel_iommu_map,
> >  	.unmap			= intel_iommu_unmap,
> >  	.map_sg			= default_iommu_map_sg,
> > diff --git a/include/linux/dma_remapping.h
> > b/include/linux/dma_remapping.h index 21b3e7d..db290b2 100644
> > --- a/include/linux/dma_remapping.h
> > +++ b/include/linux/dma_remapping.h
> > @@ -28,6 +28,7 @@
> >  
> >  #define CONTEXT_DINVE		(1ULL << 8)
> >  #define CONTEXT_PRS		(1ULL << 9)
> > +#define CONTEXT_NESTE		(1ULL << 10)
> >  #define CONTEXT_PASIDE		(1ULL << 11)
> >  
> >  struct intel_iommu;  
> 

[Jacob Pan]

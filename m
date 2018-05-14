Return-Path: <jacob.jun.pan@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqHJyVaHqMOkHnmuUboa5Ps7QOMtfrhP4AJ/vrRzuDiCIhkDvfmEsgA7gbJ4l/Zx+OYBIk5
ARC-Seal: i=1; a=rsa-sha256; t=1526329207; cv=none;
        d=google.com; s=arc-20160816;
        b=B38724RadZvgEROtdVkPBaCR88ljo9AuG/10SJZRjQm8i5nsHc5JUF9wuAp5USbADW
         YybFQnVNCzydeNIxlCK1KgKZOE7Ay3HtTULWd7vep1ycUgwUnHqsWiGIwHk7hgSDI8kZ
         PjOMKxw2VKj/4rm8IqM76ltublcHKU7HOOzqJckcAnbYkWZvJDttIchw0nanOuGjzU/O
         aFzVgdMuCG6U2Bu7c6laYYhiIUmNMbxxhOLssjUU58eBgukowzm8Xfh+x67mj/KJhIi8
         mBEeUaFMb+2azdwTf9kYaBGUAzFikzemf+WHN2tiClsU1lwngghqRE4Nj8RrVaKdNSu8
         /XGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=szimcUplbUVwBgxK8PDXeIt2CapM6915Jyt0eMbri1c=;
        b=fi+7ykrUrsefxo+GhhdqYzOo0LyGA4FNRrQ16WT291j11M0VX6x7hpM0idCF2waF8Q
         7/yqf53Mc0FxGdDGXMUHbh7wTu+7k+69cUWSapLezUDAXm5s7H/Zuckp4Z42N/x03v7e
         fupWv9bybHgWxBs/KLlxZnOcvEe1g4HlC9Q4j4RZZ4a1hWdWvavfhNrF/wRJU/xeDkR4
         8YGgjGnNJj8oa/EDzFP5Ku2CJpn40U9qRbnH/zcy3bIgFqiRmrmwkAeodPeg5eEUXggU
         QJycGaIoHPVX5RuEfdAlwF7mTeitNdyM4MpoG154jwm6mb7HyT7uLiGe/P39rh5GU0Og
         jkZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jacob.jun.pan@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jacob.jun.pan@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="55851079"
Date: Mon, 14 May 2018 13:22:53 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Williamson
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe.brucker@arm.com>, Rafael Wysocki
 <rafael.j.wysocki@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Jean
 Delvare <khali@linux-fr.org>, Christoph Hellwig <hch@infradead.org>,
 jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 04/23] iommu/vt-d: add bind_pasid_table function
Message-ID: <20180514132253.1472bbbf@jacob-builder>
In-Reply-To: <5AF8058B.4090703@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1526072055-86990-5-git-send-email-jacob.jun.pan@linux.intel.com>
	<5AF8058B.4090703@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600202361435281537?=
X-GMAIL-MSGID: =?utf-8?q?1600472174547064069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 13 May 2018 17:29:47 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:53 AM, Jacob Pan wrote:
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
> >  drivers/iommu/intel-iommu.c   | 122
> > ++++++++++++++++++++++++++++++++++++++++++
> > include/linux/dma_remapping.h |   1 + 2 files changed, 123
> > insertions(+)
> >
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index a0f81a4..4623294 100644
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
> > @@ -5258,6 +5260,122 @@ struct intel_iommu
> > *intel_svm_device_to_iommu(struct device *dev) 
> >  	return iommu;
> >  }
> > +
> > +static int intel_iommu_bind_pasid_table(struct iommu_domain
> > *domain,
> > +		struct device *dev, struct pasid_table_config
> > *pasidt_binfo) +{
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
> 
> I personally prefer to have this in order.
> 
>         struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>         u8 bus, devfn, host_table_pasid_bits;
>         struct device_domain_info *info;
>         struct context_entry *context;
>         struct intel_iommu *iommu;
>         struct pci_dev *pdev;
>         unsigned long flags;
>         u16 did, sid;
>         int ret = 0;
>         u64 ctx_lo;
> 
looks better.
> > +
> > +	if ((pasidt_binfo->version != PASID_TABLE_CFG_VERSION_1)
> > ||  
> 
> Unnecessary parentheses.
> 
here for readability.
> > +		pasidt_binfo->bytes != sizeof(*pasidt_binfo))  
> 
> Alignment should match open parenthesis.
> 
> > +		return -EINVAL;
> > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > +	if (!iommu)
> > +		return -ENODEV;
> > +	/* VT-d spec section 9.4 says pasid table size is encoded
> > as 2^(x+5) */
> > +	host_table_pasid_bits = intel_iommu_get_pts(iommu) +
> > MIN_NR_PASID_BITS;
> > +	if (!pasidt_binfo || pasidt_binfo->pasid_bits >
> > host_table_pasid_bits ||  
> 
> "!pasidt_binfo" checking should be moved up to the version checking.
> 
good point!
> > +		pasidt_binfo->pasid_bits < MIN_NR_PASID_BITS) {
> > +		pr_err("Invalid gPASID bits %d, host range %d -
> > %d\n",  
> 
> How about dev_err()? 
> 
the error is not exactly specific to the device but rather the guest.
> > +			pasidt_binfo->pasid_bits,
> > +			MIN_NR_PASID_BITS, host_table_pasid_bits);
> > +		return -ERANGE;
> > +	}
> > +	if (!ecap_nest(iommu->ecap)) {
> > +		dev_err(dev, "Cannot bind PASID table, no nested
> > translation\n");
> > +		ret = -ENODEV;
> > +		goto out;  
> 
> How about
> +        return -ENODEV;
> ?
> 
> > +	}
> > +	pdev = to_pci_dev(dev);  
> 
> We can't always assume that it is a PCI device, right?
> 
for vt-d, I don't think we expect any non-pci device.
> > +	sid = PCI_DEVID(bus, devfn);
> > +	info = dev->archdata.iommu;
> > +
> > +	if (!info) {
> > +		dev_err(dev, "Invalid device domain info\n");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +	if (info->pasid_table_bound) {  
> 
> We should do this checking with lock hold.
> 
agreed. will hold the device_domain_lock.
> Otherwise,
> 
> Thread A on CPUx                Thread B on CPUy
> ===========                ============
> check pasid_table_bound    check pasid_table_bound
> 
> mutex_lock()
> Setup context
> pasid_table_bound = 1
> mutex_unlock()
> 
>                                                mutex_lock()
>                                                Setup context
>                                                pasid_table_bound = 1
>                                                mutex_unlock()
> 
> 
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
> 
> I prefer a blank line here.
> 
>  [...]  
> 
> Best regards,
> Lu Baolu

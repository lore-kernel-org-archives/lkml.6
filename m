Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965380AbeE2Raq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:30:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:49533 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965010AbeE2Rap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:30:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="45693057"
Date: Tue, 29 May 2018 10:33:39 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 17/23] iommu/vt-d: report non-recoverable faults to
 device
Message-ID: <20180529103339.7b214b0e@jacob-builder>
In-Reply-To: <5AF94618.2080403@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-18-git-send-email-jacob.jun.pan@linux.intel.com>
        <5AF94618.2080403@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 16:17:28 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > Currently, dmar fault IRQ handler does nothing more than rate
> > limited printk, no critical hardware handling need to be done
> > in IRQ context.  
> 
> Not exactly. dmar_fault() needs to clear all the faults so that
> the subsequent faults could be logged.
True, but this is standard IRQ handling. Moving to threaded IRQ should
not be causing any functional problems, this is what I am trying to say.
> 
> > For some use case such as vIOMMU, it might be useful to report
> > non-recoverable faults outside host IOMMU subsystem. DMAR fault
> > can come from both DMA and interrupt remapping which has to be
> > set up early before threaded IRQ is available.
> > This patch adds an option and a workqueue such that when faults
> > are requested, DMAR fault IRQ handler can use the IOMMU fault
> > reporting API to report.
> >
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > ---
> >  drivers/iommu/dmar.c        | 159
> > ++++++++++++++++++++++++++++++++++++++++++--
> > drivers/iommu/intel-iommu.c |   6 +- include/linux/dmar.h
> > |   2 +- include/linux/intel-iommu.h |   1 +
> >  4 files changed, 159 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 0b5b052..ef846e3 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1110,6 +1110,12 @@ static int alloc_iommu(struct dmar_drhd_unit
> > *drhd) return err;
> >  }
> >  
> > +static inline void dmar_free_fault_wq(struct intel_iommu *iommu)
> > +{
> > +	if (iommu->fault_wq)
> > +		destroy_workqueue(iommu->fault_wq);
> > +}
> > +
> >  static void free_iommu(struct intel_iommu *iommu)
> >  {
> >  	if (intel_iommu_enabled) {
> > @@ -1126,6 +1132,7 @@ static void free_iommu(struct intel_iommu
> > *iommu) free_irq(iommu->irq, iommu);
> >  		dmar_free_hwirq(iommu->irq);
> >  		iommu->irq = 0;
> > +		dmar_free_fault_wq(iommu);
> >  	}
> >  
> >  	if (iommu->qi) {
> > @@ -1554,6 +1561,31 @@ static const char *irq_remap_fault_reasons[]
> > = "Blocked an interrupt request due to source-id verification
> > failure", };
> >  
> > +/* fault data and status */
> > +enum intel_iommu_fault_reason {
> > +	INTEL_IOMMU_FAULT_REASON_SW,
> > +	INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT,
> > +	INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT,
> > +	INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID,
> > +	INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH,
> > +	INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS,
> > +	INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS,
> > +	INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID,
> > +	INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID,
> > +	INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID,
> > +	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_RTP,
> > +	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_CTP,
> > +	INTEL_IOMMU_FAULT_REASON_NONE_ZERO_PTE,
> > +	NR_INTEL_IOMMU_FAULT_REASON,
> > +};
> > +
> > +/* fault reasons that are allowed to be reported outside IOMMU
> > subsystem */ +#define
> > INTEL_IOMMU_FAULT_REASON_ALLOWED			\
> > +	((1ULL << INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH)
> > |	\
> > +		(1ULL <<
> > INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS) |	\
> > +		(1ULL << INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS))
> > +
> > +
> >  static const char *dmar_get_fault_reason(u8 fault_reason, int
> > *fault_type) {
> >  	if (fault_reason >= 0x20 && (fault_reason - 0x20 <
> > @@ -1634,11 +1666,91 @@ void dmar_msi_read(int irq, struct msi_msg
> > *msg) raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
> >  }
> >  
> > +static enum iommu_fault_reason to_iommu_fault_reason(u8 reason)
> > +{
> > +	if (reason >= NR_INTEL_IOMMU_FAULT_REASON) {
> > +		pr_warn("unknown DMAR fault reason %d\n", reason);
> > +		return IOMMU_FAULT_REASON_UNKNOWN;
> > +	}
> > +	switch (reason) {
> > +	case INTEL_IOMMU_FAULT_REASON_SW:
> > +	case INTEL_IOMMU_FAULT_REASON_ROOT_NOT_PRESENT:
> > +	case INTEL_IOMMU_FAULT_REASON_CONTEXT_NOT_PRESENT:
> > +	case INTEL_IOMMU_FAULT_REASON_CONTEXT_INVALID:
> > +	case INTEL_IOMMU_FAULT_REASON_BEYOND_ADDR_WIDTH:
> > +	case INTEL_IOMMU_FAULT_REASON_ROOT_ADDR_INVALID:
> > +	case INTEL_IOMMU_FAULT_REASON_CONTEXT_PTR_INVALID:
> > +		return IOMMU_FAULT_REASON_INTERNAL;
> > +	case INTEL_IOMMU_FAULT_REASON_NEXT_PT_INVALID:
> > +	case INTEL_IOMMU_FAULT_REASON_PTE_WRITE_ACCESS:
> > +	case INTEL_IOMMU_FAULT_REASON_PTE_READ_ACCESS:
> > +		return IOMMU_FAULT_REASON_PERMISSION;
> > +	default:
> > +		return IOMMU_FAULT_REASON_UNKNOWN;
> > +	}
> > +}
> > +
> > +struct dmar_fault_work {
> > +	struct work_struct fault_work;
> > +	struct intel_iommu *iommu;
> > +	u64 addr;
> > +	int type;
> > +	int fault_type;
> > +	enum intel_iommu_fault_reason reason;
> > +	u16 sid;
> > +};
> > +
> > +static void report_fault_to_device(struct work_struct *work)
> > +{
> > +	struct dmar_fault_work *dfw = container_of(work, struct
> > dmar_fault_work,
> > +						fault_work);
> > +	struct iommu_fault_event event;
> > +	struct pci_dev *pdev;
> > +	u8 bus, devfn;
> > +
> > +	memset(&event, 0, sizeof(struct iommu_fault_event));
> > +
> > +	/* check if fault reason is permitted to report outside
> > IOMMU */
> > +	if (!((1 << dfw->reason) &
> > INTEL_IOMMU_FAULT_REASON_ALLOWED)) {
> > +		pr_debug("Fault reason %d not allowed to report to
> > device\n",
> > +			dfw->reason);  
> 
> No need to print this message. And how about moving this check ahead
> before queue the work?
> 
Good point. rest of the points taken. Thanks!
>  [...]  
> 
> No need to print this warn message.
> 
>  [...]  
> 
> No need to add braces.
> 
> > +
> > +	dfw = kmalloc(sizeof(*dfw), GFP_ATOMIC);
> > +	if (!dfw)
> > +		return -ENOMEM;
> > +
> > +	INIT_WORK(&dfw->fault_work, report_fault_to_device);
> > +	dfw->addr = addr;
> > +	dfw->type = type;
> > +	dfw->fault_type = fault_type;
> > +	dfw->reason = fault_reason;
> > +	dfw->sid = source_id;
> > +	dfw->iommu = iommu;
> > +	if (!queue_work(iommu->fault_wq, &dfw->fault_work)) {  
> 
> Check whether this fault is allowed to report to device before
> queuing the work.
> 
>  [...]  
> 
> Best regards,
> Lu Baolu

[Jacob Pan]

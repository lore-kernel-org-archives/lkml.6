Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935667AbeE2QK3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:10:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:63080 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935324AbeE2QKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:10:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="45114413"
Date: Tue, 29 May 2018 09:13:19 -0700
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
Subject: Re: [PATCH v5 14/23] iommu: introduce page response function
Message-ID: <20180529091319.544d2e57@jacob-builder>
In-Reply-To: <5AF92F37.3050404@linux.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-15-git-send-email-jacob.jun.pan@linux.intel.com>
        <5AF92F37.3050404@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 14:39:51 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 05/12/2018 04:54 AM, Jacob Pan wrote:
> > IO page faults can be handled outside IOMMU subsystem. For an
> > example, when nested translation is turned on and guest owns the
> > first level page tables, device page request can be forwared
> > to the guest for handling faults. As the page response returns
> > by the guest, IOMMU driver on the host need to process the
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
> > +			kfree(evt);
> > +			break;
> > +		}
> > +	}  
> 
> Are above two checks duplicated? We won't find a matching
> request if the list is empty. And we need to  printk a message
> if we can't find the matching request.
> 
sorry about the delay. I am not sure which two checks, we only search
for pending page request if the list is not empty.
Yes, it is a good idea to print out warning if the page response has no
match request.
> Best regards,
> Lu Baolu
> 
>  [...]  
> 

[Jacob Pan]

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeEQP4X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:56:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:33658 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeEQP4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:56:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,411,1520924400";
   d="scan'208";a="41775716"
Date: Thu, 17 May 2018 08:59:09 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 13/23] iommu: introduce device fault report API
Message-ID: <20180517085909.7470dfb5@jacob-builder>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
References: <1526072055-86990-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1526072055-86990-14-git-send-email-jacob.jun.pan@linux.intel.com>
        <A2975661238FB949B60364EF0F2C257439BF2537@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 11:41:56 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > +int iommu_report_device_fault(struct device *dev, struct
> > +iommu_fault_event *evt) {
> > +	int ret = 0;
> > +	struct iommu_fault_event *evt_pending;
> > +	struct iommu_fault_param *fparam;
> > +
> > +	/* iommu_param is allocated when device is added to group
> > */
> > +	if (!dev->iommu_param | !evt)
> > +		return -EINVAL;
> > +	/* we only report device fault if there is a handler
> > registered */
> > +	mutex_lock(&dev->iommu_param->lock);
> > +	if (!dev->iommu_param->fault_param ||
> > +		!dev->iommu_param->fault_param->handler) {
> > +		ret = -EINVAL;
> > +		goto done_unlock;
> > +	}
> > +	fparam = dev->iommu_param->fault_param;
> > +	if (evt->type == IOMMU_FAULT_PAGE_REQ && evt->last_req) {
> > +		evt_pending = kmemdup(evt, sizeof(struct
> > iommu_fault_event),
> > +				GFP_KERNEL);
> > +		if (!evt_pending) {
> > +			ret = -ENOMEM;
> > +			goto done_unlock;
> > +		}
> > +		mutex_lock(&fparam->lock);
> > +		list_add_tail(&evt_pending->list,
> > &fparam->faults);  
> 
> I may missed it. Here only see list add, how about removing? Who
> would remove entry from the fault list?
> 
deletion of the pending event is in page response function (int
iommu_page_response), once iommu driver finds a matching response for
the pending request, it will delete the pending event.

if the response never came, right now we don't delete it, just gives
warning.

> > +		mutex_unlock(&fparam->lock);
> > +	}
> > +	ret = fparam->handler(evt, fparam->data);  
> 
> I remember you mentioned there will be a queue to store the faults.
> Is it in the fparam->faults list? Or there is no such queue?
There are two use cases:
case A: guest SVA, PRQ events are reported outside IOMMU subsystem,
	e.g. vfio
case B: in-kernel

The io page fault queuing is Jean's patchset, mostly for case
B (in-kernel IO page fault handling). I will convert intel-svm to Jean's
io page fault mechanism so that we can also have parallel and out of
order queuing of PRQ. I still need some time to evaluate intel specific
needs such as streaming page request/response.

For case A, there is no queuing in host IOMMU driver. My understanding
of the flow is as the following:
1. host IOMMU receives PRQ
2. host IOMMU driver reports PRQ fault event to registered called, i.e.
vfio
3. VFIO reports fault event to QEMU
4. QEMU injects PRQ to guest
5. Guest IOMMU driver receives PRQ in IRQ
6. Guest IOMMU driver queue PRQ by groups, PASID.
So as long as in-kernel PRQ handling can do queuing, there is no need
for queuing in the host reporting path.

Jacob

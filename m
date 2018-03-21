Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeCUDal convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:30:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:63608 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751581AbeCUDai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:30:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="39233851"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 2/7] vfio/type1: Check reserve region conflict and
 update iova list
Thread-Topic: [PATCH v5 2/7] vfio/type1: Check reserve region conflict and
 update iova list
Thread-Index: AQHTwJwcNZfimSid2kSB3RzWbTA2BqPaCCZw
Date: Wed, 21 Mar 2018 03:30:29 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191089B3B@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
        <20180315163509.17740-3-shameerali.kolothum.thodi@huawei.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D1910857ED@SHSMSX101.ccr.corp.intel.com>
 <20180320163744.3c09fde0@t450s.home>
In-Reply-To: <20180320163744.3c09fde0@t450s.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmZlMTBmNmQtYmRjYy00N2I0LTg1MDktMTA2MDBhYzI5NzgwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6Imk2aEhtcldzbzJhR25WamxidGc3elFEXC9RYkNId20zMEt3b293RXU3K01VPSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, March 21, 2018 6:38 AM
> 
> On Mon, 19 Mar 2018 07:51:58 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Shameer Kolothum
> > > Sent: Friday, March 16, 2018 12:35 AM
> > >
> > > This retrieves the reserved regions associated with dev group and
> > > checks for conflicts with any existing dma mappings. Also update
> > > the iova list excluding the reserved regions.
> > >
> > > Signed-off-by: Shameer Kolothum
> > > <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 90
> > > +++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > > b/drivers/vfio/vfio_iommu_type1.c
> > > index 1123c74..cfe2bb2 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -1313,6 +1313,82 @@ static int vfio_iommu_aper_resize(struct
> > > list_head *iova,
> > >  	return 0;
> > >  }
> > >
> > > +/*
> > > + * Check reserved region conflicts with existing dma mappings
> > > + */
> > > +static bool vfio_iommu_resv_conflict(struct vfio_iommu *iommu,
> > > +				struct list_head *resv_regions)
> > > +{
> > > +	struct iommu_resv_region *region;
> > > +
> > > +	/* Check for conflict with existing dma mappings */
> > > +	list_for_each_entry(region, resv_regions, list) {
> > > +		if (vfio_find_dma(iommu, region->start, region->length))
> > > +			return true;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +/*
> > > + * Check iova region overlap with  reserved regions and
> > > + * exclude them from the iommu iova range
> > > + */
> > > +static int vfio_iommu_resv_exclude(struct list_head *iova,
> > > +					struct list_head *resv_regions)
> > > +{
> > > +	struct iommu_resv_region *resv;
> > > +	struct vfio_iova *n, *next;
> > > +
> > > +	list_for_each_entry(resv, resv_regions, list) {
> > > +		phys_addr_t start, end;
> > > +
> > > +		start = resv->start;
> > > +		end = resv->start + resv->length - 1;
> > > +
> > > +		list_for_each_entry_safe(n, next, iova, list) {
> > > +			int ret = 0;
> > > +
> > > +			/* No overlap */
> > > +			if ((start > n->end) || (end < n->start))
> > > +				continue;
> > > +			/*
> > > +			 * Insert a new node if current node overlaps with
> > > the
> > > +			 * reserve region to exlude that from valid iova
> > > range.
> > > +			 * Note that, new node is inserted before the
> > > current
> > > +			 * node and finally the current node is deleted
> > > keeping
> > > +			 * the list updated and sorted.
> > > +			 */
> > > +			if (start > n->start)
> > > +				ret = vfio_iommu_iova_insert(&n->list,
> > > +							n->start, start - 1);
> > > +			if (!ret && end < n->end)
> > > +				ret = vfio_iommu_iova_insert(&n->list,
> > > +							end + 1, n->end);
> > > +			if (ret)
> > > +				return ret;
> >
> > Is it safer to delete the 1st node here in case of failure of the 2nd node?
> > There is no problem with current logic since upon error iova_copy will
> > be released anyway. However this function alone doesn't assume the
> > fact of a temporary list, thus it's better to keep the list clean w/o garbage
> > left from any error handling.
> 
> I don't think the proposal makes the list notably more sane on failure
> than we have here.  If the function returns an error and the list is
> modified in any way, how can the caller recover?  We're operating on a
> principle of modify a copy and throw it away on error, the only
> function level solution to the problem you're noting is to make each
> function generate a working copy, which is clearly inefficient.  This
> is a static function, not intended for general use, so I think a
> sufficient approach to address your concern is to simply note the error
> behavior in the comment above the function, the list is in an
> unknown/inconsistent state on error.  Thanks,
> 

'static' doesn't mean it cannot be used for general purpose in the same
file. Clarifying the expected behavior in comment is OK to me.

Thanks
Kevin

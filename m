Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nt2bD7BLGVsDXQAAmS7hNA
	; Thu, 07 Jun 2018 15:14:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 259386063F; Thu,  7 Jun 2018 15:14:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 95E6F60290;
	Thu,  7 Jun 2018 15:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95E6F60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935904AbeFGPOK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:14:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935044AbeFGPB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6419330832EF;
        Thu,  7 Jun 2018 15:01:58 +0000 (UTC)
Received: from w520.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D90FC5D6A3;
        Thu,  7 Jun 2018 15:01:57 +0000 (UTC)
Date: Thu, 7 Jun 2018 09:01:57 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shameerali.kolothum.thodi@huawei.com"
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved
 ranges
Message-ID: <20180607090157.5458a2ae@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD@SHSMSX101.ccr.corp.intel.com>
References: <20180605190400.22732.2998.stgit@gimli.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D1911F88AD@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 07 Jun 2018 15:01:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018 05:29:58 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson
> > Sent: Wednesday, June 6, 2018 3:07 AM
> > 
> > device_is_rmrr_locked() allows graphics and USB devices to participate
> > in the IOMMU API despite, and ignoring their RMRR association, however
> > intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
> > IOVA space for the device.  Are we ignoring the RMRR for these devices
> > or are we not?  If vfio starts consuming reserved regions, perhaps we
> > no longer need to consider devices with RMRRs excluded from the IOMMU
> > API interface, but we have a transitional problem that these allowed
> > devices still impose incompatible IOVA restrictions per the reserved
> > region reporting.  Dive further down the rabbit hole by also ignoring
> > RMRRs for "known" devices in the reserved region reporting.  
> 
> intel_iommu_get_resv_regions is used not just for IOMMU API. I'm
> afraid doing so will make RMRR completely ignored, even in normal
> DMA API path...

Well, I'm a bit stuck then, we have existing IOMMU API users that
ignore these ranges and in fact conflict with these ranges blocking us
from restricting mappings within these ranges.  My impression is that
IOMMU reserved ranges should only be ranges which have some fundamental
limitation in the IOMMU, not simply mappings for which firmware has
requested an identity mapped range.  The latter should simply be a
pre-allocation of the IOVA space, for the cases where we choose to
honor the RMRR.  Thanks,

Alex

> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >  drivers/iommu/intel-iommu.c |   35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> > 
> > If this is the approach we want to take, I could pull this in via the
> > vfio tree, along with Shameer's patches which expose an IOVA list and
> > enforce it to userspace, otherwise I'm afraid Shameer's patches will
> > be blocked a while longer.  Thanks,
> > 
> > Alex
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 749d8f235346..f312f93199c5 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -2864,19 +2864,24 @@ static bool device_has_rmrr(struct device *dev)
> >   * any use of the RMRR regions will be torn down before assigning the
> > device
> >   * to a guest.
> >   */
> > -static bool device_is_rmrr_locked(struct device *dev)
> > +static bool rmrr_is_ignored(struct device *dev)
> >  {
> > -	if (!device_has_rmrr(dev))
> > -		return false;
> > -
> >  	if (dev_is_pci(dev)) {
> >  		struct pci_dev *pdev = to_pci_dev(dev);
> > 
> >  		if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
> > -			return false;
> > +			return true;
> >  	}
> > 
> > -	return true;
> > +	return false;
> > +}
> > +
> > +static bool device_is_rmrr_locked(struct device *dev)
> > +{
> > +	if (!device_has_rmrr(dev))
> > +		return false;
> > +
> > +	return !rmrr_is_ignored(dev);
> >  }
> > 
> >  static int iommu_should_identity_map(struct device *dev, int startup)
> > @@ -5141,17 +5146,19 @@ static void
> > intel_iommu_get_resv_regions(struct device *device,
> >  	struct device *i_dev;
> >  	int i;
> > 
> > -	rcu_read_lock();
> > -	for_each_rmrr_units(rmrr) {
> > -		for_each_active_dev_scope(rmrr->devices, rmrr-  
> > >devices_cnt,  
> > -					  i, i_dev) {
> > -			if (i_dev != device)
> > -				continue;
> > +	if (!rmrr_is_ignored(device)) {
> > +		rcu_read_lock();
> > +		for_each_rmrr_units(rmrr) {
> > +			for_each_active_dev_scope(rmrr->devices,
> > +						  rmrr->devices_cnt, i, i_dev)
> > {
> > +				if (i_dev != device)
> > +					continue;
> > 
> > -			list_add_tail(&rmrr->resv->list, head);
> > +				list_add_tail(&rmrr->resv->list, head);
> > +			}
> >  		}
> > +		rcu_read_unlock();
> >  	}
> > -	rcu_read_unlock();
> > 
> >  	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
> >  				      IOAPIC_RANGE_END -
> > IOAPIC_RANGE_START + 1,  
> 

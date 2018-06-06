Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91E7A6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbeFFEYq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 00:24:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:13798 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbeFFEYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 00:24:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,481,1520924400";
   d="scan'208";a="64672111"
Date: Tue, 5 Jun 2018 21:27:42 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jacob.jun.pan@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Exclude known RMRRs from reserved
 ranges
Message-ID: <20180605212742.2cb5882a@jacob-builder>
In-Reply-To: <20180605190400.22732.2998.stgit@gimli.home>
References: <20180605190400.22732.2998.stgit@gimli.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2018 13:06:54 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> device_is_rmrr_locked() allows graphics and USB devices to participate
> in the IOMMU API despite, and ignoring their RMRR association, however
> intel_iommu_get_resv_regions() still includes the RMRRs as unavailable
> IOVA space for the device.  Are we ignoring the RMRR for these devices
> or are we not?  If vfio starts consuming reserved regions, perhaps we
> no longer need to consider devices with RMRRs excluded from the IOMMU
> API interface, but we have a transitional problem that these allowed
> devices still impose incompatible IOVA restrictions per the reserved
> region reporting.  Dive further down the rabbit hole by also ignoring
> RMRRs for "known" devices in the reserved region reporting.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c |   35
> +++++++++++++++++++++-------------- 1 file changed, 21 insertions(+),
> 14 deletions(-)
> 
> If this is the approach we want to take, I could pull this in via the
> vfio tree, along with Shameer's patches which expose an IOVA list and
> enforce it to userspace, otherwise I'm afraid Shameer's patches will
> be blocked a while longer.  Thanks,
> 
I think this patch makes sense in that it makes IOVA reserved range
check consistent.

Thanks,

Jacob
> Alex
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 749d8f235346..f312f93199c5 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2864,19 +2864,24 @@ static bool device_has_rmrr(struct device
> *dev)
>   * any use of the RMRR regions will be torn down before assigning
> the device
>   * to a guest.
>   */
> -static bool device_is_rmrr_locked(struct device *dev)
> +static bool rmrr_is_ignored(struct device *dev)
>  {
> -	if (!device_has_rmrr(dev))
> -		return false;
> -
>  	if (dev_is_pci(dev)) {
>  		struct pci_dev *pdev = to_pci_dev(dev);
>  
>  		if (IS_USB_DEVICE(pdev) || IS_GFX_DEVICE(pdev))
> -			return false;
> +			return true;
>  	}
>  
> -	return true;
> +	return false;
> +}
> +
> +static bool device_is_rmrr_locked(struct device *dev)
> +{
> +	if (!device_has_rmrr(dev))
> +		return false;
> +
> +	return !rmrr_is_ignored(dev);
>  }
>  
>  static int iommu_should_identity_map(struct device *dev, int startup)
> @@ -5141,17 +5146,19 @@ static void
> intel_iommu_get_resv_regions(struct device *device, struct device
> *i_dev; int i;
>  
> -	rcu_read_lock();
> -	for_each_rmrr_units(rmrr) {
> -		for_each_active_dev_scope(rmrr->devices,
> rmrr->devices_cnt,
> -					  i, i_dev) {
> -			if (i_dev != device)
> -				continue;
> +	if (!rmrr_is_ignored(device)) {
> +		rcu_read_lock();
> +		for_each_rmrr_units(rmrr) {
> +			for_each_active_dev_scope(rmrr->devices,
> +						  rmrr->devices_cnt,
> i, i_dev) {
> +				if (i_dev != device)
> +					continue;
>  
> -			list_add_tail(&rmrr->resv->list, head);
> +				list_add_tail(&rmrr->resv->list,
> head);
> +			}
>  		}
> +		rcu_read_unlock();
>  	}
> -	rcu_read_unlock();
>  
>  	reg = iommu_alloc_resv_region(IOAPIC_RANGE_START,
>  				      IOAPIC_RANGE_END -
> IOAPIC_RANGE_START + 1,
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]

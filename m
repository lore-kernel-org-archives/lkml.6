Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F76FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F626206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 10:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F626206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503461AbeKWVdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 16:33:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387897AbeKWVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 16:33:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C28F31256C9;
        Fri, 23 Nov 2018 10:50:06 +0000 (UTC)
Received: from [10.36.116.235] (ovpn-116-235.ams2.redhat.com [10.36.116.235])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 199A383E98;
        Fri, 23 Nov 2018 10:49:59 +0000 (UTC)
Subject: Re: [PATCH v4 2/8] iommu/vt-d: Add multiple domains per device query
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-3-baolu.lu@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <929c8ce3-94f5-bcd5-89ff-71758b808b50@redhat.com>
Date:   Fri, 23 Nov 2018 11:49:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181105073408.21815-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 23 Nov 2018 10:50:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/5/18 8:34 AM, Lu Baolu wrote:
> Add the response to IOMMU_DEV_ATTR_AUXD_CAPABILITY capability query
> through iommu_get_dev_attr().

commit title: Advertise auxiliary domain capability?
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 38 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5e149d26ea9b..298f7a3fafe8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5167,6 +5167,24 @@ static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
>  	return phys;
>  }
>  
> +static inline bool scalable_mode_support(void)
> +{
> +	struct dmar_drhd_unit *drhd;
> +	struct intel_iommu *iommu;
> +	bool ret = true;
> +
> +	rcu_read_lock();
> +	for_each_active_iommu(iommu, drhd) {
> +		if (!sm_supported(iommu)) {
> +			ret = false;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  static bool intel_iommu_capable(enum iommu_cap cap)
>  {
>  	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> @@ -5331,6 +5349,25 @@ struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
>  }
>  #endif /* CONFIG_INTEL_IOMMU_SVM */
>  
> +static int intel_iommu_get_dev_attr(struct device *dev,
> +				    enum iommu_dev_attr attr, void *data)
> +{
> +	int ret = 0;
> +	bool *auxd_capable;
nit: could be local to the case as other cases may use other datatypes.
> +
> +	switch (attr) {
> +	case IOMMU_DEV_ATTR_AUXD_CAPABILITY:
> +		auxd_capable = data;
> +		*auxd_capable = scalable_mode_support();
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  const struct iommu_ops intel_iommu_ops = {
>  	.capable		= intel_iommu_capable,
>  	.domain_alloc		= intel_iommu_domain_alloc,
> @@ -5345,6 +5382,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.get_resv_regions	= intel_iommu_get_resv_regions,
>  	.put_resv_regions	= intel_iommu_put_resv_regions,
>  	.device_group		= pci_device_group,
> +	.get_dev_attr		= intel_iommu_get_dev_attr,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>  };
>  
>
Thanks

Eric


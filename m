Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7745C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6331620880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 05:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6331620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeILKGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 06:06:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:8843 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeILKGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 06:06:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 22:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="scan'208";a="69321952"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2018 22:03:11 -0700
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, tiwei.bie@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, jacob.jun.pan@intel.com, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
Date:   Wed, 12 Sep 2018 13:02:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/11/2018 12:23 AM, Jean-Philippe Brucker wrote:
> On 30/08/2018 05:09, Lu Baolu wrote:
>> +static int vfio_detach_aux_domain(struct device *dev, void *data)
>> +{
>> +	struct iommu_domain *domain = data;
>> +
>> +	vfio_mdev_set_aux_domain(dev, NULL);
>> +	iommu_detach_device(domain, dev->parent);
> 
> I think that's only going to work for vt-d, which doesn't use a
> default_domain. For other drivers, iommu.c ends up calling
> domain->ops->attach_dev(default_domain, dev) here, which isn't what we want.

This doesn't break any functionality. It takes effect only if iommu
hardware supports finer granular translation and advertises it through
the API.

> 
> That was my concern with reusing attach/detach_dev callbacks for PASID
> management. The attach_dev code of IOMMU drivers already has to deal
> with toggling between default and unmanaged domain. Dealing with more
> state transitions in the same path is going to be difficult.

Let's consider it from the API point of view.

We have iommu_a(de)ttach_device() APIs to attach or detach a domain
to/from a device. We should avoid applying a limitation of "these are
only for single domain case, for multiple domains, use another API".

Best regards,
Lu Baolu


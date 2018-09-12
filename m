Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C736C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129882087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129882087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeILXAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 19:00:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36866 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbeILXAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 19:00:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C521596;
        Wed, 12 Sep 2018 10:54:42 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.Emea.Arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49E083F557;
        Wed, 12 Sep 2018 10:54:40 -0700 (PDT)
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
Date:   Wed, 12 Sep 2018 18:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 06:02, Lu Baolu wrote:
> Hi,
> 
> On 09/11/2018 12:23 AM, Jean-Philippe Brucker wrote:
>> On 30/08/2018 05:09, Lu Baolu wrote:
>>> +static int vfio_detach_aux_domain(struct device *dev, void *data)
>>> +{
>>> +	struct iommu_domain *domain = data;
>>> +
>>> +	vfio_mdev_set_aux_domain(dev, NULL);
>>> +	iommu_detach_device(domain, dev->parent);
>>
>> I think that's only going to work for vt-d, which doesn't use a
>> default_domain. For other drivers, iommu.c ends up calling
>> domain->ops->attach_dev(default_domain, dev) here, which isn't what we want.
> 
> This doesn't break any functionality. It takes effect only if iommu
> hardware supports finer granular translation and advertises it through
> the API.>
>> That was my concern with reusing attach/detach_dev callbacks for PASID
>> management. The attach_dev code of IOMMU drivers already has to deal
>> with toggling between default and unmanaged domain. Dealing with more
>> state transitions in the same path is going to be difficult.
> 
> Let's consider it from the API point of view.
> 
> We have iommu_a(de)ttach_device() APIs to attach or detach a domain
> to/from a device. We should avoid applying a limitation of "these are
> only for single domain case, for multiple domains, use another API".

That's an idealized view of the API, the actual semantics aren't as
simple. For IOMMU drivers that implement IOMMU_DOMAIN_DMA in their
domain_alloc operation (Arm SMMU, AMD IOMMU, ...), attach_dev attaches
an unmanaged domain, detach_dev reattaches the default DMA domain, and
the detach_dev IOMMU op is not called. We can't change that now, so it's
difficult to add more functionality to attach_dev and detach_dev.

Thanks,
Jean

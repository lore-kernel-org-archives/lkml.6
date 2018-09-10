Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85999C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3020B20892
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3020B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeIJVR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:17:57 -0400
Received: from foss.arm.com ([217.140.101.70]:60376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbeIJVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:17:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20E018A;
        Mon, 10 Sep 2018 09:23:05 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 858193F557;
        Mon, 10 Sep 2018 09:23:03 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
        jacob.jun.pan@intel.com, kvm@vger.kernel.org
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Message-ID: <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
Date:   Mon, 10 Sep 2018 17:22:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180830040922.30426-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/08/2018 05:09, Lu Baolu wrote:
> Below APIs are introduced in the IOMMU glue for device drivers to use
> the finer granularity translation.
> 
> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
>   - Represents the ability for supporting multiple domains per device
>     (a.k.a. finer granularity translations) of the IOMMU hardware.

iommu_capable() cannot represent hardware capabilities, we need
something else for systems with multiple IOMMUs that have different
caps. How about iommu_domain_get_attr on the device's domain instead?

> * iommu_en(dis)able_aux_domain(struct device *dev)
>   - Enable/disable the multiple domains capability for a device
>     referenced by @dev.
> 
> * iommu_auxiliary_id(struct iommu_domain *domain)
>   - Return the index value used for finer-granularity DMA translation.
>     The specific device driver needs to feed the hardware with this
>     value, so that hardware device could issue the DMA transaction with
>     this value tagged.

This could also reuse iommu_domain_get_attr.


More generally I'm having trouble understanding how auxiliary domains
will be used. So VFIO allocates PASIDs like this:

* iommu_enable_aux_domain(parent_dev)
* iommu_domain_alloc() -> dom1
* iommu_domain_alloc() -> dom2
* iommu_attach_device(dom1, parent_dev)
  -> dom1 gets PASID #1
* iommu_attach_device(dom2, parent_dev)
  -> dom2 gets PASID #2

Then I'm not sure about the next steps, when userspace does
VFIO_IOMMU_MAP_DMA or VFIO_IOMMU_BIND on an mdev's container. Is the
following use accurate?

For the single translation level:
* iommu_map(dom1, ...) updates first-level/second-level pgtables for
PASID #1
* iommu_map(dom2, ...) updates first-level/second-level pgtables for
PASID #2

Nested translation:
* iommu_map(dom1, ...) updates second-level pgtables for PASID #1
* iommu_bind_table(dom1, ...) binds first-level pgtables, provided by
the guest, for PASID #1
* iommu_map(dom2, ...) updates second-level pgtables for PASID #2
* iommu_bind_table(dom2, ...) binds first-level pgtables for PASID #2


I'm trying to understand how to implement this with SMMU and other
IOMMUs. It's not a clean fit since we have a single domain to hold the
second-level pgtables. Then again, the nested case probably doesn't
matter for us - we might as well assign the parent directly, since all
mdevs have the same second-level and can only be assigned to the same VM.


Also, can non-VFIO device drivers use auxiliary domains to do map/unmap
on PASIDs? They are asking to do that and I'm proposing the private
PASID thing, but since aux domains provide a similar feature we should
probably converge somehow.

Thanks,
Jean

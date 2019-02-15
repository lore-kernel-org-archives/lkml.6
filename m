Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D735222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfBOSqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:46:24 -0500
Received: from foss.arm.com ([217.140.101.70]:37610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfBOSqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:46:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECECFA78;
        Fri, 15 Feb 2019 10:46:23 -0800 (PST)
Received: from [10.1.197.2] (ostrya.cambridge.arm.com [10.1.197.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BECE3F589;
        Fri, 15 Feb 2019 10:46:21 -0800 (PST)
Subject: Re: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
To:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "sanjay.k.kumar@intel.com" <sanjay.k.kumar@intel.com>,
        "jacob.jun.pan@intel.com" <jacob.jun.pan@intel.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "yi.y.sun@intel.com" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tiwei.bie@intel.com" <tiwei.bie@intel.com>,
        "xin.zeng@intel.com" <xin.zeng@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
 <20190214131456.3db38cdb@w520.home>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <20e89cb0-b7ab-d0d7-8630-29ff512a4ef0@arm.com>
Date:   Fri, 15 Feb 2019 18:46:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214131456.3db38cdb@w520.home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2019 20:14, Alex Williamson wrote:
>> This patch series extends both IOMMU and vfio components to support
>> mdev device passing through when it could be isolated and protected
>> by the IOMMU units. The first part of this series (PATCH 1/09~6/09)
>> adds the interfaces and implementation of the multiple domains per
>> device. The second part (PATCH 7/09~9/09) adds the iommu device
>> attribute to each mdev, determines isolation type according to the
>> existence of an iommu device when attaching group in vfio type1 iommu
>> module, and attaches the domain to iommu aware mediated devices.
>> 
>> References:
>> [1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
>> [2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
>> [3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
>> 
>> Best regards,
>> Lu Baolu
>> 
>> Change log:
>>   v5->v6:
> 
> This looks pretty reasonable with Jean-Philippe's nit fixups.  Where do
> we go from here?  I think we need an ack from Kirti since they have an
> interest here.  Presumably this looks ok to the ARM folks.

Looks great from my point of view. I focused on patch 1 since I'm
planning to reuse iommu_dev_features for SVA. I don't have time to test
auxd and mdev on SMMUv3 at the moment but I had a better look and, if it
helps, for patches 1 and 7-9:

Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

That said, are you planning to add back the mdev_get_iommu_domain()
function, in a separate patch? Because I think the parent driver still
needs a way to retrieve the PASID for an mdev?

Thanks,
Jean

> Do we have
> any consumers of this code yet?  Theoretically I think a vfio-pci-like
> meta driver could be written as an mdev vendor driver with this support
> (restricted to type1 iommu use cases).  Thanks,
> 
> Alex


Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6195A217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfBSCvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:51:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:63185 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBSCvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:51:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 18:51:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,385,1544515200"; 
   d="scan'208";a="115965463"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga007.jf.intel.com with ESMTP; 18 Feb 2019 18:51:27 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
Subject: Re: [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20190213040301.23021-1-baolu.lu@linux.intel.com>
 <20190214131456.3db38cdb@w520.home>
 <20e89cb0-b7ab-d0d7-8630-29ff512a4ef0@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0d702a80-4114-533e-f4be-235f54e659c0@linux.intel.com>
Date:   Tue, 19 Feb 2019 10:46:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20e89cb0-b7ab-d0d7-8630-29ff512a4ef0@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 2/16/19 2:46 AM, Jean-Philippe Brucker wrote:
> On 14/02/2019 20:14, Alex Williamson wrote:
>>> This patch series extends both IOMMU and vfio components to support
>>> mdev device passing through when it could be isolated and protected
>>> by the IOMMU units. The first part of this series (PATCH 1/09~6/09)
>>> adds the interfaces and implementation of the multiple domains per
>>> device. The second part (PATCH 7/09~9/09) adds the iommu device
>>> attribute to each mdev, determines isolation type according to the
>>> existence of an iommu device when attaching group in vfio type1 iommu
>>> module, and attaches the domain to iommu aware mediated devices.
>>>
>>> References:
>>> [1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
>>> [2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
>>> [3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
>>>
>>> Best regards,
>>> Lu Baolu
>>>
>>> Change log:
>>>     v5->v6:
>>
>> This looks pretty reasonable with Jean-Philippe's nit fixups.  Where do
>> we go from here?  I think we need an ack from Kirti since they have an
>> interest here.  Presumably this looks ok to the ARM folks.
> 
> Looks great from my point of view. I focused on patch 1 since I'm
> planning to reuse iommu_dev_features for SVA. I don't have time to test
> auxd and mdev on SMMUv3 at the moment but I had a better look and, if it
> helps, for patches 1 and 7-9:
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Thank you! I will add this in the next version.

> 
> That said, are you planning to add back the mdev_get_iommu_domain()
> function, in a separate patch? Because I think the parent driver still
> needs a way to retrieve the PASID for an mdev?

Yes.

As Kirti's suggestion, we removed this since there is currently no
consumer yet. We will bring it back together with the real consumer.

https://lkml.org/lkml/2018/11/16/124

Best regards,
Lu Baolu

> 
> Thanks,
> Jean
> 
>> Do we have
>> any consumers of this code yet?  Theoretically I think a vfio-pci-like
>> meta driver could be written as an mdev vendor driver with this support
>> (restricted to type1 iommu use cases).  Thanks,
>>
>> Alex
> 
> 

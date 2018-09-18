Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379F7C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6B1214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6B1214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeIRVZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:25:47 -0400
Received: from foss.arm.com ([217.140.101.70]:46982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbeIRVZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:25:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E3FD7A9;
        Tue, 18 Sep 2018 08:52:36 -0700 (PDT)
Received: from [10.4.12.111] (ostrya.emea.arm.com [10.4.12.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34D193F5BD;
        Tue, 18 Sep 2018 08:52:34 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
 <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
Message-ID: <f46bcf5f-002b-4269-a750-c4254c9fc89f@arm.com>
Date:   Tue, 18 Sep 2018 16:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2018 03:36, Tian, Kevin wrote:
>> 4) Userspace opens another mdev.
>> -> iommu.c calls domain->ops->attach_dev(domain2, dev)
> 
> another mdev in same VFIO container or different? I assume the
> latter since you mentioned a new domain2.

I was thinking a different VFIO container actually. I used domain2 to
try to make the example clearer

>> 1)? When the container is closed, VFIO calls
>> iommu_detach_device(domain2, parent_dev)
>> -> iommu.c calls default_domain->ops->attach_dev(default_domain, dev)
>> Given that auxiliary domains are attached, the IOMMU driver could deduce
>> that this actually means "detach an auxiliary domain". But which one?
> 
> I didn't get this one. There is no need to stick to 1) behavior for
> 4), i.e. below is expected:
>         domain2->ops->detach_dev(domain2, dev)

But in order to get that, the IOMMU core needs to know that domain2 is
auxiliary. Otherwise, detach_dev is never called when a default_domain
is present for the parent dev.

I guess one solution is to add an "auxiliary" attribute to iommu_domain,
so __iommu_detach_group would do something like:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7113fe398b70..2b3e9b91aee7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1786,10 +1786,11 @@ static void __iommu_detach_group(struct
iommu_domain *domain,
 {
 	int ret;

-	if (!group->default_domain) {
+	if (!group->default_domain || domain->auxiliary) {
 		__iommu_group_for_each_dev(group, domain,
 					   iommu_group_do_detach_device);
-		group->domain = NULL;
+		if (!domain->auxiliary)
+			group->domain = NULL;
 		return;
 	}

Not sure who would set this "auxiliary" attribute... Maybe the IOMMU
driver, when attaching the domain to a device that has auxiliary mode
enabled?

> why cannot ARM implement a detach_dev for aux_domain too? My
> feeling is that default domain twist is only for switch between 1/2/3
> in concept.

If the core actually calls it, we can implement detach_dev :) The
problem is that the core never calls detach_dev when default_domain is
present (affects any IOMMU driver that relies on default_domain,
including AMD), and even in case 4) the default_domain is present for
the parent device

>> So the proposed interface doesn't seem to work as is. If we want to use
>> iommu_attach/detach_device for auxiliary domains, the existing behavior
>> of iommu.c, and IOMMU drivers that rely on it, have to change. Any
>> change I can think of right now seems more daunting than introducing a
>> different path for auxiliary domains, like iommu_attach_aux_domain for
>> example.
>> 
> 
> introducing *aux* specific API will cause different VFIO code path to
> handle RID-based and PASID-based mdev, since RID-based still needs
> to use normal attach_domain that way.

The PASID-based mdev still requires a special case to retrieve the
allocated PASID and program it in the parent device, so VFIO will need
to know the difference between the two

Thanks,
Jean

> well, this argument is not very strong
> in itself, if indeed proposed way doesn't work for ARM. But let's see
> whether it is the case with more understanding of your actual concern.
> 
> Thanks
> Kevin


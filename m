Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A281ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02298214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02298214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbeISHrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:47:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:32038 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbeISHrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:47:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2018 19:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,392,1531810800"; 
   d="scan'208";a="258426371"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by orsmga005.jf.intel.com with ESMTP; 18 Sep 2018 19:11:33 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [RFC PATCH v2 08/10] vfio/type1: Add domain at(de)taching group
 helpers
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <20180830040922.30426-9-baolu.lu@linux.intel.com>
 <c5124ac1-65fe-7f89-265c-bef229bc5ce9@arm.com>
 <a97c8f75-ff49-5b87-198f-d3c8950d4e90@linux.intel.com>
 <04f5dc9d-71b1-37ec-402b-fae5f9e08664@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191300D35@SHSMSX101.ccr.corp.intel.com>
 <c285871d-2ea0-5878-c7ac-ffa4ba8256ee@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191305A74@SHSMSX101.ccr.corp.intel.com>
 <f46bcf5f-002b-4269-a750-c4254c9fc89f@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19130EAD7@SHSMSX101.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6fa39ae8-70bb-717c-bd40-327244afb68d@linux.intel.com>
Date:   Wed, 19 Sep 2018 10:10:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19130EAD7@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/19/2018 07:26 AM, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker@arm.com]
>> Sent: Tuesday, September 18, 2018 11:52 PM
>>
>> On 15/09/2018 03:36, Tian, Kevin wrote:
>>>> 4) Userspace opens another mdev.
>>>> -> iommu.c calls domain->ops->attach_dev(domain2, dev)
>>>
>>> another mdev in same VFIO container or different? I assume the
>>> latter since you mentioned a new domain2.
>>
>> I was thinking a different VFIO container actually. I used domain2 to
>> try to make the example clearer
>>
>>>> 1)? When the container is closed, VFIO calls
>>>> iommu_detach_device(domain2, parent_dev)
>>>> -> iommu.c calls default_domain->ops->attach_dev(default_domain,
>> dev)
>>>> Given that auxiliary domains are attached, the IOMMU driver could
>> deduce
>>>> that this actually means "detach an auxiliary domain". But which one?
>>>
>>> I didn't get this one. There is no need to stick to 1) behavior for
>>> 4), i.e. below is expected:
>>>          domain2->ops->detach_dev(domain2, dev)
>>
>> But in order to get that, the IOMMU core needs to know that domain2 is
>> auxiliary. Otherwise, detach_dev is never called when a default_domain
>> is present for the parent dev.
>>
>> I guess one solution is to add an "auxiliary" attribute to iommu_domain,
>> so __iommu_detach_group would do something like:
> 
> this doesn't work. same domain can be also attached to another physical
> device as non-aux domain (e.g. passthrough) at the same time (vfio-pci
> device and vfio-mdev device in same container), then default domain
> tweak is required in that case. "aux" takes effect only per-device, not
> per-domain.

If we have below APIs for aux domain (the API names are just for
discussion purpose, subject to change):

iommu_querry_aux_domain_capability(dev)
iommu_enable_aux_domain(dev)
iommu_disable_aux_domain(dev)
iommu_check_aux_domain_status(dev)

then, we could do this like below:

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ab3d7d3b1583..3bfb652c78e8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1469,12 +1469,31 @@ static int iommu_group_do_detach_device(struct 
device *dev, void *data)
         return 0;
  }

+static int iommu_group_check_aux_domain(struct device *dev, void *data)
+{
+       const struct iommu_ops *ops = dev->bus->iommu_ops;
+
+       if (ops && ops->check_auxd)
+               return !ops->check_auxd(dev);
+
+       return -EINVAL;
+}
+
+/*
+ *  Check whether devices in @group have aux domain enabled.
+ */
+static int iommu_group_aux_domain_enabled(struct iommu_group *group)
+{
+       return __iommu_group_for_each_dev(group, NULL,
+                                         iommu_group_check_aux_domain);
+}
+
  static void __iommu_detach_group(struct iommu_domain *domain,
                                  struct iommu_group *group)
  {
         int ret;

-       if (!group->default_domain) {
+       if (!group->default_domain || 
iommu_group_aux_domain_enabled(group)) {
                 __iommu_group_for_each_dev(group, domain,
                                            iommu_group_do_detach_device);
                 group->domain = NULL;

Best regards,
Lu Baolu

> 
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 7113fe398b70..2b3e9b91aee7 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1786,10 +1786,11 @@ static void __iommu_detach_group(struct
>> iommu_domain *domain,
>>   {
>>   	int ret;
>>
>> -	if (!group->default_domain) {
>> +	if (!group->default_domain || domain->auxiliary) {
>>   		__iommu_group_for_each_dev(group, domain,
>>   					   iommu_group_do_detach_device);
>> -		group->domain = NULL;
>> +		if (!domain->auxiliary)
>> +			group->domain = NULL;
>>   		return;
>>   	}
>>
>> Not sure who would set this "auxiliary" attribute... Maybe the IOMMU
>> driver, when attaching the domain to a device that has auxiliary mode
>> enabled?
>>
>>> why cannot ARM implement a detach_dev for aux_domain too? My
>>> feeling is that default domain twist is only for switch between 1/2/3
>>> in concept.
>>
>> If the core actually calls it, we can implement detach_dev :) The
>> problem is that the core never calls detach_dev when default_domain is
>> present (affects any IOMMU driver that relies on default_domain,
>> including AMD), and even in case 4) the default_domain is present for
>> the parent device
> 
> Then can we change that core logic so detach_dev is invoked in all
> cases? yes there will be some changes in vendor drivers, but I expect
> this change trivial (especially considering the gain in IOMMU API
> simplicity side as described below).
> 
>>
>>>> So the proposed interface doesn't seem to work as is. If we want to use
>>>> iommu_attach/detach_device for auxiliary domains, the existing
>> behavior
>>>> of iommu.c, and IOMMU drivers that rely on it, have to change. Any
>>>> change I can think of right now seems more daunting than introducing a
>>>> different path for auxiliary domains, like iommu_attach_aux_domain for
>>>> example.
>>>>
>>>
>>> introducing *aux* specific API will cause different VFIO code path to
>>> handle RID-based and PASID-based mdev, since RID-based still needs
>>> to use normal attach_domain that way.
>>
>> The PASID-based mdev still requires a special case to retrieve the
>> allocated PASID and program it in the parent device, so VFIO will need
>> to know the difference between the two
>>
> 
> that retrieve/program is down by parent driver, instead of VFIO.
> 
> Thanks
> Kevin
> 

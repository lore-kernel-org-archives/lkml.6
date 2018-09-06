Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D04BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B5120652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B5120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeIFHjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 03:39:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:24935 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbeIFHjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 03:39:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 20:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="68744643"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 05 Sep 2018 20:06:05 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 02/12] iommu/vt-d: Manage scalalble mode PASID tables
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-3-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A85@SHSMSX101.ccr.corp.intel.com>
 <44298d5c-5720-a382-07d1-a90a072ff24b@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912F2BBC@SHSMSX101.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3eb98f00-6bf2-0c2b-fb95-74505c7fd917@linux.intel.com>
Date:   Thu, 6 Sep 2018 11:05:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2BBC@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/06/2018 10:52 AM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, September 6, 2018 10:46 AM
>>
> [...]
>>>> @@ -143,8 +142,9 @@ int intel_pasid_alloc_table(struct device *dev)
>>>>    		return -ENOMEM;
>>>>    	INIT_LIST_HEAD(&pasid_table->dev);
>>>>
>>>> -	size = sizeof(struct pasid_entry);
>>>> +	size = sizeof(struct pasid_dir_entry);
>>>>    	count = min_t(int, pci_max_pasids(to_pci_dev(dev)),
>>>> intel_pasid_max_id);
>>>> +	count >>= PASID_PDE_SHIFT;
>>>>    	order = get_order(size * count);
>>>>    	pages = alloc_pages_node(info->iommu->node,
>>>>    				 GFP_ATOMIC | __GFP_ZERO,
>>>> @@ -154,7 +154,7 @@ int intel_pasid_alloc_table(struct device *dev)
>>>>
>>>>    	pasid_table->table = page_address(pages);
>>>>    	pasid_table->order = order;
>>>> -	pasid_table->max_pasid = count;
>>>> +	pasid_table->max_pasid = count << PASID_PDE_SHIFT;
>>>
>>> are you sure of that count is PDE_SHIFT aligned? otherwise >>
>>> then << would lose some bits. If sure, then better add some check.
>>
>> I am making the max_pasid PDE_SHIFT aligned as the result of shift
>> operations.
>>
> 
> earlier:
>>>>    	count = min_t(int, pci_max_pasids(to_pci_dev(dev)),
>>>> intel_pasid_max_id);
> 
> so you decided to truncate count to be PDE_SHIFT aligned. Is PASID
> value user configurable? if not, then it's fine.

Here @count is the count of PASID directory entries, so it must be
truncated from the original max_pasid. PASID value is not configurable
anyway.

> 
>>>
>>>>
>>>>    attach_out:
>>>>    	device_attach_pasid_table(info, pasid_table);
>>>> @@ -162,14 +162,33 @@ int intel_pasid_alloc_table(struct device *dev)
>>>>    	return 0;
>>>>    }
>>>>
>>>> +/* Get PRESENT bit of a PASID directory entry. */
>>>> +static inline bool
>>>> +pasid_pde_is_present(struct pasid_dir_entry *pde)
>>>> +{
>>>> +	return READ_ONCE(pde->val) & PASID_PTE_PRESENT;
>>>
>>> curious why adding READ_ONCE specifically for PASID structure,
>>> but not used for any other existing vtd structures? Is it to address
>>> some specific requirement on PASID structure as defined in spec?
>>
>> READ/WRITE_ONCE are used in pasid entry read/write to prevent the
>> compiler from merging, refetching or reordering successive instances of
>> read/write.
>>
> 
> that's fine. I'm just curious why this is the first user of such macros
> in intel-iommu driver. Even before with ecs we have PASID table too.
> 

Best regards,
Lu Baolu

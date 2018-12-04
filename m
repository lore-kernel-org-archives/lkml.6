Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C5EC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DCE2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DCE2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbeLDGQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:16:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:57462 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLDGQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:16:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 22:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,312,1539673200"; 
   d="scan'208";a="115841794"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2018 22:16:36 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-5-baolu.lu@linux.intel.com>
 <20181203134856.lui4us4ejm4d5avz@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3b0eadd2-b99f-98d6-594f-0419f0542789@linux.intel.com>
Date:   Tue, 4 Dec 2018 14:13:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D838AB@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/18 1:23 AM, Liu, Yi L wrote:
> Hi Joerg,
> 
>> From: Joerg Roedel [mailto:joro@8bytes.org]
>> Sent: Monday, December 3, 2018 5:49 AM
>> To: Lu Baolu <baolu.lu@linux.intel.com>
>> Subject: Re: [PATCH v5 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
>> support
>>
>> On Wed, Nov 28, 2018 at 11:54:41AM +0800, Lu Baolu wrote:
>>> -
>>> -	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
>> 0);
>>> +	/*
>>> +	 * Need two pages to accommodate 256 descriptors of 256 bits each
>>> +	 * if the remapping hardware supports scalable mode translation.
>>> +	 */
>>> +	desc_page = alloc_pages_node(iommu->node, GFP_ATOMIC | __GFP_ZERO,
>>> +				     !!ecap_smts(iommu->ecap));
>>
>>
>> Same here, does the allocation really need GFP_ATOMIC?
> 
> still leave to Baolu.

The existing code uses GFP_ATOMIC, this patch only changes the size of
the allocated desc_page.

I don't think we really need GFP_ATOMIC here (and also for some other
places). I will clean up them in a separated patch.

> 
>>
>>>   struct q_inval {
>>>   	raw_spinlock_t  q_lock;
>>> -	struct qi_desc  *desc;          /* invalidation queue */
>>> +	void		*desc;          /* invalidation queue */
>>>   	int             *desc_status;   /* desc status */
>>>   	int             free_head;      /* first free entry */
>>>   	int             free_tail;      /* last free entry */
>>
>> Why do you switch the pointer to void* ?
> 
> In this patch, there is some code like the code below. It calculates
> destination address of memcpy with qi->desc. If it's still struct qi_desc
> pointer, the calculation result would be wrong.
> 
> +			memcpy(desc, qi->desc + (wait_index << shift),
> +			       1 << shift);
> 
> The change of the calculation method is to support 128 bits invalidation
> descriptors and 256 invalidation descriptors in this unified code logic.
> 
> Also, the conversation between Baolu and me may help.
> 
> https://lore.kernel.org/patchwork/patch/1006756/

Yes. We need to support different descriptor size.

Best regards,
Lu Baolu

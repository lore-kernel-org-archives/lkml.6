Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4AFC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D69320827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D69320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeKHPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:00:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:5424 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbeKHPA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:00:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 21:27:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="94566549"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2018 21:27:12 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
 support
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
Date:   Thu, 8 Nov 2018 13:24:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/8/18 11:49 AM, Liu, Yi L wrote:
> Hi,
> 
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Thursday, November 8, 2018 10:17 AM
>> Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation descriptor
>> support
>>
>> Hi Yi,
>>
>> On 11/7/18 2:07 PM, Liu, Yi L wrote:
>>> Hi Baolu,
>>>
>>>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>>>> Sent: Monday, November 5, 2018 1:32 PM
>>>
>>> [...]
>>>
>>>> ---
>>>>    drivers/iommu/dmar.c                | 83 +++++++++++++++++++----------
>>>>    drivers/iommu/intel-svm.c           | 76 ++++++++++++++++----------
>>>>    drivers/iommu/intel_irq_remapping.c |  6 ++-
>>>>    include/linux/intel-iommu.h         |  9 +++-
>>>>    4 files changed, 115 insertions(+), 59 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c index
>>>> d9c748b6f9e4..ec10427b98ac 100644
>>>> --- a/drivers/iommu/dmar.c
>>>> +++ b/drivers/iommu/dmar.c
>>>> @@ -1160,6 +1160,7 @@ static int qi_check_fault(struct intel_iommu
>>>> *iommu, int
>>>> index)
>>>>    	int head, tail;
>>>>    	struct q_inval *qi = iommu->qi;
>>>>    	int wait_index = (index + 1) % QI_LENGTH;
>>>> +	int shift = qi_shift(iommu);
>>>>
>>>>    	if (qi->desc_status[wait_index] == QI_ABORT)
>>>>    		return -EAGAIN;
>>>> @@ -1173,13 +1174,15 @@ static int qi_check_fault(struct intel_iommu
>>>> *iommu, int index)
>>>>    	 */
>>>>    	if (fault & DMA_FSTS_IQE) {
>>>>    		head = readl(iommu->reg + DMAR_IQH_REG);
>>>> -		if ((head >> DMAR_IQ_SHIFT) == index) {
>>>> +		if ((head >> shift) == index) {
>>>> +			struct qi_desc *desc = qi->desc + head;
>>>> +
>>>>    			pr_err("VT-d detected invalid descriptor: "
>>>>    				"low=%llx, high=%llx\n",
>>>> -				(unsigned long long)qi->desc[index].low,
>>>> -				(unsigned long long)qi->desc[index].high);
>>>> -			memcpy(&qi->desc[index], &qi->desc[wait_index],
>>>> -					sizeof(struct qi_desc));
>>>> +				(unsigned long long)desc->qw0,
>>>> +				(unsigned long long)desc->qw1);
>>>
>>> Still missing qw2 and qw3. May make the print differ based on if smts is configed.
>>
>> qw2 and qw3 are reserved from software point of view. We don't need to print it for
>> information.
> 
> But for Scalable mode, it should be valid?

No. It's reserved for software.

> 
>>
>>>
>>>> +			memcpy(desc, qi->desc + (wait_index << shift),
>>>
>>> Would "memcpy(desc, (unsigned long long) (qi->desc +  (wait_index <<
>>> shift)," be more safe?
>>
>> Can that be compiled? memcpy() requires a "const void *" for the second parameter.
>> By the way, why it's safer with this casting?
> 
> This is just an example. My point is the possibility that "qi->desc + (wait_index << shift)"
> would be treated as "qi->desc plus (wait_index << shift)*sizeof(*qi->desc)". Is it possible
> for kernel build?

qi->desc is of type of "void *".

Best regards,
Lu Baolu

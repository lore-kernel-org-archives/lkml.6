Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6080C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37AC20827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37AC20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeKHPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:51:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:39714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbeKHPvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:51:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 22:18:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="94576642"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2018 22:17:57 -0800
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
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D60599@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bcc65c15-b76b-7af1-ca9f-e8818374a329@linux.intel.com>
Date:   Thu, 8 Nov 2018 14:15:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D60599@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/8/18 1:48 PM, Liu, Yi L wrote:
>> From: Liu, Yi L
>> Sent: Thursday, November 8, 2018 1:45 PM
>>>>>>> +			memcpy(desc, qi->desc + (wait_index << shift),
>>>>>>
>>>>>> Would "memcpy(desc, (unsigned long long) (qi->desc +  (wait_index
>>>>>> << shift)," be more safe?
>>>>>
>>>>> Can that be compiled? memcpy() requires a "const void *" for the
>>>>> second
>>> parameter.
>>>>> By the way, why it's safer with this casting?
>>>>
>>>> This is just an example. My point is the possibility that "qi->desc
>>>> + (wait_index <<
>>> shift)"
>>>> would be treated as "qi->desc plus (wait_index <<
>>>> shift)*sizeof(*qi->desc)". Is it possible for kernel build?
>>>
>>> qi->desc is of type of "void *".
>>
>> no, I don’t think so... Refer to the code below. Even it has no correctness issue her,
>> It's not due to qi->desc is "void *" type...
>>
>> struct qi_desc {
>> -	u64 low, high;
>> +	u64 qw0;
>> +	u64 qw1;
>> +	u64 qw2;
>> +	u64 qw3;
>> };
> 
> Oops, just see you modified it to be "void *" in this patch. Ok, then this is fair enough.

Yes. :-)

Best regards,
Lu Baolu

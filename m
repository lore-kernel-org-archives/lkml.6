Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A248C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E3420837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E3420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeKHL57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:57:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:28532 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbeKHL56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:57:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 18:24:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="94534666"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2018 18:24:45 -0800
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
Subject: Re: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT
 modes
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-6-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAE7@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <855f56ac-80be-8179-ba99-45ef99ccb87f@linux.intel.com>
Date:   Thu, 8 Nov 2018 10:22:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D5FAE7@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/18 2:55 PM, Liu, Yi L wrote:
> Hi Baolu,
> 
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Monday, November 5, 2018 1:32 PM
>> Subject: [PATCH v4 05/12] iommu/vt-d: Reserve a domain id for FL and PT modes
>>
>> Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
>> entry for first-level or pass-through translation should be
>> programmed with a domain id different from those used for
>> second-level or nested translation. It is recommended that
>> software could use a same domain id for all first-only and
>> pass-through translations.
>>
>> This reserves a domain id for first-level and pass-through
>> translations.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Cc: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-iommu.c | 10 ++++++++++
>>   drivers/iommu/intel-pasid.h |  6 ++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 9331240c70b8..2f7455ee4e7a 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1618,6 +1618,16 @@ static int iommu_init_domains(struct intel_iommu
>> *iommu)
>>   	 */
>>   	set_bit(0, iommu->domain_ids);
>>
>> +	/*
>> +	 * Vt-d spec rev3.0 (section 6.2.3.1) requires that each pasid
>> +	 * entry for first-level or pass-through translation modes should
>> +	 * be programmed with a domain id different from those used for
>> +	 * second-level or nested translation. We reserve a domain id for
>> +	 * this purpose.
>> +	 */
>> +	if (sm_supported(iommu))
>> +		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> 
> "FLPT_DEFAULT_DID" looks very likely for first level translation. How about
> "PT_FL_DEFAULT_DID"?

We have comments above it, so people won't be confused.

> 
>>   	return 0;
>>   }
>>
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
>> index 12f480c2bb8b..03c1612d173c 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -17,6 +17,12 @@
>>   #define PDE_PFN_MASK			PAGE_MASK
>>   #define PASID_PDE_SHIFT			6
>>
>> +/*
>> + * Domain ID reserved for pasid entries programmed for first-level
>> + * only and pass-through transfer modes.
>> + */
>> +#define FLPT_DEFAULT_DID		1
> 
> Would be helpful to elaborate why DID 1 is selected in the patch
> description.

Yeah. DID 0 has been caved out for caching mode and we start from 1 for
this.

Best regards,
Lu Baolu

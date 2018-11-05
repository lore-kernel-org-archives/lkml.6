Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4594C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6F820827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 05:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6F820827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbeKEPFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:05:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:33454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728918AbeKEPFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:05:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 21:47:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,466,1534834800"; 
   d="scan'208";a="93696497"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2018 21:47:11 -0800
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in
 prq_event_thread()
To:     "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20181105021858.16958-1-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5DF53@SHSMSX104.ccr.corp.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f35802b2-124f-ff54-5be3-a1fb99b2b2c6@linux.intel.com>
Date:   Mon, 5 Nov 2018 13:44:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439D5DF53@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 11/5/18 1:21 PM, Liu, Yi L wrote:
> Hi Baolu,
> 
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of Lu Baolu
>> Sent: Monday, November 5, 2018 10:19 AM
>> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>
>> Cc: Raj, Ashok <ashok.raj@intel.com>; linux-kernel@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Subject: [PATCH 1/1] iommu/vtd: Fix NULL pointer dereference in prq_event_thread()
>>
>> When handling page request without pasid event, go to "no_pasid"
>> branch instead of "bad_req". Otherwise, a NULL pointer deference will happen there.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Sohil Mehta <sohil.mehta@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel-svm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c index
>> db301efe126d..887150907526 100644
>> --- a/drivers/iommu/intel-svm.c
>> +++ b/drivers/iommu/intel-svm.c
>> @@ -595,7 +595,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>>   			pr_err("%s: Page request without PASID: %08llx %08llx\n",
>>   			       iommu->name, ((unsigned long long *)req)[0],
>>   			       ((unsigned long long *)req)[1]);
>> -			goto bad_req;
>> +			goto no_pasid;
>>   		}
>>
>>   		if (!svm || svm->pasid != req->pasid) {
>> --
> 
> I'm afraid it is still necessary to goto "bad_req". The following code behind
> "bad_req" will trigger fault_cb registered by in-kernel drivers. It is reasonable
> that PRQ without PASID can be handled by such callbacks. So I would suggest
> to keep the existing logic.

A page fault without a pasid is triggered by a DMA transfer without
PASID. It doesn't relate to the SVM functionality hence there's no
@svm or @sdev related to it. It's unnecessary to report it to the
drivers as far as I can see.

Best regards,
Lu Baolu

> 
>                  if (sdev && sdev->ops && sdev->ops->fault_cb) {
>                          int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
>                                   (req->exe_req << 1) | (req->priv_req);
>                          sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr, req->private, rwxp, result);
>                   }
> 
> Thanks,
> Yi Liu
> 

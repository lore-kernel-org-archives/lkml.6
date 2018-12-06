Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D98C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6DA214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6DA214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeLFBRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:17:00 -0500
Received: from mga11.intel.com ([192.55.52.93]:23424 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727575AbeLFBQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:16:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 17:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,320,1539673200"; 
   d="scan'208";a="116392589"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2018 17:16:57 -0800
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
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
Subject: Re: [PATCH v5 02/12] iommu/vt-d: Manage scalalble mode PASID tables
To:     Joerg Roedel <joro@8bytes.org>
References: <20181128035449.10226-1-baolu.lu@linux.intel.com>
 <20181128035449.10226-3-baolu.lu@linux.intel.com>
 <20181203134411.lejlkbnagxml54ro@8bytes.org>
 <A2975661238FB949B60364EF0F2C257439D838B9@SHSMSX104.ccr.corp.intel.com>
 <5c81008b-30e8-177d-0182-db366608562f@linux.intel.com>
 <20181205155012.GC16835@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bbaabe2a-8525-e73c-1b62-8cc8eaafe005@linux.intel.com>
Date:   Thu, 6 Dec 2018 09:13:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205155012.GC16835@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 12/5/18 11:50 PM, Joerg Roedel wrote:
> On Tue, Dec 04, 2018 at 01:58:06PM +0800, Lu Baolu wrote:
>> This function is called in an unsleepable context.
>>
>> spin_lock(&lock)
>> [...]
>> if (pasid_table_is_necessary)
>> 	allocate_pasid_table(dev)
>> [...]
>> spin_unlock(&lock)
>>
>> We can move it out of the lock range.
>>
>> How about
>>
>> if (pasid_table_is_necessary)
>> 	pasid_table = allocate_pasid_table(dev)
>>
>> spin_lock(&lock)
>> [...]
>> if (pasid_table_is_necessary)
>> 	set_up_pasid_table(pasid_table)
>> [...]
>> spin_unlock(&lock)
> 
> Hmm, so when the IOMMU is configured in scalable mode we can just
> allocate a pasid-table for the device when we set it up, right?
> 
> Scalable mode is a boot-time decision, so we know for sure whether we
> need a pasid-table on device-setup time. And the device-setup code it
> preemptable, so I think it this allocation should be outside of any
> spin-locked section.

Fair enough. I will fix this up in the next version.

Thank you for pointing this out.

Best regards,
Lu Baolu

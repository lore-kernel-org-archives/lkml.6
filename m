Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeEQBNR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 21:13:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:39011 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751290AbeEQBNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 21:13:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,408,1520924400";
   d="scan'208";a="59295943"
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
 <20180515141101.GF18595@8bytes.org> <5AFBE53C.2070604@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19116ADF6@SHSMSX101.ccr.corp.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AFCD724.6020604@linux.intel.com>
Date: Thu, 17 May 2018 09:13:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19116ADF6@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/16/2018 04:56 PM, Tian, Kevin wrote:
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: Wednesday, May 16, 2018 4:01 PM
>>
>> Hi Joerg,
>>
>> Thank you for looking at my patches.
>>
>> On 05/15/2018 10:11 PM, Joerg Roedel wrote:
>>> On Fri, May 04, 2018 at 09:41:15AM +0800, Lu Baolu wrote:
>>>> PATCH 4~9 implement per domain PASID table. Current per IOMMU
>>>> PASID table implementation is insecure in the cases where
>>>> multiple devices under one single IOMMU unit support PASID
>>>> feature. With per domain PASID table, we can achieve finer
>>>> protection and isolation granularity.
>>> Hold on, we hat discussions in the past about doing a system-wide pasid
>>> space, so that every mm_struct with devices attached gets the same pasid
>>> across all devices it is talking to. Reason was that some devices (will)
>>> require this to work correctly. This goes into the opposite direction,
>>> so I am a bit confused here. Please explain, is this not longer
>>> necessary?
>> You are right. System-wide pasid space is necessary, hence PATCH
>> 1~3 implement it. But PATCH 4~9 don't go into the opposite direction,
>> it's designed to address another potential issue.
> one thing you may want to highlight is, even with PATCH 4-9 it's
> still doing system-wide PASID space allocation. Just PASID table
> itself is kept per-device for isolation purpose as you described
> below, i.e. each device can access only those PASIDs which are
> allocated to itself while the allocation happens system-wide...

Yes, exactly.

Best regards,
Lu Baolu

>
>> With system-wide pasid space, we can use a system-wide pasid table,
>> or just keep what we have now(per iommu unit pasid table). Both
>> system-wide and per iommu unitpasid table mean that two devices
>> might share a single pasid table. That will result in an issue.
>>
>> For an example, device A is assigned to access the memory space of
>> process A, and device B is assigned to access the memory space of
>> process B. The dma remapping infrastructure looks like:
>>
>>                                                      .------------------.
>>                              .----------------.      |                  |
>>                              |                |      |                  |
>>                              .----------------.      | Paging structure |
>>                              |     PASID X    |--|   |  for Process A   |
>>                              .----------------.  |   |                  |
>>                              |                |  --->'------------------'
>>      .----------------.      .----------------.
>>      |                |      |     PASID Y    |--|
>>      .----------------.      .----------------.  |
>>      | Dev_A context  |---|  |                |  |   .------------------.
>>      '----------------'   |  .----------------.  |   |                  |
>>      |                |   |  |                |  |   |                  |
>>      '----------------'   |  .----------------.  |   | Paging structure |
>>      | Dev_B context  |   -->|                |  |   |  for Process B   |
>>      '----------------'----->'----------------'  |   |                  |
>>      |                |         system-wide      v-->'------------------'
>>      .----------------.         pasid table
>>      |                |
>>      '----------------'
>>         Intel iommu
>>        context table
>>
>>
>> Since dev_A and dev_B share a pasid table, the side effect is that a flawed
>> dev_A might access the memory space of process B (with pasid y). Vice
>> versa,
>> a flawed dev_B might access memory space of process A (with pasid x).
>>
>> What PATCH 4~9 do is to remove such possibility by assigning a pasid table
>> for each pci device. Hence, the remapping infrastructure looks like:
>>
>>
>>                                                     .------------------.
>>                                                     |                  |
>>                             .----------------.      |                  |
>>                             |                |      | Paging structure |
>>                             .----------------.      |  for Process A   |
>>                             |     PASID X    |      |                  |
>>                             .----------------.----->'------------------'
>>                             |                |
>>                             .----------------.
>>                             |                |
>>                             .----------------.
>>                             |                |
>>                             .----------------.
>>    .----------------.       |                |
>>    |                |       .----------------.
>>    .----------------.       |                |
>>    | Dev_A context  |------>'----------------'
>>    '----------------'          pasid table
>>    |                |          for Dev_A
>>    '----------------'
>>    | Dev_B context  |-->
>>    '----------------'  |    .----------------.
>>    |                |  |    |                |      .------------------.
>>    .----------------.  |    .----------------.      |                  |
>>    |                |  |    |                |      |                  |
>>    '----------------'  |    .----------------.      | Paging structure |
>>        Intel iommu     |    |                |      |  for Process B   |
>>       context table    |    .----------------.      |                  |
>>                        |    |     PASID Y    |----->'------------------'
>>                        |    .----------------.
>>                        |    |                |
>>                        |    .----------------.
>>                        |    |                |
>>                        |    .----------------.
>>                        v--->|                |
>>                             '----------------'
>>                                pasid table
>>                                for Dev_B
>>
>>
>> With this, dev_A has no means to access memory of process B and vice
>> versa.
>>
>> Best regards,
>> Lu Baolu

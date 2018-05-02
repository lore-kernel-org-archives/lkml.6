Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751144AbeEBOUf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:20:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46582 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeEBOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:20:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 02 May 2018 10:20:19 -0400
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Neil Leeder <neil.m.leeder@gmail.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
 <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
 <c1f9230b-8ff0-5b2e-def9-cbf6b2e2e99c@huawei.com>
Message-ID: <93b3738c386c528193b158da0f85fd27@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-02 02:37, Yisheng Xie wrote:
> Hi Neil,
> 
> On 2018/4/1 13:44, Neil Leeder wrote:
>> Hi Yisheng Xie,
>> 
>> On 3/29/2018 03:03 AM, Yisheng Xie wrote:
>>> 
>>> Hi Neil,
>>> 
>>> On 2017/8/5 3:59, Neil Leeder wrote:
>>>> +    mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM, 
>>>> 0);
>>>> +    mem_map_0 = devm_ioremap_resource(&pdev->dev, mem_resource_0);
>>>> +
>>> Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
>>> IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
>>> devm_ioremap_resource will failed and return -EBUSY, eg.:
>>> 
>>>   smmu reg ranges:        0x180000000 ~ 0x1801fffff
>>>   its smmu_pmu reg ranges:    0x180001000 ~ 0x180001fff
>>> 
>> Just to let you know that I no longer work at Qualcomm and I won't be 
>> able to provide updates to this patchset. I expect that others from my 
>> former team at Qualcomm will pick up ownership.
> 
> Thanks for this infomation.
> 
> hi Agustin and Timur,
> 
> Is there any new status about this patchset?
> 

Hi,

Apologies for the slow response.
We are having some internal discussions about when/if to do this.
I expect to have more clarity within a few weeks.

For what is worth let me take the opportunity to outline the approach
we would like to see for a V2 either developed by us or somebody else
in the community:

1. Rework to comply with the IORT spec changes.

2. Rework probing to extract extra information from the IORT table
    about SMMU/device associations.

   With this information and some perf user space work I think it's 
possible
   to have a single dynamic PMU node and use a similar approach to what 
is
   used in the Coresight drivers to pass the device we want to monitor 
and
   for the driver to find the PMU/PMCG. E.g.:

   $ lspci
   0001:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
   0002:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
   0002:01:00.0 Ethernet controller: Mellanox Technologies MT27500 Family 
[ConnectX-3]
   0003:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
   0003:01:00.0 Ethernet controller: Mellanox Technologies MT27500 Family 
[ConnectX-3]

   # Monitor TLB misses on root complex 2 (no stream filter is applied)
   perf stat -a -e smmu/tlb_miss,@0002:00:00.0/ <workload>

   # Monitor TLB misses on a device on root complex 2 (derive the stream 
number from the RID)
   perf stat -a -e smmu/tlb_miss,@0002:01:00.0/ <workload>

Thanks,
Agustín

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.

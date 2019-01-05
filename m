Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE37C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5561E2070C
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 10:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfAEKEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 05:04:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:5153 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfAEKEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 05:04:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 02:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,442,1539673200"; 
   d="scan'208";a="105699591"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga006.jf.intel.com with ESMTP; 05 Jan 2019 02:04:31 -0800
Message-ID: <5C308277.3090005@intel.com>
Date:   Sat, 05 Jan 2019 18:09:59 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
CC:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <5a04d8ea-b788-6018-8b34-ebd528578916@linux.intel.com> <5C2F2E3E.7020306@intel.com> <4e5cd929-8a28-461d-7f8f-79a2f9301b7c@linux.intel.com>
In-Reply-To: <4e5cd929-8a28-461d-7f8f-79a2f9301b7c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2019 11:57 PM, Liang, Kan wrote:
>
>
> On 1/4/2019 4:58 AM, Wei Wang wrote:
>> On 01/03/2019 12:33 AM, Liang, Kan wrote:
>>>
>>>
>>> On 12/26/2018 4:25 AM, Wei Wang wrote:
>>>> +
>>>> +    /*
>>>> +     * It could be possible that people have vcpus of old model 
>>>> run on
>>>> +     * physcal cpus of newer model, for example a BDW guest on a SKX
>>>> +     * machine (but not possible to be the other way around).
>>>> +     * The BDW guest may not get accurate results on a SKX machine 
>>>> as it
>>>> +     * only reads 16 entries of the lbr stack while there are 32 
>>>> entries
>>>> +     * of recordings. So we currently forbid the lbr enabling when 
>>>> the
>>>> +     * vcpu and physical cpu see different lbr stack entries.
>>>
>>> I think it's not enough to only check number of entries. The LBR 
>>> from/to MSRs may be different even the number of entries is the 
>>> same, e.g SLM and KNL.
>>
>> Yes, we could add the comparison of the FROM msrs.
>>
>>>
>>>> +     */
>>>> +    switch (vcpu_model) {
>>>
>>> That's a duplicate of intel_pmu_init(). I think it's better to 
>>> factor out the common part if you want to check LBR MSRs and 
>>> entries. Then we don't need to add the same codes in two different 
>>> places when enabling new platforms.
>>>
>>
>>
>> Yes, I thought about this, but intel_pmu_init() does a lot more 
>> things in each "Case xx". Any thought about how to factor them out?
>>
>
> I think we may only move the "switch (boot_cpu_data.x86_model) { ... 
> }" to a new function, e.g. __intel_pmu_init(int model, struct x86_pmu 
> *x86_pmu)
>
> In __intel_pmu_init, if the model != boot_cpu_data.x86_model, you only 
> need to update x86_pmu.*. Just ignore global settings, e.g 
> hw_cache_event_ids, mem_attr, extra_attr etc.

Thanks for sharing. I understand the point of maintaining those models 
at one place,
but this factor-out doesn't seem very elegant to me, like below

__intel_pmu_init (int model, struct x86_pmu *x86_pmu)
{
...
switch (model)
case INTEL_FAM6_NEHALEM:
case INTEL_FAM6_NEHALEM_EP:
case INTEL_FAM6_NEHALEM_EX:
     intel_pmu_lbr_init(x86_pmu);
     if (model != boot_cpu_data.x86_model)
         return;

     /* Other a lot of things init like below..*/
     memcpy(hw_cache_event_ids, nehalem_hw_cache_event_ids,
                    sizeof(hw_cache_event_ids));
     memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
                    sizeof(hw_cache_extra_regs));
     x86_pmu.event_constraints = intel_nehalem_event_constraints;
                 x86_pmu.pebs_constraints = 
intel_nehalem_pebs_event_constraints;
                 x86_pmu.enable_all = intel_pmu_nhm_enable_all;
                 x86_pmu.extra_regs = intel_nehalem_extra_regs;
  ...

Case...
}
We need insert "if (model != boot_cpu_data.x86_model)" in every "Case xx".

What would be the rationale that we only do lbr_init for "x86_pmu"
when model != boot_cpu_data.x86_model?
(It looks more like a workaround to factor-out the function and get what 
we want)

I would prefer having them separated as this patch for now - it is 
logically more clear to me.


>
>>
>>> Actually, I think we may just support LBR for guest if it has the 
>>> identical CPU model as host. It should be good enough for now.
>>>
>>
>> I actually tried this in the first place but it failed to work with 
>> the existing QEMU.
>> For example, when we specify "Broadwell" cpu from qemu, then qemu 
>> uses Broadwell core model,
>> but the physical machine I have is Broadwell X. This patch will 
>> support this case.
>
> I mean is it good enough if we only support "-cpu host"?
>

Not really. AFAIK, people don't use this usually. It is more common to 
specify the CPU type.

Best,
Wei



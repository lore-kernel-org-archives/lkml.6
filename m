Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE343C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78E820883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 01:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfAIBtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 20:49:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:28770 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbfAIBtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 20:49:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 17:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,455,1539673200"; 
   d="scan'208";a="124499013"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2019 17:49:08 -0800
Message-ID: <5C35545F.1010808@intel.com>
Date:   Wed, 09 Jan 2019 09:54:39 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
CC:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <5a04d8ea-b788-6018-8b34-ebd528578916@linux.intel.com> <5C2F2E3E.7020306@intel.com> <4e5cd929-8a28-461d-7f8f-79a2f9301b7c@linux.intel.com> <5C308277.3090005@intel.com> <dbe469bb-f6ca-4b1f-f2f7-09607a283977@linux.intel.com> <5C343F7C.10407@intel.com> <fe04d649-c3b4-ec5a-7674-20a93512c61d@linux.intel.com>
In-Reply-To: <fe04d649-c3b4-ec5a-7674-20a93512c61d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 10:08 PM, Liang, Kan wrote:
>
>
> On 1/8/2019 1:13 AM, Wei Wang wrote:
>> On 01/07/2019 10:22 PM, Liang, Kan wrote:
>>>
>>>> Thanks for sharing. I understand the point of maintaining those 
>>>> models at one place,
>>>> but this factor-out doesn't seem very elegant to me, like below
>>>>
>>>> __intel_pmu_init (int model, struct x86_pmu *x86_pmu)
>>>> {
>>>> ...
>>>> switch (model)
>>>> case INTEL_FAM6_NEHALEM:
>>>> case INTEL_FAM6_NEHALEM_EP:
>>>> case INTEL_FAM6_NEHALEM_EX:
>>>>      intel_pmu_lbr_init(x86_pmu);
>>>>      if (model != boot_cpu_data.x86_model)
>>>>          return;
>>>>
>>>>      /* Other a lot of things init like below..*/
>>>>      memcpy(hw_cache_event_ids, nehalem_hw_cache_event_ids,
>>>>                     sizeof(hw_cache_event_ids));
>>>>      memcpy(hw_cache_extra_regs, nehalem_hw_cache_extra_regs,
>>>>                     sizeof(hw_cache_extra_regs));
>>>>      x86_pmu.event_constraints = intel_nehalem_event_constraints;
>>>>                  x86_pmu.pebs_constraints = 
>>>> intel_nehalem_pebs_event_constraints;
>>>>                  x86_pmu.enable_all = intel_pmu_nhm_enable_all;
>>>>                  x86_pmu.extra_regs = intel_nehalem_extra_regs;
>>>>   ...
>>>>
>>>> Case...
>>>> }
>>>> We need insert "if (model != boot_cpu_data.x86_model)" in every 
>>>> "Case xx".
>>>>
>>>> What would be the rationale that we only do lbr_init for "x86_pmu"
>>>> when model != boot_cpu_data.x86_model?
>>>> (It looks more like a workaround to factor-out the function and get 
>>>> what we want)
>>>
>>> I thought the new function may be extended to support fake pmu as 
>>> below.
>>> It's not only for lbr. PMU has many CPU specific features. It can be 
>>> used for other features, if you want to check the compatibility in 
>>> future. But I don't have an example now.
>>>
>>> __intel_pmu_init (int model, struct x86_pmu *x86_pmu)
>>> {
>>> bool fake_pmu = (model != boot_cpu_data.x86_model) ? true : false;
>>> ...
>>> switch (model)
>>> case INTEL_FAM6_NEHALEM:
>>> case INTEL_FAM6_NEHALEM_EP:
>>> case INTEL_FAM6_NEHALEM_EX:
>>>      intel_pmu_lbr_init(x86_pmu);
>>>      x86_pmu->event_constraints = intel_nehalem_event_constraints;
>>>      x86_pmu->pebs_constraints = intel_nehalem_pebs_event_constraints;
>>>      x86_pmu->enable_all = intel_pmu_nhm_enable_all;
>>>      x86_pmu->extra_regs = intel_nehalem_extra_regs;
>>>
>>>      if (fake_pmu)
>>>          return;
>>
>> It looks similar as the one I shared above, the difference is that 
>> more things
>> (e.g. constraints) are assigned to x86_fake_pmu.
>> I'm not sure about the logic behind it (still look like a workaround).
>
> The fake x86_pmu will include all the supported features in host. If 
> you want to check other features in future, it would be useful.
>

OK, I'll think more about if we could have a cleaner way to factor out this.

Best,
Wei

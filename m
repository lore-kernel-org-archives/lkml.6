Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3E8C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5CE21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfADP53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:57:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:18506 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfADP52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:57:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 07:57:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="264427963"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2019 07:57:28 -0800
Received: from [10.251.13.106] (kliang2-mobl1.ccr.corp.intel.com [10.251.13.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 084ED58056F;
        Fri,  4 Jan 2019 07:57:26 -0800 (PST)
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
To:     Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, ak@linux.intel.com,
        peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com>
 <1545816338-1171-5-git-send-email-wei.w.wang@intel.com>
 <5a04d8ea-b788-6018-8b34-ebd528578916@linux.intel.com>
 <5C2F2E3E.7020306@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <4e5cd929-8a28-461d-7f8f-79a2f9301b7c@linux.intel.com>
Date:   Fri, 4 Jan 2019 10:57:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5C2F2E3E.7020306@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/2019 4:58 AM, Wei Wang wrote:
> On 01/03/2019 12:33 AM, Liang, Kan wrote:
>>
>>
>> On 12/26/2018 4:25 AM, Wei Wang wrote:
>>> +
>>> +    /*
>>> +     * It could be possible that people have vcpus of old model run on
>>> +     * physcal cpus of newer model, for example a BDW guest on a SKX
>>> +     * machine (but not possible to be the other way around).
>>> +     * The BDW guest may not get accurate results on a SKX machine 
>>> as it
>>> +     * only reads 16 entries of the lbr stack while there are 32 
>>> entries
>>> +     * of recordings. So we currently forbid the lbr enabling when the
>>> +     * vcpu and physical cpu see different lbr stack entries.
>>
>> I think it's not enough to only check number of entries. The LBR 
>> from/to MSRs may be different even the number of entries is the same, 
>> e.g SLM and KNL.
> 
> Yes, we could add the comparison of the FROM msrs.
> 
>>
>>> +     */
>>> +    switch (vcpu_model) {
>>
>> That's a duplicate of intel_pmu_init(). I think it's better to factor 
>> out the common part if you want to check LBR MSRs and entries. Then we 
>> don't need to add the same codes in two different places when enabling 
>> new platforms.
>>
> 
> 
> Yes, I thought about this, but intel_pmu_init() does a lot more things 
> in each "Case xx". Any thought about how to factor them out?
>

I think we may only move the "switch (boot_cpu_data.x86_model) { ... }" 
to a new function, e.g. __intel_pmu_init(int model, struct x86_pmu *x86_pmu)

In __intel_pmu_init, if the model != boot_cpu_data.x86_model, you only 
need to update x86_pmu.*. Just ignore global settings, e.g 
hw_cache_event_ids, mem_attr, extra_attr etc.

You may also need to introduce another new function to check if the LBR 
is compatible with guest in lbr.c, e.g. bool 
is_lbr_compatible_with_guest(int model).

bool is_lbr_compatible_with_guest(int model) {
	struct x86_pmu fake_x86_pmu;

	if (boot_cpu_data.x86_model == model)
		return true;

	__intel_pmu_init(model, &fake_x86_pmu);

	if ((x86_pmu.lbr_nr == fake_x86_pmu.lbr_nr) &&
	    (x86_pmu.lbr_tos == fake_x86_pmu.lbr_tos) &&
	    (x86_pmu.lbr_from == fake_x86_pmu.lbr_from))
		return true;

	return false;
}

> 
>> Actually, I think we may just support LBR for guest if it has the 
>> identical CPU model as host. It should be good enough for now.
>>
> 
> I actually tried this in the first place but it failed to work with the 
> existing QEMU.
> For example, when we specify "Broadwell" cpu from qemu, then qemu uses 
> Broadwell core model,
> but the physical machine I have is Broadwell X. This patch will support 
> this case.

I mean is it good enough if we only support "-cpu host"?

Thanks,
Kan

Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3528C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947EE21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfADJw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:52:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:14329 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbfADJw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:52:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 01:52:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="288788820"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2019 01:52:55 -0800
Message-ID: <5C2F2E3E.7020306@intel.com>
Date:   Fri, 04 Jan 2019 17:58:22 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
CC:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, jannh@google.com, arei.gonglei@huawei.com
Subject: Re: [PATCH v4 04/10] KVM/x86: intel_pmu_lbr_enable
References: <1545816338-1171-1-git-send-email-wei.w.wang@intel.com> <1545816338-1171-5-git-send-email-wei.w.wang@intel.com> <5a04d8ea-b788-6018-8b34-ebd528578916@linux.intel.com>
In-Reply-To: <5a04d8ea-b788-6018-8b34-ebd528578916@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 12:33 AM, Liang, Kan wrote:
>
>
> On 12/26/2018 4:25 AM, Wei Wang wrote:
>> +
>> +    /*
>> +     * It could be possible that people have vcpus of old model run on
>> +     * physcal cpus of newer model, for example a BDW guest on a SKX
>> +     * machine (but not possible to be the other way around).
>> +     * The BDW guest may not get accurate results on a SKX machine 
>> as it
>> +     * only reads 16 entries of the lbr stack while there are 32 
>> entries
>> +     * of recordings. So we currently forbid the lbr enabling when the
>> +     * vcpu and physical cpu see different lbr stack entries.
>
> I think it's not enough to only check number of entries. The LBR 
> from/to MSRs may be different even the number of entries is the same, 
> e.g SLM and KNL.

Yes, we could add the comparison of the FROM msrs.

>
>> +     */
>> +    switch (vcpu_model) {
>
> That's a duplicate of intel_pmu_init(). I think it's better to factor 
> out the common part if you want to check LBR MSRs and entries. Then we 
> don't need to add the same codes in two different places when enabling 
> new platforms.
>


Yes, I thought about this, but intel_pmu_init() does a lot more things 
in each "Case xx". Any thought about how to factor them out?


> Actually, I think we may just support LBR for guest if it has the 
> identical CPU model as host. It should be good enough for now.
>

I actually tried this in the first place but it failed to work with the 
existing QEMU.
For example, when we specify "Broadwell" cpu from qemu, then qemu uses 
Broadwell core model,
but the physical machine I have is Broadwell X. This patch will support 
this case.

Best,
Wei

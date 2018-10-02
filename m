Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C823DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3C02089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3C02089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeJBOuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:50:39 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59918 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeJBOuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:50:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E43318A;
        Tue,  2 Oct 2018 01:08:39 -0700 (PDT)
Received: from [10.4.13.92] (e112298-lin.Emea.Arm.com [10.4.13.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D392D3F5B3;
        Tue,  2 Oct 2018 01:08:36 -0700 (PDT)
Subject: Re: [PATCH v2 5/7] arm64: make arm uprobes code reusable by arm64
To:     Maciej Slodczyk <m.slodczyk2@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, oleg@redhat.com, catalin.marinas@arm.com,
        will.deacon@arm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, k.lewandowsk@samsung.com
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121216eucas1p2b896ce19f49214d497721db9d6e59bfb@eucas1p2.samsung.com>
 <1537963925-25313-6-git-send-email-m.slodczyk2@partner.samsung.com>
 <9abe9091-f305-a446-c93f-6418d35a7dee@arm.com>
 <20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814~ZfyJK4W4N0481804818eucas1p2j@eucas1p2.samsung.com>
From:   Julien Thierry <julien.thierry@arm.com>
Message-ID: <7ec4fc83-5bf1-f8c2-d6da-e55485ee6642@arm.com>
Date:   Tue, 2 Oct 2018 09:08:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181001132852eucas1p25ab2ddf39296e2c78b188234d168f814~ZfyJK4W4N0481804818eucas1p2j@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01/10/18 14:28, Maciej Slodczyk wrote:
> Hi,
> 
> Thank you for the review.
> 
>> I think that it would be good to move the renaming changes out of this
>> patch.
>>
> 
> So, as I understand, you suggest separating renaming from moving and
> putting it in separate patches, right?
> 

Yes, I just feel this patch has a lot of changes and things like 
renaming/adapting the callback handler and renaming the arm32 stucture 
field could be put in their own patches.

Thanks,

>>>    })
>>> +#define ARM_COMPAT_LR_OFFSET    0
>>
>> Not sure this should be defined here. What's the meaning of compat for
>> arch/arm ?
>>
> 
> Sure, I agree that the name is not very fortunate. I'll change it to
> something like ARM_UPROBES_BRANCH_LR_OFFSET.
> 
>>> @@ -39,7 +39,7 @@ struct arch_uprobe {
>>>        void (*posthandler)(struct arch_uprobe *auprobe,
>>>                    struct arch_uprobe_task *autask,
>>>                    struct pt_regs *regs);
>>> -    struct arch_probes_insn asi;
>>> +    struct arch_probes_insn api;
>>
>> It would be easier to follow thing by making this change in its own
>> patch. (Probably before you move arm32 code to lib/probes)
>>
> 
> Yup.
> 
> 
>>> +enum probes_insn {
>>> +    INSN_REJECTED,
>>> +    INSN_GOOD_NO_SLOT,
>>> +    INSN_GOOD,
>>> +};
>>
>> Why have two definitions of this enum rather than a common one in
>> lib/probes?
>>
> 
> Will fix in v3.
> 
>>> -typedef void (probes_handler_t) (u32 opcode,
>>> -               struct arch_probe_insn *api,
>>> +typedef void (probes_insn_handler_t) (u32 opcode,
>>> +               struct arch_probes_insn *api,
>>
>> In the previous patch you were already aligning this handler the ARM32's
>> equivalent. Why not fix the name (for the handler and struct
>> arch_probes_insn) in the previous patch?
>>
> 
> OK.
> 
>>> +
>>> +#define link_register(regs)            ((regs)->compat_lr)
>>> +
>>> +static inline void link_register_set(struct pt_regs *regs,
>>> +                       unsigned long val)
>>> +{
>>> +    link_register(regs) = val;
>>> +}
>>
>> pstate.h isn't really related to compat mode and whichever compat
>> definition it contains the relations are made explicit through their names.
>>
>> I don't think a macro "link_register" defined in arch/arm64 and visible
>> to any file including ptrace.h (which is a lot) should return
>> "compat_lr" instead of the actual link register.
>>
>> I'd say have the link_register macro check whether "regs" refers to a
>> compat mode context or not and provide the adequate link register.
>>
>> Otherwise maybe you can get away with naming the macro
>> "arm_link_register" and the macro "arm_link_register_set". But I would
>> prefer the previous approach.
>>
> 
> OK.
> 
>>> +#ifdef CONFIG_ARM64
>>> +#include <../../../arm/include/asm/opcodes.h>
>>
>> Hmmm not sure this is something that is accepted.
>>
> 
> OK, I'll fix it.
> 
>>> +/*
>>> + * based on arm kprobes implementation
>>> + */
>>> +static void __kprobes simulate_ldm1stm1(probes_opcode_t insn,
>>> +        struct arch_probes_insn *asi,
>>
>> The whole asi/api mix become a bit confusing IMO.
>> Should we have api when the argument is of type "arch_probes_insn" and
>> asi when the type is "arch_specific_insn"?
>> Should we have more coherent definitions of those structures between arm
>> and arm64 if we are going to share functions between them?
>>
> 
> OK, I'll try to figure something out that's less confusing.
> 
>>
>> #ifdef CONFIG_ARM64
>>
>>> +enum probes_insn
>>> +uprobe_decode_ldmstm_aarch64(probes_opcode_t insn,
>>> +         struct arch_probes_insn *asi,
>>> +         const struct decode_header *d)
>>
>> Should be static.
>>
> 
> OK.
> 
> Thanks again for the review. I'll rework the whole patchset to include
> your remarks.
> 
> 
> Thank you,
> Maciej
> 

-- 
Julien Thierry

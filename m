Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1C0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6E72082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6E72082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeJBRrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:47:41 -0400
Received: from foss.arm.com ([217.140.101.70]:34632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbeJBRrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:47:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 422FE7A9;
        Tue,  2 Oct 2018 04:04:57 -0700 (PDT)
Received: from [10.1.38.141] (desktop-vlo843j.cambridge.arm.com [10.1.38.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4273F5B7;
        Tue,  2 Oct 2018 04:04:53 -0700 (PDT)
Subject: Re: [PATCH v2 7/7] arm64: uprobes - ARM32 instruction probing
To:     Maciej Slodczyk <m.slodczyk2@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, peterz@infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, acme@kernel.org, oleg@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        k.lewandowsk@samsung.com, namhyung@kernel.org, jolsa@redhat.com,
        m.szyprowski@samsung.com
References: <1537963925-25313-1-git-send-email-m.slodczyk2@partner.samsung.com>
 <CGME20180926121218eucas1p1b20a88cfec17c6403a35e4f23de96ade@eucas1p1.samsung.com>
 <1537963925-25313-8-git-send-email-m.slodczyk2@partner.samsung.com>
 <89110505-da2e-3266-c2aa-6e5128c520a4@arm.com>
 <20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818~Zf8TZ4bLI3108031080eucas1p2e@eucas1p2.samsung.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ed84ac78-dc78-768d-2d95-a50db323bed5@arm.com>
Date:   Tue, 2 Oct 2018 12:04:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001134031eucas1p20355222b5692ca99bbeb915b9dbc6818~Zf8TZ4bLI3108031080eucas1p2e@eucas1p2.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-01 2:40 PM, Maciej Slodczyk wrote:
> Hi Robin,
> 
> Thank you for having a look at my patchset.
> 
> On 27.09.2018 19:01, Robin Murphy wrote:
>> On 26/09/18 13:12, Maciej Slodczyk wrote:
>> [...]
>>> @@ -38,16 +78,44 @@ int arch_uprobe_analyze_insn(struct arch_uprobe
>>> *auprobe, struct mm_struct *mm,
>>>            unsigned long addr)
>>>    {
>>>        probes_opcode_t insn;
>>> +    enum probes_insn retval;
>>> +    unsigned int bpinsn;
>>> -    /* TODO: Currently we do not support AARCH32 instruction probing */
>>> -    if (mm->context.flags & MMCF_AARCH32)
>>> -        return -ENOTSUPP;
>>> -    else if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>>> +    insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>>> +
>>> +    if (!IS_ALIGNED(addr, AARCH64_INSN_SIZE))
>>>            return -EINVAL;
>>> -    insn = *(probes_opcode_t *)(&auprobe->insn[0]);
>>> +    /* check if AARCH32 */
>>> +    if (is_compat_task()) {
>>> +
>>> +        /* Thumb is not supported yet */
>>> +        if (addr & 0x3)
>>
>> I'm only skimming, so forgive me if I'm missing something which should
>> be obvious, but this has a big red flag all over it. If "addr" is the
>> actual instruction address (or even a branch target, for a
>> non-interworking branch), plenty of Thumb instructions will just happen
>> to lie at 4-byte-aligned addresses anyway.
>>
> That's the same way Thumb instructions are filtered out in arch/arm
> uprobes and kprobes code. I believe that at this point all Thumb
> instruction have bit 0 set. Please correct me if I'm wrong.

No, only Thumb *symbols* have bit 0 set. AFAICS [ku]probes are dealing 
with arbitrary instruction *addresses* here, which will always be 2- or 
4-byte aligned. Besides, even if that was the case, testing against 0x3 
would be misleading if 0x1 is sufficient. The existing code in arch/arm/ 
looks just as wrong.

>> Furthermore, how would this check ever catch anything anyway given
>> !IS_ALIGNED(addr, AARCH64_INSN_SIZE) above?
> 
> You're right, there's no point in checking it here. I'll fix it in v3.

Although it still won't solve the problem of potentially dumping an A32 
breakpoint in the middle of suitably-aligned T32 code. TBH I'm not sure 
it's even possible to solve that in the general case :(

Robin.

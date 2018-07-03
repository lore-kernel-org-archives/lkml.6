Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB53C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6A424C8E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6A424C8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753014AbeGCLyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:54:32 -0400
Received: from foss.arm.com ([217.140.101.70]:48102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752067AbeGCLya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:54:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7353C80D;
        Tue,  3 Jul 2018 04:54:30 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46F083F5BA;
        Tue,  3 Jul 2018 04:54:28 -0700 (PDT)
Subject: Re: [PATCH v3 10/20] kvm: arm64: Dynamic configuration of VTTBR mask
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
 <e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
Date:   Tue, 3 Jul 2018 12:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 02/07/18 15:41, Auger Eric wrote:
> Hi Suzuki,
> 
> On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
>> On arm64 VTTBR_EL2:BADDR holds the base address for the stage2
>> translation table. The Arm ARM mandates that the bits BADDR[x-1:0]
>> should be 0, where 'x' is defined for a given IPA Size and the
>> number of levels for a translation granule size. It is defined
>> using some magical constants. This patch is a reverse engineered
>> implementation to calculate the 'x' at runtime for a given ipa and
>> number of page table levels. See patch for more details.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since V2:
>>   - Part 1 of spilt from VTCR & VTTBR dynamic configuration
>> ---
>>   arch/arm64/include/asm/kvm_arm.h | 60 +++++++++++++++++++++++++++++++++++++---
>>   arch/arm64/include/asm/kvm_mmu.h | 25 ++++++++++++++++-
>>   2 files changed, 80 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index 3dffd38..c557f45 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -140,8 +140,6 @@
>>    * Note that when using 4K pages, we concatenate two first level page tables
>>    * together. With 16K pages, we concatenate 16 first level page tables.
>>    *
>> - * The magic numbers used for VTTBR_X in this patch can be found in Tables
>> - * D4-23 and D4-25 in ARM DDI 0487A.b.
> Isn't it a pretty old reference? Could you refer to C.a?

Sure, I will update the references everywhere.

>> + *
>> + * The algorithm defines the expectations on the BaseAddress (for the page
>> + * table) bits resolved at each level based on the page size, entry level
>> + * and T0SZ. The variable "x" in the algorithm also affects the VTTBR:BADDR
>> + * for stage2 page table.
>> + *
>> + * The value of "x" is calculated as :
>> + *	x = Magic_N - T0SZ
>> + *
>> + * where Magic_N is an integer depending on the page size and the entry
>> + * level of the page table as below:
>> + *
>> + *	--------------------------------------------
>> + *	| Entry level		|  4K    16K   64K |
>> + *	--------------------------------------------
>> + *	| Level: 0 (4 levels)	| 28   |  -  |  -  |
>> + *	--------------------------------------------
>> + *	| Level: 1 (3 levels)	| 37   | 31  | 25  |
>> + *	--------------------------------------------
>> + *	| Level: 2 (2 levels)	| 46   | 42  | 38  |
>> + *	--------------------------------------------
>> + *	| Level: 3 (1 level)	| -    | 53  | 51  |
>> + *	--------------------------------------------
> I understand entry level = Lookup level in the table.

Entry level => The level at which we start the page table walk for
a given address (This is in line with the ARM ARM). So,

Entry_level = (4 - Number_of_Page_table_levels)

> But you may want to compute x for BaseAddress matching lookup level 2
> with number of levels = 4.

No, the BaseAddress is only calcualted for the "Entry_level". So the
above case doesn't exist at all.

> So shouldn't you s/Number of levels/4 - entry_level?

Ok, I now understood what you are referring to [0]
> for BADDR we want the BaseAddr of the initial lookup level so
> effectively the entry level we are interested in is 4 - number of levels
> and we don't care or d) condition. At least this is my understanding ;-)
> If correct you may slightly reword the explanation?


>> + *
>> + * We have a magic formula for the Magic_N below.
>> + *
>> + *  Magic_N(PAGE_SIZE, Entry_Level) = 64 - ((PAGE_SHIFT - 3) * Number of levels)

[0] ^^^



>> + *
>> + * where number of levels = (4 - Entry_Level).

^^^ Doesn't this help make it clear ? Using the expansion makes it a bit more
unreadable below.

>>   
>> +/*
>> + * Get the magic number 'x' for VTTBR:BADDR of this KVM instance.
>> + * With v8.2 LVA extensions, 'x' should be a minimum of 6 with
>> + * 52bit IPS.
> Link to the spec?

Sure, will add it.

Thanks for the patience to review :-)

Cheers
Suzuki

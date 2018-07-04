Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D68C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0167241C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0167241C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933919AbeGDIYp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:24:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932322AbeGDIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:24:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEF9340704A2;
        Wed,  4 Jul 2018 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-71.ams2.redhat.com [10.36.116.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0C9111C4A2;
        Wed,  4 Jul 2018 08:24:39 +0000 (UTC)
Subject: Re: [PATCH v3 10/20] kvm: arm64: Dynamic configuration of VTTBR mask
To:     Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-11-git-send-email-suzuki.poulose@arm.com>
 <e0c8dc62-42e8-ee24-5519-e19b2739160b@redhat.com>
 <a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
Cc:     cdall@kernel.org, kvm@vger.kernel.org, marc.zyngier@arm.com,
        catalin.marinas@arm.com, punit.agrawal@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, julien.grall@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <3192c7dc-4127-ec97-6ba3-262fa3ff6243@redhat.com>
Date:   Wed, 4 Jul 2018 10:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <a6fa912a-b2ff-ac1e-0120-b2f7eabb6f7f@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 08:24:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 04 Jul 2018 08:24:41 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eric.auger@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 07/03/2018 01:54 PM, Suzuki K Poulose wrote:
> Hi Eric,
> 
> On 02/07/18 15:41, Auger Eric wrote:
>> Hi Suzuki,
>>
>> On 06/29/2018 01:15 PM, Suzuki K Poulose wrote:
>>> On arm64 VTTBR_EL2:BADDR holds the base address for the stage2
>>> translation table. The Arm ARM mandates that the bits BADDR[x-1:0]
>>> should be 0, where 'x' is defined for a given IPA Size and the
>>> number of levels for a translation granule size. It is defined
>>> using some magical constants. This patch is a reverse engineered
>>> implementation to calculate the 'x' at runtime for a given ipa and
>>> number of page table levels. See patch for more details.
>>>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Christoffer Dall <cdall@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>> Changes since V2:
>>>   - Part 1 of spilt from VTCR & VTTBR dynamic configuration
>>> ---
>>>   arch/arm64/include/asm/kvm_arm.h | 60
>>> +++++++++++++++++++++++++++++++++++++---
>>>   arch/arm64/include/asm/kvm_mmu.h | 25 ++++++++++++++++-
>>>   2 files changed, 80 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/kvm_arm.h
>>> b/arch/arm64/include/asm/kvm_arm.h
>>> index 3dffd38..c557f45 100644
>>> --- a/arch/arm64/include/asm/kvm_arm.h
>>> +++ b/arch/arm64/include/asm/kvm_arm.h
>>> @@ -140,8 +140,6 @@
>>>    * Note that when using 4K pages, we concatenate two first level
>>> page tables
>>>    * together. With 16K pages, we concatenate 16 first level page
>>> tables.
>>>    *
>>> - * The magic numbers used for VTTBR_X in this patch can be found in
>>> Tables
>>> - * D4-23 and D4-25 in ARM DDI 0487A.b.
>> Isn't it a pretty old reference? Could you refer to C.a?
> 
> Sure, I will update the references everywhere.
> 
>>> + *
>>> + * The algorithm defines the expectations on the BaseAddress (for
>>> the page
>>> + * table) bits resolved at each level based on the page size, entry
>>> level
>>> + * and T0SZ. The variable "x" in the algorithm also affects the
>>> VTTBR:BADDR
>>> + * for stage2 page table.
>>> + *
>>> + * The value of "x" is calculated as :
>>> + *    x = Magic_N - T0SZ
>>> + *
>>> + * where Magic_N is an integer depending on the page size and the entry
>>> + * level of the page table as below:
>>> + *
>>> + *    --------------------------------------------
>>> + *    | Entry level        |  4K    16K   64K |
>>> + *    --------------------------------------------
>>> + *    | Level: 0 (4 levels)    | 28   |  -  |  -  |
>>> + *    --------------------------------------------
>>> + *    | Level: 1 (3 levels)    | 37   | 31  | 25  |
>>> + *    --------------------------------------------
>>> + *    | Level: 2 (2 levels)    | 46   | 42  | 38  |
>>> + *    --------------------------------------------
>>> + *    | Level: 3 (1 level)    | -    | 53  | 51  |
>>> + *    --------------------------------------------
>> I understand entry level = Lookup level in the table.
> 
> Entry level => The level at which we start the page table walk for
> a given address (This is in line with the ARM ARM). So,
> 
> Entry_level = (4 - Number_of_Page_table_levels)
> 
>> But you may want to compute x for BaseAddress matching lookup level 2
>> with number of levels = 4.
> 
> No, the BaseAddress is only calcualted for the "Entry_level". So the
> above case doesn't exist at all.
> 
>> So shouldn't you s/Number of levels/4 - entry_level?
> 
> Ok, I now understood what you are referring to [0]
>> for BADDR we want the BaseAddr of the initial lookup level so
>> effectively the entry level we are interested in is 4 - number of levels
>> and we don't care or d) condition. At least this is my understanding ;-)
>> If correct you may slightly reword the explanation?
> 
> 
>>> + *
>>> + * We have a magic formula for the Magic_N below.
>>> + *
>>> + *  Magic_N(PAGE_SIZE, Entry_Level) = 64 - ((PAGE_SHIFT - 3) *
>>> Number of levels)
> 
> [0] ^^^
> 
> 
> 
>>> + *
>>> + * where number of levels = (4 - Entry_Level).
> 
> ^^^ Doesn't this help make it clear ? Using the expansion makes it a bit
> more
> unreadable below.

I just wanted to mention the tables you refer (D4-23 and D4-25) give
Magic_N for a larger scope as they deal with any lookup level while we
only care about the entry level for BADDR. So I was a little bit
confused when reading the explanation but that's not a big deal.

> 
>>>   +/*
>>> + * Get the magic number 'x' for VTTBR:BADDR of this KVM instance.
>>> + * With v8.2 LVA extensions, 'x' should be a minimum of 6 with
>>> + * 52bit IPS.
>> Link to the spec?
> 
> Sure, will add it.
> 
> Thanks for the patience to review :-)
you're welcome ;-)

Eric
> 
> Cheers
> Suzuki

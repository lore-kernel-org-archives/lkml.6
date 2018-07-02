Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5859C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC09241D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC09241D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752635AbeGBNyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:54:41 -0400
Received: from foss.arm.com ([217.140.101.70]:32900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751912AbeGBNyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:54:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB37680D;
        Mon,  2 Jul 2018 06:54:39 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B46CE3F2EA;
        Mon,  2 Jul 2018 06:54:37 -0700 (PDT)
Subject: Re: [PATCH v3 19/20] kvm: arm64: Allow IPA size supported by the
 system
To:     Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com,
        will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
 <1530270944-11351-20-git-send-email-suzuki.poulose@arm.com>
 <8dcb10d8-d0ff-feb9-4ca8-38d7eeb5e6ce@arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <72472fe5-69a2-9272-c0ef-d0b981ee0446@arm.com>
Date:   Mon, 2 Jul 2018 14:54:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8dcb10d8-d0ff-feb9-4ca8-38d7eeb5e6ce@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/18 14:50, Marc Zyngier wrote:
> On 29/06/18 12:15, Suzuki K Poulose wrote:
>> So far we have restricted the IPA size of the VM to the default
>> value (40bits). Now that we can manage the IPA size per VM and
>> support dynamic stage2 page tables, allow VMs to have larger IPA.
>> This is done by setting the IPA limit to the one supported by
>> the hardware and kernel. This patch also moves the check for
>> the default IPA size support to kvm_get_ipa_limit().
>>
>> Since the stage2 page table code is dependent on the stage1
>> page table, we always ensure that :
>>
>>    Number of Levels at Stage1 >= Number of Levels at Stage2
>>
>> So we limit the IPA to make sure that the above condition
>> is satisfied. This will affect the following combinations
>> of VA_BITS and IPA for different page sizes.
>>
>>    39bit VA, 4K  - IPA > 43 (Upto 48)
>>    36bit VA, 16K - IPA > 40 (Upto 48)
>>    42bit VA, 64K - IPA > 46 (Upto 52)
> 
> I'm not sure I get it. Are these the IPA sizes that we forbid based on
> the host VA size and page size configuration?

Yes, thats right.

> If so, can you rewrite
> this as:
> 
>     host configuration | unsupported IPA range
>     39bit VA, 4k       | [44, 48]
>     36bit VA, 16K      | [41, 48]
>     42bit VA, 64k      | [47, 52]
> 
> and say that all the other combinations are supported?

Sure, that looks much better. Thanks

Suzuki

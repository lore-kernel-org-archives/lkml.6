Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74772C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD8E20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD8E20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeGKJJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:09:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbeGKJJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F001CED1;
        Wed, 11 Jul 2018 02:05:54 -0700 (PDT)
Received: from [10.1.206.73] (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCF143F5AD;
        Wed, 11 Jul 2018 02:05:52 -0700 (PDT)
Subject: Re: [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the physical
 address size for VM
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>, cdall@kernel.org,
        kvm@vger.kernel.org, catalin.marinas@arm.com,
        punit.agrawal@arm.com, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
 <20180704155104.GN4828@arm.com>
 <12d1832a-1a13-7dd4-662b-addf58400789@arm.com>
 <fe9f5aa5-b283-07e0-5f0e-e97d96b780e7@arm.com>
 <9f1af26e-2913-2b0b-1352-63160096f78f@arm.com>
 <f3463d0a-c6a3-c34d-acb3-13c99fc61c5a@arm.com>
 <20180709112326.GD9486@e103592.cambridge.arm.com>
 <17f8d585-3489-ab6f-6ee1-4d8d337dcf9c@arm.com>
 <20180709133750.GE9486@e103592.cambridge.arm.com>
 <377420ce-97a8-4359-6224-273d91f37247@arm.com>
 <20180710170330.GJ9486@e103592.cambridge.arm.com>
From:   Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <0d9d48fc-f913-9f05-afbe-83299c470611@arm.com>
Date:   Wed, 11 Jul 2018 10:05:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710170330.GJ9486@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/18 18:03, Dave Martin wrote:
> On Tue, Jul 10, 2018 at 05:38:39PM +0100, Suzuki K Poulose wrote:
>> On 09/07/18 14:37, Dave Martin wrote:
>>> On Mon, Jul 09, 2018 at 01:29:42PM +0100, Marc Zyngier wrote:
>>>> On 09/07/18 12:23, Dave Martin wrote:
> 
> [...]
> 
>>>>> Wedging arguments into a few bits in the type argument feels awkward,
>>>>> and may be regretted later if we run out of bits, or something can't be
>>>>> represented in the chosen encoding.
>>>>
>>>> I think that's a pretty convincing argument for a "better" CREATE_VM,
>>>> one that would have a clearly defined, structured (and potentially
>>>> extensible) argument.
>>>>
>>>> I've quickly hacked the following:
>>>>
>>>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>>>> index b6270a3b38e9..3e76214034c2 100644
>>>> --- a/include/uapi/linux/kvm.h
>>>> +++ b/include/uapi/linux/kvm.h
>>>> @@ -735,6 +735,20 @@ struct kvm_ppc_resize_hpt {
>>>>   	__u32 pad;
>>>>   };
>>>>
>>>> +struct kvm_create_vm2 {
>>>> +	__u64	version;	/* Or maybe not */
>>>> +	union {
>>>> +		struct {
>>>> +#define KVM_ARM_SVE_CAPABLE	(1 << 0)
>>>> +#define KVM_ARM_SELECT_IPA	{1 << 1)
>>>> +			__u64	capabilities;
>>>> +			__u16	sve_vlen;
>>>> +			__u8	ipa_size;
>>>> +		} arm64;
>>>> +		__u64	dummy[15];
>>>> +	};
>>>> +};
>>>> +
>>>>   #define KVMIO 0xAE
>>>>
>>>>   /* machine type bits, to be used as argument to KVM_CREATE_VM */
>>>>
>>>> Other architectures could fill in their own bits if they need to.
>>>>
>>>> Thoughts?
>>>
>>> This kind of thing should work, but it may still get messy when we
>>> add additional fields.
>>
>>
>> Marc, Dave,
>>
>> I like Dave's approach. Some comments below.
>>
>>>
>>> It we want this to work cross-arch, would it make sense to go
>>> for a more generic approach, say
>>>
>>> struct kvm_create_vm_attr_any {
>>>          __u32   type;
>>> };
>>>
>>> #define KVM_CREATE_VM_ATTR_ARCH_CAPABILITIES 1
>>> struct kvm_create_vm_attr_arch_capabilities {
>>>          __u32   type;
>>>          __u16   size; /* support future expansion of capabilities[] */
>>>          __u16   reserved;
>>>          __u64   capabilities[1];
>>> };
>>
>> We also need to advertise which attributes are supported by the host,
>> so that the user can tune the available ones. That would make a bit mask
>> like the above trickier, unless we return the supported values back
>> in the argument ptr for the "probe" call. And this scheme in general
>> can be useful for passing back a non-boolean result specific to the
>> attribute, without having a per-attribute ioctl. (e.g, maximum limit
>> for IPA).
> 
> Maybe, but this could quickly become bloated.  (My approach already
> feels a bit bloated...)
> 
> I'm not sure that arbitrarily complex negotiation will really be
> needed, but userspace might want to change its mind if setting a
> particular propertiy fails.
> 
> An alternative might be to have a bunch of per-VM ioctls to configure
> different things, like x86 has.  There's at least precedent for that.
> For arm, we currently only have a few.  That allows for easy extension,
> at the cost of adding ioctls.

As you know, one of the major problems with the per-VM ioctls is
the ordering of different operations and tracking to make sure that
the userspace follows the expected order. e.g, the first approach for
IPA series was based on this and it made things complex enough to drop
it.

> 
> There may be some ioctls we can reuse, like KVM_ENABLE_CAP for per-
> vm capability flags.

May be we could switch to KVM_VM_CAPS and pass a list of capabilities
to be enabled at creation time ? The kvm_enable_cap can pass in additional
arguments for each cap. That way we don't have to rely on a new set of
attributes and probing becomes straight forward.

Suzuki

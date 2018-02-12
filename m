Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934125AbeBLLaJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:30:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934072AbeBLLaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:30:07 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use
References: <20180209130133.28387-1-vkuznets@redhat.com>
        <20180211052539.GA31261@xz-mi>
Date: Mon, 12 Feb 2018 12:30:04 +0100
In-Reply-To: <20180211052539.GA31261@xz-mi> (Peter Xu's message of "Sun, 11
        Feb 2018 13:25:39 +0800")
Message-ID: <87r2pqxx6r.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Fri, Feb 09, 2018 at 02:01:33PM +0100, Vitaly Kuznetsov wrote:
>> Devices which use level-triggered interrupts under Windows 2016 with
>> Hyper-V role enabled don't work: Windows disables EOI broadcast in SPIV
>> unconditionally. Our in-kernel IOAPIC implementation emulates an old IOAPIC
>> version which has no EOI register so EOI never happens.
>> 
>> The issue was discovered and discussed a while ago:
>> https://www.spinics.net/lists/kvm/msg148098.html
>> 
>> While this is a guest OS bug (it should check that IOAPIC has the required
>> capabilities before disabling EOI broadcast) we can workaround it in KVM:
>> advertising DIRECTED_EOI with in-kernel IOAPIC makes little sense anyway.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> - Radim's suggestion was to disable DIRECTED_EOI unconditionally but I'm not
>>   that radical :-) In theory, we may have multiple IOAPICs in userspace in
>>   future and DIRECTED_EOI can be leveraged.
>
> I sort of agree on this, especially considering that we already have
> IOAPIC version 0x20 support in QEMU already.
>
>> ---
>>  arch/x86/kvm/lapic.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index 924ac8ce9d50..5339287fee63 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -321,8 +321,16 @@ void kvm_apic_set_version(struct kvm_vcpu *vcpu)
>>  	if (!lapic_in_kernel(vcpu))
>>  		return;
>>  
>> +	/*
>> +	 * KVM emulates 82093AA datasheet (with in-kernel IOAPIC implementation)
>> +	 * which doesn't have EOI register; Some buggy OSes (e.g. Windows with
>> +	 * Hyper-V role) disable EOI broadcast in lapic not checking for IOAPIC
>> +	 * version first and level-triggered interrupts never get EOIed in
>> +	 * IOAPIC.
>> +	 */
>>  	feat = kvm_find_cpuid_entry(apic->vcpu, 0x1, 0);
>> -	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))))
>> +	if (feat && (feat->ecx & (1 << (X86_FEATURE_X2APIC & 31))) &&
>> +	    !ioapic_in_kernel(vcpu->kvm))
>>  		v |= APIC_LVR_DIRECTED_EOI;
>>  	kvm_lapic_set_reg(apic, APIC_LVR, v);
>>  }
>> -- 
>> 2.14.3
>> 
>
> Does this mean that we can avoid the migration problem that Radim
> raised in previous discussion?  Basically the OSs should only probe
> this version once for each boot, if so I think it should be fine.  But
> since you didn't mention that in either commit message and comment, I
> would like to ask and confirm.
>

My thoughts were: with in-kernel IOAPIC nobody does EOI broadcast
disabling today or he's already broken -- there's no way to EOI
level-triggered interrupts. And the patch changes nothing for QEMU
ioapic implementation.

What I'm not sure about is if we allow migration between in-kernel and
QEMU ioapic implementations. I don't think so but in case we do it is
again already broken because going down from 0x20 to 0x11 will leave you
without EOI register. Migrating from 0x11 to 0x20 should be fine, the
guest will continue without knowing there's a new feature available.

But I may have missed something. Radim? :-)

-- 
  Vitaly

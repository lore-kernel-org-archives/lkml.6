Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932976AbeB1PgF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:36:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932362AbeB1PgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:36:03 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH 3/3] x86/kvm/hyper-v: inject #GP only when invalid SINTx vector is unmasked
References: <20180228134401.6544-1-vkuznets@redhat.com>
        <20180228134401.6544-4-vkuznets@redhat.com>
        <20180228151843.GB2376@rkaganb.sw.ru>
Date: Wed, 28 Feb 2018 16:35:59 +0100
In-Reply-To: <20180228151843.GB2376@rkaganb.sw.ru> (Roman Kagan's message of
        "Wed, 28 Feb 2018 18:18:44 +0300")
Message-ID: <87lgfdgm8w.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Kagan <rkagan@virtuozzo.com> writes:

> On Wed, Feb 28, 2018 at 02:44:01PM +0100, Vitaly Kuznetsov wrote:
>> Hyper-V 2016 on KVM with SynIC enabled doesn't boot with the following
>> trace:
>> 
>>     kvm_entry:            vcpu 0
>>     kvm_exit:             reason MSR_WRITE rip 0xfffff8000131c1e5 info 0 0
>>     kvm_hv_synic_set_msr: vcpu_id 0 msr 0x40000090 data 0x10000 host 0
>>     kvm_msr:              msr_write 40000090 = 0x10000 (#GP)
>>     kvm_inj_exception:    #GP (0x0)
>
> I don't remember having seen this...  Does this happen with the mainline
> QEMU, which doesn't set the SintPollingModeAvailable (17) bit in cpuid
> 0x40000003:edx?

Yes, you need to have Hyper-V role enabled, kvm-intel modules needs to
be loaded with 'nesting' support enabled.

>
>> 
>> KVM acts according to the following statement from TLFS:
>> 
>> "
>> 11.8.4 SINTx Registers
>> ...
>> Valid values for vector are 16-255 inclusive. Specifying an invalid
>> vector number results in #GP.
>> "
>> 
>> However, I checked and genuine Hyper-V doesn't #GP when we write 0x10000
>> to SINTx. I checked with Microsoft and they confirmed that if either the
>> Masked bit (bit 16) or the Polling bit (bit 18) is set to 1, then they
>> ignore the value of Vector. Make KVM act accordingly.
>
> I wonder if that cpuid setting affects this behavior?  Also curious what
> exactly the guest is trying to achieve writing this bogus value?

The value is actually the default value which is supposed to be there:

"At virtual processor creation time, the default value of all SINTx
(synthetic interrupt source) registers is 0x0000000000010000." so I
guess this is just an intialization procedure.

>
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/include/uapi/asm/hyperv.h | 1 +
>>  arch/x86/kvm/hyperv.c              | 7 ++++++-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
>> index 62c778a303a1..a492dc357bd7 100644
>> --- a/arch/x86/include/uapi/asm/hyperv.h
>> +++ b/arch/x86/include/uapi/asm/hyperv.h
>> @@ -326,6 +326,7 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
>>  #define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
>>  #define HV_SYNIC_SINT_MASKED		(1ULL << 16)
>>  #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
>> +#define HV_SYNIC_SINT_POLLING		(1ULL << 18)
>>  #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
>>  
>>  #define HV_SYNIC_STIMER_COUNT		(4)
>> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
>> index 6d14f808145d..d3d866c32976 100644
>> --- a/arch/x86/kvm/hyperv.c
>> +++ b/arch/x86/kvm/hyperv.c
>> @@ -95,9 +95,14 @@ static int synic_set_sint(struct kvm_vcpu_hv_synic *synic, int sint,
>>  			  u64 data, bool host)
>>  {
>>  	int vector, old_vector;
>> +	bool masked, polling;
>>  
>>  	vector = data & HV_SYNIC_SINT_VECTOR_MASK;
>> -	if (vector < HV_SYNIC_FIRST_VALID_VECTOR && !host)
>> +	masked = data & HV_SYNIC_SINT_MASKED;
>> +	polling = data & HV_SYNIC_SINT_POLLING;
>> +
>> +	if (vector < HV_SYNIC_FIRST_VALID_VECTOR &&
>> +	    !host && !masked && !polling)
>>  		return 1;
>>  	/*
>>  	 * Guest may configure multiple SINTs to use the same vector, so
>
> I'm not sure this is enough to implement the polling mode: per spec,
>

Oh, no, I wasn't trying to -- and by the way we don't currently announce
SintPollingModeAvailable so guests are not supposed to do that. This is
rather a future proof to 'not forget'.

>> Setting the polling bit will have the effect of unmasking an interrupt
>> source, except that an actual interrupt is not generated.
>
> However, if the guest sets a valid vector and the masked bit cleared,
> we'll consider it a usual SINT and add to masks and inject interrupts,
> etc, regardless of the polling bit.
>
> I must admit I'm confused by the above quote from the spec: is the
> polling bit supposed to come together with the masked bit?  If so, then
> we probably should validate it here (but your logs indicate otherwise).
> In general I'm missing the utility of this mode: why should an interrupt
> controller be involved in polling at all?

"Setting the polling bit will have the effect of unmasking an interrupt
source, except that an actual interrupt is not generated."

So, as I understand it, setting polling bit makes Vector value
irrelevant - the interrupt is not generated so I *assume* we may see
writes with zero Vector and polling bit set. But again, we're not
implementing polling mode for now, I can just drop it from the patch if
you think it is confusing.

-- 
  Vitaly

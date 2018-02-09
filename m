Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbeBIXmI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:42:08 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:60247 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752521AbeBIXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:42:07 -0500
X-IronPort-AV: E=Sophos;i="5.46,486,1511827200";
   d="scan'208";a="666411953"
Subject: Re: [PATCH 3/3] X86/nVMX: Update the MSR_BITMAP field with the L02
 MSR BITMAP
To: Jim Mattson <jmattson@google.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
CC: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de>
 <1518130410-6583-3-git-send-email-karahmed@amazon.de>
 <CALMp9eThOMGTru3hnuupJ_m4jPA7Hf=5=8ZJ4ygmC50vsDmngw@mail.gmail.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <8d50836c-4eee-15ef-da20-212559105594@amazon.com>
Date: Sat, 10 Feb 2018 00:41:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eThOMGTru3hnuupJ_m4jPA7Hf=5=8ZJ4ygmC50vsDmngw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.67]
X-ClientProxiedBy: EX13D17UWB003.ant.amazon.com (10.43.161.42) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w19NgFQS019994

On 02/10/2018 12:26 AM, Jim Mattson wrote:
> On Thu, Feb 8, 2018 at 2:53 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
>> ... otherwise we will just be running with the L1 MSR BITMAP!
>>
>> It does not seem that we ever update the MSR_BITMAP when the nested guest
>> is running. The only place where we update the MSR_BITMAP field in VMCS is
>> for the L1 guest!
>>
>> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   arch/x86/kvm/vmx.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 91e3539..f40be10 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -10589,6 +10589,9 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>>          vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
>>          vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
>>
>> +       if (cpu_has_vmx_msr_bitmap())
>> +               vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
>> +
> 
> This is already in David's "[PATCH 5/9] KVM: VMX: make MSR bitmaps
> per-VCPU," isn't it?

I assume you are referring to this:

https://patchwork.kernel.org/patch/10194819/

.. which is now:

commit 904e14fb7cb9 ("KVM: VMX: make MSR bitmaps per-VCPU")

right?

If this is the case, then I do not see where the MSR_BITMAP is being
updated here. In fact, would not this be the commit that actually broke
it?

Now MSR_BITMAP is only set in vmx_vcpu_setup:

         if (cpu_has_vmx_msr_bitmap())
                 vmcs_write64(MSR_BITMAP, __pa(vmx->vmcs01.msr_bitmap));

> 
>>          if (from_vmentry &&
>>              (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
>>                  kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
>> --
>> 2.7.4
>>
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

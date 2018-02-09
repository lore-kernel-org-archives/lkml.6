Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751205AbeBIMPd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:15:33 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:45050 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBIMPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:15:31 -0500
X-IronPort-AV: E=Sophos;i="5.46,483,1511827200";
   d="scan'208";a="707574613"
Subject: Re: [RFC 03/12] KVM/VMX: Use the new host mapping API for
 virtual_apic_page
To: Jim Mattson <jmattson@google.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
CC: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
 <1517856451-2932-4-git-send-email-karahmed@amazon.de>
 <CALMp9eRhHfoy7cL0x3qUMOHn4DUacHGc_497ac1QMPbiGU9O5g@mail.gmail.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <b12b9a53-2793-5317-bc59-535b615eb903@amazon.com>
Date: Fri, 9 Feb 2018 13:15:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eRhHfoy7cL0x3qUMOHn4DUacHGc_497ac1QMPbiGU9O5g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.161.129]
X-ClientProxiedBy: EX13D17UWB003.ant.amazon.com (10.43.161.42) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w19CFbBa025067

On 02/05/2018 11:26 PM, Jim Mattson wrote:
> On Mon, Feb 5, 2018 at 10:48 AM KarimAllah Ahmed <karahmed@amazon.de> wrote:
> 
>> @@ -5264,9 +5264,8 @@ static void
> vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
> 
>>           max_irr = find_last_bit((unsigned long
> *)vmx->nested.pi_desc->pir, 256);
>>           if (max_irr != 256) {
>> -               vapic_page = kmap(vmx->nested.virtual_apic_page);
>> +               vapic_page = vmx->nested.virtual_apic_mapping.kaddr;
>>                   __kvm_apic_update_irr(vmx->nested.pi_desc->pir,
> vapic_page);
>> -               kunmap(vmx->nested.virtual_apic_page);
> 
> Your kernel mapping now survives exits to userspace. I didn't think that
> was kosher, but I'd be happy to hear that I'm wrong.

Can you elaborate a bit? I do not really understand what is the concern.

>> @@ -7502,10 +7501,8 @@ static void free_nested(struct vcpu_vmx *vmx)
>>           /* Unpin physical memory we referred to in the vmcs02 */
>>           if (vmx->nested.apic_access_mapping.pfn)
> 
> kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
>> -       if (vmx->nested.virtual_apic_page) {
>> -               kvm_release_page_dirty(vmx->nested.virtual_apic_page);
>> -               vmx->nested.virtual_apic_page = NULL;
>> -       }
>> +       if (vmx->nested.virtual_apic_mapping.pfn)
>> +
> kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);
> 
> Is the host PFN guaranteed to be non-zero?

Yeah, I should not have assumed that PFN zero is invalid. Will fix.
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946812AbeCBRkt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:40:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1946796AbeCBRkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:40:47 -0500
Subject: Re: [PATCH 00/10] KVM/X86: Handle guest memory that does not have a
 struct page
To: Jim Mattson <jmattson@google.com>,
        "Raslan, KarimAllah" <karahmed@amazon.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
 <1519917874.15908.41.camel@amazon.de>
 <CALMp9eQmA920LgDQjZ4+X8zLFoKMMpntZj0Kx_3i1OW=LcRDWg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7003cc1a-fc0a-f814-a2fd-189974003605@redhat.com>
Date: Fri, 2 Mar 2018 18:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQmA920LgDQjZ4+X8zLFoKMMpntZj0Kx_3i1OW=LcRDWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2018 18:51, Jim Mattson wrote:
> No complaints here!

It seems sane here too, I'll review the individual patches as soon as
possible.

Thanks,

Paolo

> On Thu, Mar 1, 2018 at 7:24 AM, Raslan, KarimAllah <karahmed@amazon.de> wrote:
>> Jim/Paolo/Radim,
>>
>> Any complains about the current API? (introduced in 4/10)
>>
>> I have more patches on top and I would like to ensure that this is
>> agreed upon at least before sending more revisions/patches.
>>
>> Also 1, 2, and 3 should be a bit straight forward and does not use
>> this API.
>>
>> Thanks.
>>
>> On Wed, 2018-02-21 at 18:47 +0100, KarimAllah Ahmed wrote:
>>> For the most part, KVM can handle guest memory that does not have a struct
>>> page (i.e. not directly managed by the kernel). However, There are a few places
>>> in the code, specially in the nested code, that does not support that.
>>>
>>> Patch 1, 2, and 3 avoid the mapping and unmapping all together and just
>>> directly use kvm_guest_read and kvm_guest_write.
>>>
>>> Patch 4 introduces a new guest mapping interface that encapsulate all the
>>> bioler plate code that is needed to map and unmap guest memory. It also
>>> supports guest memory without "struct page".
>>>
>>> Patch 5, 6, 7, 8, 9, and 10 switch most of the offending code in VMX and hyperv
>>> to use the new guest mapping API.
>>>
>>> This patch series is the first set of fixes. Handling SVM and APIC-access page
>>> will be handled in a different patch series.
>>>
>>> KarimAllah Ahmed (10):
>>>   X86/nVMX: handle_vmon: Read 4 bytes from guest memory instead of
>>>     map->read->unmap sequence
>>>   X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
>>>     instead of map->copy->unmap sequence.
>>>   X86/nVMX: Update the PML table without mapping and unmapping the page
>>>   KVM: Introduce a new guest mapping API
>>>   KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
>>>   KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
>>>   KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
>>>     descriptor table
>>>   KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
>>>   KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
>>>   KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
>>>
>>>  arch/x86/kvm/hyperv.c    |  28 ++++-----
>>>  arch/x86/kvm/vmx.c       | 144 +++++++++++++++--------------------------------
>>>  arch/x86/kvm/x86.c       |  13 ++---
>>>  include/linux/kvm_host.h |  15 +++++
>>>  virt/kvm/kvm_main.c      |  50 ++++++++++++++++
>>>  5 files changed, 129 insertions(+), 121 deletions(-)
>>>
>> Amazon Development Center Germany GmbH
>> Berlin - Dresden - Aachen
>> main office: Krausenstr. 38, 10117 Berlin
>> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
>> Ust-ID: DE289237879
>> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

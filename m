Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033708AbeCARvv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:51:51 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:35092 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033559AbeCARvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:51:49 -0500
X-Google-Smtp-Source: AG47ELtpxoyHcYH3Hw6Qz/XC/KpuhLts15lHsNkfdEgFT9z6aqiCnV6MfaEiMjk26BQ1RmHIqAparg4DH/DP9/aTgEU=
MIME-Version: 1.0
In-Reply-To: <1519917874.15908.41.camel@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de> <1519917874.15908.41.camel@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 1 Mar 2018 09:51:47 -0800
Message-ID: <CALMp9eQmA920LgDQjZ4+X8zLFoKMMpntZj0Kx_3i1OW=LcRDWg@mail.gmail.com>
Subject: Re: [PATCH 00/10] KVM/X86: Handle guest memory that does not have a
 struct page
To: "Raslan, KarimAllah" <karahmed@amazon.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No complaints here!

On Thu, Mar 1, 2018 at 7:24 AM, Raslan, KarimAllah <karahmed@amazon.de> wrote:
> Jim/Paolo/Radim,
>
> Any complains about the current API? (introduced in 4/10)
>
> I have more patches on top and I would like to ensure that this is
> agreed upon at least before sending more revisions/patches.
>
> Also 1, 2, and 3 should be a bit straight forward and does not use
> this API.
>
> Thanks.
>
> On Wed, 2018-02-21 at 18:47 +0100, KarimAllah Ahmed wrote:
>> For the most part, KVM can handle guest memory that does not have a struct
>> page (i.e. not directly managed by the kernel). However, There are a few places
>> in the code, specially in the nested code, that does not support that.
>>
>> Patch 1, 2, and 3 avoid the mapping and unmapping all together and just
>> directly use kvm_guest_read and kvm_guest_write.
>>
>> Patch 4 introduces a new guest mapping interface that encapsulate all the
>> bioler plate code that is needed to map and unmap guest memory. It also
>> supports guest memory without "struct page".
>>
>> Patch 5, 6, 7, 8, 9, and 10 switch most of the offending code in VMX and hyperv
>> to use the new guest mapping API.
>>
>> This patch series is the first set of fixes. Handling SVM and APIC-access page
>> will be handled in a different patch series.
>>
>> KarimAllah Ahmed (10):
>>   X86/nVMX: handle_vmon: Read 4 bytes from guest memory instead of
>>     map->read->unmap sequence
>>   X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
>>     instead of map->copy->unmap sequence.
>>   X86/nVMX: Update the PML table without mapping and unmapping the page
>>   KVM: Introduce a new guest mapping API
>>   KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
>>   KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
>>   KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
>>     descriptor table
>>   KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
>>   KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
>>   KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
>>
>>  arch/x86/kvm/hyperv.c    |  28 ++++-----
>>  arch/x86/kvm/vmx.c       | 144 +++++++++++++++--------------------------------
>>  arch/x86/kvm/x86.c       |  13 ++---
>>  include/linux/kvm_host.h |  15 +++++
>>  virt/kvm/kvm_main.c      |  50 ++++++++++++++++
>>  5 files changed, 129 insertions(+), 121 deletions(-)
>>
> Amazon Development Center Germany GmbH
> Berlin - Dresden - Aachen
> main office: Krausenstr. 38, 10117 Berlin
> Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
> Ust-ID: DE289237879
> Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

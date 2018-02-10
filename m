Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751116AbeBJLdz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 06:33:55 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:36585 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBJLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 06:33:53 -0500
X-IronPort-AV: E=Sophos;i="5.46,489,1511827200";
   d="scan'208";a="331609327"
Subject: Re: [RFC 00/12] KVM/X86: Introduce a new guest mapping API
To: =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
CC: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
 <1517858790.22345.62.camel@bitdefender.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <266d9b21-0431-39cf-bb6f-61327fa5e0a0@amazon.com>
Date: Sat, 10 Feb 2018 12:33:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1517858790.22345.62.camel@bitdefender.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D01UWB001.ant.amazon.com (10.43.161.75) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1ABYARj007602

On 02/05/2018 08:26 PM, Mihai Donțu wrote:
> On Mon, 2018-02-05 at 19:47 +0100, KarimAllah Ahmed wrote:
>> Guest memory can either be directly managed by the kernel (i.e. have a "struct
>> page") or they can simply live outside kernel control (i.e. do not have a
>> "struct page"). KVM mostly support these two modes, except in a few places
>> where the code seems to assume that guest memory must have a "struct page".
> 
> In cases where there is no 'struct page', would it be possible to get
> two VM-s to share memory (in the way Xen's grant tables do)?
> 
> We are working on a page sharing mechanism and would like to know if
> this use case can be accommodated.

If your code is posted somewhere, I can take a look and let you know it
can be accommodated or not.

> 
> Thank you,
> 
>> This patchset introduces a new mapping function to map guest memory into host
>> kernel memory. Ideally I should also get rid of all guest mapping functions
>> that end up converting a guest address to a page, but I decided to get feedback
>> on this first and see if this is an acceptable API.
>>
>> Most of the offending code paths that has been updated are in the nested code
>> base. Mostly because I stumbled upon this code while looking at the nested MSR
>> bitmap handling for the IBRS patches. There are also offending code paths in
>> SVM code, but I will do that once the interface is accepted.
>>
>> KarimAllah Ahmed (12):
>>    KVM: Introduce helper functions to map/unmap guest memory
>>    KVM/VMX: Use the new host mapping API for apic_access_page
>>    KVM/VMX: Use the new host mapping API for virtual_apic_page
>>    KVM/VMX: Use the new host mapping API for pi_desc_page
>>    KVM/VMX: Use the new host mapping API for mapping nested vmptr
>>    KVM/VMX: Use the new host mapping API for handle_vmptrld
>>    KVM/VMX: Use the new host mapping API for mapping L12 MSR bitmap
>>    KVM/VMX: Use the new host mapping API for mapping nested PML
>>    KVM/VMX: Use the new host mapping API for cmpxchg_emulated
>>    KVM/VMX: Use the new host mapping API for synic_clear_sint_msg_pending
>>    KVM/VMX: Use the new host mapping API for synic_deliver_msg
>>    KVM/VMX: Remove kvm_vcpu_gpa_to_page as it is now unused
>>
>>   arch/x86/kvm/hyperv.c    |  24 +++----
>>   arch/x86/kvm/vmx.c       | 159 ++++++++++++++++++++---------------------------
>>   arch/x86/kvm/x86.c       |  12 ++--
>>   include/linux/kvm_host.h |  18 +++++-
>>   virt/kvm/kvm_main.c      |  62 ++++++++++++++++++
>>   5 files changed, 161 insertions(+), 114 deletions(-)
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbeBHSv7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:51:59 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:58896 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752413AbeBHSv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:51:57 -0500
X-IronPort-AV: E=Sophos;i="5.46,480,1511827200";
   d="scan'208";a="331347591"
Subject: Re: [RFC 05/12] KVM/VMX: Use the new host mapping API for mapping
 nested vmptr
To: Jim Mattson <jmattson@google.com>,
        KarimAllah Ahmed <karahmed@amazon.de>
CC: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
 <1517856451-2932-6-git-send-email-karahmed@amazon.de>
 <CALMp9eScXeCi6J4kuktdZmmOg2oDyyatpzOdVmUSso7F8FU+zA@mail.gmail.com>
From: KarimAllah Ahmed <karahmed@amazon.com>
Message-ID: <ad1fd6bd-0dd3-52c0-0343-dc9f0cb4f5f8@amazon.com>
Date: Thu, 8 Feb 2018 19:51:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eScXeCi6J4kuktdZmmOg2oDyyatpzOdVmUSso7F8FU+zA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.43.160.245]
X-ClientProxiedBy: EX13D01UWA004.ant.amazon.com (10.43.160.99) To
 EX13D01EUB003.ant.amazon.com (10.43.166.248)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18Iq3st029130

On 02/05/2018 11:15 PM, Jim Mattson wrote:
> On Mon, Feb 5, 2018 at 10:49 AM KarimAllah Ahmed <karahmed@amazon.de> wrote:
> 
> 
>> @@ -7410,19 +7410,17 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
>>                   return kvm_skip_emulated_instruction(vcpu);
>>           }
> 
>> -       page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
>> -       if (is_error_page(page)) {
>> +       if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmptr, &mapping, true)) {
>>                   nested_vmx_failInvalid(vcpu);
>>                   return kvm_skip_emulated_instruction(vcpu);
>>           }
>> -       if (*(u32 *)kmap(page) != VMCS12_REVISION) {
>> -               kunmap(page);
>> -               kvm_release_page_clean(page);
>> +       if (*(u32 *)mapping.kaddr != VMCS12_REVISION) {
>> +               kvm_release_host_mapping(&mapping, false);
>>                   nested_vmx_failInvalid(vcpu);
>>                   return kvm_skip_emulated_instruction(vcpu);
>>           }
>> -       kunmap(page);
>> -       kvm_release_page_clean(page);
>> +
>> +       kvm_release_host_mapping(&mapping, false);
> 
> Why go through this explicit mapping/release dance? Why not just:
> 
> uint32_t revision;
> ...
> if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
>       revision != VMCS12_REVISION) {
>           nested_vmx_failInvalid(vcpu);
>           return kvm_skip_emulated_instruction(vcpu);
> }
> 

Fair enough, I will update.
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

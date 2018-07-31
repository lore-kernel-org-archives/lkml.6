Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B79DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D889F20862
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D889F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeGaJTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:19:04 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50251 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbeGaJTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:19:04 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so1937713wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 00:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lAR5c89RF4kZpy9i5eg3akklRziFgxCZNrQKCbYez+M=;
        b=uimUkPkI3N5hPtwDlzGj+LPWIfuKyPu16Xq7j+EhQunFLbeFNJ7gy+pP7qHJGpZGua
         UNy+fAT5M+ZcH0QJGsLoU1EuE2I49O3TDSCjgsetnqY+viC1lg9idBEVbgHP9hY4cf3V
         JDkVfWdztzT/iFLzAU7yXTOMBiMjBw+0Zj/YxvJsIS99SP9j9AdyD5uaKRHQhZJetrTp
         e96jgmvD84GmvBIneu6DG6sqcwdxPHN5VE1Pl7MVsUIbsNQbKb+sYNxd7XVDC9C0e/oZ
         ingET5hEmM2gcuJU9XnUZGE0LXayuDGAgB+rg5JP8T4aMTjEZKzlnxGJe0yAIr2dVQ8k
         kuOw==
X-Gm-Message-State: AOUpUlEvRvVIWvXQrDoLx45ItJ6HRD+qk1uOckmtTt47edKtANaq4EnI
        0WteBT2QxzmQF9zfydciBFqhhw==
X-Google-Smtp-Source: AAOMgpd08XrcN3Et/8X+xoiQ6kBocTeoauJ4mWumckGKA4bEi9VWmbAcWeIy1nkPMRbFxjYvNNYn1g==
X-Received: by 2002:a1c:92:: with SMTP id 140-v6mr1353415wma.87.1533022802250;
        Tue, 31 Jul 2018 00:40:02 -0700 (PDT)
Received: from [192.168.10.150] (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id l16-v6sm1135989wme.36.2018.07.31.00.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 00:40:01 -0700 (PDT)
Subject: Re: [PATCH 06/10] KVM: x86: do not load vmcs12 pages while still in
 SMM
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
 <1532819412-51357-7-git-send-email-pbonzini@redhat.com>
 <CALMp9eREhbUc73qDnNnriG+AgfXNTkmJuChbVepmCRxo+TSaaA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1e89e7a8-01cb-69d7-043c-425a66b36500@redhat.com>
Date:   Tue, 31 Jul 2018 09:40:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eREhbUc73qDnNnriG+AgfXNTkmJuChbVepmCRxo+TSaaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2018 21:27, Jim Mattson wrote:
> On Sat, Jul 28, 2018 at 4:10 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> If the vCPU enters system management mode while running a nested guest,
>> RSM starts processing the vmentry while still in SMM.  In that case,
>> however, the pages pointed to by the vmcs12 might be incorrectly
>> loaded from SMRAM.  To avoid this, delay the handling of the pages
>> until just before the next vmentry.  This is done with a new request
>> and a new entry in kvm_x86_ops, which we will be able to reuse for
>> nested VMX state migration.
>>
>> Extracted from a patch by Jim Mattson and KarimAllah Ahmed.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |  3 +++
>>  arch/x86/kvm/vmx.c              | 53 +++++++++++++++++++++++++++--------------
>>  arch/x86/kvm/x86.c              |  2 ++
>>  3 files changed, 40 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index c13cd28d9d1b..da957725992d 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -75,6 +75,7 @@
>>  #define KVM_REQ_HV_EXIT                        KVM_ARCH_REQ(21)
>>  #define KVM_REQ_HV_STIMER              KVM_ARCH_REQ(22)
>>  #define KVM_REQ_LOAD_EOI_EXITMAP       KVM_ARCH_REQ(23)
>> +#define KVM_REQ_GET_VMCS12_PAGES       KVM_ARCH_REQ(24)
>>
>>  #define CR0_RESERVED_BITS                                               \
>>         (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
>> @@ -1085,6 +1086,8 @@ struct kvm_x86_ops {
>>
>>         void (*setup_mce)(struct kvm_vcpu *vcpu);
>>
>> +       void (*get_vmcs12_pages)(struct kvm_vcpu *vcpu);
>> +
>>         int (*smi_allowed)(struct kvm_vcpu *vcpu);
>>         int (*pre_enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
>>         int (*pre_leave_smm)(struct kvm_vcpu *vcpu, u64 smbase);
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index 2630ab38d72c..17aede06ae0e 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -10636,9 +10636,9 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
>>  static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
>>                                                  struct vmcs12 *vmcs12);
>>
>> -static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
>> -                                       struct vmcs12 *vmcs12)
>> +static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
>>  {
>> +       struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>>         struct page *page;
>>         u64 hpa;
>> @@ -11750,13 +11750,18 @@ static int check_vmentry_postreqs(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>>         return 0;
>>  }
>>
>> -static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
>> +/*
>> + * If p_exit_qual is NULL, this is being called from state restore (either
>> + * kvm_set_nested_state or RSM).  Otherwise it's called from vmlaunch/vmresume.
>> + */
>> +static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *p_exit_qual)
>>  {
>>         struct vcpu_vmx *vmx = to_vmx(vcpu);
>>         struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>> +       bool from_vmentry = !!p_exit_qual;
>>         u32 msr_entry_idx;
>> -       u32 exit_qual;
>> -       int r;
>> +       u32 dummy_exit_qual;
>> +       int r = 0;
>>
>>         enter_guest_mode(vcpu);
>>
>> @@ -11770,17 +11775,27 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
>>                 vcpu->arch.tsc_offset += vmcs12->tsc_offset;
>>
>>         r = EXIT_REASON_INVALID_STATE;
>> -       if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
>> +       if (prepare_vmcs02(vcpu, vmcs12, from_vmentry ? p_exit_qual : &dummy_exit_qual))
>>                 goto fail;
>>
>> -       nested_get_vmcs12_pages(vcpu, vmcs12);
>> +       if (from_vmentry) {
>> +               nested_get_vmcs12_pages(vcpu);
>>
>> -       r = EXIT_REASON_MSR_LOAD_FAIL;
>> -       msr_entry_idx = nested_vmx_load_msr(vcpu,
>> -                                           vmcs12->vm_entry_msr_load_addr,
>> -                                           vmcs12->vm_entry_msr_load_count);
>> -       if (msr_entry_idx)
>> -               goto fail;
>> +               r = EXIT_REASON_MSR_LOAD_FAIL;
>> +               msr_entry_idx = nested_vmx_load_msr(vcpu,
>> +                                                   vmcs12->vm_entry_msr_load_addr,
>> +                                                   vmcs12->vm_entry_msr_load_count);
>> +               if (msr_entry_idx)
>> +                       goto fail;
>> +       } else {
>> +               /*
>> +                * The MMU is not initialized to point at the right entities yet and
>> +                * "get pages" would need to read data from the guest (i.e. we will
>> +                * need to perform gpa to hpa translation). Request a call
>> +                * to nested_get_vmcs12_pages before the next VM-entry.
>> +                */
>> +               kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
>> +       }
> 
> The from_vmentry variable seems unnecessary. Why not (a) hoist the
> call to nested_vmx_load_msr() into nested_vmx_run and (b) always use
> the deferred KVM_REQ_GET_VMCS12_PAGES?

Yeah, I thought about that.  from_vmentry is ugly.

However, for (a) you would have to duplicate the code at the "fail"
label, which is uglier than from_vmentry; as to (b), it is a little bit
slower and our nested vmentry is already slow enough...

Paolo

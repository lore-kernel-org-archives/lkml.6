Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55085C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0804020840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzAjDGEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0804020840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeKJHyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:54:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39348 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeKJHyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:54:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id g27so3033621oth.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 14:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cVJzDokP8G7rTZxK4K6d9MiLT0ljzEFm46DI5ADvF9o=;
        b=qzAjDGEFHe3y7i2Dle17nRfs1V4Dir33ggKqNj9EIVUX0dmh46XLC/YjmpzKcBHNSh
         0WV/bCnGZAx3m2q+RC8Eo4vbf/1W3khoFqE2TIfoB6cH3S+ATj/4fu+D42udouuJdFAL
         zPxmThLnQQeaKoNnGTRcfTEtgeJRdge1O/rLANGj8rJGNJNLiSxZ8EnrPn74ZvRWi14z
         P4yU+f4LaY3rNkNl+2YojC/UGm5FAUA+Zuh/AjWNHZDQ6UP25m1ywmFo67tZCjJ0xR9B
         QIofQbo61CunjagZvj9cees7Cr10zscWzV7DqcKMNliRl/Lig9L2zD0GFZX20NJhmLAM
         U9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cVJzDokP8G7rTZxK4K6d9MiLT0ljzEFm46DI5ADvF9o=;
        b=ZeygCBHM46oJQu+gg0c5apO6VukpEPRmd3lc0bVYgZssZ2FitHXoztinqHb46VhKe9
         RQevGNr2ssMLF7eMOgDXwB8tWCvIgJWdm4AKfa7fuxTQ0R/b/9ns7267hN7JwDnN0KTA
         jGCsawgP6ni4R+LM81W8k8Lm2bulgQY59Y9X/Sy56eo/VGpZ90EedFe5eRVu9wKxuL13
         sUgBvR862L9pHRGNBHlcNU4fZSAzrzuYmB2wF+XicTOhQdCLHEBP6tDq4XANvFh5Javn
         ic4nOKCmc1eBPdPIbpVz4Osaxfyp4Oejybxa2QwZ7orT3qw12K6DnhLGD3vILg3fAOGz
         GIhQ==
X-Gm-Message-State: AGRZ1gJKNdVPibqdgOrVPIJmuYJV1QIwbBQxwwghWpA9l+LN5XRAe+2F
        TZagsHZ8IxOee24A7fC1rRasZsbiGF8ZAsgncFp72g==
X-Google-Smtp-Source: AJdET5dx344uZxtIBYDqmjN+LtVOWI5+j4NgTE1QHhWHzOWArOcbYn0ogK+wLNtsutkKqasj5D4iz8uzpkiPMa/Zc+Y=
X-Received: by 2002:a9d:bee:: with SMTP id 101mr6697315oth.120.1541801495753;
 Fri, 09 Nov 2018 14:11:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:31a7:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 14:11:35 -0800 (PST)
In-Reply-To: <31279dfd-d0a1-3720-46a2-52395a124057@redhat.com>
References: <20181019141603.15995-1-vkuznets@redhat.com> <31279dfd-d0a1-3720-46a2-52395a124057@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 9 Nov 2018 14:11:35 -0800
Message-ID: <CALMp9eQ4493qH4sA4e5UibaHhatEKnztGNBO2s40jc2jXXCdUQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm/nVMX: tweak shadow fields
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not convinced that the "one size fits all" and "context-free"
approaches to VMCS shadowing are terribly effective.

For example, we never shadow VMX_INSTRUCTION_INFO, but if we just
reflected an exit to L1 for which that field is defined, there's
probably a good chance that L1 will use it. We always shadow
VM_EXIT_INTR_INFO, but if we didn't just reflect exit reason 0 to L1,
it's not likely to be read. If the L2 guest is in legacy mode or
compatibility mode, L1 is much more likely to be interested in the
contents of the descriptor cache than if the guest is in 64-bit mode.

Some hypervisors write TSC_OFFSET quite frequently. Others rarely.
Last time I checked (it's been a while), VirtualBox was always
interested in everything. :-) Kvm, Hyper-V, VMware, VirtualBox,
Parallels...they all have different patterns, and they change from
release to release.

Is it worth having a set of VMCS shadowing bitmaps per-vCPU, in order
to make better use of this feature?

On Fri, Oct 19, 2018 at 9:45 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 19/10/2018 16:16, Vitaly Kuznetsov wrote:
>> It seems we have some leftovers from times when 'unrestricted guest'
>> wasn't exposed to L1. Stop shadowing GUEST_CS_{BASE,LIMIT,AR_SELECTOR}
>> and GUEST_ES_BASE, shadow GUEST_SS_AR_BYTES as it was found that some
>> hypervisors (e.g. Hyper-V without Enlightened VMCS) access it pretty
>> often.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> Queued, thanks.
>
> Paolo
>
>> ---
>>  arch/x86/kvm/vmx.c               | 10 +++++-----
>>  arch/x86/kvm/vmx_shadow_fields.h |  5 +----
>>  2 files changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> index abeeb45d1c33..641a65b30685 100644
>> --- a/arch/x86/kvm/vmx.c
>> +++ b/arch/x86/kvm/vmx.c
>> @@ -12715,6 +12715,7 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>>       if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>>                          HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
>>               vmcs_write16(GUEST_ES_SELECTOR, vmcs12->guest_es_selector);
>> +             vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>>               vmcs_write16(GUEST_SS_SELECTOR, vmcs12->guest_ss_selector);
>>               vmcs_write16(GUEST_DS_SELECTOR, vmcs12->guest_ds_selector);
>>               vmcs_write16(GUEST_FS_SELECTOR, vmcs12->guest_fs_selector);
>> @@ -12722,6 +12723,7 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>>               vmcs_write16(GUEST_LDTR_SELECTOR, vmcs12->guest_ldtr_selector);
>>               vmcs_write16(GUEST_TR_SELECTOR, vmcs12->guest_tr_selector);
>>               vmcs_write32(GUEST_ES_LIMIT, vmcs12->guest_es_limit);
>> +             vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>>               vmcs_write32(GUEST_SS_LIMIT, vmcs12->guest_ss_limit);
>>               vmcs_write32(GUEST_DS_LIMIT, vmcs12->guest_ds_limit);
>>               vmcs_write32(GUEST_FS_LIMIT, vmcs12->guest_fs_limit);
>> @@ -12731,12 +12733,13 @@ static void prepare_vmcs02_full(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>>               vmcs_write32(GUEST_GDTR_LIMIT, vmcs12->guest_gdtr_limit);
>>               vmcs_write32(GUEST_IDTR_LIMIT, vmcs12->guest_idtr_limit);
>>               vmcs_write32(GUEST_ES_AR_BYTES, vmcs12->guest_es_ar_bytes);
>> -             vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
>>               vmcs_write32(GUEST_DS_AR_BYTES, vmcs12->guest_ds_ar_bytes);
>>               vmcs_write32(GUEST_FS_AR_BYTES, vmcs12->guest_fs_ar_bytes);
>>               vmcs_write32(GUEST_GS_AR_BYTES, vmcs12->guest_gs_ar_bytes);
>>               vmcs_write32(GUEST_LDTR_AR_BYTES, vmcs12->guest_ldtr_ar_bytes);
>>               vmcs_write32(GUEST_TR_AR_BYTES, vmcs12->guest_tr_ar_bytes);
>> +             vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
>> +             vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>>               vmcs_writel(GUEST_SS_BASE, vmcs12->guest_ss_base);
>>               vmcs_writel(GUEST_DS_BASE, vmcs12->guest_ds_base);
>>               vmcs_writel(GUEST_FS_BASE, vmcs12->guest_fs_base);
>> @@ -12838,11 +12841,8 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>>        */
>>       if (!hv_evmcs || !(hv_evmcs->hv_clean_fields &
>>                          HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_GRP2)) {
>> -             vmcs_write16(GUEST_CS_SELECTOR, vmcs12->guest_cs_selector);
>> -             vmcs_write32(GUEST_CS_LIMIT, vmcs12->guest_cs_limit);
>>               vmcs_write32(GUEST_CS_AR_BYTES, vmcs12->guest_cs_ar_bytes);
>> -             vmcs_writel(GUEST_ES_BASE, vmcs12->guest_es_base);
>> -             vmcs_writel(GUEST_CS_BASE, vmcs12->guest_cs_base);
>> +             vmcs_write32(GUEST_SS_AR_BYTES, vmcs12->guest_ss_ar_bytes);
>>       }
>>
>>       if (vmx->nested.nested_run_pending &&
>> diff --git a/arch/x86/kvm/vmx_shadow_fields.h b/arch/x86/kvm/vmx_shadow_fields.h
>> index cd0c75f6d037..132432f375c2 100644
>> --- a/arch/x86/kvm/vmx_shadow_fields.h
>> +++ b/arch/x86/kvm/vmx_shadow_fields.h
>> @@ -28,7 +28,6 @@
>>   */
>>
>>  /* 16-bits */
>> -SHADOW_FIELD_RW(GUEST_CS_SELECTOR)
>>  SHADOW_FIELD_RW(GUEST_INTR_STATUS)
>>  SHADOW_FIELD_RW(GUEST_PML_INDEX)
>>  SHADOW_FIELD_RW(HOST_FS_SELECTOR)
>> @@ -47,8 +46,8 @@ SHADOW_FIELD_RW(VM_ENTRY_EXCEPTION_ERROR_CODE)
>>  SHADOW_FIELD_RW(VM_ENTRY_INTR_INFO_FIELD)
>>  SHADOW_FIELD_RW(VM_ENTRY_INSTRUCTION_LEN)
>>  SHADOW_FIELD_RW(TPR_THRESHOLD)
>> -SHADOW_FIELD_RW(GUEST_CS_LIMIT)
>>  SHADOW_FIELD_RW(GUEST_CS_AR_BYTES)
>> +SHADOW_FIELD_RW(GUEST_SS_AR_BYTES)
>>  SHADOW_FIELD_RW(GUEST_INTERRUPTIBILITY_INFO)
>>  SHADOW_FIELD_RW(VMX_PREEMPTION_TIMER_VALUE)
>>
>> @@ -61,8 +60,6 @@ SHADOW_FIELD_RW(GUEST_CR0)
>>  SHADOW_FIELD_RW(GUEST_CR3)
>>  SHADOW_FIELD_RW(GUEST_CR4)
>>  SHADOW_FIELD_RW(GUEST_RFLAGS)
>> -SHADOW_FIELD_RW(GUEST_CS_BASE)
>> -SHADOW_FIELD_RW(GUEST_ES_BASE)
>>  SHADOW_FIELD_RW(CR0_GUEST_HOST_MASK)
>>  SHADOW_FIELD_RW(CR0_READ_SHADOW)
>>  SHADOW_FIELD_RW(CR4_READ_SHADOW)
>>
>

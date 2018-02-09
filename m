Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeBIX0z (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 18:26:55 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:39301 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753085AbeBIX0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 18:26:53 -0500
X-Google-Smtp-Source: AH8x224qeh0BL45+CWaQYLG0K8XkCt3D5K/F57K2I0Pecbo3ye5JLU5FXcCifWPA4XS7b4XX4Dwh4nzd5Wdziu6wGR8=
MIME-Version: 1.0
In-Reply-To: <1518130410-6583-3-git-send-email-karahmed@amazon.de>
References: <1518130410-6583-1-git-send-email-karahmed@amazon.de> <1518130410-6583-3-git-send-email-karahmed@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 9 Feb 2018 15:26:51 -0800
Message-ID: <CALMp9eThOMGTru3hnuupJ_m4jPA7Hf=5=8ZJ4ygmC50vsDmngw@mail.gmail.com>
Subject: Re: [PATCH 3/3] X86/nVMX: Update the MSR_BITMAP field with the L02
 MSR BITMAP
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w19NQxYo018510

On Thu, Feb 8, 2018 at 2:53 PM, KarimAllah Ahmed <karahmed@amazon.de> wrote:
> ... otherwise we will just be running with the L1 MSR BITMAP!
>
> It does not seem that we ever update the MSR_BITMAP when the nested guest
> is running. The only place where we update the MSR_BITMAP field in VMCS is
> for the L1 guest!
>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kvm/vmx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 91e3539..f40be10 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -10589,6 +10589,9 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
>         vmcs_writel(GUEST_GDTR_BASE, vmcs12->guest_gdtr_base);
>         vmcs_writel(GUEST_IDTR_BASE, vmcs12->guest_idtr_base);
>
> +       if (cpu_has_vmx_msr_bitmap())
> +               vmcs_write64(MSR_BITMAP, __pa(vmx->nested.vmcs02.msr_bitmap));
> +

This is already in David's "[PATCH 5/9] KVM: VMX: make MSR bitmaps
per-VCPU," isn't it?

>         if (from_vmentry &&
>             (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS)) {
>                 kvm_set_dr(vcpu, 7, vmcs12->guest_dr7);
> --
> 2.7.4
>

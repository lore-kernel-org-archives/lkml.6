Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbeDMQDD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 12:03:03 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39432 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeDMQDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 12:03:00 -0400
X-Google-Smtp-Source: AIpwx4/gwXTgK7EWKH0+yiiOGMuDw6bxtaU3VodPeB+pbQUfJVnUd5hrokQMr/rOPFTO/NNiNzL/AgRTJErmPJyLcSc=
MIME-Version: 1.0
In-Reply-To: <1523618608-30574-2-git-send-email-pbonzini@redhat.com>
References: <1523618608-30574-1-git-send-email-pbonzini@redhat.com> <1523618608-30574-2-git-send-email-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 13 Apr 2018 09:02:58 -0700
Message-ID: <CALMp9eSj=mNQbMzyBNQQWPPsijrrjmTFA9A=H-7KEwbfDqZz2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3DG37gn012456

On Fri, Apr 13, 2018 at 4:23 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: KarimAllah Ahmed <karahmed@amazon.de>
>
> Update 'tsc_offset' on vmenty/vmexit of L2 guests to ensure that it always
> captures the TSC_OFFSET of the running guest whether it is the L1 or L2
> guest.
>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> [AMD changes, fix update_ia32_tsc_adjust_msr. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> @@ -11489,6 +11497,9 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
>         if (enable_shadow_vmcs)
>                 copy_shadow_to_vmcs12(vmx);
>
> +       if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> +               vcpu->arch.tsc_offset += vmcs12->tsc_offset;
> +

This seems a little early, since we don't restore the L1 TSC offset on
the nested_vmx_failValid path.

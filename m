Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753542AbeBGGl4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 01:41:56 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45876 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbeBGGly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 01:41:54 -0500
X-Google-Smtp-Source: AH8x22551XumqEnwEq5/dRXhSl1GAPdZZjcq6EK4te7ZvLhA2bnvijxRSQlL0vzrP7vwNuNxX5j14U5wrGjMC+6pJTU=
MIME-Version: 1.0
In-Reply-To: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 7 Feb 2018 07:41:33 +0100
Message-ID: <CACT4Y+ZEah_QHsq1VJ8jFGFG6UPkHMojhEDyaSWyVHvxxJfg_A@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w176g3kx004798

On Wed, Feb 7, 2018 at 7:25 AM, Wanpeng Li <kernellwp@gmail.com> wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
>
> Reported by syzkaller:
>
>    WARNING: CPU: 6 PID: 2434 at arch/x86/kvm/vmx.c:6660 handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
>    CPU: 6 PID: 2434 Comm: repro_test Not tainted 4.15.0+ #4
>    RIP: 0010:handle_ept_misconfig+0x54/0x1e0 [kvm_intel]
>    Call Trace:
>     vmx_handle_exit+0xbd/0xe20 [kvm_intel]
>     kvm_arch_vcpu_ioctl_run+0xdaf/0x1d50 [kvm]
>     kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
>     do_vfs_ioctl+0xa4/0x6a0
>     SyS_ioctl+0x79/0x90
>     entry_SYSCALL_64_fastpath+0x25/0x9c
>
> The syzkaller creates a former thread to issue KVM_SMI ioctl, and then creates
> a latter thread to mmap and operate on the same vCPU, rsm emulation will not be
> executed since there is no something like seabios which implements smi handler
> when running syzkaller directly. This triggers a race condition when running
> the testcase with multiple threads. Sometimes one thread exit w/ SHUTDOWN
> reason, another thread mmaps and operates on the same vCPU, it continues to
> use CS=0x30000, IP=0x8000 to access the address of SMI handler which results
> in the above ept misconfig. This patch fixes it by bailing out immediately if
> the vCPU is marked EXIT_SHUTDOWN reason.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>

This was reported by syzbot:
https://groups.google.com/d/msg/syzkaller-bugs/6GrlY0UcDEk/aMShRKq3AwAJ

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c1d9517cab094dae65e446c0c5b4de6c40f4dc58@syzkaller.appspotmail.com
It will help syzbot understand when the bug is fixed.


> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 786cd00..445e702 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7458,6 +7458,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>                 goto out;
>         }
>
> +       if (unlikely(vcpu->run->exit_reason == KVM_EXIT_SHUTDOWN)) {
> +               r = -EINVAL;
> +               goto out;
> +       }
> +
>         if (vcpu->run->kvm_dirty_regs) {
>                 r = sync_regs(vcpu);
>                 if (r != 0)
> --
> 2.7.4
>

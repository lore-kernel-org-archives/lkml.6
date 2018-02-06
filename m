Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbeBFA55 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 19:57:57 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44373 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeBFA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 19:57:39 -0500
X-Google-Smtp-Source: AH8x226DVtLvGognYg1a+AzyfJP1NBJFpStHWpZB9RnQumyIZI96IFMpmI4GZ3igaDGr5mWslMwi0seLFXRfvQEy6WA=
MIME-Version: 1.0
In-Reply-To: <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com>
References: <1517828686-29070-1-git-send-email-wanpengli@tencent.com>
 <CALMp9eQNB+2KLAR2Tv+By2oTthRLvAQMmJiEs61kFNrZDct3_g@mail.gmail.com> <CALMp9eSXvMmRj15q26_=VpJhYfUL_gHP-ce4h9bCv0N55JtT1w@mail.gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 6 Feb 2018 08:57:37 +0800
Message-ID: <CANRm+Cx_KVftOfeGWjqn_1P=j8R-NsNcH7w+pA9gCouM_4FDRw@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Fix CR4 after VMLAUNCH/VMRESUME failure
To: Jim Mattson <jmattson@google.com>
Cc: kvm list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Radim Krcmar <rkrcmar@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w160w1IT023079

2018-02-06 2:24 GMT+08:00 Jim Mattson <jmattson@google.com>:
> [Resending as plain text]
>
> On Mon, Feb 5, 2018 at 10:21 AM Jim Mattson <jmattson@google.com> wrote:
>
>> This is incorrect. In the event of an early VM-entry failure (e.g. a
>> VM-entry failure for "VM entry with invalid control field(s)"), no host
>> state should be loaded from the VMCS12. Of course, no guest state should
>> have been loaded from the VMCS12 either, but that's a problem we have with
>> deferring some VMCS12 control field checks to the hardware.
>
>> CR4 should be unchanged from the time of the VMLAUNCH/VMRESUME. There is

This is effective one, what I restore in this patch is
achitectural/guest visible.

Regards,
Wanpeng Li

>> no guarantee that vmcs12->host_cr4 holds the correct value.
>
>
>> On Mon, Feb 5, 2018 at 3:05 AM Wanpeng Li <kernellwp@gmail.com> wrote:
>
>>> From: Wanpeng Li <wanpengli@tencent.com>
>
>>> In L0, Haswell client host:
>
>>>   nested_vmx_exit_reflected failed vm entry 7
>>>   WARNING: CPU: 6 PID: 6797 at kvm/arch/x86/kvm//vmx.c:6206
>>> handle_desc+0x2d/0x40 [kvm_intel]
>>>   CPU: 6 PID: 6797 Comm: qemu-system-x86 Tainted: G        W  OE
>>> 4.15.0+ #4
>>>   RIP: 0010:handle_desc+0x2d/0x40 [kvm_intel]
>>>   Call Trace:
>>>    vmx_handle_exit+0xbd/0xe20 [kvm_intel]
>>>    ? kvm_arch_vcpu_ioctl_run+0xcde/0x1c00 [kvm]
>>>    kvm_arch_vcpu_ioctl_run+0xd5a/0x1c00 [kvm]
>>>    kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
>>>    ? kvm_vcpu_ioctl+0x3e9/0x720 [kvm]
>>>    ? __fget+0xfc/0x210
>>>    ? __fget+0xfc/0x210
>>>    do_vfs_ioctl+0xa4/0x6a0
>>>    ? __fget+0x11d/0x210
>>>    SyS_ioctl+0x79/0x90
>>>    entry_SYSCALL_64_fastpath+0x25/0x9c
>
>>> This can be reproduced by running kvm-unit-tests/run_tests.sh
>>> vmx_controls in
>>> L1. UMIP CPUID bit is exposed to the L1 UMIP aware guest since it is
>>> emulated
>>> by enabling descriptor-table exits on L0. There is a vmentry fail when
>>> L0 tries to run L2 directly, the L1 guest architectural CR4 is not
>>> restored
>>> after this failure since commit 4f350c6dbcb (kvm: nVMX: Handle deferred
>>> early
>>> VMLAUNCH/VMRESUME failure properly). The L2 is kvm-unit-tests which will
>>> not
>>> write CR4 w/ X86_CR4_UMIP bit. After another L1 access descriptor vmexit,
>>> we
>>> check L2's architectural CR4 instead of L1's architectural CR4. This
>>> patch
>>> fixes it by restoring L1's architectural CR4 after L0's VMLAUNCH/VMRESUME
>>> failure.
>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> ---
>>>   arch/x86/kvm/vmx.c | 1 +
>>>   1 file changed, 1 insertion(+)
>
>>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>>> index 23789c9..9fc0492 100644
>>> --- a/arch/x86/kvm/vmx.c
>>> +++ b/arch/x86/kvm/vmx.c
>>> @@ -11633,6 +11633,7 @@ static void nested_vmx_vmexit(struct kvm_vcpu
>>> *vcpu, u32 exit_reason,
>>>           */
>>>          nested_vmx_failValid(vcpu, VMXERR_ENTRY_INVALID_CONTROL_FIELD);
>
>>> +       vcpu->arch.cr4 = vmcs12->host_cr4;
>>>          load_vmcs12_mmu_host_state(vcpu, vmcs12);
>
>>>          /*
>>> --
>>> 2.7.4

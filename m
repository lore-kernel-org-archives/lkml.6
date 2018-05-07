Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeEGW5B (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:57:01 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:39948 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeEGW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:56:59 -0400
X-Google-Smtp-Source: AB8JxZo9q7T3yu2pvsq7kzngkeEp/Vxbqj0ef7Mf7muji/FTQDuJUCtB7RmyHoZpbdDgJgejQK+Ir5XeDXbeAa7i2+8=
MIME-Version: 1.0
In-Reply-To: <CALMp9eTGeqV21MtMRsvsBsKn6VT7qHNrh8ciT1zueLZ0z1-dww@mail.gmail.com>
References: <1509670249-4907-1-git-send-email-wanpeng.li@hotmail.com>
 <1509670249-4907-3-git-send-email-wanpeng.li@hotmail.com> <50b82c53-1e57-88a9-25bd-76697bf2d048@oracle.com>
 <CALMp9eSoGfhutN3R7pYBYsG-Guu9tNG4ebc5r+MjD+Epxi0=Dw@mail.gmail.com> <CALMp9eTGeqV21MtMRsvsBsKn6VT7qHNrh8ciT1zueLZ0z1-dww@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 7 May 2018 15:56:58 -0700
Message-ID: <CALMp9eSJ0UpH9zLT0+uf3+vPa1wvhZSY9wiyWF7_HFOL9jKC=A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] KVM: nVMX: Fix mmu context after VMLAUNCH/VMRESUME failure
To: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc: Wanpeng Li <kernellwp@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47Mv7YO028194

Moreover, if the VMLAUNCH/VMRESUME is in 32-bit PAE mode, then the
PDPTRs should not be reloaded.

On Mon, Feb 5, 2018 at 10:44 AM, Jim Mattson <jmattson@google.com> wrote:
> I realize now that this fix isn't quite right, since it loads
> vmcs12->host_cr3 rather than reverting to the CR3 that was loaded at the
> time of VMLAUNCH/VMRESUME. In the case of VMfailValid(VM entry with invalid
> VMX-control field(s)), none of the VMCS12 host state fields should be
> loaded. See the pseudocode for VMLAUNCH/VMRESUME in volume 3 of the SDM.
>
>
> On Wed, Nov 8, 2017 at 1:47 PM Jim Mattson <jmattson@google.com> wrote:
>
>> I realize now that there are actually many other problems with
>> deferring some control field checks to the hardware VM-entry of
>> vmcs02. When there is an invalid control field, the vCPU should just
>> fall through to the next instruction, without any state modifiation
>> other than the ALU flags and the VM-instruction error field of the
>> current VMCS. However, in preparation for the hardware VM-entry of
>> vmcs02, we have already changed quite a bit of the vCPU state: the
>> MSRs on the VM-entry MSR-load list, DR7, IA32_DEBUGCTL, the entire
>> FLAGS register, etc. All of these changes should be undone, and we're
>> not prepared to do that. (For instance, what was the old DR7 value
>> that needs to be restored?)
>
>
>> On Fri, Nov 3, 2017 at 5:07 PM, Krish Sadhukhan
>> <krish.sadhukhan@oracle.com> wrote:
>> > On 11/02/2017 05:50 PM, Wanpeng Li wrote:
>> >
>> >> From: Wanpeng Li <wanpeng.li@hotmail.com>
>> >>
>> >> Commit 4f350c6dbcb (kvm: nVMX: Handle deferred early VMLAUNCH/VMRESUME
>> >> failure
>> >> properly) can result in L1(run kvm-unit-tests/run_tests.sh vmx_controls
>> in
>> >> L1)
>> >> null pointer deference and also L0 calltrace when EPT=0 on both L0 and
>> L1.
>> >>
>> >> In L1:
>> >>
>> >> BUG: unable to handle kernel paging request at ffffffffc015bf8f
>> >>   IP: vmx_vcpu_run+0x202/0x510 [kvm_intel]
>> >>   PGD 146e13067 P4D 146e13067 PUD 146e15067 PMD 3d2686067 PTE 3d4af9161
>> >>   Oops: 0003 [#1] PREEMPT SMP
>> >>   CPU: 2 PID: 1798 Comm: qemu-system-x86 Not tainted 4.14.0-rc4+ #6
>> >>   RIP: 0010:vmx_vcpu_run+0x202/0x510 [kvm_intel]
>> >>   Call Trace:
>> >>   WARNING: kernel stack frame pointer at ffffb86f4988bc18 in
>> >> qemu-system-x86:1798 has bad value 0000000000000002
>> >>
>> >> In L0:
>> >>
>> >> -----------[ cut here ]------------
>> >>   WARNING: CPU: 6 PID: 4460 at
>> /home/kernel/linux/arch/x86/kvm//vmx.c:9845
>> >> vmx_inject_page_fault_nested+0x130/0x140 [kvm_intel]
>> >>   CPU: 6 PID: 4460 Comm: qemu-system-x86 Tainted: G           OE
>> >> 4.14.0-rc7+ #25
>> >>   RIP: 0010:vmx_inject_page_fault_nested+0x130/0x140 [kvm_intel]
>> >>   Call Trace:
>> >>    paging64_page_fault+0x500/0xde0 [kvm]
>> >>    ? paging32_gva_to_gpa_nested+0x120/0x120 [kvm]
>> >>    ? nonpaging_page_fault+0x3b0/0x3b0 [kvm]
>> >>    ? __asan_storeN+0x12/0x20
>> >>    ? paging64_gva_to_gpa+0xb0/0x120 [kvm]
>> >>    ? paging64_walk_addr_generic+0x11a0/0x11a0 [kvm]
>> >>    ? lock_acquire+0x2c0/0x2c0
>> >>    ? vmx_read_guest_seg_ar+0x97/0x100 [kvm_intel]
>> >>    ? vmx_get_segment+0x2a6/0x310 [kvm_intel]
>> >>    ? sched_clock+0x1f/0x30
>> >>    ? check_chain_key+0x137/0x1e0
>> >>    ? __lock_acquire+0x83c/0x2420
>> >>    ? kvm_multiple_exception+0xf2/0x220 [kvm]
>> >>    ? debug_check_no_locks_freed+0x240/0x240
>> >>    ? debug_smp_processor_id+0x17/0x20
>> >>    ? __lock_is_held+0x9e/0x100
>> >>    kvm_mmu_page_fault+0x90/0x180 [kvm]
>> >>    kvm_handle_page_fault+0x15c/0x310 [kvm]
>> >>    ? __lock_is_held+0x9e/0x100
>> >>    handle_exception+0x3c7/0x4d0 [kvm_intel]
>> >>    vmx_handle_exit+0x103/0x1010 [kvm_intel]
>> >>    ? kvm_arch_vcpu_ioctl_run+0x1628/0x2e20 [kvm]
>> >>
>> >> The commit avoids to load host state of vmcs12 as vmcs01's guest state
>> >> since vmcs12 is not modified (except for the VM-instruction error
>> >> field)
>> >> if the checking of vmcs control area fails. However, the mmu context is
>> >> switched to nested mmu in prepare_vmcs02() and it will not be reloaded
>> >> since load_vmcs12_host_state() is skipped when nested VMLAUNCH/VMRESUME
>> >> fails. This patch fixes it by reloading mmu context when nested
>> >> VMLAUNCH/VMRESUME fails.
>> >>
>> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> >> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> >> Cc: Jim Mattson <jmattson@google.com>
>> >> Signed-off-by: Wanpeng Li <wanpeng.li@hotmail.com>
>> >> ---
>> >> v3 -> v4:
>> >>   * move it to a new function load_vmcs12_mmu_host_state
>> >>
>> >>   arch/x86/kvm/vmx.c | 34 ++++++++++++++++++++++------------
>> >>   1 file changed, 22 insertions(+), 12 deletions(-)
>> >>
>> >> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>> >> index 6cf3972..8aefb91 100644
>> >> --- a/arch/x86/kvm/vmx.c
>> >> +++ b/arch/x86/kvm/vmx.c
>> >> @@ -11259,6 +11259,24 @@ static void prepare_vmcs12(struct kvm_vcpu
>> *vcpu,
>> >> struct vmcs12 *vmcs12,
>> >>         kvm_clear_interrupt_queue(vcpu);
>> >>   }
>> >>   +static void load_vmcs12_mmu_host_state(struct kvm_vcpu *vcpu,
>> >> +                       struct vmcs12 *vmcs12)
>> >> +{
>> >> +       u32 entry_failure_code;
>> >> +
>> >> +       nested_ept_uninit_mmu_context(vcpu);
>> >> +
>> >> +       /*
>> >> +        * Only PDPTE load can fail as the value of cr3 was checked on
>> >> entry and
>> >> +        * couldn't have changed.
>> >> +        */
>> >> +       if (nested_vmx_load_cr3(vcpu, vmcs12->host_cr3, false,
>> >> &entry_failure_code))
>> >> +               nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);
>> >> +
>> >> +       if (!enable_ept)
>> >> +               vcpu->arch.walk_mmu->inject_page_fault =
>> >> kvm_inject_page_fault;
>> >> +}
>> >> +
>> >>   /*
>> >>    * A part of what we need to when the nested L2 guest exits and we
>> want
>> >> to
>> >>    * run its L1 parent, is to reset L1's guest state to the host state
>> >> specified
>> >> @@ -11272,7 +11290,6 @@ static void load_vmcs12_host_state(struct
>> kvm_vcpu
>> >> *vcpu,
>> >>                                    struct vmcs12 *vmcs12)
>> >>   {
>> >>         struct kvm_segment seg;
>> >> -       u32 entry_failure_code;
>> >>         if (vmcs12->vm_exit_controls & VM_EXIT_LOAD_IA32_EFER)
>> >>                 vcpu->arch.efer = vmcs12->host_ia32_efer;
>> >> @@ -11299,17 +11316,7 @@ static void load_vmcs12_host_state(struct
>> >> kvm_vcpu *vcpu,
>> >>         vcpu->arch.cr4_guest_owned_bits =
>> >> ~vmcs_readl(CR4_GUEST_HOST_MASK);
>> >>         vmx_set_cr4(vcpu, vmcs12->host_cr4);
>> >>   -     nested_ept_uninit_mmu_context(vcpu);
>> >> -
>> >> -       /*
>> >> -        * Only PDPTE load can fail as the value of cr3 was checked on
>> >> entry and
>> >> -        * couldn't have changed.
>> >> -        */
>> >> -       if (nested_vmx_load_cr3(vcpu, vmcs12->host_cr3, false,
>> >> &entry_failure_code))
>> >> -               nested_vmx_abort(vcpu, VMX_ABORT_LOAD_HOST_PDPTE_FAIL);
>> >> -
>> >> -       if (!enable_ept)
>> >> -               vcpu->arch.walk_mmu->inject_page_fault =
>> >> kvm_inject_page_fault;
>> >> +       load_vmcs12_mmu_host_state(vcpu, vmcs12);
>> >>         if (enable_vpid) {
>> >>                 /*
>> >> @@ -11539,6 +11546,9 @@ static void nested_vmx_vmexit(struct kvm_vcpu
>> >> *vcpu, u32 exit_reason,
>> >>          * accordingly.
>> >>          */
>> >>         nested_vmx_failValid(vcpu, VMXERR_ENTRY_INVALID_CONTROL_FIELD);
>> >> +
>> >> +       load_vmcs12_mmu_host_state(vcpu, vmcs12);
>> >> +
>> >>         /*
>> >>          * The emulated instruction was already skipped in
>> >>          * nested_vmx_run, but the updated RIP was never
>> >
>> > Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
>
>

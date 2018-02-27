Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeB0J0b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:26:31 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36571 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeB0J01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:26:27 -0500
X-Google-Smtp-Source: AG47ELvmOEWvveWQ3H2+yWdM25S/xcxaE7FJPVQhf2Qzgx0+7dS7SqfWhYAP6nZRdzM3okZSazTEzzR1YfxUgFEC0Ww=
MIME-Version: 1.0
In-Reply-To: <b6051971-04a5-09e7-d11f-3689369292fe@redhat.com>
References: <1519698910-4272-1-git-send-email-wanpengli@tencent.com> <b6051971-04a5-09e7-d11f-3689369292fe@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 27 Feb 2018 17:26:26 +0800
Message-ID: <CANRm+CzvN5ypz=Y2moJQph36O5tpDbqzJtB2N_8Hm3guqWXYSg@mail.gmail.com>
Subject: Re: [PATCH v4] KVM: X86: Allow userspace to define the microcode version
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1R9Qchp001138

2018-02-27 16:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
> On 27/02/2018 03:35, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Linux (among the others) has checks to make sure that certain features
>> aren't enabled on a certain family/model/stepping if the microcode version
>> isn't greater than or equal to a known good version.
>>
>> By exposing the real microcode version, we're preventing buggy guests that
>> don't check that they are running virtualized (i.e., they should trust the
>> hypervisor) from disabling features that are effectively not buggy.
>>
>> Suggested-by: Filippo Sironi <sironi@amazon.de>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: Liran Alon <liran.alon@oracle.com>
>> Cc: Nadav Amit <nadav.amit@gmail.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>> ---
>> v3 -> v4:
>>  * add the shifts back
>
> Please wait for a review instead of pushing new versions continuously.
> Leaving the shifts means that MSR_IA32_UCODE_REV's bits 0-31 are zeroed
> even if KVM_SET_MSRS makes them nonzero.

How about something like this?

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 938d453..df6720f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -507,6 +507,7 @@ struct kvm_vcpu_arch {
  u64 smi_count;
  bool tpr_access_reporting;
  u64 ia32_xss;
+ u64 microcode_version;

  /*
  * Paging state of the vcpu
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f874798..312f33f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1907,6 +1907,7 @@ static void svm_vcpu_reset(struct kvm_vcpu
*vcpu, bool init_event)
  u32 dummy;
  u32 eax = 1;

+ vcpu->arch.microcode_version = 0x01000065;
  svm->spec_ctrl = 0;

  if (!init_event) {
@@ -3962,9 +3963,6 @@ static int svm_get_msr(struct kvm_vcpu *vcpu,
struct msr_data *msr_info)

  msr_info->data = svm->spec_ctrl;
  break;
- case MSR_IA32_UCODE_REV:
- msr_info->data = 0x01000065;
- break;
  case MSR_F15H_IC_CFG: {

  int family, model;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9968906..2cdbea7 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5781,6 +5781,7 @@ static void vmx_vcpu_reset(struct kvm_vcpu
*vcpu, bool init_event)
  vmx->rmode.vm86_active = 0;
  vmx->spec_ctrl = 0;

+ vcpu->arch.microcode_version = 0x100000000ULL;
  vmx->vcpu.arch.regs[VCPU_REGS_RDX] = get_rdx_init_val();
  kvm_set_cr8(vcpu, 0);

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d4985a9..7afffd3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1058,6 +1058,7 @@ static unsigned num_emulated_msrs;
 static u32 msr_based_features[] = {
  MSR_IA32_ARCH_CAPABILITIES,
  MSR_F10H_DECFG,
+ MSR_IA32_UCODE_REV,
 };

 static unsigned int num_msr_based_features;
@@ -1067,8 +1068,14 @@ static int do_get_msr_feature(struct kvm_vcpu
*vcpu, unsigned index, u64 *data)
  struct kvm_msr_entry msr;

  msr.index = index;
- if (kvm_x86_ops->get_msr_feature(&msr))
- return 1;
+ switch (msr.index) {
+ case MSR_IA32_UCODE_REV:
+ rdmsrl(msr.index, msr.data);
+ break;
+ default:
+ if (kvm_x86_ops->get_msr_feature(&msr))
+ return 1;
+ }

  *data = msr.data;

@@ -2248,7 +2255,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu,
struct msr_data *msr_info)

  switch (msr) {
  case MSR_AMD64_NB_CFG:
- case MSR_IA32_UCODE_REV:
  case MSR_IA32_UCODE_WRITE:
  case MSR_VM_HSAVE_PA:
  case MSR_AMD64_PATCH_LOADER:
@@ -2256,6 +2262,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu,
struct msr_data *msr_info)
  case MSR_AMD64_DC_CFG:
  break;

+ case MSR_IA32_UCODE_REV:
+ if (msr_info->host_initiated)
+ vcpu->arch.microcode_version = data;
+ break;
  case MSR_EFER:
  return set_efer(vcpu, data);
  case MSR_K7_HWCR:
@@ -2551,7 +2561,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu,
struct msr_data *msr_info)
  msr_info->data = 0;
  break;
  case MSR_IA32_UCODE_REV:
- msr_info->data = 0x100000000ULL;
+ msr_info->data = vcpu->arch.microcode_version;
  break;
  case MSR_MTRRcap:
  case 0x200 ... 0x2ff:

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752333AbeCEB4p (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 20:56:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:32481 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeCEB4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 20:56:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,425,1515484800";
   d="scan'208";a="21986036"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v5 00/11] Intel Processor Trace virtulization enabling
Date: Sun,  4 Mar 2018 20:07:10 +0800
Message-Id: <1520165241-15819-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a patch-series which adding Processor Trace enabling in KVM guest. You can get It's software developer manuals from:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
In Chapter 5 INTEL PROCESSOR TRACE: VMX IMPROVEMENTS.

Introduction:
Intel Processor Trace (Intel PT) is an extension of Intel Architecture that captures information about software execution using dedicated hardware facilities that cause only minimal performance perturbation to the software being traced. Details on the Intel PT infrastructure and trace capabilities can be found in the Intel 64 and IA-32 Architectures Software Developer’s Manual, Volume 3C.

The suite of architecture changes serve to simplify the process of virtualizing Intel PT for use by a guest software. There are two primary elements to this new architecture support for VMX support improvements made for Intel PT.
1. Addition of a new guest IA32_RTIT_CTL value field to the VMCS.
  — This serves to speed and simplify the process of disabling trace on VM exit, and restoring it on VM entry.
2. Enabling use of EPT to redirect PT output.
  — This enables the VMM to elect to virtualize the PT output buffer using EPT. In this mode, the CPU will treat PT output addresses as Guest Physical Addresses (GPAs) and translate them using EPT. This means that Intel PT output reads (of the ToPA table) and writes (of trace output) can cause EPT violations, and other output events.

Processor Trace virtualization can be work in one of 3 possible modes by set new option "pt_mode". Default value is system mode.
 a. system-wide: trace both host/guest and output to host buffer;
 b. host-only: only trace host and output to host buffer;
 c. host-guest: trace host/guest simultaneous and output to their respective buffer.

>From V4:
 - add data check when setting the value of MSR_IA32_RTIT_CTL;
 - Invoke new interface to set the intercept of MSRs read/write after "MSR bitmap per-vcpu" patches.

>From V3:
 - change default mode to SYSTEM mode;
 - add a new patch to move PT out of scattered features;
 - add a new fucntion kvm_get_pt_addr_cnt() to get the number of address ranges;
 - add a new function vmx_set_rtit_ctl() to set the value of guest RTIT_CTL, GUEST_IA32_RTIT_CTL and MSRs intercept.

>From v2:
 - replace *_PT_SUPPRESS_PIP to *_PT_CONCEAL_PIP;
 - clean SECONDARY_EXEC_PT_USE_GPA, VM_EXIT_CLEAR_IA32_RTIT_CTL and VM_ENTRY_LOAD_IA32_RTIT_CTL in SYSTEM mode. These bits must be all set or all clean;
 - move processor tracing out of scattered features;
 - add a new function to enable/disable intercept MSRs read/write;
 - add all Intel PT MSRs read/write and disable intercept when PT is enabled in guest;
 - disable Intel PT and enable intercept MSRs when L1 guest VMXON;
 - performance optimization.
   In Host only mode. we just need to save host RTIT_CTL before vm-entry and restore host RTIT_CTL after vm-exit;
   In HOST_GUEST mode. we need to save and restore all MSRs only when PT has enabled in guest.
 - use XSAVES/XRESTORES implement context switch.
   Haven't implementation in this version and still in debuging. will make a separate patch work on this.

>From v1:
 - remove guest-only mode because guest-only mode can be covered by host-guest mode;
 - always set "use GPA for processor tracing" in secondary execution control if it can be;
 - trap RTIT_CTL read/write. Forbid write this msr when VMXON in L1 hypervisor.

Chao Peng (8):
  perf/x86/intel/pt: Move Intel-PT MSR bit definitions to a public
    header
  perf/x86/intel/pt: Change pt_cap_get() to a public function
  KVM: x86: Add Intel Processor Trace virtualization mode
  KVM: x86: Add Intel Processor Trace cpuid emulation
  KVM: x86: Add Intel processor trace context for each vcpu
  KVM: x86: Implement Intel Processor Trace context switch
  KVM: x86: Implement Intel Processor Trace MSRs read/write
  KVM: x86: Set intercept for Intel PT MSRs

Luwei Kang (3):
  perf/x86/intel/pt: Introduce a new function to get the capability of
    Intel PT
  KVM: x86: Introduce a function to initialize the PT configuration
  KVM: x86: Disable Intel Processor Trace when VMXON in L1 guest

 arch/x86/events/intel/pt.c       |  18 +-
 arch/x86/events/intel/pt.h       |  58 ------
 arch/x86/include/asm/intel_pt.h  |  40 ++++
 arch/x86/include/asm/kvm_host.h  |   1 +
 arch/x86/include/asm/msr-index.h |  38 ++++
 arch/x86/include/asm/vmx.h       |   8 +
 arch/x86/kvm/cpuid.c             |  22 ++-
 arch/x86/kvm/svm.c               |   6 +
 arch/x86/kvm/vmx.c               | 416 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c               |  33 +++-
 10 files changed, 572 insertions(+), 68 deletions(-)

-- 
1.8.3.1

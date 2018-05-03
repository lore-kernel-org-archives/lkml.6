Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeECKON (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 06:14:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:34418 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751765AbeECKOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 06:14:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38109665"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        joro@8bytes.org, peterz@infradead.org, chao.p.peng@linux.intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v7 00/13] Intel Processor Trace virtualization enabling
Date: Thu,  3 May 2018 20:08:30 +0800
Message-Id: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is a patch-series which adding Processor Trace enabling in KVM guest. You can get It's software developer manuals from:
https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
In Chapter 4 INTEL PROCESSOR TRACE: VMX IMPROVEMENTS.

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

>From V6:
 - split pathes 1~2 to four separate patches (these patches do 2 things) and add more descriptions.

>From V5:
 - rename the function from pt_cap_get_ex() to __pt_cap_get();
 - replace the most of function from vmx_pt_supported() to "pt_mode == PT_MODE_HOST_GUEST"(or !=).

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
  perf/x86/intel/pt: Move Intel-PT MSRs bit definitions to a public
    header
  perf/x86/intel/pt: Change pt_cap_get() to a public function
  KVM: x86: Add Intel Processor Trace virtualization mode
  KVM: x86: Add Intel Processor Trace cpuid emulation
  KVM: x86: Add Intel processor trace context for each vcpu
  KVM: x86: Implement Intel Processor Trace context switch
  KVM: x86: Implement Intel Processor Trace MSRs read/write
  KVM: x86: Set intercept for Intel PT MSRs read/write

Luwei Kang (5):
  perf/x86/intel/pt: Add new bit definitions for Intel PT MSRs
  perf/x86/intel/pt: add new capability for Intel PT
  perf/x86/intel/pt: Introduce a new function to get capability of Intel
    PT
  KVM: x86: Introduce a function to initialize the PT configuration
  KVM: x86: Disable Intel Processor Trace when VMXON in L1 guest

 arch/x86/events/intel/pt.c       |  12 +-
 arch/x86/events/intel/pt.h       |  58 ------
 arch/x86/include/asm/intel_pt.h  |  40 ++++
 arch/x86/include/asm/kvm_host.h  |   1 +
 arch/x86/include/asm/msr-index.h |  38 ++++
 arch/x86/include/asm/vmx.h       |   8 +
 arch/x86/kvm/cpuid.c             |  22 ++-
 arch/x86/kvm/svm.c               |   6 +
 arch/x86/kvm/vmx.c               | 412 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c               |  33 +++-
 10 files changed, 563 insertions(+), 67 deletions(-)

-- 
1.8.3.1

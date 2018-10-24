Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23915C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D719D207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D719D207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeJXQeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:34:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:43258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbeJXQd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:33:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 01:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="273987146"
Received: from skx-d.bj.intel.com ([10.238.135.53])
  by fmsmga005.fm.intel.com with ESMTP; 24 Oct 2018 01:06:52 -0700
From:   Luwei Kang <luwei.kang@intel.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, joro@8bytes.org,
        songliubraving@fb.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, thomas.lendacky@amd.com,
        konrad.wilk@oracle.com, mattst88@gmail.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        jpoimboe@redhat.com, marcorr@google.com, ubizjak@gmail.com,
        sean.j.christopherson@intel.com, jmattson@google.com,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v13 00/12] Intel Processor Trace virtualization enabling
Date:   Wed, 24 Oct 2018 16:05:04 +0800
Message-Id: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From V12
 - Refine the title and description of patch 1~3. -- Thomas Gleixner
 - Rename the function of validate the capabilities of Intel PT. -- Thomas Gleixner
 - Add more description of Intel PT work mode. -- Alexander Shishkin

>From V11:
 - In patch 3, arguments caps vs. cap is not good. Spell second one out. -- Thomas Gleixner

>From V10: (This version don't have code change)
 - move the patch 5 in version 9 to patch 3 (reorder patch 5) -- Alexander Shishkin
 - refind the patch description of patch 5 (add new capability for Intel PT) -- Alexander Shishkin
 - CC all the maintainers, reviewers and submitters in each patch of this patch set -- Alexander Shishkin

>From V9:
 - remove redundant initialize for "ctl_bitmask" in patch 9;
 - do some changes for patch's description.

>From V8:
 - move macro definition MSR_IA32_RTIT_ADDR_RANGE from msr-index.h to intel_pt.h;
 - initialize the RTIT_CTL bitmask to ~0ULL.

>From V7:
 - remove host only mode since it can be emulated by perf code;
 - merge patch 8 and 9 to make code and data in the same patch;
 - rename __pt_cap_get() to pt_cap_decode();
 - other minor change.

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

Chao Peng (7):
  perf/x86/intel/pt: Move Intel PT MSRs bit defines to global header
  perf/x86/intel/pt: Export pt_cap_get()
  KVM: x86: Add Intel PT virtualization work mode
  KVM: x86: Add Intel Processor Trace cpuid emulation
  KVM: x86: Add Intel PT context switch for each vcpu
  KVM: x86: Implement Intel PT MSRs read/write emulation
  KVM: x86: Set intercept for Intel PT MSRs read/write

Luwei Kang (5):
  perf/x86/intel/pt: Introduce intel_pt_validate_cap()
  perf/x86/intel/pt: Add new bit definitions for PT MSRs
  perf/x86/intel/pt: add new capability for Intel PT
  KVM: x86: Introduce a function to initialize the PT configuration
  KVM: x86: Disable Intel PT when VMXON in L1 guest

 arch/x86/events/intel/pt.c       |  60 +++---
 arch/x86/events/intel/pt.h       |  58 -----
 arch/x86/include/asm/intel_pt.h  |  39 ++++
 arch/x86/include/asm/kvm_host.h  |   1 +
 arch/x86/include/asm/msr-index.h |  37 ++++
 arch/x86/include/asm/vmx.h       |   8 +
 arch/x86/kvm/cpuid.c             |  22 +-
 arch/x86/kvm/svm.c               |   6 +
 arch/x86/kvm/vmx.c               | 446 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c               |  33 ++-
 10 files changed, 620 insertions(+), 90 deletions(-)

-- 
1.8.3.1


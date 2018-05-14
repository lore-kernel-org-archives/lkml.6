Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZoxB/ug3FwcklO2laHgRGaCewh3zTYtNncu4wMehBfux+AxxPu7nXTX8rVS8ocfDSRqYCkb
ARC-Seal: i=1; a=rsa-sha256; t=1526288564; cv=none;
        d=google.com; s=arc-20160816;
        b=fFT5F96RrHmtlWws0Zxay1wgrayJVQk6i9RIgspnMIivfJ3YJt6vPwjUdwyWDMzFw1
         zJqgbDKtdmcV4Etgk1U+Ha/rAZcytFFCpsdvLsh2WYW0qyRsq5mt7mVrxWZbNZdBX8aq
         hFcGu9TUeg8U6xaXHNMb71OL+GQWuukxPASUr1YuT5dUzecaXPbEhKMXGNams2ido0UG
         BgR53zYGruZ9pA1990i/J3RquiV/BRQc8TQmXf5A4VAqBbtZ8qCHcb16KgRSgnNnjV+i
         mM/2rhnIUIh/DZ7IOb6tPc5CQAaQ2PBvPjdCiGPEBZx7FAGNlmK5htHuvWhKSXjzcvPv
         GURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=bl5uvKydQzHO3DNaIFecdNybAAq7ABc9vXppZK8Xrm4=;
        b=ttJhNGHqM6rZa3GqElsZNzfrob42GdNIvFk4rDsXTjxgNhuwqZDynM4AlhrZhen54X
         +7c4W3oSJZDnZojNtk9m3DUyZmv9CI30/uAgXqQF+kLUdFqmCMKsxVEloKLx8bvZk3HV
         3CBsXYx75Jd8qRN5eaGnlmlrvwz0xHadrIyQGgq12e2p9rDYAou9hPtaXJZxGb4QPYPj
         TL8vAb9Gk8St7xApFyigK0DaSCsW1tER7LKjECYx8Qb0qck9XwhMNbfOAWZM28BNLZhq
         7/O/xNNnm6oH3IjfTPIpcps+MUsQu1ZE0R+uiH2iyIDjyiICRNvmzSDPdmnZT9vxObId
         JPXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701782"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	thomas.lendacky@amd.com,
	bp@suse.de,
	Kan.liang@intel.com,
	Janakarajan.Natarajan@amd.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mathieu.poirier@linaro.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	david@redhat.com,
	bsd@redhat.com,
	yu.c.zhang@linux.intel.com,
	joro@8bytes.org,
	Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v8 00/12] Intel Processor Trace virtualization enabling
Date: Mon, 14 May 2018 18:57:00 +0800
Message-Id: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429557573580703?=
X-GMAIL-MSGID: =?utf-8?q?1600429557573580703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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

Processor Trace virtualization can be work in one of 2 possible modes by set new option "pt_mode". Default value is system mode.
 a. system-wide: trace both host/guest and output to host buffer;
 b. host-guest: trace host/guest simultaneous and output to their respective buffer.

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
  perf/x86/intel/pt: Move Intel-PT MSRs bit definitions to a public
    header
  perf/x86/intel/pt: Change pt_cap_get() to a public function
  KVM: x86: Add Intel Processor Trace virtualization mode
  KVM: x86: Add Intel Processor Trace cpuid emulation
  KVM: x86: Add Intel Processor Trace context switch for each vcpu
  KVM: x86: Implement Intel Processor Trace MSRs read/write emulation
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
 arch/x86/include/asm/intel_pt.h  |  37 ++++
 arch/x86/include/asm/kvm_host.h  |   1 +
 arch/x86/include/asm/msr-index.h |  38 ++++
 arch/x86/include/asm/vmx.h       |   8 +
 arch/x86/kvm/cpuid.c             |  22 +-
 arch/x86/kvm/svm.c               |   6 +
 arch/x86/kvm/vmx.c               | 438 ++++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c               |  33 ++-
 10 files changed, 586 insertions(+), 67 deletions(-)

-- 
1.8.3.1

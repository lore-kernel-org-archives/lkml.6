Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3198C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E7A2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E7A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbeK3TA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:00:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:62312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:00:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 23:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="114108282"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 23:52:30 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id BA46D580460;
        Thu, 29 Nov 2018 23:52:28 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 00/11] Intel EPT-Based Sub-page Protection Support
Date:   Fri, 30 Nov 2018 15:52:13 +0800
Message-Id: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch-series which adding EPT-Based Sub-page Write Protection Support.

Introduction:

EPT-Based Sub-page Write Protection referred to as SPP, it is a capability which
allow Virtual Machine Monitors(VMM) to specify write-permission for guest
physical memory at a sub-page(128 byte) granularity.  When this capability is
utilized, the CPU enforces write-access permissions for sub-page regions of 4K
pages as specified by the VMM. EPT-based sub-page permissions is intended to
enable fine-grained memory write enforcement by a VMM for security(guest OS
monitoring) and usages such as device virtualization and memory check-point.

SPPT is active when the "sub-page write protection" VM-execution control is 1.
SPPT looks up the guest physical addresses to derive a 64 bit "sub-page
permission" value containing sub-page write permissions. The lookup from
guest-physical addresses to the sub-page region permissions is determined by a
set of SPPT paging structures.

When the "sub-page write protection" VM-execution control is 1, the SPPT is used
to lookup write permission bits for the 128 byte sub-page regions containing in
the 4KB guest physical page. EPT specifies the 4KB page level privileges that
software is allowed when accessing the guest physical address, whereas SPPT
defines the write permissions for software at the 128 byte granularity regions
within a 4KB page. Write accesses prevented due to sub-page permissions looked
up via SPPT are reported as EPT violation VM exits. Similar to EPT, a logical
processor uses SPPT to lookup sub-page region write permissions for
guest-physical addresses only when those addresses are used to access memory.

______________________________________________________________________________

How SPP hardware works:
______________________________________________________________________________


Guest write access --> GPA --> Walk EPT --> EPT leaf entry -┐
┌-----------------------------------------------------------┘
└-> if VMexec_control.spp && ept_leaf_entry.spp_bit (bit 61)
     |
     └-> <false> --> EPT legacy behavior
     |
     |
     └-> <true>  --> if ept_leaf_entry.writable
                      |
                      └-> <true>  --> Ignore SPP
                      |
		      └-> <false> --> GPA --> Walk SPP 4-level table--┐
                                                                      |
┌------------<----------get-the-SPPT-point-from-VMCS-filed-----<------┘
|
Walk SPP L4E table
|
└┐--> entry misconfiguration ------------>----------┐<----------------┐
 |                                                  |                 |
else                                                |                 |
 |                                                  |                 |
 |   ┌------------------SPP VMexit<-----------------┘                 |
 |   |                                                                |
 |   └-> exit_qualification & sppt_misconfig --> sppt misconfig       |
 |   |                                                                |
 |   └-> exit_qualification & sppt_miss --> sppt miss                 |
 └--┐                                                                 |
    |                                                                 |
walk SPPT L3E--┐--> if-entry-misconfiguration------------>------------┘
               |                                                      |
	      else                                                    |
	       |                                                      |
	       |                                                      |
        walk SPPT L2E --┐--> if-entry-misconfiguration-------->-------┘
                        |                                             |
                       else                                           |
			|                                             |
			|                                             |
	         walk SPPT L1E --┐-> if-entry-misconfiguration--->----┘
                                 |
			        else
				 |
                                 └-> if sub-page writable
                                      └-> <true>  allow, write access
	                              └-> <false> disallow, EPT violation

Patch description:

Patch 1: The design Doc of EPT-Based Sub-page Write Protection(SPP)

Patch 2: this patch adds reporting SPP capability from VMX Procbased MSR,
according to the definition of hardware spec, bit 23 is the control of the SPP
capability.

Patch 3: Add new secondary processor-based VM-execution control bit which
defined as "sub-page write permission", same as VMX Procbased MSR, bit 23 is
the enable bit of SPP. Also we introduced a kernel parameter "enable_ept_spp",
now SPP is active when the "Sub-page Write Protection" in Secondary VM-Execution
Control is set and enable the kernel parameter by "spp=1".

Patch 4: Introduced the spptp and spp page table.
The sub-page permission table is referenced via a 64-bit control field called
Sub-Page Permission Table Pointer (SPPTP) which contains a 4K-aligned physical
address. The index and encoding for this VMCS field if defined 0x2030 at this
time The format of SPPTP is shown in below figure:

---------------------------------------------------------------|
| Bit    | Contents                                            |
:--------------------------------------------------------------|
| 11:0   | Reserved (0)                                        |
| N-1:12 | Physical address of 4KB aligned SPPT L4E Table      |
| 51:N   | Reserved (0)                                        |
| 63:52  | Reserved (0)                                        |
---------------------------------------------------------------|

This patch introduced the Spp paging structures, which root page will created at
kvm mmu page initialization. Also we added a mmu page role type spp to distinguish
it is a spp page or a EPT page.

Patch 5: Defined SPPTP in new VMCS area, then we write the SPPTP to vmcs.

Patch 6: Introduced the SPP-Induced VM exit and it's handle.
Accesses using guest-physical addresses may cause SPP-induced VM exits due to an
SPPT misconfiguration or an SPPT miss. The basic VM exit reason code reported for
SPP-induced VM exits is 66.

Also Introduced the below exit qualification for SPPT-induced vmexits.

| Bit   | Contents                                                          |
| :---- | :---------------------------------------------------------------- |
| 10:0  | Reserved (0).                                                     |
| 11    | SPPT VM exit type. Set for SPPT Miss, cleared for SPPT Misconfig. |
| 12    | NMI unblocking due to IRET                                        |
| 63:13 | Reserved (0)                                                      |

Patch 7: Added a handle of EPT subpage write protection fault.
A control bit in EPT leaf paging-structure entries is defined as Sub-Page
Permission (SPP bit). The bit position is 61; it is chosen from among the bits
that are currently ignored by the processor and available to software.

While hardware walking the SPP page table, If the sub-page  region write
permission bit is set, the write is allowed, else the write is disallowed and
results in an EPT violation.

We need peek this case in EPT volition handler, and trigger a user-space exit,
return the write protected address(GVA) to user(qemu).

Patch 8: Introduce ioctls to set/get Sub-Page Write Protection.
We introduced 2 ioctls to let user application to set/get subpage write
protection bitmap per gfn, each gfn corresponds to a bitmap.
The user application, qemu, or some other security control daemon, will set the
protection bitmap via this ioctl.

the API defined as:
	struct kvm_subpage {
		__u64 base_gfn;
		__u64 npages;
		/* sub-page write-access bitmap array */
		__u32 access_map[SUBPAGE_MAX_BITMAP];
		}sp;
	kvm_vm_ioctl(s, KVM_SUBPAGES_SET_ACCESS, &sp)
	kvm_vm_ioctl(s, KVM_SUBPAGES_GET_ACCESS, &sp)

Patch 9 ~ Patch 11: Setup spp page table and update the EPT leaf entry indicated
with the SPP enable bit. If the sub-page write permission VM-execution control
is set, treatment of write accesses to guest-physical accesses depends on the
state of the accumulated write-access bit (position 1) and sub-page permission
bit(position 61) in the EPT leaf paging-structure.

Software will update the EPT leaf entry sub-page permission bit while
kvm_set_subpage(patch 7). If the EPT write-access bit set to 0 and the SPP bit
set to 1 in the leaf EPT paging-structure entry that maps a 4KB page, then the
hardware will look up a VMM-managed Sub-Page Permission Table (SPPT), which
will be prepared by setup kvm_set_subpage(patch 8).

The hardware uses the guest-physical address and bits 11:7 of the address
accessed to lookup the SPPT to fetch a write permission bit for the 128 byte
wide sub-page region being accessed within the 4K guest-physical page. If the
sub-page region write permission bit is set, the write is allowed, otherwise
the write is disallowed and results in an EPT violation.

Guest-physical pages mapped via leaf EPT-paging-structures for which the
accumulated write-access bit and the SPP bits are both clear (0) generate EPT
violations on memory writes accesses. Guest-physical pages mapped via
EPT-paging-structure for which the accumulated write-access bit is set (1) allow
writes, effectively ignoring the SPP bit on the leaf EPT-paging structure.
Software will setup the spp page table level4,3,2 as well as EPT page structure,
and fill the level1 via the 32 bit bitmaps per a single 4K page. Now it could be
divided to 32 x 128 sub-pages.

The SPP L4E L3E L2E is defined as below figure.
________________________________________________________________________________
| Bit    | Contents                                                            |
| :----- | :-------------------------------------------------------------------|
| 0      | Valid entry when set; indicates whether the entry is present        |
| 11:1   | Reserved (0)                                                        |
| N-1:12 | Physical address of 4K SPPT LX-1 Table referenced by the entry      |
| 51:N   | Reserved (0)                                                        |
| 63:52  | Reserved (0)                                                        |

Note: N is the physical address width supported by the processor, X is the page level

The SPP L1E format is defined as below figure.
____________________________________________________________________________
| Bit   | Contents                                                          |
| :---- | :---------------------------------------------------------------- |
| 0+2i  | Write permission for i-th 128 byte sub-page region.               |
| 1+2i  | Reserved (0).                                                     |
Note: `0<=i<=31`

Chang logs:
V2 - V1:
1. Rebased to 4.20-rc1
2. Move VMCS change to a separated patch.
3. Code refine and Bug fix

Zhang Yi (11):
  Documentation: Added EPT Subpage Protection Documentation.
  x86/cpufeature: Add intel Sub-Page Protection to CPU features
  KVM: VMX: Added VMX SPP feature flags and VM-Execution Controls.
  KVM: VMX: Introduce the SPPTP and SPP page table.
  KVM: VMX: Write the SPPTP to VMCS area.
  KVM: VMX: Introduce SPP-Induced vm exit and it's handle.
  KVM: VMX: Added handle of SPP write protection fault.
  KVM: VMX: Introduce ioctls to set/get Sub-Page Write Protection.
  KVM: VMX: Update the EPT leaf entry indicated with the SPP enable bit.
  KVM: VMX: Added setup spp page structure.
  KVM: VMX: implement setup SPP page structure in spp miss.

 Documentation/virtual/kvm/spp_design_kvm.txt | 275 ++++++++++++++++++++++
 arch/x86/include/asm/cpufeatures.h           |   1 +
 arch/x86/include/asm/kvm_host.h              |  19 +-
 arch/x86/include/asm/vmx.h                   |  10 +
 arch/x86/include/uapi/asm/vmx.h              |   2 +
 arch/x86/kernel/cpu/intel.c                  |   4 +
 arch/x86/kvm/mmu.c                           | 334 ++++++++++++++++++++++++++-
 arch/x86/kvm/mmu.h                           |   1 +
 arch/x86/kvm/vmx.c                           | 105 +++++++++
 arch/x86/kvm/x86.c                           | 124 +++++++++-
 include/linux/kvm_host.h                     |   5 +
 include/uapi/linux/kvm.h                     |  16 ++
 12 files changed, 892 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/virtual/kvm/spp_design_kvm.txt

-- 
2.7.4


Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91151C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F71B2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F71B2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeK3TQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:16:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:36170 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbeK3TQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:16:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 00:08:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="96176417"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2018 00:08:10 -0800
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.128])
        by linux.intel.com (Postfix) with ESMTP id 15B33580460;
        Fri, 30 Nov 2018 00:08:07 -0800 (PST)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     pbonzini@redhat.com, mdontu@bitdefender.com, ncitu@bitdefender.com
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH V2 01/11] Documentation: Added EPT Subpage Protection Documentation.
Date:   Fri, 30 Nov 2018 16:07:52 +0800
Message-Id: <a8fd64aef788e1fb2ff6df758ffabffcccf53a3f.1543481993.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
In-Reply-To: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
References: <cover.1543481993.git.yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 Documentation/virtual/kvm/spp_design_kvm.txt | 275 +++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 Documentation/virtual/kvm/spp_design_kvm.txt

diff --git a/Documentation/virtual/kvm/spp_design_kvm.txt b/Documentation/virtual/kvm/spp_design_kvm.txt
new file mode 100644
index 0000000..8dc4530
--- /dev/null
+++ b/Documentation/virtual/kvm/spp_design_kvm.txt
@@ -0,0 +1,275 @@
+DRAFT: EPT-Based Sub-Page Protection (SPP) Design Doc for KVM
+=============================================================
+
+1. Overview
+
+EPT-based Sub-Page Protection (SPP) capability to allow Virtual Machine
+Monitors to specify write-protection for guest physical memory at a
+sub-page (128 byte) granularity. When this capability is utilized, the
+CPU enforces write-access permissions for sub-page regions of 4K pages
+as specified by the VMM.
+
+2. Operation of SPP
+
+Sub-Page Protection Table (SPPT) is introduced to manage sub-page
+write-access.
+
+SPPT is active when the "sub-page write protection" VM-execution control
+is 1. SPPT looks up the guest physical addresses to derive a 64 bit
+"sub-page permission" value containing sub-page write permissions. The
+lookup from guest-physical addresses to the sub-page region permissions
+is determined by a set of SPPT paging structures.
+
+When the "sub-page write protection" VM-execution control is 1, the SPPT
+is used to lookup write permission bits for the 128 byte sub-page regions
+containing in the 4KB guest physical page. EPT specifies the 4KB page
+level privileges that software is allowed when accessing the guest
+physical address, whereas SPPT defines the write permissions for software
+at the 128 byte granularity regions within a 4KB page. Write accesses
+prevented due to sub-page permissions looked up via SPPT are reported as
+EPT violation VM exits. Similar to EPT, a logical processor uses SPPT to
+lookup sub-page region write permissions for guest-physical addresses
+only when those addresses are used to access memory.
+______________________________________________________________________________
+
+How SPP hardware works:
+______________________________________________________________________________
+
+Guest write access --> GPA --> Walk EPT --> EPT leaf entry -┐
+┌-----------------------------------------------------------┘
+└-> if VMexec_control.spp && ept_leaf_entry.spp_bit (bit 61)
+     |
+     └-> <false> --> EPT legacy behavior
+     |
+     |
+     └-> <true>  --> if ept_leaf_entry.writable
+                      |
+                      └-> <true>  --> Ignore SPP
+                      |
+		      └-> <false> --> GPA --> Walk SPP 4-level table--┐
+                                                                      |
+┌------------<----------get-the-SPPT-point-from-VMCS-filed-----<------┘
+|
+Walk SPP L4E table
+|
+└┐--> entry misconfiguration ------------>----------┐<----------------┐
+ |                                                  |                 |
+else                                                |                 |
+ |                                                  |                 |
+ |   ┌------------------SPP VMexit<-----------------┘                 |
+ |   |                                                                |
+ |   └-> exit_qualification & sppt_misconfig --> sppt misconfig       |
+ |   |                                                                |
+ |   └-> exit_qualification & sppt_miss --> sppt miss                 |
+ └--┐                                                                 |
+    |                                                                 |
+walk SPPT L3E--┐--> if-entry-misconfiguration------------>------------┘
+               |                                                      |
+	      else                                                    |
+	       |                                                      |
+	       |                                                      |
+        walk SPPT L2E --┐--> if-entry-misconfiguration-------->-------┘
+                        |                                             |
+                       else                                           |
+			|                                             |
+			|                                             |
+	         walk SPPT L1E --┐-> if-entry-misconfiguration--->----┘
+                                 |
+			        else
+				 |
+                                 └-> if sub-page writable
+                                      └-> <true>  allow, write access
+	                              └-> <false> disallow, EPT violation
+______________________________________________________________________________
+
+3. Interfaces
+
+* Feature enabling
+
+Add "spp=on" to KVM module parameter to enable SPP feature, default is off.
+
+* Get/Set sub-page write access permission
+
+New KVM ioctl:
+
+`KVM_SUBPAGES_GET_ACCESS`:
+Get sub-pages write access bitmap corresponding to given rang of continuous gfn.
+
+`KVM_SUBPAGES_SET_ACCESS`
+Set sub-pages write access bitmap corresponding to given rang of continuous gfn.
+
+```c
+/* for KVM_SUBPAGES_GET_ACCESS and KVM_SUBPAGES_SET_ACCESS */
+struct kvm_subpage_info {
+	__u64 gfn;
+	__u64 npages; /* number of 4K pages */
+	__u64 *access_map; /* sub-page write-access bitmap array */
+};
+
+#define KVM_SUBPAGES_GET_ACCESS   _IOR(KVMIO,  0x49, struct kvm_subpage_info)
+#define KVM_SUBPAGES_SET_ACCESS   _IOW(KVMIO,  0x4a, struct kvm_subpage_info)
+```
+
+4. SPPT initialization
+
+* SPPT root page allocation
+
+  SPPT is referenced via a 64-bit control field called "sub-page
+  protection table pointer" (SPPTP, encoding 0x2030) which contains a
+  4K-align physical address.
+
+  SPPT also has 4 level table as well as EPT. So, as EPT does, when KVM
+  loads mmu, we allocate a root page for SPPT L4 table.
+
+* EPT leaf entry SPP bit
+
+  Set 0 to SPP bit to close SPP by default.
+
+5. Set/Get Sub-Page access bitmap for bunch of guest physical pages
+
+* To utilize SPP feature, system admin should Set a Sub-page access write via
+  SPP KVM ioctl `KVM_SUBPAGES_SET_ACCESS`, which will prepared the flowing things.
+
+   (1.Got the corresponding EPT leaf entry via the guest physical address.
+   (2.If it is a 4K page frame, flag the bit 61 to enable subpage protection on this page.
+   (3.Setup spp page structure, the page structure format is list following.
+
+   Format of the SPPT L4E, L3E, L2E:
+   | Bit    | Contents                                                                 |
+   | :----- | :------------------------------------------------------------------------|
+   | 0      | Valid entry when set; indicates whether the entry is present             |
+   | 11:1   | Reserved (0)                                                             |
+   | N-1:12 | Physical address of 4KB aligned SPPT LX-1 Table referenced by this entry |
+   | 51:N   | Reserved (0)                                                             |
+   | 63:52  | Reserved (0)                                                             |
+   Note: N is the physical address width supported by the processor. X is the page level
+
+   Format of the SPPT L1E:
+   | Bit   | Contents                                                          |
+   | :---- | :---------------------------------------------------------------- |
+   | 0+2i  | Write permission for i-th 128 byte sub-page region.               |
+   | 1+2i  | Reserved (0).                                                     |
+   Note: `0<=i<=31`
+
+   (4.Update the subpage info into memory slot structure.
+
+* Sub-page write access bitmap setting pseudo-code:
+
+```c
+static int kvm_mmu_set_subpages(struct kvm_vcpu *vcpu,
+				struct kvm_subpage_info *spp_info)
+{
+	gfn_t *gfns = spp_info->gfns;
+	u64 *access_map = spp_info->access_map;
+
+	sanity_check();
+
+	/* SPP works when the page is unwritable */
+	if (set_ept_leaf_level_unwritable(gfn) == success)
+
+		if (kvm_mmu_setup_spp_structure(gfn) == success)
+
+			set_subpage_slot_info(access_map);
+
+}
+```
+
+User could get the subpage info via SPP KVM ioctl `KVM_SUBPAGES_GET_ACCESS`,
+which from the memory slot structure corresponding the specify gpa.
+
+* Sub-page get subpage info pseudo-code:
+
+```c
+static int kvm_mmu_get_subpages(struct kvm_vcpu *vcpu,
+				struct kvm_subpage_info *spp_info)
+{
+	gfn_t *gfns = spp_info->gfns;
+
+	sanity_check(gfn);
+	spp_info = get_subpage_slot_info(gfn);
+}
+
+```
+
+5. SPPT-induced vmexits
+
+* SPP VM exits
+
+Accesses using guest physical addresses may cause VM exits due to a SPPT
+Misconfiguration or a SPPT Miss.
+
+A SPPT Misconfiguration vmexit occurs when, in the course of translating
+a guest physical address, the logical processor encounters a leaf EPT
+paging-structure entry mapping a 4KB page, with SPP enabled, during the
+SPPT lookup, a SPPT paging-structure entry contains an unsupported
+value.
+
+A SPPT Miss vmexit occurs during the SPPT lookup there is no SPPT
+misconfiguration but any level of SPPT paging-structure entries are not
+present.
+
+NOTE. SPPT misconfigurations and SPPT miss can occur only due to an
+attempt to write memory with a guest physical address.
+
+* EPT violation vmexits due to SPPT
+
+EPT violations due to memory write accesses disallowed due to sub-page
+protection permissions specified in the SPPT are reported via EPT
+violation VM exits.
+
+6. SPPT-induced vmexits handling
+
+```c
+#define EXIT_REASON_SPP                 66
+
+static int (*const kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
+	...
+	[EXIT_REASON_SPP]                     = handle_spp,
+	...
+};
+```
+
+New exit qualification for SPPT-induced vmexits.
+
+| Bit   | Contents                                                          |
+| :---- | :---------------------------------------------------------------- |
+| 10:0  | Reserved (0).                                                     |
+| 11    | SPPT VM exit type. Set for SPPT Miss, cleared for SPPT Misconfig. |
+| 12    | NMI unblocking due to IRET                                        |
+| 63:13 | Reserved (0)                                                      |
+
+In addition to the exit qualification, Guest Linear Address and Guest
+Physical Address fields will be reported.
+
+* SPPT miss and misconfiguration
+
+Allocate a page for the SPPT entry and set the entry correctly.
+
+
+SPP VMexit handler Pseudo-code:
+```c
+static int handle_spp(kvm_vcpu *vcpu)
+{
+	exit_qualification = vmcs_readl(EXIT_QUALIFICATION);
+	if (exit_qualification & SPP_EXIT_TYPE_BIT) {
+		/* SPPT Miss */
+		/* We don't set SPP write access for the corresponding
+		 * GPA, leave it unwritable, so no need to construct
+		 * SPP table here. */
+	} else {
+		/* SPPT Misconfig */
+		vcpu->run->exit_reason = KVM_EXIT_UNKNOWN;
+		vcpu->run->hw.hardware_exit_reason = EXIT_REASON_SPP;
+	}
+	return 0;
+}
+```
+
+* EPT violation vmexits due to SPPT
+
+While hardware walking the SPP page table, If the sub-page region write
+permission bit is set, the write is allowed, else the write is disallowed
+and results in an EPT violation.
+
+we need peek this case in EPT volition handler, and trigger a user-space
+exit, return the write protected address(GPA) to user(qemu).
-- 
2.7.4


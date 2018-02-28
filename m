Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeB1SHH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:07:07 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:57913 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751566AbeB1SHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:07:06 -0500
X-IronPort-AV: E=Sophos;i="5.47,406,1515456000";
   d="scan'208";a="722069735"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] X86/KVM: Update the exit_qualification access bits while walking an address
Date: Wed, 28 Feb 2018 19:06:48 +0100
Message-Id: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... to avoid having a stale value when handling an EPT misconfig for MMIO
regions.

MMIO regions that are not passed-through to the guest are handled through
EPT misconfigs. The first time a certain MMIO page is touched it causes an
EPT violation, then KVM marks the EPT entry to cause an EPT misconfig
instead. Any subsequent accesses to the entry will generate an EPT
misconfig.

Things gets slightly complicated with nested guest handling for MMIO
regions that are not passed through from L0 (i.e. emulated by L0
user-space).

An EPT violation for one of these MMIO regions from L2, exits to L0
hypervisor. L0 would then look at the EPT12 mapping for L1 hypervisor and
realize it is not present (or not sufficient to serve the request). Then L0
injects an EPT violation to L1. L1 would then update its EPT mappings. The
EXIT_QUALIFICATION value for L1 would come from exit_qualification variable
in "struct vcpu". The problem is that this variable is only updated on EPT
violation and not on EPT misconfig. So if an EPT violation because of a
read happened first, then an EPT misconfig because of a write happened
afterwards. The L0 hypervisor will still contain exit_qualification value
from the previous read instead of the write and end up injecting an EPT
violation to the L1 hypervisor with an out of date EXIT_QUALIFICATION.

The EPT violation that is injected from L0 to L1 needs to have the correct
EXIT_QUALIFICATION specially for the access bits because the individual
access bits for MMIO EPTs are updated only on actual access of this
specific type. So for the example above, the L1 hypervisor will keep
updating only the read bit in the EPT then resume the L2 guest. The L2
guest would end up causing another exit where the L0 *again* will inject
another EPT violation to L1 hypervisor with *again* an out of date
exit_qualification which indicates a read and not a write. Then this
ping-pong just keeps happening without making any forward progress.

The behavior of mapping MMIO regions changed in:

   commit a340b3e229b24 ("kvm: Map PFN-type memory regions as writable (if possible)")

... where an EPT violation for a read would also fixup the write bits to
avoid another EPT violation which by acciddent would fix the bug mentioned
above.

This commit fixes this situation and ensures that the access bits for the
exit_qualifcation is up to date. That ensures that even L1 hypervisor
running with a KVM version before the commit mentioned above would still
work.

( The description above assumes EPT to be available and used by L1
  hypervisor + the L1 hypervisor is passing through the MMIO region to the L2
  guest while this MMIO region is emulated by the L0 user-space ).

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/paging_tmpl.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 5abae72..6288e9d 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -452,14 +452,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	 * done by is_rsvd_bits_set() above.
 	 *
 	 * We set up the value of exit_qualification to inject:
-	 * [2:0] - Derive from [2:0] of real exit_qualification at EPT violation
+	 * [2:0] - Derive from the access bits. The exit_qualification might be
+	 *         out of date if it is serving an EPT misconfiguration.
 	 * [5:3] - Calculated by the page walk of the guest EPT page tables
 	 * [7:8] - Derived from [7:8] of real exit_qualification
 	 *
 	 * The other bits are set to 0.
 	 */
 	if (!(errcode & PFERR_RSVD_MASK)) {
-		vcpu->arch.exit_qualification &= 0x187;
+		vcpu->arch.exit_qualification &= 0x180;
+		if (write_fault)
+			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_WRITE;
+		if (user_fault)
+			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_READ;
+		if (fetch_fault)
+			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
 		vcpu->arch.exit_qualification |= (pte_access & 0x7) << 3;
 	}
 #endif
-- 
2.7.4

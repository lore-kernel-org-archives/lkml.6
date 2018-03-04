Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeCDKQ5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:16:57 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21519 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeCDKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:16:55 -0500
X-IronPort-AV: E=Sophos;i="5.47,422,1515456000";
   d="scan'208";a="722625929"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH] nvmx: Check exit qualification RD/WR permission for MMIO accesses
Date: Sun,  4 Mar 2018 11:16:32 +0100
Message-Id: <1520158592-16952-1-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
References: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validate that a write MMIO access that follows a read MMIO access would
have the correct access captured in the exit qualification.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Message-Id: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
---
 x86/vmx_tests.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index 598dd88..a72af1a 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -7,6 +7,7 @@
 #include "msr.h"
 #include "processor.h"
 #include "vm.h"
+#include "pci.h"
 #include "fwcfg.h"
 #include "isr.h"
 #include "desc.h"
@@ -28,6 +29,8 @@ unsigned long *pml4;
 u64 eptp;
 void *data_page1, *data_page2;
 
+phys_addr_t pci_physaddr;
+
 void *pml_log;
 #define PML_INDEX 512
 
@@ -1041,6 +1044,9 @@ static int apic_version;
 
 static int ept_init_common(bool have_ad)
 {
+	int ret;
+	struct pci_dev pcidev;
+
 	if (setup_ept(have_ad))
 		return VMX_TEST_EXIT;
 	data_page1 = alloc_page();
@@ -1053,6 +1059,13 @@ static int ept_init_common(bool have_ad)
 			EPT_RA | EPT_WA | EPT_EA);
 
 	apic_version = apic_read(APIC_LVR);
+
+	ret = pci_find_dev(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_TEST);
+	if (ret != PCIDEVADDR_INVALID) {
+		pci_dev_init(&pcidev, ret);
+		pci_physaddr = pcidev.resource[PCI_TESTDEV_BAR_MEM];
+	}
+
 	return VMX_TEST_START;
 }
 
@@ -1101,6 +1114,16 @@ t1:
 	vmcall();
 	*((u32 *)data_page1) = MAGIC_VAL_2;
 	report("EPT violation - paging structure", vmx_get_test_stage() == 5);
+
+	// MMIO Read/Write
+	vmx_set_test_stage(5);
+	vmcall();
+
+	*(u32 volatile *)pci_physaddr;
+	report("MMIO EPT violation - read", vmx_get_test_stage() == 6);
+
+	*(u32 volatile *)pci_physaddr = MAGIC_VAL_1;
+	report("MMIO EPT violation - write", vmx_get_test_stage() == 7);
 }
 
 static void ept_main()
@@ -1108,12 +1131,12 @@ static void ept_main()
 	ept_common();
 
 	// Test EPT access to L1 MMIO
-	vmx_set_test_stage(6);
+	vmx_set_test_stage(7);
 	report("EPT - MMIO access", *((u32 *)0xfee00030UL) == apic_version);
 
 	// Test invalid operand for INVEPT
 	vmcall();
-	report("EPT - unsupported INVEPT", vmx_get_test_stage() == 7);
+	report("EPT - unsupported INVEPT", vmx_get_test_stage() == 8);
 }
 
 bool invept_test(int type, u64 eptp)
@@ -1187,7 +1210,7 @@ static int ept_exit_handler_common(bool have_ad)
 	ulong reason;
 	u32 insn_len;
 	u32 exit_qual;
-	static unsigned long data_page1_pte, data_page1_pte_pte;
+	static unsigned long data_page1_pte, data_page1_pte_pte, memaddr_pte;
 
 	guest_rip = vmcs_read(GUEST_RIP);
 	guest_cr3 = vmcs_read(GUEST_CR3);
@@ -1249,7 +1272,12 @@ static int ept_exit_handler_common(bool have_ad)
 				data_page1_pte_pte & ~EPT_PRESENT);
 			ept_sync(INVEPT_SINGLE, eptp);
 			break;
-		case 6:
+		case 5:
+			install_ept(pml4, (unsigned long)pci_physaddr,
+				(unsigned long)pci_physaddr, 0);
+			ept_sync(INVEPT_SINGLE, eptp);
+			break;
+		case 7:
 			if (!invept_test(0, eptp))
 				vmx_inc_test_stage();
 			break;
@@ -1305,6 +1333,22 @@ static int ept_exit_handler_common(bool have_ad)
 				data_page1_pte_pte | (EPT_PRESENT));
 			ept_sync(INVEPT_SINGLE, eptp);
 			break;
+		case 5:
+			if (exit_qual & EPT_VLT_RD)
+				vmx_inc_test_stage();
+			TEST_ASSERT(get_ept_pte(pml4, (unsigned long)pci_physaddr,
+						1, &memaddr_pte));
+			set_ept_pte(pml4, memaddr_pte, 1, memaddr_pte | EPT_RA);
+			ept_sync(INVEPT_SINGLE, eptp);
+			break;
+		case 6:
+			if (exit_qual & EPT_VLT_WR)
+				vmx_inc_test_stage();
+			TEST_ASSERT(get_ept_pte(pml4, (unsigned long)pci_physaddr,
+						1, &memaddr_pte));
+			set_ept_pte(pml4, memaddr_pte, 1, memaddr_pte | EPT_RA | EPT_WA);
+			ept_sync(INVEPT_SINGLE, eptp);
+			break;
 		default:
 			// Should not reach here
 			report("ERROR : unexpected stage, %d", false,
-- 
2.7.4

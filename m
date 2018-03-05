Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeCEQ2O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:28:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:31633 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752639AbeCEQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:26:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,427,1515484800";
   d="scan'208";a="25328730"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC, PATCH 15/22] x86/mm: Introduce variables to store number, shift and mask of KeyIDs
Date: Mon,  5 Mar 2018 19:26:03 +0300
Message-Id: <20180305162610.37510-16-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mktme_nr_keyids holds number of KeyIDs available for MKTME, excluding
KeyID zero which used by TME. MKTME KeyIDs start from 1.

mktme_keyid_shift holds shift of KeyID within physical address.

mktme_keyid_mask holds mask to extract KeyID from physical address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mktme.h | 16 ++++++++++++++++
 arch/x86/kernel/cpu/intel.c  | 13 +++++++++----
 arch/x86/mm/Makefile         |  2 ++
 arch/x86/mm/mktme.c          |  5 +++++
 4 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/asm/mktme.h
 create mode 100644 arch/x86/mm/mktme.c

diff --git a/arch/x86/include/asm/mktme.h b/arch/x86/include/asm/mktme.h
new file mode 100644
index 000000000000..df31876ec48c
--- /dev/null
+++ b/arch/x86/include/asm/mktme.h
@@ -0,0 +1,16 @@
+#ifndef	_ASM_X86_MKTME_H
+#define	_ASM_X86_MKTME_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_X86_INTEL_MKTME
+extern phys_addr_t mktme_keyid_mask;
+extern int mktme_nr_keyids;
+extern int mktme_keyid_shift;
+#else
+#define mktme_keyid_mask	((phys_addr_t)0)
+#define mktme_nr_keyids		0
+#define mktme_keyid_shift	0
+#endif
+
+#endif
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 35436bbadd0b..77b5dc937ac6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -589,11 +589,13 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * and number of bits claimed for KeyID is 6, bits 51:46 of
 		 * physical address is unusable.
 		 */
-		phys_addr_t keyid_mask;
+		mktme_keyid_mask = 1ULL << c->x86_phys_bits;
+		mktme_keyid_mask -= 1ULL << (c->x86_phys_bits - keyid_bits);
+		physical_mask &= ~mktme_keyid_mask;
 
-		keyid_mask = 1ULL << c->x86_phys_bits;
-		keyid_mask -= 1ULL << (c->x86_phys_bits - keyid_bits);
-		physical_mask &= ~keyid_mask;
+
+		mktme_nr_keyids = nr_keyids;
+		mktme_keyid_shift = c->x86_phys_bits - keyid_bits;
 	} else {
 		/*
 		 * Reset __PHYSICAL_MASK.
@@ -601,6 +603,9 @@ static void detect_tme(struct cpuinfo_x86 *c)
 		 * between CPUs.
 		 */
 		physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+		mktme_keyid_mask = 0;
+		mktme_keyid_shift = 0;
+		mktme_nr_keyids = 0;
 	}
 #endif
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd6e52f..4ebee899c363 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_X86_INTEL_MKTME)	+= mktme.o
diff --git a/arch/x86/mm/mktme.c b/arch/x86/mm/mktme.c
new file mode 100644
index 000000000000..467f1b26c737
--- /dev/null
+++ b/arch/x86/mm/mktme.c
@@ -0,0 +1,5 @@
+#include <asm/mktme.h>
+
+phys_addr_t mktme_keyid_mask;
+int mktme_nr_keyids;
+int mktme_keyid_shift;
-- 
2.16.1

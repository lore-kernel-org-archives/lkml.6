Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeBGNAe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:00:34 -0500
Received: from mga07.intel.com ([134.134.136.100]:26269 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753630AbeBGM74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:59:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="29584595"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 5/5] x86/pconfig: Provide defines and helper to run MKTME_KEY_PROG leaf
Date: Wed,  7 Feb 2018 15:59:46 +0300
Message-Id: <20180207125946.5906-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
References: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MKTME_KEY_PROG allows to manipulate MKTME keys in the CPU.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/intel_pconfig.h | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/x86/include/asm/intel_pconfig.h b/arch/x86/include/asm/intel_pconfig.h
index fb7a37c3798b..3cb002b1d0f9 100644
--- a/arch/x86/include/asm/intel_pconfig.h
+++ b/arch/x86/include/asm/intel_pconfig.h
@@ -12,4 +12,54 @@ enum pconfig_target {
 
 int pconfig_target_supported(enum pconfig_target target);
 
+enum pconfig_leaf {
+	MKTME_KEY_PROGRAM	= 0,
+	PCONFIG_LEAF_INVALID,
+};
+
+#define PCONFIG ".byte 0x0f, 0x01, 0xc5"
+
+/* Defines and structure for MKTME_KEY_PROGRAM of PCONFIG instruction */
+
+/* mktme_key_program::keyid_ctrl COMMAND, bits [7:0] */
+#define MKTME_KEYID_SET_KEY_DIRECT	0
+#define MKTME_KEYID_SET_KEY_RANDOM	1
+#define MKTME_KEYID_CLEAR_KEY		2
+#define MKTME_KEYID_NO_ENCRYPT		3
+
+/* mktme_key_program::keyid_ctrl ENC_ALG, bits [23:8] */
+#define MKTME_AES_XTS_128	(1 << 8)
+
+/* Return codes from the PCONFIG MKTME_KEY_PROGRAM */
+#define MKTME_PROG_SUCCESS	0
+#define MKTME_INVALID_PROG_CMD	1
+#define MKTME_ENTROPY_ERROR	2
+#define MKTME_INVALID_KEYID	3
+#define MKTME_INVALID_ENC_ALG	4
+#define MKTME_DEVICE_BUSY	5
+
+/* Hardware requires the structure to be 256 byte alinged. Otherwise #GP(0). */
+struct mktme_key_program {
+	u16 keyid;
+	u32 keyid_ctrl;
+	u8 __rsvd[58];
+	u8 key_field_1[64];
+	u8 key_field_2[64];
+} __packed __aligned(256);
+
+static inline int mktme_key_program(struct mktme_key_program *key_program)
+{
+	unsigned long rax = MKTME_KEY_PROGRAM;
+
+	if (!pconfig_target_supported(MKTME_TARGET))
+		return -ENXIO;
+
+	asm volatile(PCONFIG
+		: "=a" (rax), "=b" (key_program)
+		: "0" (rax), "1" (key_program)
+		: "memory", "cc");
+
+	return rax;
+}
+
 #endif	/* _ASM_X86_INTEL_PCONFIG_H */
-- 
2.15.1

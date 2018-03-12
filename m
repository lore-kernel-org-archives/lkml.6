Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeCLMXZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:23:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44931 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCLMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:23:22 -0400
Date: Mon, 12 Mar 2018 05:23:00 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-24c517856af6511be1339dd55edd131160e37aac@git.kernel.org>
Cc: kai.huang@linux.intel.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, mingo@kernel.org,
        hpa@zytor.com, peterz@infradead.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com
Reply-To: dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, hpa@zytor.com, mingo@kernel.org,
        torvalds@linux-foundation.org, kai.huang@linux.intel.com
In-Reply-To: <20180305162610.37510-6-kirill.shutemov@linux.intel.com>
References: <20180305162610.37510-6-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/pconfig: Provide defines and helper to run
 MKTME_KEY_PROG leaf
Git-Commit-ID: 24c517856af6511be1339dd55edd131160e37aac
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  24c517856af6511be1339dd55edd131160e37aac
Gitweb:     https://git.kernel.org/tip/24c517856af6511be1339dd55edd131160e37aac
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Mon, 5 Mar 2018 19:25:53 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:10:54 +0100

x86/pconfig: Provide defines and helper to run MKTME_KEY_PROG leaf

MKTME_KEY_PROG allows to manipulate MKTME keys in the CPU.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kai Huang <kai.huang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180305162610.37510-6-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeENHqJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:46:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeENHqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:46:07 -0400
Date: Mon, 14 May 2018 00:45:45 -0700
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-7c9449b8c8a59511b7d749afb193c96353451c82@git.kernel.org>
Cc: matt@codeblueprint.co.uk, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, ard.biesheuvel@linaro.org, hpa@zytor.com,
        yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, matt@codeblueprint.co.uk, tglx@linutronix.de,
        ard.biesheuvel@linaro.org, hpa@zytor.com, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org
In-Reply-To: <20180504060003.19618-6-ard.biesheuvel@linaro.org>
References: <20180504060003.19618-6-ard.biesheuvel@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Decode IA32/X64 Processor Error Info Structure
Git-Commit-ID: 7c9449b8c8a59511b7d749afb193c96353451c82
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

Commit-ID:  7c9449b8c8a59511b7d749afb193c96353451c82
Gitweb:     https://git.kernel.org/tip/7c9449b8c8a59511b7d749afb193c96353451c82
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 4 May 2018 07:59:51 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 08:57:47 +0200

efi: Decode IA32/X64 Processor Error Info Structure

Print the fields in the IA32/X64 Processor Error Info Structure.

Based on UEFI 2.7 Table 253. IA32/X64 Processor Error Information
Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180504060003.19618-6-ard.biesheuvel@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/cper-x86.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 863f0cd2a0ff..e0633a103fcf 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -9,9 +9,20 @@
  */
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
+#define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7, 2)) >> 2)
+
+#define INFO_VALID_CHECK_INFO		BIT_ULL(0)
+#define INFO_VALID_TARGET_ID		BIT_ULL(1)
+#define INFO_VALID_REQUESTOR_ID		BIT_ULL(2)
+#define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
+#define INFO_VALID_IP			BIT_ULL(4)
 
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
+	int i;
+	struct cper_ia_err_info *err_info;
+	char newpfx[64];
+
 	if (proc->validation_bits & VALID_LAPIC_ID)
 		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
 
@@ -20,4 +31,41 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
 			       sizeof(proc->cpuid), 0);
 	}
+
+	snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
+
+	err_info = (struct cper_ia_err_info *)(proc + 1);
+	for (i = 0; i < VALID_PROC_ERR_INFO_NUM(proc->validation_bits); i++) {
+		printk("%sError Information Structure %d:\n", pfx, i);
+
+		printk("%sError Structure Type: %pUl\n", newpfx,
+		       &err_info->err_type);
+
+		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
+			printk("%sCheck Information: 0x%016llx\n", newpfx,
+			       err_info->check_info);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
+			printk("%sTarget Identifier: 0x%016llx\n",
+			       newpfx, err_info->target_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_REQUESTOR_ID) {
+			printk("%sRequestor Identifier: 0x%016llx\n",
+			       newpfx, err_info->requestor_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_RESPONDER_ID) {
+			printk("%sResponder Identifier: 0x%016llx\n",
+			       newpfx, err_info->responder_id);
+		}
+
+		if (err_info->validation_bits & INFO_VALID_IP) {
+			printk("%sInstruction Pointer: 0x%016llx\n",
+			       newpfx, err_info->ip);
+		}
+
+		err_info++;
+	}
 }

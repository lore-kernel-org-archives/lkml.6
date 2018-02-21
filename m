Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938968AbeBUSBp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:01:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45517 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeBUSBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:01:44 -0500
Date: Wed, 21 Feb 2018 10:00:06 -0800
From: tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-e5d6a126d4c473499f354254a15ca0c2d8c84ca3@git.kernel.org>
Cc: hpa@zytor.com, linux-edac@vger.kernel.org, bp@suse.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, mingo@kernel.org,
        peterz@infradead.org, yazen.ghannam@amd.com, bp@alien8.de,
        tglx@linutronix.de, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de, bp@alien8.de,
        peterz@infradead.org, yazen.ghannam@amd.com, mingo@kernel.org,
        tony.luck@intel.com, bp@suse.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, linux-edac@vger.kernel.org
In-Reply-To: <20180221101900.10326-6-bp@alien8.de>
References: <20180221101900.10326-6-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce/AMD: Pass the bank number to
 smca_get_bank_type()
Git-Commit-ID: e5d6a126d4c473499f354254a15ca0c2d8c84ca3
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

Commit-ID:  e5d6a126d4c473499f354254a15ca0c2d8c84ca3
Gitweb:     https://git.kernel.org/tip/e5d6a126d4c473499f354254a15ca0c2d8c84ca3
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Wed, 21 Feb 2018 11:18:57 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 17:00:54 +0100

x86/mce/AMD: Pass the bank number to smca_get_bank_type()

Pass the bank number to smca_get_bank_type() since that's all we need.

Also, we should compare the bank number to MAX_NR_BANKS (size of the
smca_banks array) not the number of bank types. Bank types are reused
for multiple banks, so the number of types can be different from the
number of banks in a system and thus we could return an invalid bank
type.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: <stable@vger.kernel.org> # 4.14.x: 11cf887728a3 x86/MCE/AMD: Define a function to get SMCA bank type
Cc: <stable@vger.kernel.org> # 4.14.x: c6708d50f166 x86/MCE: Report only DRAM ECC as memory errors on AMD systems
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-6-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 0f32ad2..7fbb19c 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -110,14 +110,14 @@ const char *smca_get_long_name(enum smca_bank_types t)
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
-static enum smca_bank_types smca_get_bank_type(struct mce *m)
+static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 {
 	struct smca_bank *b;
 
-	if (m->bank >= N_SMCA_BANK_TYPES)
+	if (bank >= MAX_NR_BANKS)
 		return N_SMCA_BANK_TYPES;
 
-	b = &smca_banks[m->bank];
+	b = &smca_banks[bank];
 	if (!b->hwid)
 		return N_SMCA_BANK_TYPES;
 
@@ -760,7 +760,7 @@ bool amd_mce_is_memory_error(struct mce *m)
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1063,7 +1063,7 @@ static struct kobj_type threshold_ktype = {
 
 static const char *get_name(unsigned int bank, struct threshold_block *b)
 {
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 
 	if (!mce_flags.smca) {
 		if (b && bank == 4)
@@ -1072,11 +1072,10 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return th_names[bank];
 	}
 
-	if (!smca_banks[bank].hwid)
+	bank_type = smca_get_bank_type(bank);
+	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
-	bank_type = smca_banks[bank].hwid->bank_type;
-
 	if (b && bank_type == SMCA_UMC) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];

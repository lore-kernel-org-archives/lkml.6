Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932916AbeBUKUm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:20:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932798AbeBUKTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:19:23 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] x86/MCE/AMD: Pass the bank number to smca_get_bank_type()
Date: Wed, 21 Feb 2018 11:18:57 +0100
Message-Id: <20180221101900.10326-6-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180221101900.10326-1-bp@alien8.de>
References: <20180221101900.10326-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Pass the bank number to smca_get_bank_type() since that's all we need.

Also, we should compare the bank number to MAX_NR_BANKS (size of the
smca_banks array) not the number of bank types. Bank types are reused
for multiple banks, so the number of types can be different from the
number of banks in a system and thus we could return an invalid bank
type.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: <stable@vger.kernel.org> # 4.14.x: 11cf887728a3 x86/MCE/AMD: Define a function to get SMCA bank type
Cc: <stable@vger.kernel.org> # 4.14.x: c6708d50f166 x86/MCE: Report only DRAM ECC as memory errors on AMD systems
Cc: <stable@vger.kernel.org> # 4.14.x
Link: https://lkml.kernel.org/r/20180215210943.11530-1-Yazen.Ghannam@amd.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 0f32ad242324..7fbb19cb1859 100644
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
-- 
2.13.0

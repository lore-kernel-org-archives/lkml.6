Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+atjXGV7/DTZash4svis6On3RP1PLDtgaeGt5I0jh8wQT1Mlb/msLQMkvN7/acBODEAFeE
ARC-Seal: i=1; a=rsa-sha256; t=1523980957; cv=none;
        d=google.com; s=arc-20160816;
        b=MTaGxJW2N8x6EHutkC9qKvIuIMnUw5VP+UAWjLDxZ/AzBor8OHYdRaTpf0kLwq+m/8
         4DnXlnxTx/tX+GqPbdJ8V/h8bKp0hf3Xi8zk7ibhAGv+IYhRk54SG2aYUEuErGSwoCH0
         ibP8UN49tsq7k5oS2DvHx7mRWzVVu+v0OStbfss5c78KScKlYBBJs6HO2dLbMgfAuaYj
         ZEdNIZyFJyhe74RN5lWre5e9lR9DGvmQyJ50lsW9pz9JqaYR2/BfNxJqcUbbKv4+Saya
         Per1Jxt7BIz597Xu5z5GB5RMP1Df6WSMmkgMHsulT8qOHNgfR6EymFatCm0slHipTutk
         ve6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EjTHK5rf5CsA16gAO/y6iAJkGt0A68bSCb/VftYq9Qo=;
        b=TSvIlXlm5VSHzUs8hB7rs3LST7zOTsxKdEHiJpJK1+dA7mh5chY+TGoG+xOV5VS9Kt
         RL8ucmVZTL8f8iLsAhPdV3J2CpncEUnOatZY//ow3UiqBNSk8tCpKfm739qZ1KZTMhiW
         5LmYTKpzYv6uDrlTibZZFc/wlGw2wJC4u+wdsOXJoCo4QY650oP4udGV/uPJ+89kvESG
         mgolUR8KERhsi+kk7pL4EwQz7Otgjs/qOv/R9xbZtOLUoD0+nXEoBe0Bl0F+RQ3MCy4k
         yCRkNtPtuwlpCBCX/enfhqQf4ZZtMK9zUEQOUQ8anCDq1+g5f3Kq7v2kEYq9pxPET7Yl
         3IIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@suse.de>,
	Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac <linux-edac@vger.kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 28/68] x86/mce/AMD: Pass the bank number to smca_get_bank_type()
Date: Tue, 17 Apr 2018 17:57:41 +0200
Message-Id: <20180417155750.484924852@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009856327420253?=
X-GMAIL-MSGID: =?utf-8?q?1598009856327420253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit e5d6a126d4c473499f354254a15ca0c2d8c84ca3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -110,14 +110,14 @@ const char *smca_get_long_name(enum smca
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
 
@@ -760,7 +760,7 @@ bool amd_mce_is_memory_error(struct mce
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1063,7 +1063,7 @@ static struct kobj_type threshold_ktype
 
 static const char *get_name(unsigned int bank, struct threshold_block *b)
 {
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 
 	if (!mce_flags.smca) {
 		if (b && bank == 4)
@@ -1072,11 +1072,10 @@ static const char *get_name(unsigned int
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

Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/o7feX27fmDe7yCN7X9xI9i/ZwIzxWnxFqJt5yQoAaVfHbCfA06ctfakCCefG1c71tqU9G
ARC-Seal: i=1; a=rsa-sha256; t=1523981223; cv=none;
        d=google.com; s=arc-20160816;
        b=mgvWYCtn2MlgjLQEm2rp8WKIBvSCsjQzlDLoh2enQJBTxEpYuxtMy2l4NEbKAxdUxS
         0nc60UdUvNwCgUdg1tz4jo3QKJKdDGmRDZEnXFabvMkbnt/dB1c99+qQvpPKX46DnBNM
         T3BFJEdZMEjJJX1qPbS6clDOA/VERzxgjkpHojXYyyRvC3LE4l6LEOM57FPA+Qsm5EFo
         599NFHtaawWyzTGw7o8neTO8Cn30rn2WiOLnDhXD4MwORuRSPcpNPvVM2ldb5f0AYMlD
         91MgDwWAeGujcUXmJIIhsd53cCpSmkx/huPqBLAb79sOC+D1tlJ80tJ8dT1x9mGqxN8G
         brXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P/hhgyyE0o9H2jGggCnH3uTSiYGr5kP+2zQm08Dgig4=;
        b=g0ZswjGKoH02ci62+H2iH2Aqyzod0uC9hEE88Nx5DAY9qljtsBaVehYHcuC6+cUDJs
         V282k6HNrtAEg22KR+0miFN8zyCrTX+H4aVDVzIXPqotB3ShRPnJPuW2/eVt5oP75dx3
         Y92NpQStcqi05Tz1cKv6EZZaUIc8wUNcGB1z4xGIzznH8jttlF/DNXr6ESmRc22VDrvP
         lt+TFLPDWfam6W0vhLcGYupl5oU+EsvObv8lYSfreb+HvOclJAJvRZvT+xwTWs4mxMdi
         AV2azTGUK7HaIuduJRb3lFoT18utZOFU5viP1kCmiZA1NnobbG8JkUqY1ge8lZ195Bjg
         bZ3w==
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
Subject: [PATCH 4.14 37/49] x86/mce/AMD: Pass the bank number to smca_get_bank_type()
Date: Tue, 17 Apr 2018 17:59:16 +0200
Message-Id: <20180417155716.787234362@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009856327420253?=
X-GMAIL-MSGID: =?utf-8?q?1598010135526808329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -758,7 +758,7 @@ bool amd_mce_is_memory_error(struct mce
 	u8 xec = (m->status >> 16) & 0x1f;
 
 	if (mce_flags.smca)
-		return smca_get_bank_type(m) == SMCA_UMC && xec == 0x0;
+		return smca_get_bank_type(m->bank) == SMCA_UMC && xec == 0x0;
 
 	return m->bank == 4 && xec == 0x8;
 }
@@ -1061,7 +1061,7 @@ static struct kobj_type threshold_ktype
 
 static const char *get_name(unsigned int bank, struct threshold_block *b)
 {
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 
 	if (!mce_flags.smca) {
 		if (b && bank == 4)
@@ -1070,11 +1070,10 @@ static const char *get_name(unsigned int
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

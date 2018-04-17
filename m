Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7UKF5cYjAF2+vYfKg13QUk5WdMjbLfAm+J9VIpUVuY4kLvm53x1zes827WvbMgyr/lE6y
ARC-Seal: i=1; a=rsa-sha256; t=1523980959; cv=none;
        d=google.com; s=arc-20160816;
        b=ypfPDwdBIuXwnKjfRU57TLb7z1e6O7X8H7QcZEuj+yaAdSlpaaf0s5AOv1F8mOlJJT
         PyLELsCxCoWbJzqQr+GyEQvsICxBaJNT/QyreQ2czRTi73XKV8DIHszcKC362iIvXdjD
         N/3QEbtweJT6quqbRA5PafgXmKRxbtesA1xpaCSFUBFIu/3nesuZVYFstdBE41jBZA/c
         uP6Sjltgdf/YfCBCzsQrwYTai1SuPl/hrNixQQHhtwALpPnSz6T+a1oSAhbX0KXBEs0k
         1h8JRKcsGJTHmfM5ksI6wa/l4+n2HotmwYf3Ab+sFSNub48a2/J46CpnGK9Nfa05yufc
         wcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rf5ArrMrgNa4kgMR+DtqxTqQOX1pD4mxwrxoMnjd6rA=;
        b=Tr2TfjAXCb8UJQOfB8ZLnhFTrMx1G/je45HqsM/19qEz8M61/6iae5LQtH9hRglENb
         AnkNDM1VxDF3lQX9Hojk1ndIeNMQ6ob9AbrdQSnyhCBXuzAMIcvuKM76SaKrAFFi96xU
         8sFSfiYXQ9GgBIw5jNp/mzWppOGuXc0RvfdoovFIaFKWqcTIxGTfT2ZoSTDTAOBJPMS6
         /vYINuXf5dyI72UtoxcHgeGA1zjCbyjChL8juay8mT/Jq7eaQNAbXmvTKQeM64DX/IW8
         YyiK0DEcdhgs/ECYweKwn+RdnHg/W7TNeOBeeNJNQTOwWLHt1HKdPbtqZiA7qqO4K+Au
         29vA==
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
Subject: [PATCH 4.16 29/68] x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
Date: Tue, 17 Apr 2018 17:57:42 +0200
Message-Id: <20180417155750.522518451@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009858597408342?=
X-GMAIL-MSGID: =?utf-8?q?1598009858597408342?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 68627a697c195937672ce07683094c72b1174786 upstream.

Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
bank 4 in the smca_banks array. This means that when we check if a bank
is initialized, like during boot or resume, we will see that bank 4 is
not initialized and try to initialize it.

This will cause a call trace, when resuming from suspend, due to
rdmsr_*on_cpu() calls in the init path. The rdmsr_*on_cpu() calls issue
an IPI but we're running with interrupts disabled. This triggers:

  WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0
  ...

Reserved banks will be read-as-zero, so their MCA_IPID register will be
zero. So, like the smca_banks array, the threshold_banks array will not
have an entry for a reserved bank since all its MCA_MISC* registers will
be zero.

Enumerate a "Reserved" bank type that matches on a HWID_MCATYPE of 0,0.

Use the "Reserved" type when checking if a bank is reserved. It's
possible that other bank numbers may be reserved on future systems.

Don't try to find the block address on reserved banks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org> # 4.14.x
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180221101900.10326-7-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mce.h           |    1 +
 arch/x86/kernel/cpu/mcheck/mce_amd.c |    7 +++++++
 drivers/edac/mce_amd.c               |   11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -346,6 +346,7 @@ enum smca_bank_types {
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
+	SMCA_RESERVED,	/* Reserved */
 	SMCA_EX,	/* Execution Unit */
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -82,6 +82,7 @@ static struct smca_bank_name smca_names[
 	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
 	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
 	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
+	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
 	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
 	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
@@ -127,6 +128,9 @@ static enum smca_bank_types smca_get_ban
 static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype, xec_bitmap } */
 
+	/* Reserved type */
+	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
+
 	/* ZN Core (HWID=0xB0) MCA types */
 	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
@@ -433,6 +437,9 @@ static u32 get_block_address(unsigned in
 	u32 addr = 0, offset = 0;
 
 	if (mce_flags.smca) {
+		if (smca_get_bank_type(bank) == SMCA_RESERVED)
+			return addr;
+
 		if (!block) {
 			addr = MSR_AMD64_SMCA_MCx_MISC(bank);
 		} else {
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -854,21 +854,24 @@ static void decode_mc6_mce(struct mce *m
 static void decode_smca_error(struct mce *m)
 {
 	struct smca_hwid *hwid;
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
 	if (m->bank >= ARRAY_SIZE(smca_banks))
 		return;
 
-	if (x86_family(m->cpuid) >= 0x17 && m->bank == 4)
-		pr_emerg(HW_ERR "Bank 4 is reserved on Fam17h.\n");
-
 	hwid = smca_banks[m->bank].hwid;
 	if (!hwid)
 		return;
 
 	bank_type = hwid->bank_type;
+
+	if (bank_type == SMCA_RESERVED) {
+		pr_emerg(HW_ERR "Bank %d is reserved.\n", m->bank);
+		return;
+	}
+
 	ip_name = smca_get_long_name(bank_type);
 
 	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);

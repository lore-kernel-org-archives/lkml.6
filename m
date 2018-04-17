Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/5bT+IQjEB8ILpUqK7i2z6F46BLLiNWCsAvmQFULbtzGaOZjE/Lc3QlgmPn7pX/lIx8vJq
ARC-Seal: i=1; a=rsa-sha256; t=1523981220; cv=none;
        d=google.com; s=arc-20160816;
        b=PJdjpIC8wvWfX5JN3xV92RvjI0x905+AxSlldi9Ta/Tl6nbxdarkogV72CmTNcgtI7
         1IySuWwOQFNdNjh2Y+sqAchnbnr4nqsfa+RIgD7/9DsnmQ+KhvcR3P1ENCFJBeRkUr54
         UojfnldGTsHgo4ZKblhEaptdwDMZYVXyPVyTGAXh2mAwxz6Eib07mbT8Eo8KOt3tltkc
         lAP4BCJuzkx6QECB+Um9MiYlGBVC8FPWlRBHjFjxUDdJ35S6CiSjypOd6NUdAOiin3yJ
         JlvyK5PPVGPU6MnQC4/FvyOHfVLMLf91apAMdnzXPb5+YPLqI9ofvyzpcL58kJfb0osa
         k1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cX44EAS4NKcal9BritQaBhG0YLfjydDPyQyXYEQdU9U=;
        b=FUTrVioomDHprflso7ClvqCRnYn/w2e81hAXY2Phd+cGwBVFBZRolFXLcRIEwCwWck
         tZJqB/pcPoCDXlVqdMqaeMzZmpaas49Er8IDtemwEz5hu3eGlrvpjBDir0zESEsIxzve
         8vWIYxH7rqnrSm5QaYiOG3TpfZbgBhm/MQbR8FCHF2DZwI0Ocq7lxOtJx2liC2dboc1w
         FKZLfltDPva33GSe4wcwFqm+nX/LDrBgVueIjrm3cRyngdgjNyVWOEqvGytOzIuy8uAW
         SGZ5TnFegILFfJiblIBW8K7OYB5vwPLInrh7D5pw9yldF7/xufHft9sf9F9W8j21cnjy
         8iTg==
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 36/49] x86/MCE: Report only DRAM ECC as memory errors on AMD systems
Date: Tue, 17 Apr 2018 17:59:15 +0200
Message-Id: <20180417155716.737471721@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010132018413158?=
X-GMAIL-MSGID: =?utf-8?q?1598010132018413158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit c6708d50f166bea2d763c96485d31fdbc50204f1 upstream.

The MCA_STATUS[ErrorCodeExt] field is very bank type specific.
We currently check if the ErrorCodeExt value is 0x0 or 0x8 in
mce_is_memory_error(), but we don't check the bank number. This means
that we could flag non-memory errors as memory errors.

We know that we want to flag DRAM ECC errors as memory errors, so let's do
those cases first. We can add more cases later when needed.

Define a wrapper function in mce_amd.c so we can use SMCA enums.

[ bp: Remove brackets around return statements. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20171207203955.118171-2-Yazen.Ghannam@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mce.h           |    2 ++
 arch/x86/kernel/cpu/mcheck/mce.c     |    4 +---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   11 +++++++++++
 3 files changed, 14 insertions(+), 3 deletions(-)

--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -376,6 +376,7 @@ struct smca_bank {
 extern struct smca_bank smca_banks[MAX_NR_BANKS];
 
 extern const char *smca_get_long_name(enum smca_bank_types t);
+extern bool amd_mce_is_memory_error(struct mce *m);
 
 extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
@@ -384,6 +385,7 @@ extern int mce_threshold_remove_device(u
 
 static inline int mce_threshold_create_device(unsigned int cpu) { return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu) { return 0; };
+static inline bool amd_mce_is_memory_error(struct mce *m) { return false; };
 
 #endif
 
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -512,10 +512,8 @@ static int mce_usable_address(struct mce
 bool mce_is_memory_error(struct mce *m)
 {
 	if (m->cpuvendor == X86_VENDOR_AMD) {
-		/* ErrCodeExt[20:16] */
-		u8 xec = (m->status >> 16) & 0x1f;
+		return amd_mce_is_memory_error(m);
 
-		return (xec == 0x0 || xec == 0x8);
 	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -752,6 +752,17 @@ out_err:
 }
 EXPORT_SYMBOL_GPL(umc_normaddr_to_sysaddr);
 
+bool amd_mce_is_memory_error(struct mce *m)
+{
+	/* ErrCodeExt[20:16] */
+	u8 xec = (m->status >> 16) & 0x1f;
+
+	if (mce_flags.smca)
+		return smca_get_bank_type(m) == SMCA_UMC && xec == 0x0;
+
+	return m->bank == 4 && xec == 0x8;
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;

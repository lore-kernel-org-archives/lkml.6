Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+cbKfbDVzLUb/ihCPhcPZl7pUhD/OWCegtLrf1jWo/ARntyyKQjHm+uKEQ+wjZXvGOjVsg
ARC-Seal: i=1; a=rsa-sha256; t=1523981180; cv=none;
        d=google.com; s=arc-20160816;
        b=Lxzcb6vCPojdu+QELb9q+MKzKopaCrWiDAyz83xV9iTlVMIRfhbAOpTFmsmdTkiWLg
         yPU9MpgzSmXVZebpQBIIO6Xh5imRvyhS6S2spjcIj4agM/d7Ikjhn/LuJBZp29jS2Li0
         J8bNWKccIIiKNYLUK8veHTXpk3rnG0uhKc/OvG3xrCNVmWwzqBGaarR3GjSPdz+l2GbZ
         J8jBLn/DyGqDQuFRS79/tEkb2TocBRQmNOiN9UKgdcOPNxm8A+CGO9Ro+d2scuwmpi5k
         HAf7wK59ymgrmbWD4hy5ZpvqdhdU5ZqDIDF+sZ2Q+hhVgujH/iX/pmoyIVInGlfVG5Tg
         EguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QonIo7HQ6jbc8qp3AqNrxJGtZrzwTnH/rOu7zzGR/bg=;
        b=DDJx8kagdr29+bJ6M0bscvbfZISszSb0eq+3SRkL66V5QDRVQHR2YmiSlZY4uyTUxu
         7PVJOclHgCQY3lICIc9LQaV8p2PLgKREHJs3WXfVmOb63RwThSLlDo/mEF7J7HAiL/t8
         QIRm2nZ23wxqxDSxvmdXnTklx0I6smo54mZp68tIitw2PFiy7QzHicUXUYYBMTF1qjwV
         q0+YiIY5o2I5LzbUvbuJJ4SR4fX9C2Ew9yXsV8unsFBo+OHw1K+YTkxGlcXD52MA1zOm
         xvZt16UNw2rxAI26FzCDNfSXVRMPIgUQjNMfsDFdnKdZuZBK6FqYyAd6EBh9UuQNqU56
         yNqg==
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
Subject: [PATCH 4.14 21/49] x86/MCE/AMD: Define a function to get SMCA bank type
Date: Tue, 17 Apr 2018 17:59:00 +0200
Message-Id: <20180417155716.034473186@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010090008085881?=
X-GMAIL-MSGID: =?utf-8?q?1598010090008085881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 11cf887728a3d1de77cc12ce247b64ef32608891 upstream.

Scalable MCA systems have various types of banks. The bank's type
can determine how we handle errors from it. For example, if a bank
represents a UMC (Unified Memory Controller) then we will need to
convert its address from a normalized address to a system physical
address before handling the error.

[ bp: Verify m->bank is within range and use bank pointer. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20171207203955.118171-1-Yazen.Ghannam@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/mcheck/mce_amd.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -110,6 +110,20 @@ const char *smca_get_long_name(enum smca
 }
 EXPORT_SYMBOL_GPL(smca_get_long_name);
 
+static enum smca_bank_types smca_get_bank_type(struct mce *m)
+{
+	struct smca_bank *b;
+
+	if (m->bank >= N_SMCA_BANK_TYPES)
+		return N_SMCA_BANK_TYPES;
+
+	b = &smca_banks[m->bank];
+	if (!b->hwid)
+		return N_SMCA_BANK_TYPES;
+
+	return b->hwid->bank_type;
+}
+
 static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype, xec_bitmap } */
 

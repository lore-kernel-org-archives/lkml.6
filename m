Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225gl9BCxH0b2EHeUuNAemfHTNOVteELkzkqCztYDGsiDMKLkP3FBXmBqZHYequsRroW6nWx
ARC-Seal: i=1; a=rsa-sha256; t=1517855109; cv=none;
        d=google.com; s=arc-20160816;
        b=kciAqQP7oCRP8Ws/mTmBWBJa9dmUcKOviQF9rlg8k8rXMCCdCiyTrB5oroxFN3RMVU
         kVSCdRxXQ4/BhOPo4iXomAjVvfjkp1Nv41HBoBCUOfJwGKbrrflbpvKKc20VwEtPtoiY
         00GglTsz08LdYy1go2dXd/Pf3scXEmUrXYmzH5s4pxqK5lcvjqIXwvc9Knk4Azb86Y3c
         Sk8/MmqWU6vXqmv6MDRwSYpLDJ/hXzLVq0gbywXnrn3wgrqzEUbDuZquevU3vt19KV7X
         NNZQ8R/iI37QqfoB94Ubj/DEsUVZQ8eOC8Kg3D0JB9qYpwvZVQUxEu1nYwx/iBTeIb0L
         TR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wn4/Y5s15j2exljyjEC6P+eWAjeeoEfvcPRWBYzC07I=;
        b=Ds6LpWG1WYXrOmkRPuUVpqfUjhjeXNAHnWNfRbDHcxpgsGJFwolChrF92dPmqO8lr2
         UxFsiAMXcKmtC79ts9cMJOxuE8zP+5mc/ESmcm8oTL3lijK+7oAacZatI1Hn/70hx46E
         CkE+VI3z6qNEYik7S652pHOZLwP1kjvqmqwLT+IT078csuV+UxnvHTWnaXB1rOWBlJHE
         RsXXg6p4pjL3RqYLb2QRUhzHufQVpBxQRtfkdUnACcfAekq/VrkG4NSwrArGiSz3DP3p
         JYTUC4qj72H+gFaHMbBvy57PVw8gXMWB8edRYgfbbewjyQYae20sXpoi/JEDpckpD9wS
         lWJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	gnomes@lxorguk.ukuu.org.uk,
	ak@linux.intel.com,
	ashok.raj@intel.com,
	dave.hansen@intel.com,
	karahmed@amazon.de,
	arjan@linux.intel.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	bp@alien8.de,
	pbonzini@redhat.com,
	tim.c.chen@linux.intel.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 09/60] x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes
Date: Mon,  5 Feb 2018 10:22:42 -0800
Message-Id: <20180205182214.305086493@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586336170736700?=
X-GMAIL-MSGID: =?utf-8?q?1591586438786121742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit a5b2966364538a0e68c9fa29bc0a3a1651799035

This doesn't refuse to load the affected microcodes; it just refuses to
use the Spectre v2 mitigation features if they're detected, by clearing
the appropriate feature bits.

The AMD CPUID bits are handled here too, because hypervisors *may* have
been exposing those bits even on Intel chips, for fine-grained control
of what's available.

It is non-trivial to use x86_match_cpu() for this table because that
doesn't handle steppings. And the approach taken in commit bd9240a18
almost made me lose my lunch.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-7-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/intel.c |   66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -102,6 +102,59 @@ static void probe_xeon_phi_r3mwait(struc
 		ELF_HWCAP2 |= HWCAP2_RING3MWAIT;
 }
 
+/*
+ * Early microcode releases for the Spectre v2 mitigation were broken.
+ * Information taken from;
+ * - https://newsroom.intel.com/wp-content/uploads/sites/11/2018/01/microcode-update-guidance.pdf
+ * - https://kb.vmware.com/s/article/52345
+ * - Microcode revisions observed in the wild
+ * - Release note from 20180108 microcode release
+ */
+struct sku_microcode {
+	u8 model;
+	u8 stepping;
+	u32 microcode;
+};
+static const struct sku_microcode spectre_bad_microcodes[] = {
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0B,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_DESKTOP,	0x09,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x84 },
+	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x84 },
+	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
+	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
+	{ INTEL_FAM6_SKYLAKE_MOBILE,	0x03,	0xc2 },
+	{ INTEL_FAM6_SKYLAKE_DESKTOP,	0x03,	0xc2 },
+	{ INTEL_FAM6_BROADWELL_CORE,	0x04,	0x28 },
+	{ INTEL_FAM6_BROADWELL_GT3E,	0x01,	0x1b },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x02,	0x14 },
+	{ INTEL_FAM6_BROADWELL_XEON_D,	0x03,	0x07000011 },
+	{ INTEL_FAM6_BROADWELL_X,	0x01,	0x0b000025 },
+	{ INTEL_FAM6_HASWELL_ULT,	0x01,	0x21 },
+	{ INTEL_FAM6_HASWELL_GT3E,	0x01,	0x18 },
+	{ INTEL_FAM6_HASWELL_CORE,	0x03,	0x23 },
+	{ INTEL_FAM6_HASWELL_X,		0x02,	0x3b },
+	{ INTEL_FAM6_HASWELL_X,		0x04,	0x10 },
+	{ INTEL_FAM6_IVYBRIDGE_X,	0x04,	0x42a },
+	/* Updated in the 20180108 release; blacklist until we know otherwise */
+	{ INTEL_FAM6_ATOM_GEMINI_LAKE,	0x01,	0x22 },
+	/* Observed in the wild */
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x06,	0x61b },
+	{ INTEL_FAM6_SANDYBRIDGE_X,	0x07,	0x712 },
+};
+
+static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
+		if (c->x86_model == spectre_bad_microcodes[i].model &&
+		    c->x86_mask == spectre_bad_microcodes[i].stepping)
+			return (c->microcode <= spectre_bad_microcodes[i].microcode);
+	}
+	return false;
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
@@ -122,6 +175,19 @@ static void early_init_intel(struct cpui
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
+	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_STIBP) ||
+	     cpu_has(c, X86_FEATURE_AMD_SPEC_CTRL) ||
+	     cpu_has(c, X86_FEATURE_AMD_PRED_CMD) ||
+	     cpu_has(c, X86_FEATURE_AMD_STIBP)) && bad_spectre_microcode(c)) {
+		pr_warn("Intel Spectre v2 broken microcode detected; disabling SPEC_CTRL\n");
+		clear_cpu_cap(c, X86_FEATURE_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_STIBP);
+		clear_cpu_cap(c, X86_FEATURE_AMD_SPEC_CTRL);
+		clear_cpu_cap(c, X86_FEATURE_AMD_PRED_CMD);
+		clear_cpu_cap(c, X86_FEATURE_AMD_STIBP);
+	}
+
 	/*
 	 * Atom erratum AAE44/AAF40/AAG38/AAH41:
 	 *

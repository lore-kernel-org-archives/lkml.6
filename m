Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoUliJUf/H9QxFGspI+CQK6fR1jPMOLZ/FnZOh1bRXm3EQWlPOCT+weSqDRx+8k1GnQ9bmC
ARC-Seal: i=1; a=rsa-sha256; t=1526937587; cv=none;
        d=google.com; s=arc-20160816;
        b=HtbOGneiYzY8bQVNsiGktwicUPyb2t6Q7sFP5molqs0jmloFIRf4E2chva9MIQvK8z
         +jI0AJAk66sLbJeCWopNrLidoq1t2P4hIehoZSgR1/+TrDIYcXMiPZpnAQWSl1j202FG
         hvDHax0Oo/Lq07I+M8ifM4CbgOgotjSZJEun5a9Vtr9MTVT4tF9kvFpGQNc1Cy7cJ0ui
         qrbuNoPmT5x669xcO4OGsUVeQbqhXl+2RuoF6zRXQZ46eWBw3+nr0HW0HwNRY58Bj/DQ
         P2p9qifY32ptKcprYU+soxSEqmTAwe4T9/nYqxbrYjB278lHqlUvZo3YBUvJfmiCmrPo
         rj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=FB989A0DZJsnqkEDdaBemxvRWRalCcAVVwdN+BalQG8=;
        b=CHcaTxwlvlebL54SkWjQHpjw3DoQuk/zaxHykDPNySVjQGAKoxVrj56j38DQGA8NFb
         pRUwcPNYB75OR3mJi1Ibpj6E1NKdV9dyyVUOrHgieJ0IvzIkROSsD4RswoOsA9OTRSLr
         wDbvB5ibntzq7IMv/3kv9ICKopSRuAMLAsObwnKHGxulBfR8ppF8Sw/x1x4+PrJ/Q1im
         uQw6A6XAZT2U1wWTxsg8FNSjYehoGkRJbwdaYiB1uzH3L2wt1JHwkqKsOcQlYc3zHbv5
         9Ed4JLqxHsimwjqojq4tBkXWYN5TNXbvCiJAtZGMIFCGymnb8sNSpXkTxQb9foi9OF9J
         FjEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kkZsk6wg;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kkZsk6wg;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 49/95] x86/bugs: Concentrate bug detection into a separate function
Date: Mon, 21 May 2018 23:11:39 +0200
Message-Id: <20180521210457.765126913@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109824365345903?=
X-GMAIL-MSGID: =?utf-8?q?1601110107328045143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 4a28bfe3267b68e22c663ac26185aa16c9b879ef upstream

Combine the various logic which goes through all those
x86_cpu_id matching structures in one function.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/common.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -894,21 +894,27 @@ static const __initconst struct x86_cpu_
 	{}
 };
 
-static bool __init cpu_vulnerable_to_meltdown(struct cpuinfo_x86 *c)
+static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
 
+	if (x86_match_cpu(cpu_no_speculation))
+		return;
+
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+
 	if (x86_match_cpu(cpu_no_meltdown))
-		return false;
+		return;
 
 	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
-		return false;
+		return;
 
-	return true;
+	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
 /*
@@ -958,12 +964,7 @@ static void __init early_identify_cpu(st
 
 	setup_force_cpu_cap(X86_FEATURE_ALWAYS);
 
-	if (!x86_match_cpu(cpu_no_speculation)) {
-		if (cpu_vulnerable_to_meltdown(c))
-			setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
-	}
+	cpu_set_bug_bits(c);
 
 	fpu__init_system(c);
 

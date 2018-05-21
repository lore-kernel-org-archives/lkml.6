Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq93U0U9NUpfoWb8yaIsvK0+cOoV/k6Jo4FzhS44XJvnovp6wnrMZX92iWd3joRkVavctcr
ARC-Seal: i=1; a=rsa-sha256; t=1526937612; cv=none;
        d=google.com; s=arc-20160816;
        b=IhAO72Dexva3ntWYuhdmWHisJ8o8lVJaq7HEGRYuWCqeoVMMcTdkpOhZwTV4rHf4JI
         y9Sfgk5fK8JgY3LY6gQxachFQPHyC3bATSoqY6egATsRqcHqHXp5X9jURHPTSyz4d0K+
         f7LsbLUvO7SGkc/yyrpiXn5CmXkYiNa/Qb1nY79Ns0UE7eD7S1SG3ijhDrU4ofLon3EJ
         FJMpcwtoMkuFlbmeERk0m5W4aDla4/ahKKDvx96W0Jf8ofLbGN+cH4UkV5vzKoARUfOi
         uXJICdpCAnUIMKw43HqLGy9y/B/jkrzfbiKLUkQEpnl/b4MK0LfTlzXqyUB8hiY4Rv/p
         847w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=27E+phvh7iDbkqWLNw8eooU45ErAUTPhRoBHC9f4Qfc=;
        b=oUTLcnyO0kORF4igg5lNpa58kmjm/UgAbNsPmx3MTKK33z698nr+fw4eg3cg0SIssf
         lWGzAxFskr8bYvM/YPMBHfP3Ugfzd+e8DLsc5LgDY+IIcMWzR9WJruIwnpqc20m95TH4
         SrXG+1kWvvw9i3RYrDR7JwDc8cSADAofkLq8w00/31xhsNNuxw0BoEOLAWjqzcq64XCT
         PYtc7cUeVpxuROtXZbNH7FK1nE+lJkKPlDT1XZGGykbT28zn7dBmc8H/dC68WUT84CX0
         GYXw9IJeZfvAwARY8AEPFAUM3M8w5xNfYTV3fa/8Dn30ZU3K+DN7+NJBee/YvB6Woay+
         T/7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UoNf28oa;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=UoNf28oa;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 57/95] x86/bugs: Whitelist allowed SPEC_CTRL MSR values
Date: Mon, 21 May 2018 23:11:47 +0200
Message-Id: <20180521210458.597469853@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109850611268953?=
X-GMAIL-MSGID: =?utf-8?q?1601110134277804022?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 1115a859f33276fe8afb31c60cf9d8e657872558 upstream

Intel and AMD SPEC_CTRL (0x48) MSR semantics may differ in the
future (or in fact use different MSRs for the same functionality).

As such a run-time mechanism is required to whitelist the appropriate MSR
values.

[ tglx: Made the variable __ro_after_init ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -35,6 +35,12 @@ static void __init ssb_select_mitigation
  */
 static u64 __ro_after_init x86_spec_ctrl_base;
 
+/*
+ * The vendor and possibly platform specific bits which can be modified in
+ * x86_spec_ctrl_base.
+ */
+static u64 __ro_after_init x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -117,7 +123,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
+	if (val & x86_spec_ctrl_mask)
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -459,6 +465,7 @@ static enum ssb_mitigation_cmd __init __
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
+			x86_spec_ctrl_mask &= ~SPEC_CTRL_RDS;
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
@@ -482,7 +489,7 @@ static void ssb_select_mitigation()
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & (SPEC_CTRL_IBRS | SPEC_CTRL_RDS));
+		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 }
 
 #ifdef CONFIG_SYSFS

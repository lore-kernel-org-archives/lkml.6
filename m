Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrhRJ71kNFY4ngrkM+UhG6FdG+53gL3JF3uyG1x/IGnYah3pF7L3VNJaN5uBVkflm9hI63t
ARC-Seal: i=1; a=rsa-sha256; t=1526937997; cv=none;
        d=google.com; s=arc-20160816;
        b=o8RJXtnbSJHn9BNzQkkWziQxPAJQLMRfXtJaKPybtql9zn+QljFOeWs8OtBa51R9hz
         F4ZwnZAFQd57UM2OC8l/71sPbKSmf0FMtBUdX2JlC8G8KC1JMr+Sc2sz6/ON3v1JNxvn
         E0A/QWx4u7ql3frWSt6lsN2gJqDaAbxr0bgtcgSt9IKzCiTO0KkENbB9fgGQIrNZvHtr
         /V9RYpR4UJffSx582aC7SzliqODewldhhEkuSjPNze6aTQT8v9sz/zBGZthWWAwiREJ6
         KzOjme/U73LwQs8faYjzae//ksjbg6Ouwu049/bvo+WM6aXvgu4GzBCExUGUGoTj0Kii
         VTbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2L+lScfIQu3P/dDRO45yYIsZM1UfFapfjkCumux88DQ=;
        b=rmRNAK4sqxIXtkCO20jasZowcIDdz8P0dNN3puKutXboB9i+z/094iccod0dBrDKKe
         9zNz4VCB//hstaPByrQvy4Ch5g2BaTv8a3Io+3WaMiGEFXXKjN4MDKQZqYfUzSBuuKj/
         rqt1AXsEZ25BJxySi89WRfw2eyCJlpluFjmS7KW7JU3vUCH7Mi3BPpVj7VFQzX5++1v8
         UesAW5niUkv7Ppvxt11ZSroyruNUw8a8TmR58tkUdlfy+lEWi0HN/EYQqxPNNrdxecKk
         szeZjA20nNMJWijA/7CvV1X+iP6zcP7fZ9ZVp5hhsGOcJCfzqoHgtFjupFiG+ihV47na
         jlZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OIh5M2+W;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=OIh5M2+W;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.16 071/110] x86/bugs: Whitelist allowed SPEC_CTRL MSR values
Date: Mon, 21 May 2018 23:12:08 +0200
Message-Id: <20180521210512.449085078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109850611268953?=
X-GMAIL-MSGID: =?utf-8?q?1601110537721870005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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

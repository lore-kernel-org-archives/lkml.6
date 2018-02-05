Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225hStUzP32ZOMaNbnRHy1dhfowaU/UFXgl+ahY2Xl0Ig5xCup4iWBP8btYcXhgHeNPnpzsn
ARC-Seal: i=1; a=rsa-sha256; t=1517855162; cv=none;
        d=google.com; s=arc-20160816;
        b=NCjXAiHafzYH/ZpNZPRFYPDWELhITDdRP4TV0SZz1fcJDd4nlVtiHcQKRhrmRNhaBY
         Prya/wMbniE5eN2FMWYG+BBK5X6h/SXe/hcM9dECdVISk1bP4wRUwiHcbKMjNstQ9WfP
         jpMTWZBejmfWBGkvK0ilzPwgh+PWa0666R3NKn4hNXf+xjCJ2oIv9xoUSH/ydO8AmH6L
         jGshRpukV2IrmZF9KJaSAGvv2eKEYbT8TMFW7be/8wQFWCI+3NpkEgMPHQP/1SEcmLkk
         lxKvdl44J125/6wX3kANSGMK1OCNKFScMuQXXGRxwX2cSyGUn6itm80RBoXZXlfFAedP
         KUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=T1MguqecCA2RPHfwzb6EPf54I4dFPbqNU45oiKWjM7o=;
        b=R98TrEzRZJ/DSeF8kioBfjffTFQekYBAzbzdGv+NlT0LymmAZAzyVRwLKx2mNTclHw
         Em9YkDv2YUUiRX4Nc7udSou6TVpomGDrDo25L6LNAfz3k+gKYl6MXlv/FUHVJ0p3qsvH
         O0cUeb6Nf+cOVCu2SijmK/sKaJkK2wAoVbaVY0AYbiuwdfi/Onr9NxA9BxEYskr9WNiq
         6cW5tACpo6ulUa9frn+1USpZ7MWdpJOgdvdAHQTjfHCbgNeq4INTZ978zQIIGsYzDSkv
         7XzOdWDw5G288gg5+DTJaYJXEckwLTeRqCY7AKBnUrVGGm6u384ZVKhhh8wwpoQrjNH5
         txCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	peterz@infradead.org,
	bp@alien8.de
Subject: [PATCH 4.15 51/60] x86/spectre: Simplify spectre_v2 command line parsing
Date: Mon,  5 Feb 2018 10:23:24 -0800
Message-Id: <20180205182216.343466931@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586400224596220?=
X-GMAIL-MSGID: =?utf-8?q?1591586494918116569?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed karahmed@amazon.de

commit 9005c6834c0ffdfe46afa76656bd9276cca864f6

[dwmw2: Use ARRAY_SIZE]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/kernel/cpu/bugs.c |   84 +++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -119,13 +119,13 @@ static inline const char *spectre_v2_mod
 static void __init spec2_print_if_insecure(const char *reason)
 {
 	if (boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s\n", reason);
+		pr_info("%s selected on command line.\n", reason);
 }
 
 static void __init spec2_print_if_secure(const char *reason)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
-		pr_info("%s\n", reason);
+		pr_info("%s selected on command line.\n", reason);
 }
 
 static inline bool retp_compiler(void)
@@ -140,42 +140,68 @@ static inline bool match_option(const ch
 	return len == arglen && !strncmp(arg, opt, len);
 }
 
+static const struct {
+	const char *option;
+	enum spectre_v2_mitigation_cmd cmd;
+	bool secure;
+} mitigation_options[] = {
+	{ "off",               SPECTRE_V2_CMD_NONE,              false },
+	{ "on",                SPECTRE_V2_CMD_FORCE,             true },
+	{ "retpoline",         SPECTRE_V2_CMD_RETPOLINE,         false },
+	{ "retpoline,amd",     SPECTRE_V2_CMD_RETPOLINE_AMD,     false },
+	{ "retpoline,generic", SPECTRE_V2_CMD_RETPOLINE_GENERIC, false },
+	{ "auto",              SPECTRE_V2_CMD_AUTO,              false },
+};
+
 static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 {
 	char arg[20];
-	int ret;
+	int ret, i;
+	enum spectre_v2_mitigation_cmd cmd = SPECTRE_V2_CMD_AUTO;
+
+	if (cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+		return SPECTRE_V2_CMD_NONE;
+	else {
+		ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
+					  sizeof(arg));
+		if (ret < 0)
+			return SPECTRE_V2_CMD_AUTO;
 
-	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg,
-				  sizeof(arg));
-	if (ret > 0)  {
-		if (match_option(arg, ret, "off")) {
-			goto disable;
-		} else if (match_option(arg, ret, "on")) {
-			spec2_print_if_secure("force enabled on command line.");
-			return SPECTRE_V2_CMD_FORCE;
-		} else if (match_option(arg, ret, "retpoline")) {
-			spec2_print_if_insecure("retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE;
-		} else if (match_option(arg, ret, "retpoline,amd")) {
-			if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-				pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
-				return SPECTRE_V2_CMD_AUTO;
-			}
-			spec2_print_if_insecure("AMD retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE_AMD;
-		} else if (match_option(arg, ret, "retpoline,generic")) {
-			spec2_print_if_insecure("generic retpoline selected on command line.");
-			return SPECTRE_V2_CMD_RETPOLINE_GENERIC;
-		} else if (match_option(arg, ret, "auto")) {
+		for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
+			if (!match_option(arg, ret, mitigation_options[i].option))
+				continue;
+			cmd = mitigation_options[i].cmd;
+			break;
+		}
+
+		if (i >= ARRAY_SIZE(mitigation_options)) {
+			pr_err("unknown option (%s). Switching to AUTO select\n",
+			       mitigation_options[i].option);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
 
-	if (!cmdline_find_option_bool(boot_command_line, "nospectre_v2"))
+	if ((cmd == SPECTRE_V2_CMD_RETPOLINE ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_AMD ||
+	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC) &&
+	    !IS_ENABLED(CONFIG_RETPOLINE)) {
+		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
+		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
-disable:
-	spec2_print_if_insecure("disabled on command line.");
-	return SPECTRE_V2_CMD_NONE;
+	}
+
+	if (cmd == SPECTRE_V2_CMD_RETPOLINE_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+		pr_err("retpoline,amd selected but CPU is not AMD. Switching to AUTO select\n");
+		return SPECTRE_V2_CMD_AUTO;
+	}
+
+	if (mitigation_options[i].secure)
+		spec2_print_if_secure(mitigation_options[i].option);
+	else
+		spec2_print_if_insecure(mitigation_options[i].option);
+
+	return cmd;
 }
 
 /* Check for Skylake-like CPUs (for RSB handling) */

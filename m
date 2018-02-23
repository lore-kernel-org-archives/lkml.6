Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225fdUp6a9w3RBLWRJpBwuzZ9rrqI2XVsrQ9iiOjSK+mfDPOnlWe3wFRzFK7fNe0AulvsqYE
ARC-Seal: i=1; a=rsa-sha256; t=1519411295; cv=none;
        d=google.com; s=arc-20160816;
        b=c/k/+BVvd27rIQs6fGLPw80KvefGovkh2OlWcmXBwWy4RioN4KzLDUqcChIxKCDXKL
         DlESprlpofDZabPhZNzw5SEWYwS9ba1vhW8MDgn+D7fqUy5UOOQyDcleU+SgDbVWXy+f
         GiR8aTDhq+Wo3RktHl4Jaue1IwghJX8ftP8bAHJuGqcj6OBK8TkhY5bHlRcInxzxs86C
         Hm3B3Ea8rbsB6wAZw3ybJVYE7OInYplq8F3vhDrTAD2u58BFACP8AiIwmSNeF4C9nZdT
         01GXJQyzZOfkeoC65vFZB2gp2rVJkZp7xCG0VUYlLFPgxsecReHSlbm2zJD17oOKYtMo
         VCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lutd+L0LCllD5pxaESWPVzHYs0KfKP5Qbj596el59y0=;
        b=ySF0AOTeXKDFrbqcVydTpyD6RzZMgFmINTP2R6W3rKFOj1skqutGeBn2aiNgc7/0dY
         gH/7N2Sw3XvEixQ5qUs9TR3PNE7iSTdG8mu4hbLZtnvmtBSvjkJH1bkQJVZgVHXHAnvH
         zrMo0l9UeVUVbLOGXa6xkQg3QoPi/tGM0b+FnPIDNUA7/0djT6kg7cB9Wg9CeX+dmKKr
         fulcTzLbpjts9NfZ5D9SJDWLaSqLi0SZUwNcqjMz2A17iohfnY9TJd0wMeac+PR7oGqR
         gagd1xLghj8ECpIgyXb0DseofSnrwd9Q9liiah1rK1u4/wHGeIR6nR3QXSMBw12WBx8P
         MZUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	KarimAllah Ahmed <karahmed@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	peterz@infradead.org,
	bp@alien8.de,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 4.4 186/193] x86/spectre: Simplify spectre_v2 command line parsing
Date: Fri, 23 Feb 2018 19:26:59 +0100
Message-Id: <20180223170355.379658981@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218218564418522?=
X-GMAIL-MSGID: =?utf-8?q?1593218218564418522?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: KarimAllah Ahmed <karahmed@amazon.de>

(cherry picked from commit 9005c6834c0ffdfe46afa76656bd9276cca864f6)

[dwmw2: Use ARRAY_SIZE]

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
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

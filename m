Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrX9dSbWeWqvL6QXOLOrd7v0o+9v9gtvexf09nZNdpvv6LUu8nV7Hna3StjPCXXZir1d8Kq
ARC-Seal: i=1; a=rsa-sha256; t=1526937384; cv=none;
        d=google.com; s=arc-20160816;
        b=yG7banns/jR20YR5c4CAkRgnqgoTx1F3uM2ggUg1YBBBN8+bCZeoUja5865QF5+WNa
         bGsXdODzmiwCWi0/auPNSCtPPQxBs11OsS/yM+Rfp7WMZTi/70h5wO8CsZalvB6O+LX/
         GPIFMm/IZa3/TtJosF0yTxMmmMD3Hs5eG8tePzpNUFSlVWb7jjEzJCFZvpld3vPcfMfR
         aktablvaVoK7cHzTua1D6E2wgG6qyipOJTg3w6JZhqwdVhhEm+QJqpLifjUStbAbuf4l
         uvQ/eEM+bPTHAsqteEY94GE3mZdY+XEgBg5mtMbNpZti7s02A3b30zuEt5WxBDOSD4s7
         /ZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=dmNzbCSnJQLXa+RhWOgiQLvNmCIxrepnc6DMDIUxmL8=;
        b=pYkEbt4mtniQ6vChUmaz47INHwMB2bYeqxSdWR/Ke27DIWYukqnhbPugCiCxTKk2cI
         2ZpaIBokt5eaV8IxvDBtgcTXR3qNUdYhkOhNf5aA+n73th27GFKJAB4Qaw9Q1vFSHHvw
         xAlH+3O/YMwF1o255AoPJzJlMjhgJWWmBg3J6qdtXsh75nnfKBY+eeUJZbT5BUlsy+VX
         ReRHnn+Q9amsRa1mO6MUpYe/Q463s+1uTyLQOIl2x3LaJ+zND3dtNB4jxbzqFiyvuTLG
         zFwLiiUYF4daMCKrel7M+fYbh6KHBRA70pW6PLTWsJj3AwZa1N9oRIwR44ePUQL59Om0
         8j5Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EL8aLZzG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EL8aLZzG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 63/87] x86/speculation: Make "seccomp" the default mode for Speculative Store Bypass
Date: Mon, 21 May 2018 23:11:39 +0200
Message-Id: <20180521210425.733930167@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109894850235462?=
X-GMAIL-MSGID: =?utf-8?q?1601109894850235462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit f21b53b20c754021935ea43364dbf53778eeba32 upstream

Unless explicitly opted out of, anything running under seccomp will have
SSB mitigations enabled. Choosing the "prctl" mode will disable this.

[ tglx: Adjusted it to the new arch_seccomp_spec_mitigate() mechanism ]

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/kernel-parameters.txt  |   26 +++++++++++++++++---------
 arch/x86/include/asm/nospec-branch.h |    1 +
 arch/x86/kernel/cpu/bugs.c           |   32 +++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 18 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3997,19 +3997,27 @@ bytes respectively. Such letter suffixes
 			This parameter controls whether the Speculative Store
 			Bypass optimization is used.
 
-			on     - Unconditionally disable Speculative Store Bypass
-			off    - Unconditionally enable Speculative Store Bypass
-			auto   - Kernel detects whether the CPU model contains an
-				 implementation of Speculative Store Bypass and
-				 picks the most appropriate mitigation.
-			prctl  - Control Speculative Store Bypass per thread
-				 via prctl. Speculative Store Bypass is enabled
-				 for a process by default. The state of the control
-				 is inherited on fork.
+			on      - Unconditionally disable Speculative Store Bypass
+			off     - Unconditionally enable Speculative Store Bypass
+			auto    - Kernel detects whether the CPU model contains an
+				  implementation of Speculative Store Bypass and
+				  picks the most appropriate mitigation. If the
+				  CPU is not vulnerable, "off" is selected. If the
+				  CPU is vulnerable the default mitigation is
+				  architecture and Kconfig dependent. See below.
+			prctl   - Control Speculative Store Bypass per thread
+				  via prctl. Speculative Store Bypass is enabled
+				  for a process by default. The state of the control
+				  is inherited on fork.
+			seccomp - Same as "prctl" above, but all seccomp threads
+				  will disable SSB unless they explicitly opt out.
 
 			Not specifying this option is equivalent to
 			spec_store_bypass_disable=auto.
 
+			Default mitigations:
+			X86:	If CONFIG_SECCOMP=y "seccomp", otherwise "prctl"
+
 	spia_io_base=	[HW,MTD]
 	spia_fio_base=
 	spia_pedr=
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -233,6 +233,7 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
+	SPEC_STORE_BYPASS_SECCOMP,
 };
 
 extern char __indirect_thunk_start[];
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -415,22 +415,25 @@ enum ssb_mitigation_cmd {
 	SPEC_STORE_BYPASS_CMD_AUTO,
 	SPEC_STORE_BYPASS_CMD_ON,
 	SPEC_STORE_BYPASS_CMD_PRCTL,
+	SPEC_STORE_BYPASS_CMD_SECCOMP,
 };
 
 static const char *ssb_strings[] = {
 	[SPEC_STORE_BYPASS_NONE]	= "Vulnerable",
 	[SPEC_STORE_BYPASS_DISABLE]	= "Mitigation: Speculative Store Bypass disabled",
-	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl"
+	[SPEC_STORE_BYPASS_PRCTL]	= "Mitigation: Speculative Store Bypass disabled via prctl",
+	[SPEC_STORE_BYPASS_SECCOMP]	= "Mitigation: Speculative Store Bypass disabled via prctl and seccomp",
 };
 
 static const struct {
 	const char *option;
 	enum ssb_mitigation_cmd cmd;
 } ssb_mitigation_options[] = {
-	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },  /* Platform decides */
-	{ "on",		SPEC_STORE_BYPASS_CMD_ON },    /* Disable Speculative Store Bypass */
-	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },  /* Don't touch Speculative Store Bypass */
-	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL }, /* Disable Speculative Store Bypass via prctl */
+	{ "auto",	SPEC_STORE_BYPASS_CMD_AUTO },    /* Platform decides */
+	{ "on",		SPEC_STORE_BYPASS_CMD_ON },      /* Disable Speculative Store Bypass */
+	{ "off",	SPEC_STORE_BYPASS_CMD_NONE },    /* Don't touch Speculative Store Bypass */
+	{ "prctl",	SPEC_STORE_BYPASS_CMD_PRCTL },   /* Disable Speculative Store Bypass via prctl */
+	{ "seccomp",	SPEC_STORE_BYPASS_CMD_SECCOMP }, /* Disable Speculative Store Bypass via prctl and seccomp */
 };
 
 static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
@@ -480,8 +483,15 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
-		/* Choose prctl as the default mode */
-		mode = SPEC_STORE_BYPASS_PRCTL;
+	case SPEC_STORE_BYPASS_CMD_SECCOMP:
+		/*
+		 * Choose prctl+seccomp as the default mode if seccomp is
+		 * enabled.
+		 */
+		if (IS_ENABLED(CONFIG_SECCOMP))
+			mode = SPEC_STORE_BYPASS_SECCOMP;
+		else
+			mode = SPEC_STORE_BYPASS_PRCTL;
 		break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
@@ -529,12 +539,14 @@ static void ssb_select_mitigation()
 }
 
 #undef pr_fmt
+#define pr_fmt(fmt)     "Speculation prctl: " fmt
 
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	bool update;
 
-	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL)
+	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
+	    ssb_mode != SPEC_STORE_BYPASS_SECCOMP)
 		return -ENXIO;
 
 	switch (ctrl) {
@@ -582,7 +594,8 @@ int arch_prctl_spec_ctrl_set(struct task
 #ifdef CONFIG_SECCOMP
 void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
-	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
+		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -591,6 +604,7 @@ static int ssb_prctl_get(struct task_str
 	switch (ssb_mode) {
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
+	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;

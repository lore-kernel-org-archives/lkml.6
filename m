Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D843ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032C420685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032C420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbeGWNry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389443AbeGWNry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:54 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63C93C8A;
        Mon, 23 Jul 2018 12:45:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 075/107] x86/speculation: Make "seccomp" the default mode for Speculative Store Bypass
Date:   Mon, 23 Jul 2018 14:42:09 +0200
Message-Id: <20180723122417.157439760@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 Documentation/kernel-parameters.txt  |   26 +++++++++++++++++---------
 arch/x86/include/asm/nospec-branch.h |    1 +
 arch/x86/kernel/cpu/bugs.c           |   32 +++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 18 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3647,19 +3647,27 @@ bytes respectively. Such letter suffixes
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
@@ -188,6 +188,7 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
 	SPEC_STORE_BYPASS_DISABLE,
 	SPEC_STORE_BYPASS_PRCTL,
+	SPEC_STORE_BYPASS_SECCOMP,
 };
 
 extern char __indirect_thunk_start[];
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -414,22 +414,25 @@ enum ssb_mitigation_cmd {
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
@@ -479,8 +482,15 @@ static enum ssb_mitigation_cmd __init __
 
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
@@ -528,12 +538,14 @@ static void ssb_select_mitigation()
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
@@ -581,7 +593,8 @@ int arch_prctl_spec_ctrl_set(struct task
 #ifdef CONFIG_SECCOMP
 void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
-	ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
+	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
+		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
 
@@ -590,6 +603,7 @@ static int ssb_prctl_get(struct task_str
 	switch (ssb_mode) {
 	case SPEC_STORE_BYPASS_DISABLE:
 		return PR_SPEC_DISABLE;
+	case SPEC_STORE_BYPASS_SECCOMP:
 	case SPEC_STORE_BYPASS_PRCTL:
 		if (task_spec_ssb_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;



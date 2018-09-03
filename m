Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F5C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5543F20868
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5543F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeICRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:05:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:32788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727330AbeICRFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:05:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 841CFAFFE;
        Mon,  3 Sep 2018 12:45:32 +0000 (UTC)
Date:   Mon, 3 Sep 2018 14:45:31 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH v2 3/3] x86/speculation: Enable cross-hyperthread spectre v2
 STIBP mitigation
Message-ID: <nycvar.YFH.7.76.1809031444160.25787@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

STIBP is a feature provided by certain Intel ucodes / CPUs. This feature
(once enabled) prevents cross-hyperthread control of decisions made by
indirect branch predictors.

Enable this feature if

- the CPU is vulnerable to spectre v2
- the CPU supports SMT
- spectre_v2 mitigation autoselection is enabled (default)

After some previous discussion, this patch leaves STIBP on all the time,
as wrmsr on crossing kernel boundary is a no-no. This could perhaps later
be a bit more optimized (like disabling it in NOHZ, experiment with
disabling it in idle, etc) if needed.

Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/kernel/cpu/bugs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 40bdaea97fe7..535b006dc50d 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -325,6 +325,12 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	return cmd;
 }
 
+static bool __init stibp_needed(void)
+{
+	return (cpu_smt_control != CPU_SMT_NOT_SUPPORTED &&
+			boot_cpu_has(X86_FEATURE_STIBP));
+}
+
 static void __init spectre_v2_select_mitigation(void)
 {
 	enum spectre_v2_mitigation_cmd cmd = spectre_v2_parse_cmdline();
@@ -344,6 +350,12 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (stibp_needed()) {
+			/* Enable STIBP on SMT-capable systems */
+			pr_info("Spectre v2 cross-process SMT mitigation: Enabling STIBP\n");
+			x86_spec_ctrl_base |= SPEC_CTRL_STIBP;
+			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		}
 		if (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED)) {
 			mode = SPECTRE_V2_IBRS_ENHANCED;
 			/* Force it so VMEXIT will restore correctly */
-- 
Jiri Kosina
SUSE Labs


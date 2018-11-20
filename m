Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A4C04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45F5213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45F5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeKULFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:05:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:30241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeKULFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:05:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:33:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93650181"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 16:33:20 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [Patch v6 03/16] x86/speculation: Disable STIBP when enhanced IBRS is in use
Date:   Tue, 20 Nov 2018 15:59:55 -0800
Message-Id: <98459d97781796d8fa04aecb7ed473b7c4e48956.1542757030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If enhanced IBRS is engaged, STIBP is redundant in mitigating Spectre
v2 user space exploits from hyperthread sibling.

Disable STIBP when enhanced IBRS is used.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3a6f13b..199f27e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -323,11 +323,16 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	return cmd;
 }
 
+/* Determine if STIBP should be always on. */
 static bool stibp_needed(void)
 {
 	if (spectre_v2_enabled == SPECTRE_V2_NONE)
 		return false;
 
+	/* Using enhanced IBRS makes using STIBP unnecessary. */
+	if (static_cpu_has(X86_FEATURE_USE_IBRS_ENHANCED))
+		return false;
+
 	if (!boot_cpu_has(X86_FEATURE_STIBP))
 		return false;
 
@@ -856,6 +861,9 @@ static ssize_t l1tf_show_state(char *buf)
 
 static char *stibp_state(void)
 {
+	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+		return "";
+
 	if (x86_spec_ctrl_base & SPEC_CTRL_STIBP)
 		return ", STIBP";
 	else
-- 
2.9.4


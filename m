Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1866CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCB32086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFCB32086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeIYSqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:46:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:34740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728781AbeIYSqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:46:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 503C5AEA3;
        Tue, 25 Sep 2018 12:39:29 +0000 (UTC)
Date:   Tue, 25 Sep 2018 14:39:28 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v7 3/3] x86/speculation: Propagate information about RSB
 filling mitigation to sysfs
In-Reply-To: <nycvar.YFH.7.76.1809251431260.15880@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1809251438580.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809251431260.15880@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

If spectrev2 mitigation has been enabled, we're filling RSB on context 
switch in order to protect from various classess of spectrev2 attacks.

If this mitigation is enabled, say so in sysfs for spectrev2.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 arch/x86/kernel/cpu/bugs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 53eb14a65610..fe32103fcdc7 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -874,10 +874,11 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 
 	case X86_BUG_SPECTRE_V2:
-		ret = sprintf(buf, "%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
+		ret = sprintf(buf, "%s%s%s%s%s%s\n", spectre_v2_strings[spectre_v2_enabled],
 			       boot_cpu_has(X86_FEATURE_USE_IBPB) ? ", IBPB" : "",
 			       boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? ", IBRS_FW" : "",
 			       (x86_spec_ctrl_base & SPEC_CTRL_STIBP) ? ", STIBP" : "",
+			       boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? ", RSB filling" : "",
 			       spectre_v2_module_string());
 		return ret;
 
-- 
2.12.3


-- 
Jiri Kosina
SUSE Labs


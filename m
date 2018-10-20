Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2571CECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE742098A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE742098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJTIU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:20:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:18823 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeJTIU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:20:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 17:12:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="82652154"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2018 17:12:34 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B71C1300FC1; Fri, 19 Oct 2018 17:12:34 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, eranian@google.com,
        kan.liang@intel.com, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v3 1/2] x86/cpufeature: Add facility to match microcode revisions
Date:   Fri, 19 Oct 2018 17:12:29 -0700
Message-Id: <20181020001230.31555-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For bug workarounds or checks it is useful to check for specific
microcode revisionss. Add a new table format to check for steppings
with min microcode revisions.

This does not change the existing x86_cpu_id because it's an ABI
shared with modutils, and also has quite different requirements,
as in no wildcards, but everything has to be matched exactly.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
v2:
Remove all CPU match, only check boot cpu
Move INTEL_MIN_UCODE macro to header.
Minor cleanups.
Remove max ucode and driver data
v3:
Rename function
Update comments.
Document mixed stepping caveats.
Use u8 for model
Remove vendor 0 check.
Change return check
---
 arch/x86/include/asm/cpu_device_id.h | 29 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/match.c          | 19 ++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index baeba0567126..97d645910ec2 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -11,4 +11,33 @@
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 
+/*
+ * Match specific microcode revisions.
+ *
+ * vendor/family/model/stepping must be all set.
+ *
+ * only checks against the boot cpu.  When mixed-stepping configs are
+ * valid for a CPU model, add a quirk for every valid stepping and
+ * do the fine-tuning in the quirk handler.
+ */
+
+struct x86_ucode_id {
+	u8  vendor;
+	u8  family;
+	u8  model;
+	u8  stepping;
+	u32 min_ucode;
+};
+
+#define INTEL_MIN_UCODE(mod, step, rev) {			\
+	.vendor = X86_VENDOR_INTEL,				\
+	.family = 6,						\
+	.model = mod,						\
+	.stepping = step,					\
+	.min_ucode = rev,					\
+}
+
+extern const struct x86_ucode_id *
+x86_match_microcode(const struct x86_ucode_id *match);
+
 #endif
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 3fed38812eea..d44c8cfd7b29 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -48,3 +48,22 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	return NULL;
 }
 EXPORT_SYMBOL(x86_match_cpu);
+
+const struct x86_ucode_id *x86_match_microcode(const struct x86_ucode_id *match)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	const struct x86_ucode_id *m;
+
+	for (m = match; m->family | m->model; m++) {
+		if (c->x86_vendor != m->vendor)
+			continue;
+		if (c->x86 != m->family)
+			continue;
+		if (c->x86_model != m->model)
+			continue;
+		if (c->x86_stepping != m->stepping)
+			continue;
+		return c->microcode >= m->min_ucode ? m : NULL;
+	}
+	return NULL;
+}
-- 
2.17.1


Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF992083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF992083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJZIU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:20:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:46868 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeJZIU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:20:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 16:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="81649555"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2018 16:45:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4496E301B82; Thu, 25 Oct 2018 16:45:46 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        eranian@google.com, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v4 1/2] x86/cpufeature: Add facility to match microcode revisions
Date:   Thu, 25 Oct 2018 16:45:19 -0700
Message-Id: <20181025234520.30838-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
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
v4:
Rename to x86_min_microcode
Change return value to bool
---
 arch/x86/include/asm/cpu_device_id.h | 28 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/match.c          | 19 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index baeba0567126..28847d5ea1fa 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -11,4 +11,32 @@
 
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
+extern bool x86_min_microcode(const struct x86_ucode_id *mt);
+
 #endif
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 3fed38812eea..12db14232d62 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -48,3 +48,22 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	return NULL;
 }
 EXPORT_SYMBOL(x86_match_cpu);
+
+bool x86_min_microcode(const struct x86_ucode_id *mt)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	const struct x86_ucode_id *m;
+
+	for (m = mt; m->family | m->model; m++) {
+		if (c->x86_vendor != m->vendor)
+			continue;
+		if (c->x86 != m->family)
+			continue;
+		if (c->x86_model != m->model)
+			continue;
+		if (c->x86_stepping != m->stepping)
+			continue;
+		return c->microcode >= m->min_ucode;
+	}
+	return false;
+}
-- 
2.17.2


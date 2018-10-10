Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D292DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D5E21470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D5E21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJJXtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:49:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:40793 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJXtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:49:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2018 09:26:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,364,1534834800"; 
   d="scan'208";a="87300183"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Oct 2018 09:26:18 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 408A9300B47; Wed, 10 Oct 2018 09:26:18 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     peterz@infradead.org
Cc:     x86@kernel.org, eranian@google.com, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 1/2] x86/cpufeature: Add facility to match microcode revisions
Date:   Wed, 10 Oct 2018 09:26:07 -0700
Message-Id: <20181010162608.23899-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

For bug workarounds or checks it is useful to check for specific
microcode versions. Add a new table format to check for steppings
with min microcode revisions.

This does not change the existing x86_cpu_id because it's an ABI
shared with modutils, and also has quite difference requirements,
as in no wildcards, but everything has to be matched exactly.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
v2:
Remove all CPU match, only check boot cpu
Move INTEL_MIN_UCODE macro to header.
Minor cleanups.
Remove max ucode and driver data
---
 arch/x86/include/asm/cpu_device_id.h | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/match.c          | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index baeba0567126..1b90bd1d0b95 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -11,4 +11,30 @@
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 
+/*
+ * Match specific microcodes
+ *
+ * vendor/family/model/stepping must be all set.
+ * min_ucode is optional and can be 0.
+ */
+
+struct x86_ucode_id {
+	u8 vendor;
+	u8 family;
+	u16 model;
+	u16 stepping;
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
+x86_match_ucode(const struct x86_ucode_id *match);
+
 #endif
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 3fed38812eea..ec8ee31699cd 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -48,3 +48,24 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	return NULL;
 }
 EXPORT_SYMBOL(x86_match_cpu);
+
+const struct x86_ucode_id *x86_match_ucode(const struct x86_ucode_id *match)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	const struct x86_ucode_id *m;
+
+	for (m = match; m->vendor | m->family | m->model; m++) {
+		if (c->x86_vendor != m->vendor)
+			continue;
+		if (c->x86 != m->family)
+			continue;
+		if (c->x86_model != m->model)
+			continue;
+		if (c->x86_stepping != m->stepping)
+			continue;
+		if (c->microcode < m->min_ucode)
+			continue;
+		return m;
+	}
+	return NULL;
+}
-- 
2.17.1


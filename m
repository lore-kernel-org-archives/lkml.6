Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC43CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2EE2147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfAGWfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:35:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:34117 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfAGWfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:35:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 14:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124985842"
Received: from otc-lr-04.jf.intel.com ([10.54.39.135])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2019 14:35:04 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 1/4] x86/cpufeature: Add facility to check for min microcode revisions
Date:   Mon,  7 Jan 2019 14:34:22 -0800
Message-Id: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

For bug workarounds or checks it is useful to check for specific
microcode revisions.

Add a new generic function to match the CPU with stepping.
Add the other function to check the min microcode revisions for
the matched CPU.
A new table format is introduced to facilitate the quirk to
fill the related information.

This does not change the existing x86_cpu_id because it's an ABI
shared with modules, and also has quite different requirements,
as in no wildcards, but everything has to be matched exactly.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V4:
- Rename to x86_cpu_check and INTEL_CHECK_UCODE
- Split x86_min_microcode() into two functions. One is a generic
  CPU match function with stepping. The other is to check the min
  microcode revisions.

The previous discussion can be found here.
https://lkml.org/lkml/2018/10/10/740

 arch/x86/include/asm/cpu_device_id.h | 28 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/match.c          | 31 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index baeba05..43f19af 100644
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
+struct x86_cpu_check {
+	u8	vendor;
+	u8	family;
+	u8	model;
+	u8	stepping;
+	u32	microcode_rev;
+};
+
+#define INTEL_CHECK_UCODE(mod, step, rev) {			\
+	.vendor = X86_VENDOR_INTEL,				\
+	.family = 6,						\
+	.model = mod,						\
+	.stepping = step,					\
+	.microcode_rev = rev,					\
+}
+
+extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_check *table);
+
 #endif
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 3fed388..408bed37 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -48,3 +48,34 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	return NULL;
 }
 EXPORT_SYMBOL(x86_match_cpu);
+
+static const struct x86_cpu_check *
+x86_match_cpu_with_stepping(const struct x86_cpu_check *match)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	const struct x86_cpu_check *m;
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
+		return m;
+	}
+	return NULL;
+}
+
+bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_check *table)
+{
+	const struct x86_cpu_check *res = x86_match_cpu_with_stepping(table);
+
+	if (!res || res->microcode_rev > boot_cpu_data.microcode)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL(x86_cpu_has_min_microcode_rev);
-- 
2.7.4


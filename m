Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388EFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB9B20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBKKoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:44:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43877 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfBKKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:44:03 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1BAhek03495930
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 11 Feb 2019 02:43:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1BAheNY3495927;
        Mon, 11 Feb 2019 02:43:40 -0800
Date:   Mon, 11 Feb 2019 02:43:40 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-0f42b790c9ba5ec2f25b7da8b0b6d361082d67b0@git.kernel.org>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        bp@alien8.de, tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, bp@alien8.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, ak@linux.intel.com,
          peterz@infradead.org, kan.liang@linux.intel.com
In-Reply-To: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
References: <1549319013-4522-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] x86/cpufeature: Add facility to check for min
 microcode revisions
Git-Commit-ID: 0f42b790c9ba5ec2f25b7da8b0b6d361082d67b0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0f42b790c9ba5ec2f25b7da8b0b6d361082d67b0
Gitweb:     https://git.kernel.org/tip/0f42b790c9ba5ec2f25b7da8b0b6d361082d67b0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 4 Feb 2019 14:23:29 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 11 Feb 2019 07:59:23 +0100

x86/cpufeature: Add facility to check for min microcode revisions

For bug workarounds or checks, it is useful to check for specific
microcode revisions.

Add a new generic function to match the CPU with stepping.
Add the other function to check the min microcode revisions for
the matched CPU.

A new table format is introduced to facilitate the quirk to
fill the related information.

This does not change the existing x86_cpu_id because it's an ABI
shared with modules, and also has quite different requirements,
as in no wildcards, but everything has to be matched exactly.

Originally-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: eranian@google.com
Link: https://lkml.kernel.org/r/1549319013-4522-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/cpu_device_id.h | 28 ++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/match.c          | 31 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index baeba0567126..3417110574c1 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -11,4 +11,32 @@
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 
+/*
+ * Match specific microcode revisions.
+ *
+ * vendor/family/model/stepping must be all set.
+ *
+ * Only checks against the boot CPU.  When mixed-stepping configs are
+ * valid for a CPU model, add a quirk for every valid stepping and
+ * do the fine-tuning in the quirk handler.
+ */
+
+struct x86_cpu_desc {
+	__u8	x86_family;
+	__u8	x86_vendor;
+	__u8	x86_model;
+	__u8	x86_stepping;
+	__u32	x86_microcode_rev;
+};
+
+#define INTEL_CPU_DESC(mod, step, rev) {			\
+	.x86_family = 6,					\
+	.x86_vendor = X86_VENDOR_INTEL,				\
+	.x86_model = mod,					\
+	.x86_stepping = step,					\
+	.x86_microcode_rev = rev,				\
+}
+
+extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
+
 #endif
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 3fed38812eea..6dd78d8235e4 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -48,3 +48,34 @@ const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match)
 	return NULL;
 }
 EXPORT_SYMBOL(x86_match_cpu);
+
+static const struct x86_cpu_desc *
+x86_match_cpu_with_stepping(const struct x86_cpu_desc *match)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	const struct x86_cpu_desc *m;
+
+	for (m = match; m->x86_family | m->x86_model; m++) {
+		if (c->x86_vendor != m->x86_vendor)
+			continue;
+		if (c->x86 != m->x86_family)
+			continue;
+		if (c->x86_model != m->x86_model)
+			continue;
+		if (c->x86_stepping != m->x86_stepping)
+			continue;
+		return m;
+	}
+	return NULL;
+}
+
+bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table)
+{
+	const struct x86_cpu_desc *res = x86_match_cpu_with_stepping(table);
+
+	if (!res || res->x86_microcode_rev > boot_cpu_data.microcode)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);

Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6177C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669D7208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669D7208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeH0SUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50018 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeH0SUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:20:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32DC8AFE7;
        Mon, 27 Aug 2018 14:33:41 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     will.deacon@arm.com, marc.zyngier@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robert.richter@cavium.com, cwu@amperecomputing.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RESEND 2/6] arm64: add sysfs vulnerability show for meltdown
Date:   Mon, 27 Aug 2018 16:33:06 +0200
Message-Id: <20180827143310.641-3-ykaukab@suse.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180827143310.641-1-ykaukab@suse.de>
References: <20180827143310.641-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking CSV3 support directly in case CONFIG_UNMAP_KERNEL_AT_EL0
is not enabled.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 arch/arm64/kernel/cpu_errata.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index dec10898d688..996edb4e18ad 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -22,6 +22,7 @@
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/mmu.h>
 
 static bool __maybe_unused
 is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int scope)
@@ -683,3 +684,26 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 	}
 };
+
+#ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
+
+ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	u64 pfr0;
+	u32 csv3;
+
+	if (arm64_kernel_unmapped_at_el0())
+		return sprintf(buf, "Mitigation: KPTI\n");
+
+	pfr0 = read_cpuid(ID_AA64PFR0_EL1);
+	csv3 = cpuid_feature_extract_unsigned_field(pfr0,
+			ID_AA64PFR0_CSV3_SHIFT);
+
+	if (csv3 || is_cpu_meltdown_safe())
+		return sprintf(buf, "Not affected\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
+
+#endif
-- 
2.11.0


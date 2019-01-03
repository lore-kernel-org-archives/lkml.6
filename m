Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B7820815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfACAtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:49:36 -0500
Received: from foss.arm.com ([217.140.101.70]:39792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfACAtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:49:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3158E1596;
        Wed,  2 Jan 2019 16:49:33 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 590D33F5AF;
        Wed,  2 Jan 2019 16:49:32 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, ykaukab@suse.de,
        julien.thierry@arm.com, mlangsdo@redhat.com, steven.price@arm.com,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 2/7] arm64: kpti: move check for non-vulnerable CPUs to a function
Date:   Wed,  2 Jan 2019 18:49:16 -0600
Message-Id: <20190103004921.1928921-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190103004921.1928921-1-jeremy.linton@arm.com>
References: <20190103004921.1928921-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Add is_meltdown_safe() which is a whitelist of known safe cores.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
[Moved location of function]
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 4f272399de89..ab784d7a0083 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -947,8 +947,7 @@ has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 static int __kpti_forced; /* 0: not forced, >0: forced on, <0: forced off */
 
-static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
-				int scope)
+static bool is_cpu_meltdown_safe(void)
 {
 	/* List of CPUs that are not vulnerable and don't need KPTI */
 	static const struct midr_range kpti_safe_list[] = {
@@ -962,6 +961,15 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		{ /* sentinel */ }
 	};
+	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+		return true;
+
+	return false;
+}
+
+static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
+				int scope)
+{
 	char const *str = "command line option";
 
 	/*
@@ -985,8 +993,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE))
 		return true;
 
-	/* Don't force KPTI for CPUs that are not vulnerable */
-	if (is_midr_in_range_list(read_cpuid_id(), kpti_safe_list))
+	if (is_cpu_meltdown_safe())
 		return false;
 
 	/* Defer to CPU feature registers */
-- 
2.17.2


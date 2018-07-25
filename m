Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA28C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5691020844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5691020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeGYJps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:45:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:59980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728540AbeGYJpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:45:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D63C6AD9B;
        Wed, 25 Jul 2018 08:35:08 +0000 (UTC)
From:   Dirk Mueller <dmueller@suse.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Alex Graf <agraf@suse.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Dirk Mueller <dmueller@suse.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH] arm64: Check for errata before evaluating cpu features
Date:   Wed, 25 Jul 2018 10:35:04 +0200
Message-Id: <20180725083504.25836-1-dmueller@suse.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
detection to boot-time CPUs") we rely on errata flags being already
populated during feature enumeration. The order of errata and
features was flipped as part of commit ed478b3f9e4a ("arm64:
capabilities: Group handling of features and errata workarounds").

Return to the orginal order of errata and feature evaluation to
ensure errata flags are present during feature evaluation.

Fixes: d3aec8a28be3b8 ("arm64: capabilities: Restrict KPTI
detection to boot-time CPUs")
CC: Suzuki K Poulose <suzuki.poulose@arm.com>
CC: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Dirk Mueller <dmueller@suse.com>
---
 arch/arm64/kernel/cpufeature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f24892a40d2c..c6d80743f4ed 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1351,9 +1351,9 @@ static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 
 static void update_cpu_capabilities(u16 scope_mask)
 {
-	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
 	__update_cpu_capabilities(arm64_errata, scope_mask,
 				  "enabling workaround for");
+	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
 }
 
 static int __enable_cpu_capability(void *arg)
@@ -1408,8 +1408,8 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 
 static void __init enable_cpu_capabilities(u16 scope_mask)
 {
-	__enable_cpu_capabilities(arm64_features, scope_mask);
 	__enable_cpu_capabilities(arm64_errata, scope_mask);
+	__enable_cpu_capabilities(arm64_features, scope_mask);
 }
 
 /*
-- 
2.18.0


Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35537ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C622084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C622084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbeGTOWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:22:11 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36290 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbeGTOWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:22:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D30168F;
        Fri, 20 Jul 2018 06:33:51 -0700 (PDT)
Received: from e105550-lin.cambridge.arm.com (e105550-lin.cambridge.arm.com [10.1.211.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46A333F73C;
        Fri, 20 Jul 2018 06:33:49 -0700 (PDT)
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 4/4] arch/arm: Rebuild sched_domain hierarchy when cpu capacity changes
Date:   Fri, 20 Jul 2018 14:32:34 +0100
Message-Id: <1532093554-30504-5-git-send-email-morten.rasmussen@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
References: <1532093554-30504-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asymmetric cpu capacity can not necessarily be determined accurately at
the time the initial sched_domain hierarchy is built during boot. It is
therefore necessary to be able to force a full rebuild of the hierarchy
later triggered by the arch_topology driver. A full rebuild requires the
arch-code to implement arch_update_cpu_topology() which isn't yet
implemented for arm. This patch points the arm implementation to
arch_topology driver to ensure that full hierarchy rebuild happens when
needed.

cc: Russell King <linux@armlinux.org.uk>

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/topology.h b/arch/arm/include/asm/topology.h
index 5d88d2f22b2c..2a786f54d8b8 100644
--- a/arch/arm/include/asm/topology.h
+++ b/arch/arm/include/asm/topology.h
@@ -33,6 +33,9 @@ const struct cpumask *cpu_coregroup_mask(int cpu);
 /* Replace task scheduler's default cpu-invariant accounting */
 #define arch_scale_cpu_capacity topology_get_cpu_scale
 
+/* Enable topology flag updates */
+#define arch_update_cpu_topology topology_update_cpu_topology
+
 #else
 
 static inline void init_cpu_topology(void) { }
-- 
2.7.4


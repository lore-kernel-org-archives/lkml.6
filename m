Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8682C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1542157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1542157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeHXOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55558 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230581A25;
        Fri, 24 Aug 2018 03:46:20 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7AD683F5A0;
        Fri, 24 Aug 2018 03:46:18 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 10/20] x86/intel_rdt: Let resctrl change the resources's num_closid
Date:   Fri, 24 Aug 2018 11:45:09 +0100
Message-Id: <20180824104519.11203-11-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today we switch between different alloc_enabled resources which
have differing preset num_closid to account for CDP.
We want to merge these illusionary caches together, at which
point something needs to change the resctrl's view of num_closid.

The arch code now has its own idea of how many closids there are,
and as the two configurations for one rdtgroup is part of resctrl's
ABI we should get resctrl to change it.

We change the num_closid on the l2/l3 resources, which aren't
yet in use when cdp is enabled, then change them back afterwards.
Once we merge illusionary caches, resctrl will see the value it
changed here.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 58dceaad6863..e2a9202674f3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1149,16 +1149,36 @@ int resctrl_arch_set_cdp_enabled(bool enable)
 
 static int try_to_enable_cdp(int level)
 {
+	int ret;
 	struct rdt_resource *r = &rdt_resources_all[level].resctrl;
+	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
+	struct rdt_resource *l2 = &rdt_resources_all[RDT_RESOURCE_L2].resctrl;
 
 	if (!r->cdp_capable)
 		return -EINVAL;
+	if (r->cdp_enabled)
+		return 0;
 
-	return resctrl_arch_set_cdp_enabled(true);
+	ret = resctrl_arch_set_cdp_enabled(true);
+	if (!ret) {
+		if (l2->cdp_enabled)
+			l2->num_closid /= 2;
+		if (l3->cdp_enabled)
+			l3->num_closid /= 2;
+	}
+
+	return ret;
 }
 
 static void cdp_disable_all(void)
 {
+	struct rdt_resource *l2 = &rdt_resources_all[RDT_RESOURCE_L2].resctrl;
+	struct rdt_resource *l3 = &rdt_resources_all[RDT_RESOURCE_L3].resctrl;
+
+	if (l2->cdp_enabled)
+		l2->num_closid *= 2;
+	if (l3->cdp_enabled)
+		l3->num_closid *= 2;
 	resctrl_arch_set_cdp_enabled(false);
 }
 
-- 
2.18.0


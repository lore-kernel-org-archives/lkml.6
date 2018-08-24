Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2EBC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C602168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C602168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeHXOUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55488 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbeHXOUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C1241713;
        Fri, 24 Aug 2018 03:46:08 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E48373F5A0;
        Fri, 24 Aug 2018 03:46:06 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 05/20] x86/intel_rdt: make update_domains() learn the affected closids
Date:   Fri, 24 Aug 2018 11:45:04 +0100
Message-Id: <20180824104519.11203-6-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the closid is present in the staged configuration,
update_domains() can learn which low/high values it should update.

Remove the single passed in closid, and update msr_param as we
apply each staged config.

Once the L2/L2CODE/L2DATA resources are merged this will allow
update_domains() to be called once for the single resource, even
when CDP is in use. This results in both CODE and DATA
configurations being applied and the two consecutive closids being
updated with a single smp_call_function_many().

This will let us keep the CDP odd/even behaviour inside resctrl
so that architectures that don't do this don't need to emulate it.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  4 ++--
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 21 ++++++++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 5e271e0fe1f5..8df549ef016d 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -241,8 +241,8 @@ static inline struct rdt_hw_domain *rc_dom_to_rdt(struct rdt_domain *r)
  */
 struct msr_param {
 	struct rdt_resource	*res;
-	int			low;
-	int			high;
+	u32			low;
+	u32			high;
 };
 
 static inline bool is_llc_occupancy_enabled(void)
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 0c849653a99d..01ffd455313a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -193,22 +193,21 @@ static void apply_config(struct rdt_hw_domain *hw_dom,
 	}
 }
 
-static int update_domains(struct rdt_resource *r, int closid)
+static int update_domains(struct rdt_resource *r)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
+	bool msr_param_init = false;
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
+	u32 closid;
 	int i, cpu;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
-	/* TODO: learn these two by looping the config */
-	msr_param.low = closid;
-	msr_param.high = msr_param.low + 1;
 	msr_param.res = r;
 
 	mba_sc = is_mba_sc(r);
@@ -220,9 +219,21 @@ static int update_domains(struct rdt_resource *r, int closid)
 				continue;
 
 			apply_config(hw_dom, cfg, cpu_mask, mba_sc);
+
+			closid = cfg->closid;
+			if (!msr_param_init) {
+				msr_param.low = closid;
+				msr_param.high = closid;
+				msr_param_init = true;
+			} else {
+				msr_param.low = min(msr_param.low, closid);
+				msr_param.high = max(msr_param.high, closid);
+			}
 		}
 	}
 
+	msr_param.high += 1;
+
 	/*
 	 * Avoid writing the control msr with control values when
 	 * MBA software controller is enabled
@@ -301,7 +312,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		ret = update_domains(r, closid);
+		ret = update_domains(r);
 		if (ret)
 			goto out;
 	}
-- 
2.18.0


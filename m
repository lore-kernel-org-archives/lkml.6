Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5E5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C392157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 10:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C392157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeHXOUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:20:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55672 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHXOUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:20:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3321168F;
        Fri, 24 Aug 2018 03:46:42 -0700 (PDT)
Received: from melchizedek.Emea.Arm.com (melchizedek.emea.arm.com [10.4.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 175273F5A0;
        Fri, 24 Aug 2018 03:46:40 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>
Subject: [RFC PATCH 19/20] x86/intel_rdt: Kill off alloc_enabled
Date:   Fri, 24 Aug 2018 11:45:18 +0100
Message-Id: <20180824104519.11203-20-james.morse@arm.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180824104519.11203-1-james.morse@arm.com>
References: <20180824104519.11203-1-james.morse@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the L2/L2CODE/L2DATA resources are merged together, alloc_enabled
doesn't mean anything, its the same as alloc_capable which indicates
CAT is supported by this cache.

Take the opportunity to kill of alloc_enabled and its helpers.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 3 ---
 arch/x86/kernel/cpu/intel_rdt.h             | 5 -----
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 6 +++---
 include/linux/resctrl.h                     | 2 --
 5 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index f6f1eceb366f..982897839711 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -157,7 +157,6 @@ static inline void cache_alloc_hsw_probe(void)
 	r->cache.shareable_bits = 0xc0000;
 	r->cache.min_cbm_bits = 2;
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	rdt_alloc_capable = true;
 }
@@ -214,7 +213,6 @@ static bool rdt_get_mem_config(struct rdt_resource *r)
 	r->data_width = 3;
 
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 
 	return true;
 }
@@ -234,7 +232,6 @@ static void rdt_get_cache_alloc_cfg(int idx, struct rdt_resource *r)
 	r->cache.shareable_bits = ebx & r->default_ctrl;
 	r->data_width = (r->cache.cbm_len + 3) / 4;
 	r->alloc_capable = true;
-	r->alloc_enabled = true;
 }
 
 static int get_cache_id(int cpu, int level)
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index a4aba005cfea..735d7bd4bcd9 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -342,11 +342,6 @@ static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
 	     r = resctrl_inc(r))							\
 		if (r->mon_capable)
 
-#define for_each_alloc_enabled_rdt_resource(r)				      \
-	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
-	     r = resctrl_inc(r))							\
-		if (r->alloc_enabled)
-
 #define for_each_mon_enabled_rdt_resource(r)				      \
 	for (r = &rdt_resources_all[0].resctrl; r < &rdt_resources_all[RDT_NUM_RESOURCES].resctrl;\
 	     r = resctrl_inc(r))						\
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index e8264637a4d3..ab8bc97dee0b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -329,7 +329,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			goto out;
 	}
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	for_each_alloc_capable_rdt_resource(r) {
 		ret = resctrl_arch_update_domains(r);
 		if (ret)
 			goto out;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 39038bdfa7d6..38cd463443e8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -103,7 +103,7 @@ static void closid_init(void)
 	int rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
-	for_each_alloc_enabled_rdt_resource(r)
+	for_each_alloc_capable_rdt_resource(r)
 		rdt_min_closid = min(rdt_min_closid, r->num_closid);
 
 	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
@@ -1307,7 +1307,7 @@ static int create_schemata_list(void)
 	int ret = 0;
 	struct rdt_resource *r;
 
-	for_each_alloc_enabled_rdt_resource(r) {
+	for_each_alloc_capable_rdt_resource(r) {
 		if (r->cdp_enabled) {
 			ret = add_schema(CDP_CODE, r);
 			ret |= add_schema(CDP_DATA, r);
@@ -1586,7 +1586,7 @@ static void rdt_kill_sb(struct super_block *sb)
 	set_mba_sc(false);
 
 	/*Put everything back to default values. */
-	for_each_alloc_enabled_rdt_resource(r)
+	for_each_capable_rdt_resource(r)
 		reset_all_ctrls(r);
 	cdp_disable_all();
 	rmdir_all_sub();
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8b06ed8e7407..7a955ce93988 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -86,7 +86,6 @@ struct resctrl_membw {
 };
 
 /**
- * @alloc_enabled:	Is allocation enabled on this machine
  * @mon_enabled:	Is monitoring enabled for this feature
  * @cdp_enabled		Is CDP enabled for this resource
  * @alloc_capable:	Is allocation available on this machine
@@ -113,7 +112,6 @@ struct resctrl_membw {
  * @fflags:		flags to choose base and info files
  */
 struct rdt_resource {
-	bool				alloc_enabled;
 	bool				mon_enabled;
 	bool				cdp_enabled;
 	bool				alloc_capable;
-- 
2.18.0


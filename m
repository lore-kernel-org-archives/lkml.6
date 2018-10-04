Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89897C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7622084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7622084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbeJEEBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:01:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:24682 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725760AbeJEEBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:01:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 14:06:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="85819520"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Oct 2018 14:06:14 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/intel_rdt: Fix out-of-bounds memory access in CBM tests
Date:   Thu,  4 Oct 2018 14:05:23 -0700
Message-Id: <69a428613a53f10e80594679ac726246020ff94f.1538686926.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the DOC at the beginning of lib/bitmap.c explicitly states that
"The number of valid bits in a given bitmap does _not_ need to be an
exact multiple of BITS_PER_LONG." some of the bitmap operations do
indeed access BITS_PER_LONG portions of the provided bitmap no matter
the size of the provided bitmap. For example, if bitmap_intersects()
is provided with an 8 bit bitmap the operation will access
BITS_PER_LONG bits from the provided bitmap. While the operation
ensures that these extra bits do not affect the result the memory
is still accessed.

The capacity bitmasks (CBMs) are typically stored in u32 since they
can never exceed 32 bits. A few instances exist where a bitmap_*
operation is performed on a CBM by simply pointing the bitmap operation
to the stored u32 value.

The consequency of this pattern is that some bitmap_* operations will
access out-of-bounds memory when interacting with the provided CBM. This
is confirmed with a KASAN test that reports:

 BUG: KASAN: stack-out-of-bounds in __bitmap_intersects+0xa2/0x100

and

 BUG: KASAN: stack-out-of-bounds in __bitmap_weight+0x58/0x90

Fix this by moving any CBM provided to a bitmap operation needing
BITS_PER_LONG to an unsigned long variable.

Fixes: 72d505056604 ("x86/intel_rdt: Add utilities to test pseudo-locked region possibility")
Fixes: 49f7b4efa110 ("x86/intel_rdt: Enable setting of exclusive mode")
Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups' allocations' size in bytes")
Fixes: 95f0b77efa57 ("x86/intel_rdt: Initialize new resource group with sane defaults")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  2 +-
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 12 ++++---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 38 ++++++++++++++-------
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 285eb3ec4200..0cb986c3e382 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -531,7 +531,7 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
 bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 			   u32 _cbm, int closid, bool exclusive);
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r, struct rdt_domain *d,
-				  u32 cbm);
+				  u32 _cbm);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 30e6c9f5a0ad..9b99d151fe50 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -800,14 +800,18 @@ int rdtgroup_locksetup_exit(struct rdtgroup *rdtgrp)
  */
 bool rdtgroup_cbm_overlaps_pseudo_locked(struct rdt_domain *d, u32 _cbm)
 {
-	unsigned long *cbm = (unsigned long *)&_cbm;
-	unsigned long *cbm_b;
+	/*
+	 * Place CBMs in unsigned long to ensure bitmap_intersects() does
+	 * not access out-of-bounds memory.
+	 */
+	unsigned long cbm = _cbm;
+	unsigned long cbm_b;
 	unsigned int cbm_len;
 
 	if (d->plr) {
 		cbm_len = d->plr->r->cache.cbm_len;
-		cbm_b = (unsigned long *)&d->plr->cbm;
-		if (bitmap_intersects(cbm, cbm_b, cbm_len))
+		cbm_b = d->plr->cbm;
+		if (bitmap_intersects(&cbm, &cbm_b, cbm_len))
 			return true;
 	}
 	return false;
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 0bbdcf30ce29..c44d577bd5a6 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1052,28 +1052,31 @@ static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r,
 				    struct rdt_domain *d, u32 _cbm,
 				    int closid, bool exclusive)
 {
-	unsigned long *cbm = (unsigned long *)&_cbm;
-	unsigned long *ctrl_b;
+	/*
+	 * Place CBMs in unsigned long to ensure bitmap_intersects() does
+	 * not access out-of-bounds memory.
+	 */
+	unsigned long cbm = _cbm;
 	enum rdtgrp_mode mode;
+	unsigned long ctrl_b;
 	u32 *ctrl;
 	int i;
 
 	/* Check for any overlap with regions used by hardware directly */
 	if (!exclusive) {
-		if (bitmap_intersects(cbm,
-				      (unsigned long *)&r->cache.shareable_bits,
-				      r->cache.cbm_len))
+		ctrl_b = r->cache.shareable_bits;
+		if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len))
 			return true;
 	}
 
 	/* Check for overlap with other resource groups */
 	ctrl = d->ctrl_val;
 	for (i = 0; i < closids_supported(); i++, ctrl++) {
-		ctrl_b = (unsigned long *)ctrl;
+		ctrl_b = *ctrl;
 		mode = rdtgroup_mode_by_closid(i);
 		if (closid_allocated(i) && i != closid &&
 		    mode != RDT_MODE_PSEUDO_LOCKSETUP) {
-			if (bitmap_intersects(cbm, ctrl_b, r->cache.cbm_len)) {
+			if (bitmap_intersects(&cbm, &ctrl_b, r->cache.cbm_len)) {
 				if (exclusive) {
 					if (mode == RDT_MODE_EXCLUSIVE)
 						return true;
@@ -1238,7 +1241,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
  * rdtgroup_cbm_to_size - Translate CBM to size in bytes
  * @r: RDT resource to which @d belongs.
  * @d: RDT domain instance.
- * @cbm: bitmask for which the size should be computed.
+ * @_cbm: bitmask for which the size should be computed.
  *
  * The bitmask provided associated with the RDT domain instance @d will be
  * translated into how many bytes it represents. The size in bytes is
@@ -1247,13 +1250,18 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
  * is multiplied with the number of bits set in the bitmask.
  */
 unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
-				  struct rdt_domain *d, u32 cbm)
+				  struct rdt_domain *d, u32 _cbm)
 {
+	/*
+	 * Place CBM in unsigned long to ensure bitmap_weight() does
+	 * not access out-of-bounds memory.
+	 */
+	unsigned long cbm = _cbm;
 	struct cpu_cacheinfo *ci;
 	unsigned int size = 0;
 	int num_b, i;
 
-	num_b = bitmap_weight((unsigned long *)&cbm, r->cache.cbm_len);
+	num_b = bitmap_weight(&cbm, r->cache.cbm_len);
 	ci = get_cpu_cacheinfo(cpumask_any(&d->cpu_mask));
 	for (i = 0; i < ci->num_leaves; i++) {
 		if (ci->info_list[i].level == r->cache_level) {
@@ -2462,6 +2470,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 	u32 used_b = 0, unused_b = 0;
 	u32 closid = rdtgrp->closid;
 	struct rdt_resource *r;
+	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
 	struct rdt_domain *d;
 	u32 peer_ctl;
@@ -2511,8 +2520,13 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			 * modify the CBM based on system availability.
 			 */
 			cbm_ensure_valid(&d->new_ctrl, r);
-			if (bitmap_weight((unsigned long *) &d->new_ctrl,
-					  r->cache.cbm_len) <
+			/*
+			 * Assign the u32 CBM to an unsigned long to ensure
+			 * that bitmap_weight() does not access out-of-bound
+			 * memory.
+			 */
+			tmp_cbm = d->new_ctrl;
+			if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) <
 					r->cache.min_cbm_bits) {
 				rdt_last_cmd_printf("no space on %s:%d\n",
 						    r->name, d->id);
-- 
2.17.0


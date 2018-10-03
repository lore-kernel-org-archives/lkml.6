Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E401C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDC821486
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDC821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbeJDFI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:08:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:62866 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeJDFI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:08:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="91965089"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2018 15:17:42 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     jithu.joseph@intel.com, gavin.hindman@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 3/3] x86/intel_rdt: Fix initial allocation to consider CDP
Date:   Wed,  3 Oct 2018 15:17:03 -0700
Message-Id: <b1f7ec08b1695be067de416a4128466d49684317.1538603665.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1538603665.git.reinette.chatre@intel.com>
References: <cover.1538603665.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1538603665.git.reinette.chatre@intel.com>
References: <cover.1538603665.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new resource group is created it is initialized with a default
allocation that considers which portions of cache are currently
available for sharing across all resource groups or which portions of
cache are currently unused.

If a CDP allocation forms part of a resource group that is in exclusive
mode then it should be ensured that no new allocation overlaps with any
resource that shares the underlying hardware. The current initial
allocation does not take this sharing of hardware into account and
a new allocation in a resource that shares the same
hardware would affect the exclusive resource group.

Fix this by considering the allocation of a peer RDT domain - a RDT
domain sharing the same hardware - as part of the test to determine
which portion of cache is in use and available for use.

Fixes: 95f0b77efa57 ("x86/intel_rdt: Initialize new resource group with sane defaults")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 1a0bf6d1f06a..ce924e5e6406 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2457,11 +2457,14 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
  */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
+	struct rdt_resource *r_cdp = NULL;
+	struct rdt_domain *d_cdp = NULL;
 	u32 used_b = 0, unused_b = 0;
 	u32 closid = rdtgrp->closid;
 	struct rdt_resource *r;
 	enum rdtgrp_mode mode;
 	struct rdt_domain *d;
+	u32 peer_ctl;
 	int i, ret;
 	u32 *ctrl;
 
@@ -2473,6 +2476,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA)
 			continue;
 		list_for_each_entry(d, &r->domains, list) {
+			rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
 			d->have_new_ctrl = false;
 			d->new_ctrl = r->cache.shareable_bits;
 			used_b = r->cache.shareable_bits;
@@ -2482,9 +2486,19 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 					mode = rdtgroup_mode_by_closid(i);
 					if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
 						break;
-					used_b |= *ctrl;
+					/*
+					 * If CDP is active include peer
+					 * domain's usage to ensure there
+					 * is no overlap with an exclusive
+					 * group.
+					 */
+					if (d_cdp)
+						peer_ctl = d_cdp->ctrl_val[i];
+					else
+						peer_ctl = 0;
+					used_b |= *ctrl | peer_ctl;
 					if (mode == RDT_MODE_SHAREABLE)
-						d->new_ctrl |= *ctrl;
+						d->new_ctrl |= *ctrl | peer_ctl;
 				}
 			}
 			if (d->plr && d->plr->cbm > 0)
-- 
2.17.0


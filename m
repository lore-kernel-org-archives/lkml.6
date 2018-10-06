Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00255C71151
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64B521473
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64B521473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJGB5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:57:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeJGB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:57:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w96Ir2Jb3647718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Oct 2018 11:53:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w96Ir2nN3647715;
        Sat, 6 Oct 2018 11:53:02 -0700
Date:   Sat, 6 Oct 2018 11:53:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-42688c0c327ec0d647db6e0fc18fd644e7c50e3d@git.kernel.org>
Cc:     mingo@kernel.org, reinette.chatre@intel.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          fenghua.yu@intel.com, reinette.chatre@intel.com, mingo@kernel.org
In-Reply-To: <b1f7ec08b1695be067de416a4128466d49684317.1538603665.git.reinette.chatre@intel.com>
References: <b1f7ec08b1695be067de416a4128466d49684317.1538603665.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Fix initial allocation to consider
 CDP
Git-Commit-ID: 42688c0c327ec0d647db6e0fc18fd644e7c50e3d
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

Commit-ID:  42688c0c327ec0d647db6e0fc18fd644e7c50e3d
Gitweb:     https://git.kernel.org/tip/42688c0c327ec0d647db6e0fc18fd644e7c50e3d
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 3 Oct 2018 15:17:03 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 6 Oct 2018 20:46:27 +0200

x86/intel_rdt: Fix initial allocation to consider CDP

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: tony.luck@intel.com
Cc: jithu.joseph@intel.com
Cc: gavin.hindman@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/b1f7ec08b1695be067de416a4128466d49684317.1538603665.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 172a1a88e716..5f55f8848da6 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2460,14 +2460,16 @@ static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
  */
 static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 {
+	struct rdt_resource *r_cdp = NULL;
+	struct rdt_domain *d_cdp = NULL;
 	u32 used_b = 0, unused_b = 0;
 	u32 closid = rdtgrp->closid;
 	struct rdt_resource *r;
 	unsigned long tmp_cbm;
 	enum rdtgrp_mode mode;
 	struct rdt_domain *d;
+	u32 peer_ctl, *ctrl;
 	int i, ret;
-	u32 *ctrl;
 
 	for_each_alloc_enabled_rdt_resource(r) {
 		/*
@@ -2477,6 +2479,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 		if (r->rid == RDT_RESOURCE_MBA)
 			continue;
 		list_for_each_entry(d, &r->domains, list) {
+			rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
 			d->have_new_ctrl = false;
 			d->new_ctrl = r->cache.shareable_bits;
 			used_b = r->cache.shareable_bits;
@@ -2486,9 +2489,19 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
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

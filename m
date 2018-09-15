Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D49ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CA5214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CA5214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeIPDWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:16189 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbeIPDWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289170"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2018 15:01:29 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH V2 8/9] x86/intel_rdt: Fix exclusive mode handling of MBA resource
Date:   Sat, 15 Sep 2018 14:58:26 -0700
Message-Id: <1537048707-76280-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

It is possible for a resource group to consist out of MBA as well as
CAT/CDP resources. The "exclusive" resource mode only applies to the
CAT/CDP resources since MBA allocations cannot be specified to overlap
or not. When a user requests a resource group to become "exclusive" then it
can only be successful if there are CAT/CDP resources in the group
and none of their CBMs associated with the group's CLOSID overlaps with
any other resource group.

Fix the "exclusive" mode setting by failing if there isn't any CAT/CDP
resource in the group and ensuring that the CBM checking is only done on
CAT/CDP resources.

Fixes: 49f7b4efa ("x86/intel_rdt: Enable setting of exclusive mode")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index afd93d45e21b..f3231f78d69b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1031,16 +1031,27 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 {
 	int closid = rdtgrp->closid;
 	struct rdt_resource *r;
+	bool has_cache = false;
 	struct rdt_domain *d;
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		if (r->rid == RDT_RESOURCE_MBA)
+			continue;
+		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
 			if (rdtgroup_cbm_overlaps(r, d, d->ctrl_val[closid],
-						  rdtgrp->closid, false))
+						  rdtgrp->closid, false)) {
+				rdt_last_cmd_puts("schemata overlaps\n");
 				return false;
+			}
 		}
 	}
 
+	if (!has_cache) {
+		rdt_last_cmd_puts("cannot be exclusive without CAT/CDP\n");
+		return false;
+	}
+
 	return true;
 }
 
@@ -1092,7 +1103,6 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
 	} else if (!strcmp(buf, "exclusive")) {
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
-			rdt_last_cmd_printf("schemata overlaps\n");
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.19.0


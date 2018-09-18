Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E3ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD5E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD5E21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbeISDV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:21:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeISDV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:21:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILkmRg930529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:46:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILklor930526;
        Tue, 18 Sep 2018 14:46:47 -0700
Date:   Tue, 18 Sep 2018 14:46:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-939b90b20bc87e199b6b53942764b987289b87ce@git.kernel.org>
Cc:     fenghua.yu@intel.com, hpa@zytor.com, mingo@kernel.org,
        tony.luck@intel.com, tglx@linutronix.de, xiaochen.shen@intel.com,
        yu.c.chen@intel.com, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com
Reply-To: tglx@linutronix.de, tony.luck@intel.com,
          linux-kernel@vger.kernel.org, reinette.chatre@intel.com,
          yu.c.chen@intel.com, xiaochen.shen@intel.com,
          fenghua.yu@intel.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1537048707-76280-9-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-9-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix exclusive mode handling of MBA
 resource
Git-Commit-ID: 939b90b20bc87e199b6b53942764b987289b87ce
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

Commit-ID:  939b90b20bc87e199b6b53942764b987289b87ce
Gitweb:     https://git.kernel.org/tip/939b90b20bc87e199b6b53942764b987289b87ce
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:26 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:07 +0200

x86/intel_rdt: Fix exclusive mode handling of MBA resource

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Cc: "Chen Yu" <yu.c.chen@intel.com>
Link: https://lkml.kernel.org/r/1537048707-76280-9-git-send-email-fenghua.yu@intel.com

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

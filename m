Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3276FC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B1F249B2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B1F249B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbeFVWvF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:51:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:22310 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933440AbeFVWmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843400"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 17/41] x86/intel_rdt: Introduce the Cache Pseudo-Locking modes
Date:   Fri, 22 Jun 2018 15:42:08 -0700
Message-Id: <98d6ca129bbe7dd0932d1fcfeb3cbb65f29a8d9d.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two modes used to manage Cache Pseudo-Locked regions are introduced.  A
resource group is assigned "pseudo-locksetup" mode when the user indicates
that this resource group will be used for a Cache Pseudo-Locked
region. When the Cache Pseudo-Locked region has been set up successfully
after the user wrote the requested schemata to the "schemata" file, then
the mode will automatically changed to "pseudo-locked".  The user is not
able to modify the mode to "pseudo-locked" by writing "pseudo-locked" to
the "mode" file directly.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/6ab82fb595f4b0ffa305dc204255b921eed51de7.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h          | 10 ++++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 8bbb047bf37c..bda87f5ef7bc 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -84,15 +84,25 @@ enum rdt_group_type {
  * enum rdtgrp_mode - Mode of a RDT resource group
  * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
  * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
+ * @RDT_MODE_PSEUDO_LOCKSETUP: Resource group will be used for Pseudo-Locking
+ * @RDT_MODE_PSEUDO_LOCKED: No sharing of this resource group's allocations
+ *                          allowed AND the allocations are Cache Pseudo-Locked
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
  * of service). User is able to modify the mode of a resource group by
  * writing to the "mode" resctrl file associated with the resource group.
+ *
+ * The "shareable", "exclusive", and "pseudo-locksetup" modes are set by
+ * writing the appropriate text to the "mode" file. A resource group enters
+ * "pseudo-locked" mode after the schemata is written while the resource
+ * group is in "pseudo-locksetup" mode.
  */
 enum rdtgrp_mode {
 	RDT_MODE_SHAREABLE = 0,
 	RDT_MODE_EXCLUSIVE,
+	RDT_MODE_PSEUDO_LOCKSETUP,
+	RDT_MODE_PSEUDO_LOCKED,
 
 	/* Must be last */
 	RDT_NUM_MODES,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 6519b69e6791..336bc686a962 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -161,8 +161,10 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 }
 
 static const char * const rdt_mode_str[] = {
-	[RDT_MODE_SHAREABLE]	= "shareable",
-	[RDT_MODE_EXCLUSIVE]	= "exclusive",
+	[RDT_MODE_SHAREABLE]		= "shareable",
+	[RDT_MODE_EXCLUSIVE]		= "exclusive",
+	[RDT_MODE_PSEUDO_LOCKSETUP]	= "pseudo-locksetup",
+	[RDT_MODE_PSEUDO_LOCKED]	= "pseudo-locked",
 };
 
 /**
@@ -759,6 +761,13 @@ static int rdt_bit_usage_show(struct kernfs_open_file *of,
 			case RDT_MODE_EXCLUSIVE:
 				exclusive |= *ctrl;
 				break;
+			/*
+			 * Temporarily handle pseudo-locking enums
+			 * to silence compile warnings until handling
+			 * added in later patches.
+			 */
+			case RDT_MODE_PSEUDO_LOCKSETUP:
+			case RDT_MODE_PSEUDO_LOCKED:
 			case RDT_NUM_MODES:
 				WARN(1,
 				     "invalid mode for closid %d\n", i);
-- 
2.17.0


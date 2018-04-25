Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756277AbeDYS2H (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:28:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:41709 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755954AbeDYSMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243644"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 08/39] x86/intel_rdt: Introduce new "exclusive" mode
Date: Wed, 25 Apr 2018 03:09:44 -0700
Message-Id: <a7c9b55991e7be7559f099e4c7fe34e0f93730d0.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment all allocations are shareable. There is no way for a user
to designate that an allocation associated with a resource group cannot be
shared by another.

Introduce the new mode "exclusive". When a resource group is marked as
such it implies that no overlap is allowed between its allocation and that
of another resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          | 2 ++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index cc6e41ad9522..3fb6645de840 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -82,6 +82,7 @@ enum rdt_group_type {
 /**
  * enum rdtgrp_mode - Mode of a RDT resource group
  * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
+ * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -90,6 +91,7 @@ enum rdt_group_type {
  */
 enum rdtgrp_mode {
 	RDT_MODE_SHAREABLE = 0,
+	RDT_MODE_EXCLUSIVE,
 
 	/* Must be last */
 	RDT_NUM_MODES,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index d66283f83ece..9afcb667df3a 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -161,6 +161,7 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 
 static const char * const rdt_mode_str[] = {
 	[RDT_MODE_SHAREABLE]	= "shareable",
+	[RDT_MODE_EXCLUSIVE]	= "exclusive",
 };
 
 /**
-- 
2.13.6

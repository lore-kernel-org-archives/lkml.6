Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeEVTiB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:38:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:16708 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751946AbeEVTcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406358"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 08/38] x86/intel_rdt: Introduce new "exclusive" mode
Date: Tue, 22 May 2018 04:28:56 -0700
Message-Id: <cea76188c5b30cffaf89ad5c7efd66a3e7f105d4.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
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
index 5f3915c2e599..399bb94e865b 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -83,6 +83,7 @@ enum rdt_group_type {
 /**
  * enum rdtgrp_mode - Mode of a RDT resource group
  * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
+ * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -91,6 +92,7 @@ enum rdt_group_type {
  */
 enum rdtgrp_mode {
 	RDT_MODE_SHAREABLE = 0,
+	RDT_MODE_EXCLUSIVE,
 
 	/* Must be last */
 	RDT_NUM_MODES,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b2008c697ce0..739b1ecc2b80 100644
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755989AbeDYSUK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:20:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:41722 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932211AbeDYSMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243716"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 22/39] x86/intel_rdt: Add check to determine if monitoring in progress
Date: Wed, 25 Apr 2018 03:09:58 -0700
Message-Id: <5bb877fd392bd61947c6a6f6d187cf8362eecabe.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource group is pseudo-locked it is orphaned without a class of
service associated with it. We thus do not want any monitoring in
progress on a resource group that will be used for pseudo-locking.

Introduce a test that can be used to determine if pseudo-locking in
progress on a resource group. Temporarily mark it as unused to avoid
compile warnings until it is used.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index a373ca3ff567..6f86625288b3 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -22,6 +22,19 @@
 #include "intel_rdt.h"
 
 /**
+ * rdtgroup_monitor_in_progress - Test if monitoring in progress
+ * @r: resource group being queried
+ *
+ * Return: 1 if monitor groups have been created for this resource
+ * group, 0 otherwise.
+ */
+static int __attribute__ ((unused))
+rdtgroup_monitor_in_progress(struct rdtgroup *rdtgrp)
+{
+	return !list_empty(&rdtgrp->mon.crdtgrp_list);
+}
+
+/**
  * rdtgroup_locksetup_user_restrict - Restrict user access to group
  * @rdtgrp: resource group needing access restricted
  *
-- 
2.13.6

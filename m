Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967221AbeE2VGs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:06:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:46449 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937100AbeE2VA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:00:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,457,1520924400";
   d="scan'208";a="60127733"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 22/38] x86/intel_rdt: Add check to determine if monitoring in progress
Date: Tue, 29 May 2018 05:57:47 -0700
Message-Id: <d3efe6b526e28e335463578870ec7d5dc91ed96d.1527593971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1527593970.git.reinette.chatre@intel.com>
References: <cover.1527593970.git.reinette.chatre@intel.com>
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
index dc79b3090ac5..8693dbe602a2 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -14,6 +14,19 @@
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966280AbeBMXwL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:52:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:53394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966201AbeBMXtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822331"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 11/22] x86/intel_rdt: Associate pseudo-locked regions with its domain
Date: Tue, 13 Feb 2018 07:46:55 -0800
Message-Id: <216ad1ef8314dc578a900ff8b06248464f5aa2ee.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a pseudo-locked region is locked it needs to be associated with
the RDT domain representing the pseudo-locked cache so that its life
cycle can be managed correctly.

Only a single pseudo-locked region can exist on any cache instance so we
maintain a single pointer to a pseudo-locked region from each RDT
domain.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 060a0976ac00..f0e020686e99 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -187,6 +187,8 @@ struct mbm_state {
 	u64	prev_msr;
 };
 
+struct pseudo_lock_region;
+
 /**
  * struct rdt_domain - group of cpus sharing an RDT resource
  * @list:	all instances of this resource
@@ -205,6 +207,7 @@ struct mbm_state {
  * @ctrl_val:	array of cache or mem ctrl values (indexed by CLOSID)
  * @new_ctrl:	new ctrl value to be loaded
  * @have_new_ctrl: did user provide new_ctrl for this domain
+ * @plr:	pseudo-locked region associated with this domain
  */
 struct rdt_domain {
 	struct list_head	list;
@@ -220,6 +223,7 @@ struct rdt_domain {
 	u32			*ctrl_val;
 	u32			new_ctrl;
 	bool			have_new_ctrl;
+	struct pseudo_lock_region	*plr;
 };
 
 /**
-- 
2.13.6

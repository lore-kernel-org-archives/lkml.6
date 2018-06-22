Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAF0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD16F24994
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD16F24994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933942AbeFVWmw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:42:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:52514 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754618AbeFVWms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843349"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH V7 01/41] x86/intel_rdt: Provide pseudo-locking hooks within rdt_mount
Date:   Fri, 22 Jun 2018 15:41:52 -0700
Message-Id: <410697ead08978bd12111c0afc4ce9e7bd71a5fe.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported that the Cache Pseudo-Locking enabling and the
kernfs support for mounting with fs_context are conflicting.

In preparation for a conflict-free merge between the two repos some
no-op hooks are created within the RDT mount function being changed by
the two features. The goal is for this commit to be placed on a minimal
no-rebase branch to be consumed by both features.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: David Howells <dhowells@redhat.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 749856a2e736..7f32bca02b75 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1236,6 +1236,15 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+/*
+ * Define the hooks for Cache Pseudo-Locking to use within rdt_mount().
+ * These are no-ops provided for the new kernfs changes to use as a
+ * baseline in preparation for a conflict-free merge between it
+ * (kernfs changes) and the Cache Pseudo-Locking enabling.
+ */
+#define rdt_pseudo_lock_init() 0
+#define rdt_pseudo_lock_release() do { } while (0)
+
 static struct dentry *rdt_mount(struct file_system_type *fs_type,
 				int flags, const char *unused_dev_name,
 				void *data)
@@ -1289,10 +1298,16 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 		rdtgroup_default.mon.mon_data_kn = kn_mondata;
 	}
 
+	ret = rdt_pseudo_lock_init();
+	if (ret) {
+		dentry = ERR_PTR(ret);
+		goto out_mondata;
+	}
+
 	dentry = kernfs_mount(fs_type, flags, rdt_root,
 			      RDTGROUP_SUPER_MAGIC, NULL);
 	if (IS_ERR(dentry))
-		goto out_mondata;
+		goto out_psl;
 
 	if (rdt_alloc_capable)
 		static_branch_enable_cpuslocked(&rdt_alloc_enable_key);
@@ -1310,6 +1325,8 @@ static struct dentry *rdt_mount(struct file_system_type *fs_type,
 
 	goto out;
 
+out_psl:
+	rdt_pseudo_lock_release();
 out_mondata:
 	if (rdt_mon_capable)
 		kernfs_remove(kn_mondata);
-- 
2.17.0


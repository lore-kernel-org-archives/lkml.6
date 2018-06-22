Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C4EC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A04249BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A04249BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934136AbeFVWve (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:51:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:52517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754634AbeFVWms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843355"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 03/41] x86/intel_rdt: Introduce RDT resource group mode
Date:   Fri, 22 Jun 2018 15:41:54 -0700
Message-Id: <87e88275597fbfa03ea9d41c1186bf012c831c01.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this time there are no constraints on how bitmasks represented by
schemata can be associated with closids represented by resource groups.  A
bitmask of one class of service can without any objections overlap with the
bitmask of another class of service.

The concept of "mode" is introduced in preparation for support of control
over whether cache regions can be shared between classes of service. At
this time the only mode reflects the current cache allocations where all
can potentially be shared.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/ccdbc11e14508ce3800ac4370e788374d3855aee.1527593970.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 39752825e376..c08eee73ecd3 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -80,6 +80,22 @@ enum rdt_group_type {
 	RDT_NUM_GROUP,
 };
 
+/**
+ * enum rdtgrp_mode - Mode of a RDT resource group
+ * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
+ *
+ * The mode of a resource group enables control over the allowed overlap
+ * between allocations associated with different resource groups (classes
+ * of service). User is able to modify the mode of a resource group by
+ * writing to the "mode" resctrl file associated with the resource group.
+ */
+enum rdtgrp_mode {
+	RDT_MODE_SHAREABLE = 0,
+
+	/* Must be last */
+	RDT_NUM_MODES,
+};
+
 /**
  * struct mongroup - store mon group's data in resctrl fs.
  * @mon_data_kn		kernlfs node for the mon_data directory
-- 
2.17.0


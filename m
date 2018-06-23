Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F046C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D3D24BAA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D3D24BAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeFWMIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:08:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeFWMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:08:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NC8DiD463243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:08:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NC8D7u463240;
        Sat, 23 Jun 2018 05:08:13 -0700
Date:   Sat, 23 Jun 2018 05:08:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-eb956a636f90bd0297309a7eae6db388ae5bfc43@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, reinette.chatre@intel.com
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          reinette.chatre@intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <87e88275597fbfa03ea9d41c1186bf012c831c01.1529706536.git.reinette.chatre@intel.com>
References: <87e88275597fbfa03ea9d41c1186bf012c831c01.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce RDT resource group mode
Git-Commit-ID: eb956a636f90bd0297309a7eae6db388ae5bfc43
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

Commit-ID:  eb956a636f90bd0297309a7eae6db388ae5bfc43
Gitweb:     https://git.kernel.org/tip/eb956a636f90bd0297309a7eae6db388ae5bfc43
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:41:54 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:40 +0200

x86/intel_rdt: Introduce RDT resource group mode

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
Link: https://lkml.kernel.org/r/87e88275597fbfa03ea9d41c1186bf012c831c01.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index be152b3b2543..fef254e85da4 100644
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

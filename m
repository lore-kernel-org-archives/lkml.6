Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCF8ECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86238214C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86238214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbeIPDV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:21:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:35528 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIPDV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:21:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289148"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga007.fm.intel.com with ESMTP; 15 Sep 2018 15:01:28 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "Chen Yu" <yu.c.chen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, "Fenghua Yu" <fenghua.yu@intel.com>
Subject: [PATCH V2 3/9] x86/intel_rdt: Global closid helper to support future fixes
Date:   Sat, 15 Sep 2018 14:58:21 -0700
Message-Id: <1537048707-76280-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The number of CLOSIDs supported by a system is the minimum number of
CLOSIDs supported by any of its resources. Care should be taken when
iterating over the CLOSIDs of a resource since it may be that the number
of CLOSIDs supported on the system is less than the number of CLOSIDs
supported by the resource.

Introduce a helper function that can be used to query the number of
CLOSIDs that is supported by all resources, irrespective of how many
CLOSIDs are supported by a particular resource.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          | 1 +
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 78266c798280..285eb3ec4200 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -544,6 +544,7 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
+int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 32e8bbdf2400..b372923eb209 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -97,6 +97,12 @@ void rdt_last_cmd_printf(const char *fmt, ...)
  *   limited as the number of resources grows.
  */
 static int closid_free_map;
+static int closid_free_map_len;
+
+int closids_supported(void)
+{
+	return closid_free_map_len;
+}
 
 static void closid_init(void)
 {
@@ -111,6 +117,7 @@ static void closid_init(void)
 
 	/* CLOSID 0 is always reserved for the default group */
 	closid_free_map &= ~1;
+	closid_free_map_len = rdt_min_closid;
 }
 
 static int closid_alloc(void)
-- 
2.19.0


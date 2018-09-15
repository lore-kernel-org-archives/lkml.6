Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE97ECE564
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8CA20671
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 22:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8CA20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeIPDW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 23:22:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:34545 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIPDWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 23:22:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Sep 2018 15:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,379,1531810800"; 
   d="scan'208";a="70289145"
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
Subject: [PATCH V2 2/9] x86/intel_rdt: Fix size reporting of MBA resource
Date:   Sat, 15 Sep 2018 14:58:20 -0700
Message-Id: <1537048707-76280-3-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
References: <1537048707-76280-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

Chen Yu reported a divide-by-zero error when accessing the 'size'
resctrl file when a MBA resource is enabled.

divide error: 0000 [#1] SMP PTI
CPU: 93 PID: 1929 Comm: cat Not tainted 4.19.0-rc2-debug-rdt+ #25
RIP: 0010:rdtgroup_cbm_to_size+0x7e/0xa0
Call Trace:
rdtgroup_size_show+0x11a/0x1d0
seq_read+0xd8/0x3b0

Quoting Chen Yu's report: This is because for MB resource,
the r->cache.cbm_len is zero, thus calculating size in
rdtgroup_cbm_to_size() will trigger the exception.

Fix this issue in the 'size' file by getting correct memory bandwidth
value which is in MBps when MBA software controller is enabled or in
percentage when MBA software controller is disabled.

Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups' allocations in bytes")
Link: https://lkml.kernel.org/r/20180904174614.26682-1-yu.c.chen@intel.com
Reported-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b799c00bef09..32e8bbdf2400 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1155,8 +1155,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	unsigned int size;
-	bool sep = false;
-	u32 cbm;
+	bool sep;
+	u32 ctrl;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -1174,6 +1174,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
 			if (sep)
@@ -1181,8 +1182,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				cbm = d->ctrl_val[rdtgrp->closid];
-				size = rdtgroup_cbm_to_size(r, d, cbm);
+				ctrl = (!is_mba_sc(r) ?
+						d->ctrl_val[rdtgrp->closid] :
+						d->mbps_val[rdtgrp->closid]);
+				if (r->rid == RDT_RESOURCE_MBA)
+					size = ctrl;
+				else
+					size = rdtgroup_cbm_to_size(r, d, ctrl);
 			}
 			seq_printf(s, "%d=%u", d->id, size);
 			sep = true;
-- 
2.19.0


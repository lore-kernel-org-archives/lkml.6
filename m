Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3C2C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC26620855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC26620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeLJWb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:31:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:62328 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJWb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:31:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 14:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="302698924"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005.fm.intel.com with ESMTP; 10 Dec 2018 14:31:58 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2] x86/resctrl: Fix rdt_find_domain() return value and checks
Date:   Mon, 10 Dec 2018 14:31:13 -0800
Message-Id: <b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_find_domain() returns an ERR_PTR() that is generated from a provided
domain id when the value is negative.

Care needs to be taken when creating an ERR_PTR() from this value because
a subsequent check using IS_ERR() expects the error to be within the
MAX_ERRNO range. By using an invalid domain id as an ERR_PTR() does
work at this time since this is currently always -1. Using this
undocumented assumption is fragile since future users of
rdt_find_domain() may not be aware of thus assumption.

Two related issues are addressed:
- Ensure that rdt_find_domain() always returns a valid error value by
forcing the error to be -ENODEV when a negative domain id is provided.
- In a few instances the return value of rdt_find_domain() is just checked
for NULL - fix these to include a check of ERR_PTR.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Fixes: 521348b011d6 ("x86/intel_rdt: Introduce utility to obtain CDP peer")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
V2:
- Force error value to be -ENODEV when negative domain id provided
- Rewrite commit message to describe why error value needs to be forced in
  addition to the original fix

 arch/x86/kernel/cpu/resctrl/core.c        | 2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2ec252be4ed9..c3a9dc63edf2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -454,7 +454,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	struct list_head *l;
 
 	if (id < 0)
-		return ERR_PTR(id);
+		return ERR_PTR(-ENODEV);
 
 	list_for_each(l, &r->domains) {
 		d = list_entry(l, struct rdt_domain, list);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index ba11f54f5ab8..3b943ace786c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -534,7 +534,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid];
 	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 017505017bdb..8388adf241b2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1029,7 +1029,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	 * peer RDT CDP resource. Hence the WARN.
 	 */
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
-	if (WARN_ON(!_d_cdp)) {
+	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
 		ret = -EINVAL;
 	}
-- 
2.17.0


Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78011C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A17B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A17B206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeK2FXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:23:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:21138 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeK2FXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:23:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 10:21:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="113175070"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga001.jf.intel.com with ESMTP; 28 Nov 2018 10:21:15 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/resctrl: Fix rdt_find_domain() return value checks
Date:   Wed, 28 Nov 2018 10:20:27 -0800
Message-Id: <d932648504b745cb51c4a440710c7a1ca9830eca.1543427858.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_find_domain() may return an ERR_PTR(), NULL, or a pointer to struct
rdt_domain. It is thus required that the return value be checked for the
possibility of an ERR_PTR as well as NULL.

In a few instances the return value of rdt_find_domain() is just checked
for NULL - fix these to include a check of ERR_PTR.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Fixes: 521348b011d6 ("x86/intel_rdt: Introduce utility to obtain CDP peer")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Dear Maintainers,

Two original commits are fixed here. d89b7379015f can be found in v4.14 and
521348b011d6 starting in v4.20. I am unsure whether this is appropriate for
stable since it is not fixing an issue reported by users. This issue was
discovered during code inspection.

Thank you

Reinette


 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 6f7adb3be01e..3b5de7d54307 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -538,7 +538,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid];
 	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1c7827d142e7..715c6697b07d 100644
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


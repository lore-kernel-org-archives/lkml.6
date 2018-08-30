Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB805C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED262082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED262082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbeH3Pw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:52:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:62177 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbeH3Pw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 04:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,306,1531810800"; 
   d="scan'208";a="79567489"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2018 04:50:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4240A173; Thu, 30 Aug 2018 14:50:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] x86/intel_rdt: Switch to bitmap_zalloc()
Date:   Thu, 30 Aug 2018 14:50:39 +0300
Message-Id: <20180830115039.63430-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to bitmap_zalloc() to show clearly what we are allocating.
Besides that it returns pointer of bitmap type instead of opaque void *.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index abb71ac70443..1214f3f7ec6d 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -485,9 +485,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 	size_t tsize;
 
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc = kcalloc(BITS_TO_LONGS(r->num_rmid),
-					   sizeof(unsigned long),
-					   GFP_KERNEL);
+		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
@@ -496,7 +494,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 		tsize = sizeof(*d->mbm_total);
 		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
-			kfree(d->rmid_busy_llc);
+			bitmap_free(d->rmid_busy_llc);
 			return -ENOMEM;
 		}
 	}
@@ -504,7 +502,7 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
 		tsize = sizeof(*d->mbm_local);
 		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
-			kfree(d->rmid_busy_llc);
+			bitmap_free(d->rmid_busy_llc);
 			kfree(d->mbm_total);
 			return -ENOMEM;
 		}
@@ -612,7 +610,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 
 		kfree(d->ctrl_val);
 		kfree(d->mbps_val);
-		kfree(d->rmid_busy_llc);
+		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
 		kfree(d);
-- 
2.18.0


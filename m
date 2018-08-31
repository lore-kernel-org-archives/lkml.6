Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C385FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8740020837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8740020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbeHaMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:42:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:62955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727568AbeHaMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:42:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 01:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="69307281"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 31 Aug 2018 01:34:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A11A5173; Fri, 31 Aug 2018 11:34:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] platform/x86: intel_pmc_core: Get rid of custom ICPU() macro
Date:   Fri, 31 Aug 2018 11:34:32 +0300
Message-Id: <20180831083432.15872-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831083432.15872-1-andriy.shevchenko@linux.intel.com>
References: <20180831083432.15872-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace custom grown macro with generic INTEL_CPU_FAM6() one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 2d272a3e0176..ab904f238a3d 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -33,9 +33,6 @@
 
 #include "intel_pmc_core.h"
 
-#define ICPU(model, data) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (kernel_ulong_t)data }
-
 static struct pmc_dev pmc;
 
 static const struct pmc_bit_map spt_pll_map[] = {
@@ -648,11 +645,11 @@ static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 #endif /* CONFIG_DEBUG_FS */
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	ICPU(INTEL_FAM6_SKYLAKE_MOBILE, &spt_reg_map),
-	ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, &spt_reg_map),
-	ICPU(INTEL_FAM6_KABYLAKE_MOBILE, &spt_reg_map),
-	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, &spt_reg_map),
-	ICPU(INTEL_FAM6_CANNONLAKE_MOBILE, &cnp_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE_MOBILE,		spt_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE_DESKTOP,		spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	spt_reg_map),
+	INTEL_CPU_FAM6(CANNONLAKE_MOBILE,	cnp_reg_map),
 	{}
 };
 
-- 
2.18.0


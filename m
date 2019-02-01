Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C35C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DF720870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfBAHcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:32:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:57767 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbfBAHco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:32:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 23:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="114430719"
Received: from rajneesh-desk.iind.intel.com ([10.223.86.34])
  by orsmga008.jf.intel.com with ESMTP; 31 Jan 2019 23:32:41 -0800
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     dvhart@infradead.org, andy@infradead.org,
        linux-kernel@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E. Box" <david.e.box@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 05/10] platform/x86: intel_pmc_core: Include Reserved IP for LTR
Date:   Fri,  1 Feb 2019 13:02:29 +0530
Message-Id: <20190201073234.13280-6-rajneesh.bhardwaj@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
References: <20190201073234.13280-1-rajneesh.bhardwaj@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced commit "platform/x86: intel_pmc_core: Show Latency
Tolerance info <51337cd94d18184601ac0fb4cf1a02b8bbabc3d7> skipped the
LTR from a reserved IP. Though this doesn't cause any functional issue
but it is needed for the consumers of "ltr_ignore" as the index printing
for "ltr_show" is missing. For example, w/o this change, a user that wants
to ignore LTR from ME would do something like

echo 5 > ltr_ignore

but the index for ME is 6. Printing a reserved IP helps to properly
calculate LTR ignore offsets.

Cc: "David E. Box" <david.e.box@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_core.c | 2 ++
 drivers/platform/x86/intel_pmc_core.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 125461ca2927..835ed6d333bf 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -108,6 +108,7 @@ static const struct pmc_bit_map spt_ltr_show_map[] = {
 	{"SATA",		SPT_PMC_LTR_SATA},
 	{"GIGABIT_ETHERNET",	SPT_PMC_LTR_GBE},
 	{"XHCI",		SPT_PMC_LTR_XHCI},
+	{"Reserved",		SPT_PMC_LTR_RESERVED},
 	{"ME",			SPT_PMC_LTR_ME},
 	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
 	{"EVA",			SPT_PMC_LTR_EVA},
@@ -276,6 +277,7 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
 	{"SATA",		CNP_PMC_LTR_SATA},
 	{"GIGABIT_ETHERNET",	CNP_PMC_LTR_GBE},
 	{"XHCI",		CNP_PMC_LTR_XHCI},
+	{"Reserved",		CNP_PMC_LTR_RESERVED},
 	{"ME",			CNP_PMC_LTR_ME},
 	/* EVA is Enterprise Value Add, doesn't really exist on PCH */
 	{"EVA",			CNP_PMC_LTR_EVA},
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 1a0104d2cbf0..0680ca397b57 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -46,6 +46,7 @@
 #define SPT_PMC_LTR_SATA			0x368
 #define SPT_PMC_LTR_GBE				0x36C
 #define SPT_PMC_LTR_XHCI			0x370
+#define SPT_PMC_LTR_RESERVED			0x374
 #define SPT_PMC_LTR_ME				0x378
 #define SPT_PMC_LTR_EVA				0x37C
 #define SPT_PMC_LTR_SPC				0x380
@@ -156,6 +157,7 @@ enum ppfear_regs {
 #define CNP_PMC_LTR_SATA			0x1B68
 #define CNP_PMC_LTR_GBE				0x1B6C
 #define CNP_PMC_LTR_XHCI			0x1B70
+#define CNP_PMC_LTR_RESERVED			0x1B74
 #define CNP_PMC_LTR_ME				0x1B78
 #define CNP_PMC_LTR_EVA				0x1B7C
 #define CNP_PMC_LTR_SPC				0x1B80
-- 
2.17.1


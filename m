Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DB6C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0604C27DBA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0604C27DBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937079AbeF2TbO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:31:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:39921 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936977AbeF2TbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:31:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 12:31:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,287,1526367600"; 
   d="scan'208";a="61190898"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2018 12:31:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A6F15C5; Fri, 29 Jun 2018 22:31:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/6] x86/cpu: Introduce INTEL_CPU_FAM*() helper macros
Date:   Fri, 29 Jun 2018 22:31:08 +0300
Message-Id: <20180629193113.84425-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are often used by drivers and we have already a lot of
duplication as ICPU() macro across the drivers.

Provide a generic x86 macro for users.

Note, as Ingo Molnar pointed out this has a hidden issue when a driver
needs to preserve const qualifier. Though, it would be addressed
separately at some point.

[1]: https://lkml.org/lkml/2017/12/28/85

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cf090e584202..7ed08a7c3398 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -76,4 +76,17 @@
 #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */
 #define INTEL_FAM6_XEON_PHI_KNM		0x85 /* Knights Mill */
 
+/* Useful macros */
+#define INTEL_CPU_FAM_ANY(_family, _model, _driver_data)	\
+{								\
+	.vendor		= X86_VENDOR_INTEL,			\
+	.family		= _family,				\
+	.model		= _model,				\
+	.feature	= X86_FEATURE_ANY,			\
+	.driver_data	= (kernel_ulong_t)&_driver_data		\
+}
+
+#define INTEL_CPU_FAM6(_model, _driver_data)			\
+	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
-- 
2.18.0


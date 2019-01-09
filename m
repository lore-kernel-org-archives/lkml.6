Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAECC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885DA206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfAIQ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:57:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:38177 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfAIQ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:57:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 08:57:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,458,1539673200"; 
   d="scan'208";a="308977593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2019 08:57:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F4BB3B3; Wed,  9 Jan 2019 18:57:55 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
Date:   Wed,  9 Jan 2019 18:57:52 +0200
Message-Id: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are often used by the drivers and we have already a lot of
duplication as ICPU() macro across them.

Provide a generic x86 macro for users.

This adds no driver data variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 25b28760fada..afd70055a750 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -86,10 +86,16 @@
 	.family		= _family,				\
 	.model		= _model,				\
 	.feature	= X86_FEATURE_ANY,			\
-	.driver_data	= (kernel_ulong_t)&_driver_data		\
+	.driver_data	= (kernel_ulong_t)_driver_data		\
 }
 
 #define INTEL_CPU_FAM6(_model, _driver_data)			\
-	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, _driver_data)
+	INTEL_CPU_FAM_ANY(6, INTEL_FAM6_##_model, &_driver_data)
+
+#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)		\
+	INTEL_CPU_FAM_ANY(_family, _model, 0)
+
+#define INTEL_CPU_FAM6_NODATA(_model)				\
+	INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)
 
 #endif /* _ASM_X86_INTEL_FAMILY_H */
-- 
2.20.1


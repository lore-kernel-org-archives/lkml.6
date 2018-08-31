Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D020EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87A902083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A902083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeHaNTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:19:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:7735 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727292AbeHaNTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:19:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 02:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="253428341"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 Aug 2018 02:10:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E135A173; Fri, 31 Aug 2018 12:10:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
Date:   Fri, 31 Aug 2018 12:10:15 +0300
Message-Id: <20180831091018.17543-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are often used by drivers and we have already a lot of
duplication as ICPU() macro across the drivers.

Provide a generic x86 macro for users.

This adds no driver data variants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 7ed08a7c3398..093014aceb65 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -83,10 +83,16 @@
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
+	INTEL_CPU_FAM_ANY(_family, _model, NULL)
+
+#define INTEL_CPU_FAM6_NODATA(_model)				\
+	INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)
 
 #endif /* _ASM_X86_INTEL_FAMILY_H */
-- 
2.18.0


Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BF721848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfBSHwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:52:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:14034 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfBSHwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:52:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:52:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="134591000"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2019 23:52:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 5AD31E3; Tue, 19 Feb 2019 09:52:37 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Pitam Mitra <pitamm@gmail.com>,
        Bockjoo Kim <bockjoo@phys.ufl.edu>
Subject: [PATCH] x86/boot/compressed/64: Do not read legacy ROM on EFI system
Date:   Tue, 19 Feb 2019 10:52:24 +0300
Message-Id: <20190219075224.35058-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EFI systems may not provide legacy ROM. The memory may not be mapped
at all.

Trying to dereference values in legacy ROM leads to crash on Macbook
Pro.

Only look for values in the legacy ROM for non-EFI system.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202351
Fixes: 3548e131ec6a ("x86/boot/compressed/64: Find a place for 32-bit trampoline")
Reported-by: Pitam Mitra <pitamm@gmail.com>
Tested-by: Bockjoo Kim <bockjoo@phys.ufl.edu>
---
 arch/x86/boot/compressed/pgtable_64.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 9e2157371491..f8debf7aeb4c 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,7 @@
+#include <linux/efi.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
+#include <asm/efi.h>
 #include "pgtable.h"
 #include "../string.h"
 
@@ -37,9 +39,10 @@ int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
 {
-	unsigned long bios_start, ebda_start;
+	unsigned long bios_start = 0, ebda_start = 0;
 	unsigned long trampoline_start;
 	struct boot_e820_entry *entry;
+	char *signature;
 	int i;
 
 	/*
@@ -47,8 +50,18 @@ static unsigned long find_trampoline_placement(void)
 	 * This code is based on reserve_bios_regions().
 	 */
 
-	ebda_start = *(unsigned short *)0x40e << 4;
-	bios_start = *(unsigned short *)0x413 << 10;
+	/*
+	 * EFI systems may not provide legacy ROM. The memory may not be mapped
+	 * at all.
+	 *
+	 * Only look for values in the legacy ROM for non-EFI system.
+	 */
+	signature = (char *)&boot_params->efi_info.efi_loader_signature;
+	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
+	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
+		ebda_start = *(unsigned short *)0x40e << 4;
+		bios_start = *(unsigned short *)0x413 << 10;
+	}
 
 	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
 		bios_start = BIOS_START_MAX;
-- 
2.20.1


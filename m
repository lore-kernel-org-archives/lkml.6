Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D21ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866821479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4866821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389401AbeIUMIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:08:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:15253 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUMIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:08:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74798931"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:20:54 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 06/12][v4] x86, hibernate: Rename temp_level4_pgt to temp_pgt
Date:   Fri, 21 Sep 2018 14:27:40 +0800
Message-Id: <490c2c562f8e6ed1864d9daf3fcf21ab8ca92538.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

As 32bit system is not using 4-level page, rename it
to temp_pgt so that it can be reused for both 32bit
and 64bit hibernation.

No functional change.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/asm/suspend.h    | 2 +-
 arch/x86/power/hibernate.c        | 2 +-
 arch/x86/power/hibernate_64.c     | 2 +-
 arch/x86/power/hibernate_asm_64.S | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
index 40b02558749f..a892494ca5e4 100644
--- a/arch/x86/include/asm/suspend.h
+++ b/arch/x86/include/asm/suspend.h
@@ -7,7 +7,7 @@
 extern unsigned long restore_jump_address __visible;
 extern unsigned long jump_address_phys;
 extern unsigned long restore_cr3 __visible;
-extern unsigned long temp_level4_pgt __visible;
+extern unsigned long temp_pgt __visible;
 extern unsigned long relocated_restore_code __visible;
 extern int relocate_restore_code(void);
 /* Defined in hibernate_asm_32/64.S */
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a04ca13bf592..e3409e4a9b6a 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -36,7 +36,7 @@ unsigned long jump_address_phys;
  * in the image header).
  */
 unsigned long restore_cr3 __visible;
-unsigned long temp_level4_pgt __visible;
+unsigned long temp_pgt __visible;
 unsigned long relocated_restore_code __visible;
 
 /**
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 8bc2eb0dc464..239f424ccb29 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -121,7 +121,7 @@ static int set_up_temporary_mappings(void)
 			return result;
 	}
 
-	temp_level4_pgt = __pa(pgd);
+	temp_pgt = __pa(pgd);
 	return 0;
 }
 
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index fd369a6e9ff8..3008baa2fa95 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -59,7 +59,7 @@ ENTRY(restore_image)
 	movq	restore_cr3(%rip), %r9
 
 	/* prepare to switch to temporary page tables */
-	movq	temp_level4_pgt(%rip), %rax
+	movq	temp_pgt(%rip), %rax
 	movq	mmu_cr4_features(%rip), %rbx
 
 	/* prepare to copy image data to their original locations */
-- 
2.17.1


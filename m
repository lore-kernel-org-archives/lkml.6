Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C944ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD71D20867
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD71D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389375AbeIUMII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:08:08 -0400
Received: from mga12.intel.com ([192.55.52.136]:5596 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUMIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:08:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 23:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,283,1534834800"; 
   d="scan'208";a="74798909"
Received: from chenyu-desktop.sh.intel.com ([10.239.160.116])
  by orsmga007.jf.intel.com with ESMTP; 20 Sep 2018 23:20:43 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        x86@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 05/12][v4] x86-32, hibernate: Enable CONFIG_ARCH_HIBERNATION_HEADER on 32bit system
Date:   Fri, 21 Sep 2018 14:27:29 +0800
Message-Id: <93afbc94001d7aa85d2cabdf2f80ce72ca80168d.1537448058.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Enable CONFIG_ARCH_HIBERNATION_HEADER for 32bit system so that

1. arch_hibernation_header_save/restore() are invoked across
   hibernation on 32bit system.
2. The checksum handling as well as 'magic' number checking
   for 32bit system are enabled.

Controlled by CONFIG_X86_64 in hibernate.c

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/power/hibernate.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..e8de5de1057f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
 	def_bool y
-	depends on X86_64 && HIBERNATION
+	depends on HIBERNATION
 
 source "kernel/power/Kconfig"
 
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index f63793b8de3f..a04ca13bf592 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -53,7 +53,6 @@ int pfn_is_nosave(unsigned long pfn)
 	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
 }
 
-#ifdef CONFIG_X86_64
 
 #define MD5_DIGEST_SIZE 16
 
@@ -140,7 +139,11 @@ static bool hibernation_e820_mismatch(void *buf)
 }
 #endif
 
+#ifdef CONFIG_X86_64
 #define RESTORE_MAGIC	0x23456789ABCDEF01UL
+#else
+#define RESTORE_MAGIC	0x12345678UL
+#endif
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
@@ -154,6 +157,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
 	rdr->magic = RESTORE_MAGIC;
+#ifdef CONFIG_X86_64
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
 
@@ -175,6 +179,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	 * have any of the PCID bits set.
 	 */
 	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
+#endif
 
 	return hibernation_e820_save(rdr->e820_digest);
 }
@@ -193,9 +198,11 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_X86_64
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
+#endif
 
 	if (hibernation_e820_mismatch(rdr->e820_digest)) {
 		pr_crit("Hibernate inconsistent memory map detected!\n");
@@ -205,6 +212,7 @@ int arch_hibernation_header_restore(void *addr)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
 int relocate_restore_code(void)
 {
 	pgd_t *pgd;
-- 
2.17.1


Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B2FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E292077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E292077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeIEClj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:41:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:33782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbeIEClS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:41:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 15:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="70343602"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2018 15:14:11 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V3 2/5] efi: Introduce __efi_init attribute
Date:   Tue,  4 Sep 2018 15:12:26 -0700
Message-Id: <1536099149-12564-3-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Buggy firmware could illegally access some efi regions even after the
kernel has assumed control of the platform. When
"CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS" is enabled, the efi page fault
handler will detect and recover from these illegal accesses.
efi_md_typeattr_format() and memory_type_name are used by the efi page
fault handler to print information about memory descriptor that was
illegally accessed. As the page fault handler is present during/after
kernel boot it doesn't have an __init attribute, but
efi_md_typeattr_format() has it and thus during kernel build, "WARNING:
modpost: Found * section mismatch(es)" build warning is observed. To fix
it, remove __init attribute for efi_md_typeattr_format().

In order to not keep efi_md_typeattr_format() and memory_type_name
needlessly when "CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS" is not selected, add
a new __efi_init attribute whose value changes based on whether the
config option is selected or not.

Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Al Stone <astone@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi.c |  4 ++--
 include/linux/efi.h        | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d8a33a781a57..16571429b19c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -768,7 +768,7 @@ int __init efi_get_fdt_params(struct efi_fdt_params *params)
 }
 #endif /* CONFIG_EFI_PARAMS_FROM_FDT */
 
-static __initdata char memory_type_name[][20] = {
+static __efi_initdata char memory_type_name[][20] = {
 	"Reserved",
 	"Loader Code",
 	"Loader Data",
@@ -786,7 +786,7 @@ static __initdata char memory_type_name[][20] = {
 	"Persistent Memory",
 };
 
-char * __init efi_md_typeattr_format(char *buf, size_t size,
+char * __efi_init efi_md_typeattr_format(char *buf, size_t size,
 				     const efi_memory_desc_t *md)
 {
 	char *pos;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 855992b15269..6a07e3166fd1 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1107,10 +1107,22 @@ extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 	for_each_efi_memory_desc_in_map(&efi.memmap, md)
 
 /*
+ * __efi_init - if CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is enabled, remove __init
+ *		modifier.
+ */
+#ifdef CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS
+#define __efi_init
+#define __efi_initdata
+#else
+#define __efi_init __init
+#define __efi_initdata __initdata
+#endif
+
+/*
  * Format an EFI memory descriptor's type and attributes to a user-provided
  * character buffer, as per snprintf(), and return the buffer.
  */
-char * __init efi_md_typeattr_format(char *buf, size_t size,
+char * __efi_init efi_md_typeattr_format(char *buf, size_t size,
 				     const efi_memory_desc_t *md);
 
 /**
-- 
2.7.4


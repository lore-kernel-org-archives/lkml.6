Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59855ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DEB21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16DEB21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbeIUNUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389398AbeIUNUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 874CB3082A2C;
        Fri, 21 Sep 2018 07:32:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4493589AF5;
        Fri, 21 Sep 2018 07:32:42 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com
Subject: [PATCH 2/3 v3] x86/kexec_file: add e820 entry in case e820 type string matches to io resource name
Date:   Fri, 21 Sep 2018 15:32:10 +0800
Message-Id: <20180921073211.20097-3-lijiang@redhat.com>
In-Reply-To: <20180921073211.20097-1-lijiang@redhat.com>
References: <20180921073211.20097-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 21 Sep 2018 07:32:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
desc to e820 table for kdump kernel.

But IORES_DESC_NONE resource type includes several different e820 types,
we need add exact e820 type to kdump kernel e820 table, thus it also needs
an extra checking in memmap_entry_callback() to match the e820 type and
resource name.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/include/asm/e820/api.h | 2 ++
 arch/x86/kernel/crash.c         | 6 +++++-
 arch/x86/kernel/e820.c          | 2 +-
 kernel/resource.c               | 1 +
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 62be73b23d5c..6d5451b36e80 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -42,6 +42,8 @@ extern void e820__register_nosave_regions(unsigned long limit_pfn);
 
 extern int  e820__get_entry_type(u64 start, u64 end);
 
+extern const char *e820_type_to_string(struct e820_entry *entry);
+
 /*
  * Returns true iff the specified range [start,end) is completely contained inside
  * the ISA region.
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f631a3f15587..ae724a6e0a5f 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -37,6 +37,7 @@
 #include <asm/reboot.h>
 #include <asm/virtext.h>
 #include <asm/intel_pt.h>
+#include <asm/e820/api.h>
 
 /* Used while preparing memory map entries for second kernel */
 struct crash_memmap_data {
@@ -314,11 +315,14 @@ static int memmap_entry_callback(struct resource *res, void *arg)
 	struct crash_memmap_data *cmd = arg;
 	struct boot_params *params = cmd->params;
 	struct e820_entry ei;
+	const char *name;
 
 	ei.addr = res->start;
 	ei.size = resource_size(res);
 	ei.type = cmd->type;
-	add_e820_entry(params, &ei);
+	name = e820_type_to_string(&ei);
+	if (res->name && !strcmp(name, res->name))
+		add_e820_entry(params, &ei);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index c88c23c658c1..f9761b2f7abb 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1012,7 +1012,7 @@ void __init e820__finish_early_params(void)
 	}
 }
 
-static const char *__init e820_type_to_string(struct e820_entry *entry)
+const char *e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
diff --git a/kernel/resource.c b/kernel/resource.c
index f5d9fc70a04c..cc90633f35f9 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -366,6 +366,7 @@ static int find_next_iomem_res(struct resource *res, unsigned long desc,
 		res->end = p->end;
 	res->flags = p->flags;
 	res->desc = p->desc;
+	res->name = p->name;
 	return 0;
 }
 
-- 
2.17.1


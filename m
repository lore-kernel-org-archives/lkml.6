Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE512245E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 07:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE512245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbeKNRbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 12:31:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52210 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbeKNRbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 12:31:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 260E430B9E00;
        Wed, 14 Nov 2018 07:29:49 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DA5A105B200;
        Wed, 14 Nov 2018 07:29:41 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, akpm@linux-foundation.org,
        dyoung@redhat.com, bhe@redhat.com
Subject: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type string matches to io resource name
Date:   Wed, 14 Nov 2018 15:29:25 +0800
Message-Id: <20181114072926.13312-2-lijiang@redhat.com>
In-Reply-To: <20181114072926.13312-1-lijiang@redhat.com>
References: <20181114072926.13312-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 14 Nov 2018 07:29:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When load the kernel image and initramfs by kexec_file_load syscall, it can
not add exact e820 reserved type to kdump kernel e820 table.

Kdump uses walk_iomem_res_desc() to iterate io resources, then adds matched
desc to e820 table for kdump kernel. But, when convert the e820 type into
the iores descriptors, several e820 types are converted to 'IORES_DES_NONE'
in this function e820_type_to_iores_desc(). So the walk_iomem_res_desc()
will get these unnecessary types(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE
_KERN) when iterate io resources by the 'IORES_DES_NONE'.

It needs filter out these redundant type(such as E820_TYPE_RAM/E820_TYPE_
UNUSABLE/E820_TYPE_KERN) in order to add exact e820 reserved type to kdump
kernel e820 table. Thus it also needs an extra checking in memmap_entry_
callback() to match the e820 type and resource name.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
Changes since v5:
1. Improve the patch log

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
index 50895c2f937d..4c1fe4f8db1e 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1011,7 +1011,7 @@ void __init e820__finish_early_params(void)
 	}
 }
 
-static const char *__init e820_type_to_string(struct e820_entry *entry)
+const char *e820_type_to_string(struct e820_entry *entry)
 {
 	switch (entry->type) {
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
diff --git a/kernel/resource.c b/kernel/resource.c
index b0fbf685c77a..4ac07717e2b1 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -373,6 +373,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 	res->end = min(end, p->end);
 	res->flags = p->flags;
 	res->desc = p->desc;
+	res->name = p->name;
 	return 0;
 }
 
-- 
2.17.1


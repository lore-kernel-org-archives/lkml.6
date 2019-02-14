Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA69F222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438495AbfBNKmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:42:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:55010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438491AbfBNKmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:42:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7FA7B0BA;
        Thu, 14 Feb 2019 10:42:43 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-mm@kvack.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 1/2] x86: respect memory size limiting via mem= parameter
Date:   Thu, 14 Feb 2019 11:42:39 +0100
Message-Id: <20190214104240.24428-2-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190214104240.24428-1-jgross@suse.com>
References: <20190214104240.24428-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When limiting memory size via kernel parameter "mem=" this should be
respected even in case of memory made accessible via a PCI card.

Today this kind of memory won't be made usable in initial memory
setup as the memory won't be visible in E820 map, but it might be
added when adding PCI devices due to corresponding ACPI table entries.

Not respecting "mem=" can be corrected by adding a global max_mem_size
variable set by parse_memopt() which will result in rejecting adding
memory areas resulting in a memory size above the allowed limit.

Signed-off-by: Juergen Gross <jgross@suse.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/e820.c         | 5 +++++
 include/linux/memory_hotplug.h | 2 ++
 mm/memory_hotplug.c            | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 50895c2f937d..e67513e2cbbb 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/firmware-map.h>
 #include <linux/sort.h>
+#include <linux/memory_hotplug.h>
 
 #include <asm/e820/api.h>
 #include <asm/setup.h>
@@ -881,6 +882,10 @@ static int __init parse_memopt(char *p)
 
 	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+	max_mem_size = mem_size;
+#endif
+
 	return 0;
 }
 early_param("mem", parse_memopt);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 368267c1b71b..cfd12078172a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -100,6 +100,8 @@ extern void __online_page_free(struct page *page);
 
 extern int try_online_node(int nid);
 
+extern u64 max_mem_size;
+
 extern bool memhp_auto_online;
 /* If movable_node boot option specified */
 extern bool movable_node_enabled;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 124e794867c5..519f9db063ff 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -96,10 +96,16 @@ void mem_hotplug_done(void)
 	cpus_read_unlock();
 }
 
+u64 max_mem_size = U64_MAX;
+
 /* add this memory to iomem resource */
 static struct resource *register_memory_resource(u64 start, u64 size)
 {
 	struct resource *res, *conflict;
+
+	if (start + size > max_mem_size)
+		return ERR_PTR(-E2BIG);
+
 	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
-- 
2.16.4


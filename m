Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D004C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E334821939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="G+xk3fTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbfAaU1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:27:18 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:18358 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbfAaU1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548966435; x=1580502435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jfyjGv9g5xU0ZRTdgZ3MlRsZNZ0NVJf/Pg95NKC1DMg=;
  b=G+xk3fTsc6iZ+i6U2/Wt0bhBQRt5+el4rvQiXLdK4aMvvl0l3CHYG6k6
   Hd/rOLiyg/syfQ0Ntrej0C9Q4n/A9Q4qO7il3JdTpJ15lfcGoevOMHiWP
   zKostfn9D7n18ZtW/Fi+eoiWuZSjtXt73Zy6n0WZd4uZ46RXgAkHczwCr
   U=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539648000"; 
   d="scan'208";a="756877149"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 31 Jan 2019 20:27:12 +0000
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 85212A20F1;
        Thu, 31 Jan 2019 20:27:11 +0000 (UTC)
Received: from u54e1ad5160425a4b64ea.ant.amazon.com (localhost [127.0.0.1])
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id x0VKR97w029041;
        Thu, 31 Jan 2019 21:27:09 +0100
Received: (from karahmed@localhost)
        by u54e1ad5160425a4b64ea.ant.amazon.com (8.15.2/8.15.2/Submit) id x0VKR8rL029036;
        Thu, 31 Jan 2019 21:27:08 +0100
From:   KarimAllah Ahmed <karahmed@amazon.de>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v6 14/14] kvm, x86: Properly check whether a pfn is an MMIO or not
Date:   Thu, 31 Jan 2019 21:24:44 +0100
Message-Id: <1548966284-28642-15-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
References: <1548966284-28642-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_valid check is not sufficient because it only checks if a page has a struct
page or not, if "mem=" was passed to the kernel some valid pages won't have a
struct page. This means that if guests were assigned valid memory that lies
after the mem= boundary it will be passed uncached to the guest no matter what
the guest caching attributes are for this memory.

Introduce a new function e820__mapped_raw_any which is equivalent to
e820__mapped_any but uses the original e820 unmodified and use it to
identify real *RAM*.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Introduce e820__mapped_raw_any
---
 arch/x86/include/asm/e820/api.h |  1 +
 arch/x86/kernel/e820.c          | 18 +++++++++++++++---
 arch/x86/kvm/mmu.c              |  5 ++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index 4562062..b3f6e89 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -12,6 +12,7 @@ extern unsigned long e820_saved_max_low_pfn;
 
 extern unsigned long pci_mem_start;
 
+extern bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_any(u64 start, u64 end, enum e820_type type);
 extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index ef914d0..3039659 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -75,12 +75,13 @@ EXPORT_SYMBOL(pci_mem_start);
  * This function checks if any part of the range <start,end> is mapped
  * with type.
  */
-bool e820__mapped_any(u64 start, u64 end, enum e820_type type)
+static bool _e820__mapped_any(struct e820_table *table,
+			      u64 start, u64 end, enum e820_type type)
 {
 	int i;
 
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry = &e820_table->entries[i];
+	for (i = 0; i < table->nr_entries; i++) {
+		struct e820_entry *entry = &table->entries[i];
 
 		if (type && entry->type != type)
 			continue;
@@ -90,6 +91,17 @@ bool e820__mapped_any(u64 start, u64 end, enum e820_type type)
 	}
 	return 0;
 }
+
+bool e820__mapped_raw_any(u64 start, u64 end, enum e820_type type)
+{
+	return _e820__mapped_any(e820_table_firmware, start, end, type);
+}
+EXPORT_SYMBOL_GPL(e820__mapped_raw_any);
+
+bool e820__mapped_any(u64 start, u64 end, enum e820_type type)
+{
+	return _e820__mapped_any(e820_table, start, end, type);
+}
 EXPORT_SYMBOL_GPL(e820__mapped_any);
 
 /*
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index da9c423..abf6a0d 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -44,6 +44,7 @@
 #include <asm/page.h>
 #include <asm/pat.h>
 #include <asm/cmpxchg.h>
+#include <asm/e820/api.h>
 #include <asm/io.h>
 #include <asm/vmx.h>
 #include <asm/kvm_page_track.h>
@@ -2875,7 +2876,9 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
 			 */
 			(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
 
-	return true;
+	return !e820__mapped_raw_any(pfn_to_hpa(pfn),
+				     pfn_to_hpa(pfn + 1) - 1,
+				     E820_TYPE_RAM);
 }
 
 /* Bits which may be returned by set_spte() */
-- 
2.7.4


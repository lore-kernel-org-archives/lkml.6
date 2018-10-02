Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21200C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF0920878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF0920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeJBRBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:01:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57079 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJBRBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:01:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92AI8UU1917678
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:18:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92AI8051917675;
        Tue, 2 Oct 2018 03:18:08 -0700
Date:   Tue, 2 Oct 2018 03:18:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masayoshi Mizuma <tipbot@zytor.com>
Message-ID: <tip-e79ac9354cf95d75ff6afd341f9c5aa5cbcd638b@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        m.mizuma@jp.fujitsu.com, bhe@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        msys.mizuma@gmail.com, hpa@zytor.com, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, msys.mizuma@gmail.com,
          hpa@zytor.com, bp@alien8.de, tglx@linutronix.de,
          mingo@kernel.org, m.mizuma@jp.fujitsu.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, bhe@redhat.com
In-Reply-To: <20181001140843.26137-2-msys.mizuma@gmail.com>
References: <20181001140843.26137-2-msys.mizuma@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/mm: Add a kernel parameter to change the padding
 used for the physical memory mapping
Git-Commit-ID: e79ac9354cf95d75ff6afd341f9c5aa5cbcd638b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e79ac9354cf95d75ff6afd341f9c5aa5cbcd638b
Gitweb:     https://git.kernel.org/tip/e79ac9354cf95d75ff6afd341f9c5aa5cbcd638b
Author:     Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
AuthorDate: Mon, 1 Oct 2018 10:08:41 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 11:47:20 +0200

x86/mm: Add a kernel parameter to change the padding used for the physical memory mapping

If each node of physical memory layout has huge space for hotplug,
the padding used for the physical memory mapping section is not enough.
For exapmle of the layout:

  SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
  SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
  SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
  SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug

We can increase the padding via CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
however, the needed padding size depends on the system environment.
The kernel option is better than changing the config.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181001140843.26137-2-msys.mizuma@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/kaslr.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 61db77b0eda9..00cf4cae38f5 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -40,6 +40,7 @@
  */
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
+int __initdata rand_mem_physical_padding = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
 /*
  * Memory regions randomized by KASLR (except modules that use a separate logic
  * earlier during boot). The list is ordered based on virtual addresses. This
@@ -69,6 +70,20 @@ static inline bool kaslr_memory_enabled(void)
 	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
 }
 
+static int __init rand_mem_physical_padding_setup(char *str)
+{
+	int max_padding = (1 << (MAX_PHYSMEM_BITS - TB_SHIFT)) - 1;
+
+	get_option(&str, &rand_mem_physical_padding);
+	if (rand_mem_physical_padding < 0)
+		rand_mem_physical_padding = 0;
+	else if (rand_mem_physical_padding > max_padding)
+		rand_mem_physical_padding = max_padding;
+
+	return 0;
+}
+early_param("rand_mem_physical_padding", rand_mem_physical_padding_setup);
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -102,7 +117,7 @@ void __init kernel_randomize_memory(void)
 	 */
 	BUG_ON(kaslr_regions[0].base != &page_offset_base);
 	memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
-		CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;
+		rand_mem_physical_padding;
 
 	/* Adapt phyiscal memory region size based on available memory */
 	if (memory_tb < kaslr_regions[0].size_tb)

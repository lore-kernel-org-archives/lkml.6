Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A89C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA1B20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA1B20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeIARQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:16:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeIARQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:16:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w81D3rdt2551526
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 1 Sep 2018 06:03:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w81D3qeI2551523;
        Sat, 1 Sep 2018 06:03:52 -0700
Date:   Sat, 1 Sep 2018 06:03:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for LuckTony <tipbot@zytor.com>
Message-ID: <tip-c7486104a5ce7e8763e3cb5157bba8d0f1468d87@git.kernel.org>
Cc:     dave.jiang@intel.com, hpa@zytor.com, bp@alien8.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-edac@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: dave.jiang@intel.com, hpa@zytor.com, mingo@kernel.org,
          bp@alien8.de, linux-kernel@vger.kernel.org, tglx@linutronix.de,
          tony.luck@intel.com, dan.j.williams@intel.com,
          linux-edac@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180831165506.GA9605@agluck-desk>
References: <20180831165506.GA9605@agluck-desk>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mce: Fix set_mce_nospec() to avoid #GP fault
Git-Commit-ID: c7486104a5ce7e8763e3cb5157bba8d0f1468d87
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

Commit-ID:  c7486104a5ce7e8763e3cb5157bba8d0f1468d87
Gitweb:     https://git.kernel.org/tip/c7486104a5ce7e8763e3cb5157bba8d0f1468d87
Author:     LuckTony <tony.luck@intel.com>
AuthorDate: Fri, 31 Aug 2018 09:55:06 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 1 Sep 2018 14:59:19 +0200

x86/mce: Fix set_mce_nospec() to avoid #GP fault

The trick with flipping bit 63 to avoid loading the address of the 1:1
mapping of the poisoned page while the 1:1 map is updated used to work when
unmapping the page. But it falls down horribly when attempting to directly
set the page as uncacheable.

The problem is that when the cache mode is changed to uncachable, the pages
needs to be flushed from the cache first. But the decoy address is
non-canonical due to bit 63 flipped, and the CLFLUSH instruction throws a
#GP fault.

Add code to change_page_attr_set_clr() to fix the address before calling
flush.

Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Link: https://lkml.kernel.org/r/20180831165506.GA9605@agluck-desk

---
 arch/x86/mm/pageattr.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 8d6c34fe49be..51a5a69ecac9 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1420,6 +1420,29 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 	return 0;
 }
 
+/*
+ * Machine check recovery code needs to change cache mode of poisoned
+ * pages to UC to avoid speculative access logging another error. But
+ * passing the address of the 1:1 mapping to set_memory_uc() is a fine
+ * way to encourage a speculative access. So we cheat and flip the top
+ * bit of the address. This works fine for the code that updates the
+ * page tables. But at the end of the process we need to flush the cache
+ * and the non-canonical address causes a #GP fault when used by the
+ * CLFLUSH instruction.
+ *
+ * But in the common case we already have a canonical address. This code
+ * will fix the top bit if needed and is a no-op otherwise.
+ */
+static inline unsigned long make_addr_canonical_again(unsigned long addr)
+{
+#ifdef CONFIG_X86_64
+	return (long)(addr << 1) >> 1;
+#else
+	return addr;
+#endif
+}
+
+
 static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 				    pgprot_t mask_set, pgprot_t mask_clr,
 				    int force_split, int in_flag,
@@ -1465,7 +1488,7 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 		 * Save address for cache flush. *addr is modified in the call
 		 * to __change_page_attr_set_clr() below.
 		 */
-		baddr = *addr;
+		baddr = make_addr_canonical_again(*addr);
 	}
 
 	/* Must avoid aliasing mappings in the highmem code */

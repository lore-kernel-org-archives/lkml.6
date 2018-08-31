Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A84C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C450520658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C450520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeHaVD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:03:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:39584 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727433AbeHaVD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:03:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 09:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="87950433"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2018 09:55:06 -0700
Date:   Fri, 31 Aug 2018 09:55:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH V2] x86/mce: Fix set_mce_nospec() to avoid #GP fault
Message-ID: <20180831165506.GA9605@agluck-desk>
References: <20180830214517.29372-1-tony.luck@intel.com>
 <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
 <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
 <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trick with flipping bit 63 to avoid loading the address of the
1:1 mapping of the poisoned page while we update the 1:1 map used
to work when we wanted to unmap the page. But it falls down horribly
when we try to directly set the page as uncacheable.

The problem is that when we change the cache mode to uncachable we
try to flush the page from the cache. But the decoy address is
non-canonical, and the CLFLUSH instruction throws a #GP fault.

Add code to change_page_attr_set_clr() to fix the address
before calling flush.

Fixes: 284ce4011ba6 ("x86/memory_failure: Introduce {set, clear}_mce_nospec()")
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

The magic code to make address canonical would mess up 32-bit (which
doesn't play these games).  So I made an inline function. I've put it
in pageattr.c as I don't expect anywhere else to need this. If the #ifdef
in a ".c" file offends too badly it can move to some ".h" file.

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
-- 
2.17.1


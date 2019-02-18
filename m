Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACA3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2A82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550513758;
	bh=UcEeAmgLh6ntXppqbbwElWQz7gnAQqedMvnz2Ccfgr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+VU39+xRMvsBY5YDpOV42RoLTukbfS31Y4bYX2lS088InPMl/o/RHj6vKyyRgYi2
	 Ji6Yhgz5yPTY4rLwT32hPqe/jSfcmYJDJK9pxbCuWsr2LvmN6dbIKuGiuoIpjVt5u2
	 702kx0C6LvmfYdM1pPweh9oaoGP9VtxlR+mqV/QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391944AbfBRSP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:15:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46157 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbfBRSP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:15:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so11177142wrs.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 10:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J+6Hc4AzwOBD/tl3HtoVeZpC/fTKeuWtAOITR86cuJ8=;
        b=gL6DnL/CiKNYztbUnYWP5vcYBe91hg9/xo1MfOKRnLl8xqk1OE7kqG3hHIg3IRTZE8
         /FHew9dpTH4+NlpHdRaUrrc8q6QkmHObTDxh1sahfIzSzb0h7Lp9AbZlrpukNsnL5QLP
         0IPRq2n6grujiCh/+2qVa0CRJT5g0mz/Ry5H1yuuSUBuvuzyjSNcOf18L7EGIDqf1KhO
         J5Kvpi9GGIsq3Uvn67UgDjfS176i1tonRJYkzJ0a0oOJd+QronUMbcGYAe1rCCNBixi9
         IXHY5rw+VyhRzsn0HK+gZJ44IkFqWpMh+hH92rmJfwa3wlwmxTeLr4UhXya5GNiCwStc
         BFeA==
X-Gm-Message-State: AHQUAubO5tjDFSmN6gKVmQRSD9HnL9/ejQiYyrhl6LkZi7+2MT4bV/PW
        Mwl1V1Ev4zJMsqet2ddImNU=
X-Google-Smtp-Source: AHgI3IZ+X2a5DlmEBH8T4mTouRjo89/oxtYXCIyfrrBWJNhweHI5+eanofh4OF1k8qiHM22jwtRktg==
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr17227615wrn.290.1550513753743;
        Mon, 18 Feb 2019 10:15:53 -0800 (PST)
Received: from tiehlicka.suse.cz (ip-37-188-181-146.eurotel.cz. [37.188.181.146])
        by smtp.gmail.com with ESMTPSA id z16sm12927267wrr.66.2019.02.18.10.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 10:15:52 -0800 (PST)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <OSalvador@suse.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org,
        Michal Hocko <mhocko@suse.com>, rong.a.chen@intel.com
Subject: [RFC PATCH] mm, memory_hotplug: fix off-by-one in is_pageblock_removable
Date:   Mon, 18 Feb 2019 19:15:44 +0100
Message-Id: <20190218181544.14616-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218052823.GH29177@shao2-debian>
References: <20190218052823.GH29177@shao2-debian>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Rong Chen has reported the following boot crash
[   40.305212] PGD 0 P4D 0
[   40.308255] Oops: 0000 [#1] PREEMPT SMP PTI
[   40.313055] CPU: 1 PID: 239 Comm: udevd Not tainted 5.0.0-rc4-00149-gefad4e4 #1
[   40.321348] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   40.330813] RIP: 0010:page_mapping+0x12/0x80
[   40.335709] Code: 5d c3 48 89 df e8 0e ad 02 00 85 c0 75 da 89 e8 5b 5d c3 0f 1f 44 00 00 53 48 89 fb 48 8b 43 08 48 8d 50 ff a8 01 48 0f 45 da <48> 8b 53 08 48 8d 42 ff 83 e2 01 48 0f 44 c3 48 83 38 ff 74 2f 48
[   40.356704] RSP: 0018:ffff88801fa87cd8 EFLAGS: 00010202
[   40.362714] RAX: ffffffffffffffff RBX: fffffffffffffffe RCX: 000000000000000a
[   40.370798] RDX: fffffffffffffffe RSI: ffffffff820b9a20 RDI: ffff88801e5c0000
[   40.378830] RBP: 6db6db6db6db6db7 R08: ffff88801e8bb000 R09: 0000000001b64d13
[   40.386902] R10: ffff88801fa87cf8 R11: 0000000000000001 R12: ffff88801e640000
[   40.395033] R13: ffffffff820b9a20 R14: ffff88801f145258 R15: 0000000000000001
[   40.403138] FS:  00007fb2079817c0(0000) GS:ffff88801dd00000(0000) knlGS:0000000000000000
[   40.412243] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   40.418846] CR2: 0000000000000006 CR3: 000000001fa82000 CR4: 00000000000006a0
[   40.426951] Call Trace:
[   40.429843]  __dump_page+0x14/0x2c0
[   40.433947]  is_mem_section_removable+0x24c/0x2c0
[   40.439327]  removable_show+0x87/0xa0
[   40.443613]  dev_attr_show+0x25/0x60
[   40.447763]  sysfs_kf_seq_show+0xba/0x110
[   40.452363]  seq_read+0x196/0x3f0
[   40.456282]  __vfs_read+0x34/0x180
[   40.460233]  ? lock_acquire+0xb6/0x1e0
[   40.464610]  vfs_read+0xa0/0x150
[   40.468372]  ksys_read+0x44/0xb0
[   40.472129]  ? do_syscall_64+0x1f/0x4a0
[   40.476593]  do_syscall_64+0x5e/0x4a0
[   40.480809]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   40.486195]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

and bisected it down to efad4e475c31 ("mm, memory_hotplug:
is_mem_section_removable do not pass the end of a zone"). The reason for
the crash is that the mapping is garbage for poisoned (uninitialized) page.
This shouldn't happen as all pages in the zone's boundary should be
initialized. Later debugging revealed that the actual problem is an
off-by-one when evaluating the end_page. start_pfn + nr_pages resp.
zone_end_pfn refers to a pfn after the range and as such it might belong
to a differen memory section. This along with CONFIG_SPARSEMEM then
makes the loop condition completely bogus because a pointer arithmetic
doesn't work for pages from two different sections in that memory model.

Fix the issue by reworking is_pageblock_removable to be pfn based and
only use struct page where necessary. This makes the code slightly
easier to follow and we will remove the problematic pointer arithmetic
completely.

Fixes: efad4e475c31 ("mm, memory_hotplug: is_mem_section_removable do not pass the end of a zone")
Reported-by: <rong.a.chen@intel.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memory_hotplug.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 124e794867c5..1ad28323fb9f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1188,11 +1188,13 @@ static inline int pageblock_free(struct page *page)
 	return PageBuddy(page) && page_order(page) >= pageblock_order;
 }
 
-/* Return the start of the next active pageblock after a given page */
-static struct page *next_active_pageblock(struct page *page)
+/* Return the pfn of the start of the next active pageblock after a given pfn */
+static unsigned long next_active_pageblock(unsigned long pfn)
 {
+	struct page *page = pfn_to_page(pfn);
+
 	/* Ensure the starting page is pageblock-aligned */
-	BUG_ON(page_to_pfn(page) & (pageblock_nr_pages - 1));
+	BUG_ON(pfn & (pageblock_nr_pages - 1));
 
 	/* If the entire pageblock is free, move to the end of free page */
 	if (pageblock_free(page)) {
@@ -1200,16 +1202,16 @@ static struct page *next_active_pageblock(struct page *page)
 		/* be careful. we don't have locks, page_order can be changed.*/
 		order = page_order(page);
 		if ((order < MAX_ORDER) && (order >= pageblock_order))
-			return page + (1 << order);
+			return pfn + (1 << order);
 	}
 
-	return page + pageblock_nr_pages;
+	return pfn + pageblock_nr_pages;
 }
 
-static bool is_pageblock_removable_nolock(struct page *page)
+static bool is_pageblock_removable_nolock(unsigned long pfn)
 {
+	struct page *page = pfn_to_page(pfn);
 	struct zone *zone;
-	unsigned long pfn;
 
 	/*
 	 * We have to be careful here because we are iterating over memory
@@ -1232,13 +1234,14 @@ static bool is_pageblock_removable_nolock(struct page *page)
 /* Checks if this range of memory is likely to be hot-removable. */
 bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
-	struct page *page = pfn_to_page(start_pfn);
-	unsigned long end_pfn = min(start_pfn + nr_pages, zone_end_pfn(page_zone(page)));
-	struct page *end_page = pfn_to_page(end_pfn);
+	unsigned long end_pfn, pfn;
+
+	end_pfn = min(start_pfn + nr_pages,
+			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
 
 	/* Check the starting page of each pageblock within the range */
-	for (; page < end_page; page = next_active_pageblock(page)) {
-		if (!is_pageblock_removable_nolock(page))
+	for (pfn = start_pfn; pfn < end_pfn; pfn = next_active_pageblock(pfn)) {
+		if (!is_pageblock_removable_nolock(pfn))
 			return false;
 		cond_resched();
 	}
-- 
2.20.1


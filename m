Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06FCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE76323DEF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE76323DEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932913AbeGCP6m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:58:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752905AbeGCP6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:58:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63Fw3fX338376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 08:58:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63Fw37i338373;
        Tue, 3 Jul 2018 08:58:03 -0700
Date:   Tue, 3 Jul 2018 08:58:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-9b912485e0e74a74e042e4f2dd87f262e46fcdf1@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, bhe@redhat.com,
        peterz@infradead.org
Reply-To: hpa@zytor.com, bhe@redhat.com, tglx@linutronix.de,
          mingo@kernel.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20180625031656.12443-2-bhe@redhat.com>
References: <20180625031656.12443-2-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/KASLR: Add two new functions for 1GB huge
 pages handling
Git-Commit-ID: 9b912485e0e74a74e042e4f2dd87f262e46fcdf1
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

Commit-ID:  9b912485e0e74a74e042e4f2dd87f262e46fcdf1
Gitweb:     https://git.kernel.org/tip/9b912485e0e74a74e042e4f2dd87f262e46fcdf1
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Mon, 25 Jun 2018 11:16:55 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 10:50:12 +0200

x86/boot/KASLR: Add two new functions for 1GB huge pages handling

Introduce two new functions: parse_gb_huge_pages() and process_gb_huge_pages(),
which handle a conflict between KASLR and huge pages of 1GB.

These two functions will be used in the next patch:

- parse_gb_huge_pages() is used to parse kernel command-line to get
  how many 1GB huge pages have been specified. A static global
  variable 'max_gb_huge_pages' is added to store the number.

- process_gb_huge_pages() is used to skip as many 1GB huge pages
  as possible from the passed in memory region according to the
  specified number.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: douly.fnst@cn.fujitsu.com
Cc: fanc.fnst@cn.fujitsu.com
Cc: indou.takao@jp.fujitsu.com
Cc: keescook@chromium.org
Cc: lcapitulino@redhat.com
Cc: yasu.isimatu@gmail.com
Link: http://lkml.kernel.org/r/20180625031656.12443-2-bhe@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..d97647b5ffb7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -215,6 +215,35 @@ static void mem_avoid_memmap(char *str)
 		memmap_too_large = true;
 }
 
+/* Store the number of 1GB huge pages which users specified: */
+static unsigned long max_gb_huge_pages;
+
+static void parse_gb_huge_pages(char *param, char *val)
+{
+	static bool gbpage_sz;
+	char *p;
+
+	if (!strcmp(param, "hugepagesz")) {
+		p = val;
+		if (memparse(p, &p) != PUD_SIZE) {
+			gbpage_sz = false;
+			return;
+		}
+
+		if (gbpage_sz)
+			warn("Repeatedly set hugeTLB page size of 1G!\n");
+		gbpage_sz = true;
+		return;
+	}
+
+	if (!strcmp(param, "hugepages") && gbpage_sz) {
+		p = val;
+		max_gb_huge_pages = simple_strtoull(p, &p, 0);
+		return;
+	}
+}
+
+
 static int handle_mem_memmap(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
@@ -466,6 +495,60 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 	}
 }
 
+/*
+ * Skip as many 1GB huge pages as possible in the passed region
+ * according to the number which users specified:
+ */
+static void
+process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
+{
+	unsigned long addr, size = 0;
+	struct mem_vector tmp;
+	int i = 0;
+
+	if (!max_gb_huge_pages) {
+		store_slot_info(region, image_size);
+		return;
+	}
+
+	addr = ALIGN(region->start, PUD_SIZE);
+	/* Did we raise the address above the passed in memory entry? */
+	if (addr < region->start + region->size)
+		size = region->size - (addr - region->start);
+
+	/* Check how many 1GB huge pages can be filtered out: */
+	while (size > PUD_SIZE && max_gb_huge_pages) {
+		size -= PUD_SIZE;
+		max_gb_huge_pages--;
+		i++;
+	}
+
+	/* No good 1GB huge pages found: */
+	if (!i) {
+		store_slot_info(region, image_size);
+		return;
+	}
+
+	/*
+	 * Skip those 'i'*1GB good huge pages, and continue checking and
+	 * processing the remaining head or tail part of the passed region
+	 * if available.
+	 */
+
+	if (addr >= region->start + image_size) {
+		tmp.start = region->start;
+		tmp.size = addr - region->start;
+		store_slot_info(&tmp, image_size);
+	}
+
+	size  = region->size - (addr - region->start) - i * PUD_SIZE;
+	if (size >= image_size) {
+		tmp.start = addr + i * PUD_SIZE;
+		tmp.size = size;
+		store_slot_info(&tmp, image_size);
+	}
+}
+
 static unsigned long slots_fetch_random(void)
 {
 	unsigned long slot;

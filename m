Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67066C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CCE2253F8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCE2253F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeFYDRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:17:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752965AbeFYDRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C96A7B2B1;
        Mon, 25 Jun 2018 03:17:15 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C874C111D3CC;
        Mon, 25 Jun 2018 03:17:09 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        lcapitulino@redhat.com, keescook@chromium.org, tglx@linutronix.de
Cc:     x86@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages handling
Date:   Mon, 25 Jun 2018 11:16:55 +0800
Message-Id: <20180625031656.12443-2-bhe@redhat.com>
In-Reply-To: <20180625031656.12443-1-bhe@redhat.com>
References: <20180625031656.12443-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 03:17:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 03:17:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions parse_gb_huge_pages() and process_gb_huge_pages() are
introduced to handle a conflict between KASLR and huge pages of
GB, will be used in the next patch.

Function parse_gb_huge_pages() is used to parse kernel
command-line to get how many 1GB huge pages have been specified.
A static global variable 'max_gb_huge_pages' is added to store
the number.

And process_gb_huge_pages() is used to skip as many 1GB huge pages
as possible from the passed in memory region according to the
specified number.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b87a7582853d..0fea96f9cc28 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -215,6 +215,35 @@ static void mem_avoid_memmap(char *str)
 		memmap_too_large = true;
 }
 
+/* Store the number of 1GB huge pages which users specified.*/
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
+ * according to the number which users specified.
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
+	/* Check how many 1GB huge pages can be filtered out*/
+	while (size > PUD_SIZE && max_gb_huge_pages) {
+		size -= PUD_SIZE;
+		max_gb_huge_pages--;
+		i++;
+	}
+
+	/* No good 1GB huge pages found. */
+	if (!i) {
+		store_slot_info(region, image_size);
+		return;
+	}
+
+	/*
+	 * Skip those 'i'*1GB good huge pages. And continue checking and
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
-- 
2.13.6


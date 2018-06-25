Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA10C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E541253F9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E541253F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeFYDRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:17:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752980AbeFYDRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:17:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69B88401EF03;
        Mon, 25 Jun 2018 03:17:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42029111AF12;
        Mon, 25 Jun 2018 03:17:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        lcapitulino@redhat.com, keescook@chromium.org, tglx@linutronix.de
Cc:     x86@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] x86/boot/KASLR: Skip specified number of 1GB huge pages when do physical randomization
Date:   Mon, 25 Jun 2018 11:16:56 +0800
Message-Id: <20180625031656.12443-3-bhe@redhat.com>
In-Reply-To: <20180625031656.12443-1-bhe@redhat.com>
References: <20180625031656.12443-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 03:17:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 25 Jun 2018 03:17:23 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 1GB huge pages allocation, a regression bug could be triggered when
KASLR is enabled. On a KVM guest with 4GB RAM, after adding the following
to the kernel command-line:

	'default_hugepagesz=1G hugepagesz=1G hugepages=1'

then boot the guest and check number of 1GB pages reserved:
  # grep HugePages_Total /proc/meminfo

It shows that when booting with "nokaslr" HugePages_Total is always 1,
while booting without "nokaslr" sometimes HugePages_Total is set as 0
(that is, reserving the 1GB page fails). Note that it may need to boot
a few times to trigger the issue.

After investigation, the root cause is that kernel may be put into the
only good 1GB huge page [0x40000000, 0x7fffffff] randomly. Below is the
dmesg output snippet from the KVM guest. We can see that only
[0x40000000, 0x7fffffff] region is good 1GB huge page,
[0x100000000, 0x13fffffff] will be touched by memblock top-down
allocation.

[...] e820: BIOS-provided physical RAM map:
[...] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[...] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[...] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[...] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[...] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[...] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[...] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[...] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable

Besides, on those bare-metal machines with larger memory, one less 1GB
huge page might be got with KASLR enabled. It's also because that kernel
might be randomized into those good 1GB huge pages.

To fix this, firstly parse kernel command-line to get how many 1GB huge
pages are specified. Then try to skip the specified number of 1GB huge
pages when decide which memory region kernel can be randomized into.

And also change the name of handle_mem_memmap() as handle_mem_options()
since it handles not only 'mem=' and 'memmap=', but also 'hugepagesxxx'
now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 0fea96f9cc28..ff8a865de36b 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -244,7 +244,7 @@ static void parse_gb_huge_pages(char *param, char *val)
 }
 
 
-static int handle_mem_memmap(void)
+static int handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	size_t len = strlen((char *)args);
@@ -252,7 +252,8 @@ static int handle_mem_memmap(void)
 	char *param, *val;
 	u64 mem_size;
 
-	if (!strstr(args, "memmap=") && !strstr(args, "mem="))
+	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
+		!strstr(args, "hugepages"))
 		return 0;
 
 	tmp_cmdline = malloc(len + 1);
@@ -277,6 +278,8 @@ static int handle_mem_memmap(void)
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(val);
+		} else if (strstr(param, "hugepages")) {
+			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
 
@@ -416,7 +419,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* We don't need to set a mapping for setup_data. */
 
 	/* Mark the memmap regions we need to avoid */
-	handle_mem_memmap();
+	handle_mem_options();
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
@@ -629,7 +632,7 @@ static void process_mem_region(struct mem_vector *entry,
 
 		/* If nothing overlaps, store the region and return. */
 		if (!mem_avoid_overlap(&region, &overlap)) {
-			store_slot_info(&region, image_size);
+			process_gb_huge_pages(&region, image_size);
 			return;
 		}
 
@@ -639,7 +642,7 @@ static void process_mem_region(struct mem_vector *entry,
 
 			beginning.start = region.start;
 			beginning.size = overlap.start - region.start;
-			store_slot_info(&beginning, image_size);
+			process_gb_huge_pages(&beginning, image_size);
 		}
 
 		/* Return if overlap extends to or past end of region. */
-- 
2.13.6


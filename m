Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C771C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE4123EDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE4123EDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933633AbeGCP7N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:59:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932747AbeGCP7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:59:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63FwaUL338437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 08:58:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63FwaQ1338434;
        Tue, 3 Jul 2018 08:58:36 -0700
Date:   Tue, 3 Jul 2018 08:58:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-747ff6265db4c2b77e8c7384f8054916a0c1eb39@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, bhe@redhat.com,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          peterz@infradead.org, tglx@linutronix.de, bhe@redhat.com,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20180625031656.12443-3-bhe@redhat.com>
References: <20180625031656.12443-3-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot/KASLR: Skip specified number of 1GB huge
 pages when doing physical randomization (KASLR)
Git-Commit-ID: 747ff6265db4c2b77e8c7384f8054916a0c1eb39
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

Commit-ID:  747ff6265db4c2b77e8c7384f8054916a0c1eb39
Gitweb:     https://git.kernel.org/tip/747ff6265db4c2b77e8c7384f8054916a0c1eb39
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Mon, 25 Jun 2018 11:16:56 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 10:50:13 +0200

x86/boot/KASLR: Skip specified number of 1GB huge pages when doing physical randomization (KASLR)

When KASLR is enabled then 1GB huge pages allocations might regress
sporadically.

To reproduce on a KVM guest with 4GB RAM:

- add the following options to the kernel command-line:

   'default_hugepagesz=1G hugepagesz=1G hugepages=1'

- boot the guest and check number of 1GB pages reserved:

    # grep HugePages_Total /proc/meminfo

- sporadically, every couple of bootups the output of this
  command shows that when booting with "nokaslr" HugePages_Total is always 1,
  while booting without "nokaslr" sometimes HugePages_Total is set as 0
  (that is, reserving the 1GB page failed).

Note that you may need to boot a few times to trigger the issue,
because it's somewhat non-deterministic.

The root cause is that kernel may be put into the only good 1GB huge page
in the [0x40000000, 0x7fffffff] physical range randomly.

Below is the dmesg output snippet from the KVM guest. We can see that only
[0x40000000, 0x7fffffff] region is good 1GB huge page,
[0x100000000, 0x13fffffff] will be touched by the memblock top-down allocation:

[...] e820: BIOS-provided physical RAM map:
[...] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[...] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[...] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[...] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[...] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[...] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[...] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[...] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable

Besides, on bare-metal machines with larger memory, one less 1GB huge page
might be available with KASLR enabled. That too is because the kernel
image might be randomized into those "good" 1GB huge pages.

To fix this, firstly parse the kernel command-line to get how many 1GB huge
pages are specified. Then try to skip the specified number of 1GB huge
pages when decide which memory region kernel can be randomized into.

Also change the name of handle_mem_memmap() as handle_mem_options()
since it handles not only 'mem=' and 'memmap=', but also 'hugepagesxxx' now.

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
Link: http://lkml.kernel.org/r/20180625031656.12443-3-bhe@redhat.com
[ Rewrote the changelog, fixed style problems in the code. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/boot/compressed/kaslr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d97647b5ffb7..531c9876f573 100644
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

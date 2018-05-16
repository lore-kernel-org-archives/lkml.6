Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753489AbeEPKGJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:06:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752951AbeEPKFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:05:52 -0400
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, mingo@kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de
Cc: x86@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] x86/boot/KASLR: Skip specified number of 1GB huge pages when do physical randomization
Date: Wed, 16 May 2018 18:05:32 +0800
Message-Id: <20180516100532.14083-3-bhe@redhat.com>
In-Reply-To: <20180516100532.14083-1-bhe@redhat.com>
References: <20180516100532.14083-1-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 1GB huge pages allocation, a regression bug is reported when KASLR
is enabled. On KVM guest with 4GB RAM, and add the following to the
kernel command-line:

	'default_hugepagesz=1G hugepagesz=1G hugepages=1'

Then boot the guest and check number of 1GB pages reserved:
  grep HugePages_Total /proc/meminfo

When booting with "nokaslr" HugePages_Total is always 1. When booting
without "nokaslr" sometimes HugePages_Total is zero  (that is, reserving
the 1GB page fails). It may need to boot a few times to trigger the issue.

After investigation, the root cause is that kernel may be put in the only
good 1GB huge page [0x40000000, 0x7fffffff] randomly. Below is the dmesg
output snippet of the KVM guest. We can see that only
[0x40000000, 0x7fffffff] region is good 1GB huge page,
[0x100000000, 0x13fffffff] will be touched by memblock top-down allocation.

[  +0.000000] e820: BIOS-provided physical RAM map:
[  +0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[  +0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
[  +0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[  +0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff] usable

And also on those bare-metal machines with larger memory, one less 1GB huge
page might be got with KASLR enabled than 'nokaslr' specified case. It's also
because that kernel might be randomized into those good 1GB huge pages.

To fix this, firstly parse kernel command-line to get how many 1GB huge pages
are specified. Then try to skip the specified number of 1GB huge pages when
decide which memory region kernel can be randomized into.

And also change the name of handle_mem_memmap() as handle_mem_options() since
it doesn't only handle 'mem=' and 'memmap=', but include 'hugepagesxxx' now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 13bd879cdc5d..b4819faab602 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -241,7 +241,7 @@ static int parse_gb_huge_pages(char *param, char* val)
 }
 
 
-static int handle_mem_memmap(void)
+static int handle_mem_options(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	size_t len = strlen((char *)args);
@@ -249,7 +249,8 @@ static int handle_mem_memmap(void)
 	char *param, *val;
 	u64 mem_size;
 
-	if (!strstr(args, "memmap=") && !strstr(args, "mem="))
+	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
+		!strstr(args,"hugepages"))
 		return 0;
 
 	tmp_cmdline = malloc(len + 1);
@@ -274,6 +275,8 @@ static int handle_mem_memmap(void)
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(val);
+		} else if (strstr(param, "hugepages")) {
+			parse_gb_huge_pages(param, val);
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
 
@@ -413,7 +416,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* We don't need to set a mapping for setup_data. */
 
 	/* Mark the memmap regions we need to avoid */
-	handle_mem_memmap();
+	handle_mem_options();
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
@@ -617,7 +620,7 @@ static void process_mem_region(struct mem_vector *entry,
 
 		/* If nothing overlaps, store the region and return. */
 		if (!mem_avoid_overlap(&region, &overlap)) {
-			store_slot_info(&region, image_size);
+			process_gb_huge_page(&region, image_size);
 			return;
 		}
 
@@ -627,7 +630,7 @@ static void process_mem_region(struct mem_vector *entry,
 
 			beginning.start = region.start;
 			beginning.size = overlap.start - region.start;
-			store_slot_info(&beginning, image_size);
+			process_gb_huge_page(&beginning, image_size);
 		}
 
 		/* Return if overlap extends to or past end of region. */
-- 
2.13.6

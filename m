Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeB1Kvn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:51:43 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:23568 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752284AbeB1Kvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:51:41 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37332003"
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bhe@redhat.com>,
        <keescook@chromium.org>, <yasu.isimatu@gmail.com>
CC: <indou.takao@jp.fujitsu.com>, <lcapitulino@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>
Subject: [PATCH v9 1/5] x86/KASLR: Add kaslr_boot_mem=nn[KMG]@ss[KMG]
Date: Wed, 28 Feb 2018 18:51:01 +0800
Message-ID: <20180228105105.11487-2-fanc.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
References: <20180228105105.11487-1-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-yoursite-MailScanner-ID: 8E65B4D0EFE6.AE112
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new kernel parameter kaslr_boot_mem=nn[KMG]@ss[KMG] which is
used by KASLR only during kernel decompression stage.

Users can use it to specify memory regions where kernel can be randomized
into. E.g if movable_node specified in kernel cmdline, kernel could be
extracted into those movable regions, this will make memory hotplug fail.
With the help of 'kaslr_boot_mem=', limit kernel in those immovable regions
specified.

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Tested-by: Luiz Capitulino <lcapitulino@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/boot/compressed/kaslr.c | 73 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 66e42a098d70..e33e5cbf7244 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -114,6 +114,15 @@ enum mem_avoid_index {
 
 static struct mem_vector mem_avoid[MEM_AVOID_MAX];
 
+/* Only support at most 4 usable memory regions specified for kaslr */
+#define MAX_KASLR_MEM_USABLE	4
+
+/* Store the usable memory regions for kaslr */
+static struct mem_vector mem_usable[MAX_KASLR_MEM_USABLE];
+
+/* The amount of usable regions for kaslr user specify, not more than 4 */
+static int num_usable_region;
+
 static bool mem_overlaps(struct mem_vector *one, struct mem_vector *two)
 {
 	/* Item one is entirely before item two. */
@@ -212,7 +221,62 @@ static void mem_avoid_memmap(char *str)
 		memmap_too_large = true;
 }
 
-static int handle_mem_memmap(void)
+static int parse_kaslr_boot_mem(char *p,
+				unsigned long long *start,
+				unsigned long long *size)
+{
+	char *oldp;
+
+	if (!p)
+		return -EINVAL;
+
+	oldp = p;
+	*size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
+
+	switch (*p) {
+	case '@':
+		*start = memparse(p + 1, &p);
+		return 0;
+	default:
+		/*
+		 * If w/o offset, only size specified, kaslr_boot_mem=nn[KMG]
+		 * has the same behaviour as kaslr_boot_mem=nn[KMG]@0. It means
+		 * the region starts from 0.
+		 */
+		*start = 0;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static void parse_kaslr_boot_mem_regions(char *str)
+{
+	static int i;
+
+	while (str && (i < MAX_KASLR_MEM_USABLE)) {
+		int rc;
+		unsigned long long start, size;
+		char *k = strchr(str, ',');
+
+		if (k)
+			*k++ = 0;
+
+		rc = parse_kaslr_boot_mem(str, &start, &size);
+		if (rc < 0)
+			break;
+		str = k;
+
+		mem_usable[i].start = start;
+		mem_usable[i].size = size;
+		i++;
+	}
+	num_usable_region = i;
+}
+
+static int handle_mem_filter(void)
 {
 	char *args = (char *)get_cmd_line_ptr();
 	size_t len = strlen((char *)args);
@@ -220,7 +284,8 @@ static int handle_mem_memmap(void)
 	char *param, *val;
 	u64 mem_size;
 
-	if (!strstr(args, "memmap=") && !strstr(args, "mem="))
+	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
+	    !strstr(args, "kaslr_boot_mem="))
 		return 0;
 
 	tmp_cmdline = malloc(len + 1);
@@ -245,6 +310,8 @@ static int handle_mem_memmap(void)
 
 		if (!strcmp(param, "memmap")) {
 			mem_avoid_memmap(val);
+		} else if (!strcmp(param, "kaslr_boot_mem")) {
+			parse_kaslr_boot_mem_regions(val);
 		} else if (!strcmp(param, "mem")) {
 			char *p = val;
 
@@ -384,7 +451,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	/* We don't need to set a mapping for setup_data. */
 
 	/* Mark the memmap regions we need to avoid */
-	handle_mem_memmap();
+	handle_mem_filter();
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
 	/* Make sure video RAM can be used. */
-- 
2.14.3

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDCDg1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 23:36:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41936 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751368AbeDCDgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 23:36:25 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="38478272"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <fanc.fnst@cn.fujitsu.com>,
        <indou.takao@jp.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [RESEND PATCH] x86/boot/KASLR: Extend movable_node option for KASLR
Date: Tue, 3 Apr 2018 11:36:12 +0800
Message-ID: <20180403033612.19925-1-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: BE64348AE922.A277B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The movable_node option is a boot-time switch to make sure the physical
NUMA nodes can be hot-added/removed when ACPI table can't be parsed to
provide the memory hotplug information.

As we all know, there is always one node, called "home node", which
can't be movabled and the kernel image resides in it. With movable_node
option, Linux allocates new early memorys near the kernel image to avoid
using the other movable node.

But, due to KASLR also can't get the the memory hotplug information, it may
randomize the kernel image into a movable node which breaks the rule of
movable_node option and makes the physical hot-add/remove operation failed.

The perfect solution is providing the memory hotplug information to KASLR.
But, it needs the efforts from hardware engineers and software engineers.

Here is an alternative method. Extend movable_node option to restrict kernel
to be randomized in the home node by adding a parameter. this parameter sets
up the boundaries between the home nodes and other nodes.

Reported-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Changelog:
  -Rewrite the commit log and document.

 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++--
 arch/x86/boot/compressed/kaslr.c                | 19 ++++++++++++++++---
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..0cfc0b10a117 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2353,7 +2353,8 @@
 	mousedev.yres=	[MOUSE] Vertical screen resolution, used for devices
 			reporting absolute coordinates, such as tablets
 
-	movablecore=nn[KMG]	[KNL,X86,IA-64,PPC] This parameter
+	movablecore=nn[KMG]
+			[KNL,X86,IA-64,PPC] This parameter
 			is similar to kernelcore except it specifies the
 			amount of memory used for migratable allocations.
 			If both kernelcore and movablecore is specified,
@@ -2363,12 +2364,19 @@
 			that the amount of memory usable for all allocations
 			is not too small.
 
-	movable_node	[KNL] Boot-time switch to make hotplugable memory
+	movable_node	[KNL] Boot-time switch to make hot-pluggable memory
 			NUMA nodes to be movable. This means that the memory
 			of such nodes will be usable only for movable
 			allocations which rules out almost all kernel
 			allocations. Use with caution!
 
+	movable_node=nn[KMG]
+			[KNL] Extend movable_node to make it work well with KASLR.
+			This parameter is the boundaries between the "home node" and
+			the other nodes. The "home node" is an immovable node and is
+			defined by BIOS. Set the 'nn' to the memory size of "home
+			node", the kernel image will be extracted in immovable nodes.
+
 	MTD_Partition=	[MTD]
 			Format: <name>,<region-number>,<size>,<offset>
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8199a6187251..f906d7890e69 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -92,7 +92,10 @@ struct mem_vector {
 static bool memmap_too_large;
 
 
-/* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
+/*
+ * Store memory limit specified by the following situations:
+ * "mem=nn[KMG]" or "memmap=nn[KMG]" or "movable_node=nn[KMG]"
+ */
 unsigned long long mem_limit = ULLONG_MAX;
 
 
@@ -214,7 +217,8 @@ static int handle_mem_memmap(void)
 	char *param, *val;
 	u64 mem_size;
 
-	if (!strstr(args, "memmap=") && !strstr(args, "mem="))
+	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
+		!strstr(args, "movable_node="))
 		return 0;
 
 	tmp_cmdline = malloc(len + 1);
@@ -249,7 +253,16 @@ static int handle_mem_memmap(void)
 				free(tmp_cmdline);
 				return -EINVAL;
 			}
-			mem_limit = mem_size;
+			mem_limit = mem_limit > mem_size ? mem_size : mem_limit;
+		} else if (!strcmp(param, "movable_node")) {
+			char *p = val;
+
+			mem_size = memparse(p, &p);
+			if (mem_size == 0) {
+				free(tmp_cmdline);
+				return -EINVAL;
+			}
+			mem_limit = mem_limit > mem_size ? mem_size : mem_limit;
 		}
 	}
 
-- 
2.14.3

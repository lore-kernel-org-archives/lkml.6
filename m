Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeCEAPo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 19:15:44 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42707 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbeCEAPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 19:15:40 -0500
X-Google-Smtp-Source: AG47ELulYi6M5YZXLNORf+WcFwEQmeMusy4HZ27n116RLBHqRmnJckcGC6/CLrHtNmk8nS09qX3MRQ==
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>, cpandya@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] of: add early boot allocation of of_find_node_by_phandle() cache
Date: Sun,  4 Mar 2018 16:14:49 -0800
Message-Id: <1520208889-3908-4-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
References: <1520208889-3908-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The initial implementation of the of_find_node_by_phandle() cache
allocates the cache using kcalloc().  Add an early boot allocation
of the cache so it will be usable during early boot.  Switch over
to the kcalloc() based cache once normal memory allocation
becomes available.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Changes from v4:
  - Add checks for memblock_virt_alloc() returning zero.

Changes from previous versions:
  - no changes

Version 5 adds checks for memblock_virt_alloc() returning zero.

kernel test robot reports 10 out of 10 boot failures on
qemu-system-x86_64 with "[PATCH v4 2/2] of: add early boot
allocation of of_find_node_by_phandle() cache" applied.

The failure appears to me to be due to memblock_virt_alloc() returning
zero.

kernel BUG at arch/x86/mm/physaddr.c:27
invalid opcode: 0000 [#1] PREEMPT PTI
CPU: 0 PID: 1 Comm: swapper Not tainted 4.16.0-rc1-00008-gb013aa4 #1
RIP: 0010:__phys_addr+0x39/0x50
RSP: 0000:ffff880018de3ee0 EFLAGS: 00010087
RAX: 0000780000000000 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 0000000080000000 RSI: ffffffff82e77239 RDI: 0000000000000000
RBP: ffff880018de3ee0 R08: 0000000000000000 R09: 0000000000000001
R10: 00000000000029cb R11: 63561fc2891644ad R12: 0000000000000286
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff8309b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000ffffffff CR3: 0000000003074000 CR4: 00000000000006f0
Call Trace:
of_core_init+0x30/0x21f
driver_init+0x36/0x38
kernel_init_freeable+0x82/0x19f
? rest_init+0x220/0x220
kernel_init+0xe/0x100
ret_from_fork+0x24/0x30

I'm not conversent in the x86 dialect of assembly, but it looks
like phandle_cache has the value zero, when calling __phys_addr():

==== the call from of_core_init() to __pa(phandle_cache) aka
__physaddr():

186		size = (phandle_cache_mask + 1) * sizeof(*phandle_cache);
   0xffffffff83334d35 <+27>:	mov    0x1771e1d(%rip),%eax        # 0xffffffff84aa6b58 <phandle_cache_mask>
   0xffffffff83334d42 <+40>:	lea    0x1(%rax),%r12d
   0xffffffff83334d4b <+49>:	shl    $0x3,%r12

187		memblock_free(__pa(phandle_cache), size);
   0xffffffff83334d3b <+33>:	mov    0x1771e1e(%rip),%rdi        # 0xffffffff84aa6b60 <phandle_cache>
   0xffffffff83334d46 <+44>:	callq  0xffffffff81049ad0 <__phys_addr>
   0xffffffff83334d4f <+53>:	mov    %rax,%rdi
   0xffffffff83334d52 <+56>:	mov    %r12,%rsi
   0xffffffff83334d55 <+59>:	callq  0xffffffff8334e45b <memblock_free>

188		phandle_cache = NULL;
   0xffffffff83334d64 <+74>:	movq   $0x0,0x1771df1(%rip)        # 0xffffffff84aa6b60 <phandle_cache>

==== __pa():

(gdb) disass /m __phys_addr
Dump of assembler code for function __phys_addr:
15	{
   0xffffffff81049ad0 <+0>:	callq  0xffffffff822018e0 <__fentry__>
   0xffffffff81049ad5 <+5>:	push   %rbp
   0xffffffff81049ade <+14>:	mov    %rsp,%rbp

16		unsigned long y = x - __START_KERNEL_map;
   0xffffffff81049ad6 <+6>:	mov    $0x80000000,%eax

17
18		/* use the carry flag to determine if x was < __START_KERNEL_map */
19		if (unlikely(x > y)) {
   0xffffffff81049adb <+11>:	add    %rdi,%rax
   0xffffffff81049ae1 <+17>:	mov    %rax,%rdx
   0xffffffff81049ae4 <+20>:	jae    0xffffffff81049af8 <__phys_addr+40>

20			x = y + phys_base;
   0xffffffff81049ae6 <+22>:	add    0x1e30523(%rip),%rax        # 0xffffffff82e7a010

21
22			VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);
   0xffffffff81049aed <+29>:	cmp    $0x1fffffff,%rdx
   0xffffffff81049af4 <+36>:	jbe    0xffffffff81049b1e <__phys_addr+78>
   0xffffffff81049af6 <+38>:	ud2

23		} else {
24			x = y + (__START_KERNEL_map - PAGE_OFFSET);
   0xffffffff81049af8 <+40>:	movabs $0x780000000000,%rax
   0xffffffff81049b02 <+50>:	add    %rdi,%rax

25
26			/* carry flag will be set if starting x was >= PAGE_OFFSET */
27			VIRTUAL_BUG_ON((x > y) || !phys_addr_valid(x));
   0xffffffff81049b05 <+53>:	cmp    %rax,%rdx
   0xffffffff81049b08 <+56>:	jb     0xffffffff81049b1c <__phys_addr+76>
   0xffffffff81049b17 <+71>:	test   %rdx,%rdx
   0xffffffff81049b1a <+74>:	je     0xffffffff81049b1e <__phys_addr+78>
   0xffffffff81049b1c <+76>:	ud2

28		}
29
30		return x;
31	}
   0xffffffff81049b1e <+78>:	pop    %rbp
   0xffffffff81049b1f <+79>:	retq


 drivers/of/base.c       | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/of/fdt.c        |  2 ++
 drivers/of/of_private.h |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index e71d157d7149..48714d8e0bc9 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -16,9 +16,11 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/bootmem.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/cpu.h>
+#include <linux/memblock.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -134,6 +136,32 @@ static void of_populate_phandle_cache(void)
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
+void __init of_populate_phandle_cache_early(void)
+{
+	u32 cache_entries;
+	struct device_node *np;
+	u32 phandles = 0;
+	size_t size;
+
+	for_each_of_allnodes(np)
+		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
+			phandles++;
+
+	cache_entries = roundup_pow_of_two(phandles);
+	phandle_cache_mask = cache_entries - 1;
+
+	size = cache_entries * sizeof(*phandle_cache);
+	phandle_cache = memblock_virt_alloc(size, 4);
+	if (!phandle_cache)
+		return;
+
+	memset(phandle_cache, 0, size);
+
+	for_each_of_allnodes(np)
+		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
+			phandle_cache[np->phandle & phandle_cache_mask] = np;
+}
+
 #ifndef CONFIG_MODULES
 static int __init of_free_phandle_cache(void)
 {
@@ -153,7 +181,17 @@ static int __init of_free_phandle_cache(void)
 
 void __init of_core_init(void)
 {
+	unsigned long flags;
 	struct device_node *np;
+	phys_addr_t size;
+
+	if (phandle_cache) {
+		raw_spin_lock_irqsave(&devtree_lock, flags);
+		size = (phandle_cache_mask + 1) * sizeof(*phandle_cache);
+		memblock_free(__pa(phandle_cache), size);
+		phandle_cache = NULL;
+		raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	}
 
 	of_populate_phandle_cache();
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 84aa9d676375..cb320df23f26 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1264,6 +1264,8 @@ void __init unflatten_device_tree(void)
 	of_alias_scan(early_init_dt_alloc_memory_arch);
 
 	unittest_unflatten_overlay_base();
+
+	of_populate_phandle_cache_early();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index fa70650136b4..6720448c84cc 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -134,6 +134,8 @@ extern void __of_sysfs_remove_bin_file(struct device_node *np,
 /* illegal phandle value (set when unresolved) */
 #define OF_PHANDLE_ILLEGAL	0xdeadbeef
 
+extern void __init of_populate_phandle_cache_early(void);
+
 /* iterators for transactions, used for overlays */
 /* forward iterator */
 #define for_each_transaction_entry(_oft, _te) \
-- 
Frank Rowand <frank.rowand@sony.com>

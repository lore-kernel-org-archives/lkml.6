Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCFC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E15C20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="c3wRclJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E15C20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeKATBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:01:44 -0400
Received: from mail.efficios.com ([167.114.142.138]:41054 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbeKATBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:01:44 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DF50E227654;
        Thu,  1 Nov 2018 05:59:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id a77V0K7FUJSC; Thu,  1 Nov 2018 05:59:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 65171227650;
        Thu,  1 Nov 2018 05:59:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 65171227650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1541066365;
        bh=gFEK/lC/jUbqNWiuQ/zKOEooKr/O6Cn2r+UjhLPcrA8=;
        h=From:To:Date:Message-Id;
        b=c3wRclJF8yvQa4S9Yx11D49t9F7R82VpT0emvy7FVrO96lxovQtiQa5JTsVbXCDtG
         7tps24c8vtgRt+VC744jPgOa4JVay/p27Qrk5z9a4frakyvYF4PnBDLX0pb6Upq9RB
         ibttjPmcQV/i2bgyZRlQJkXJy9RdqrtS4kbacUvR9SoCzFelYfPeG/GHYZ9/VkWizu
         kNVuuWC8lxiYihMn+QVdEzdWQFvpaAScBazBZlYwUGCwTGfWT2gYxP+Rp+8DIOmWgv
         ypjahiAncvH9cl36QTSR85HBTgHKuZILGAstB3LpqaxB2lBYrtfMAFKU/HW3tkpfuB
         ckcMi5zI/X4eg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Bg3boQxWXxpO; Thu,  1 Nov 2018 05:59:25 -0400 (EDT)
Received: from thinkos.etherlink (sessfw99-sesbfw99-92.ericsson.net [192.176.1.92])
        by mail.efficios.com (Postfix) with ESMTPSA id 375F2227620;
        Thu,  1 Nov 2018 05:59:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.21 04/16] mm: Introduce vm_map_user_ram, vm_unmap_user_ram (v2)
Date:   Thu,  1 Nov 2018 10:58:32 +0100
Message-Id: <20181101095844.24462-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
References: <20181101095844.24462-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create and destroy mappings aliased to a user-space mapping with the same
cache coloring as the userspace mapping. Allow the kernel to load from
and store to pages shared with user-space through its own mapping in
kernel virtual addresses while ensuring cache conherency between kernel
and userspace mappings for virtually aliased architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Paul Turner <pjt@google.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andi Kleen <andi@firstfloor.org>
CC: Dave Watson <davejwatson@fb.com>
CC: Chris Lameter <cl@linux.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ben Maurer <bmaurer@fb.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Russell King <linux@arm.linux.org.uk>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
---
Changes since v1:
- Use WARN_ON() rather than BUG_ON().
---
 include/linux/vmalloc.h |  4 +++
 mm/vmalloc.c            | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 398e9c95cd61..899657b3d469 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -59,6 +59,10 @@ struct vmap_area {
 extern void vm_unmap_ram(const void *mem, unsigned int count);
 extern void *vm_map_ram(struct page **pages, unsigned int count,
 				int node, pgprot_t prot);
+extern void vm_unmap_user_ram(const void *mem, unsigned int count);
+extern void *vm_map_user_ram(struct page **pages, unsigned int count,
+				unsigned long uaddr, int node, pgprot_t prot);
+
 extern void vm_unmap_aliases(void);
 
 #ifdef CONFIG_MMU
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a236bac872f0..8df3c572036c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1188,6 +1188,72 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
 }
 EXPORT_SYMBOL(vm_map_ram);
 
+/**
+ * vm_unmap_user_ram - unmap linear kernel address space set up by vm_map_user_ram
+ * @mem: the pointer returned by vm_map_user_ram
+ * @count: the count passed to that vm_map_user_ram call (cannot unmap partial)
+ */
+void vm_unmap_user_ram(const void *mem, unsigned int count)
+{
+	unsigned long size = (unsigned long)count << PAGE_SHIFT;
+	unsigned long addr = (unsigned long)mem;
+	struct vmap_area *va;
+
+	might_sleep();
+	if (WARN_ON(!addr) ||
+	    WARN_ON(addr < VMALLOC_START) ||
+	    WARN_ON(addr > VMALLOC_END) ||
+	    WARN_ON(!PAGE_ALIGNED(addr)))
+		return;
+
+	debug_check_no_locks_freed(mem, size);
+	va = find_vmap_area(addr);
+	if (WARN_ON(!va))
+		return;
+	free_unmap_vmap_area(va);
+}
+EXPORT_SYMBOL(vm_unmap_user_ram);
+
+/**
+ * vm_map_user_ram - map user space pages linearly into kernel virtual address
+ * @pages: an array of pointers to the virtually contiguous pages to be mapped
+ * @count: number of pages
+ * @uaddr: address within the first page in the userspace mapping
+ * @node: prefer to allocate data structures on this node
+ * @prot: memory protection to use. PAGE_KERNEL for regular RAM
+ *
+ * Create a mapping aliased to a user-space mapping with the same cache
+ * coloring as the userspace mapping. Allow the kernel to load from and
+ * store to pages shared with user-space through its own mapping in kernel
+ * virtual addresses while ensuring cache conherency between kernel and
+ * userspace mappings for virtually aliased architectures.
+ *
+ * Returns: a pointer to the address that has been mapped, or %NULL on failure
+ */
+void *vm_map_user_ram(struct page **pages, unsigned int count,
+		unsigned long uaddr, int node, pgprot_t prot)
+{
+	unsigned long size = (unsigned long)count << PAGE_SHIFT;
+	unsigned long va_offset = ALIGN_DOWN(uaddr, PAGE_SIZE) & (SHMLBA - 1);
+	unsigned long alloc_size = ALIGN(va_offset + size, SHMLBA);
+	struct vmap_area *va;
+	unsigned long addr;
+	void *mem;
+
+	va = alloc_vmap_area(alloc_size, SHMLBA, VMALLOC_START, VMALLOC_END,
+			node, GFP_KERNEL);
+	if (IS_ERR(va))
+		return NULL;
+	addr = va->va_start + va_offset;
+	mem = (void *)addr;
+	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
+		vm_unmap_user_ram(mem, count);
+		return NULL;
+	}
+	return mem;
+}
+EXPORT_SYMBOL(vm_map_user_ram);
+
 static struct vm_struct *vmlist __initdata;
 /**
  * vm_area_add_early - add vmap area early during boot
-- 
2.11.0


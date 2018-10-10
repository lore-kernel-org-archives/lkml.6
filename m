Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92217C46462
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C392082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vB1mpn4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C392082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJKCnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:43:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:32890 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJKCnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:41 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C7C9B183B82;
        Wed, 10 Oct 2018 15:20:07 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id SvxrZ4pdMk3b; Wed, 10 Oct 2018 15:20:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4E2B8183B7E;
        Wed, 10 Oct 2018 15:20:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4E2B8183B7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199207;
        bh=mJM93KP006rhOnrNxcep+TBt964ZEP4ES2TiYXSRFJc=;
        h=From:To:Date:Message-Id;
        b=vB1mpn4EEonJYNebCDGgHkcUzRttDB7rYCW7JjXgihO8AbnRz0C7Ldp1wPQGhy6qh
         n/AcNGCe8mglpuggIPQAp32LJ0cmkFC/NksnLJj3QWsZ1w4qf9WWYkJlmU4NVWFKN4
         TEk0HjtaYp5vtzUNW7MTgOa/b7ARUSNp8Oin2Sjn3XfFJQBoh0izknnE/5I7a09KvX
         5v/CrIt22F35BW4MpTy1x/VKIsqH4VaYx5XkTnbhAjKsnPIrJp5h40J89ZIR+t6cr8
         0b/Ien38Biu7OZp0dNhSqiVsfDmkrSyVWnBg4q67T0mGVZsdDJ08S9viq2SesxIVtw
         YE6n6FP+c8vKQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id lVycwN8FsDQI; Wed, 10 Oct 2018 15:20:07 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 295FC183B5F;
        Wed, 10 Oct 2018 15:20:06 -0400 (EDT)
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
Subject: [RFC PATCH for 4.21 04/16] mm: Introduce vm_map_user_ram, vm_unmap_user_ram
Date:   Wed, 10 Oct 2018 15:19:24 -0400
Message-Id: <20181010191936.7495-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
References: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
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
 include/linux/vmalloc.h |  4 ++++
 mm/vmalloc.c            | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

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
index a728fc492557..a86bf550b027 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1186,6 +1186,70 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
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
+	BUG_ON(!addr);
+	BUG_ON(addr < VMALLOC_START);
+	BUG_ON(addr > VMALLOC_END);
+	BUG_ON(!PAGE_ALIGNED(addr));
+
+	debug_check_no_locks_freed(mem, size);
+	va = find_vmap_area(addr);
+	BUG_ON(!va);
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


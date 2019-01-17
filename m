Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBDBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1A820657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJl9vFuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfAQM5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:57:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfAQM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AaYyNEv5GeetB7VwBqm33QqUsVQc8q6zDyWJKxNNuHU=; b=NJl9vFuCUhcM1NxAOMsz9nuq8
        HQfZ53BRYqY7gz8Vx3q/rkd6B9KvKlRTPn9PaU934PZqVOQqHl8UIzNScHbqc/7iVqWzbatEbwees
        orfg/+KpP0gRBB9e1I5WZn0F1fbSynetrhcuGKAlmx/znb+HSjzpmcjsbCVK1RViCTPuAj+tn4Dsi
        8LDBEpM2NlejPjdwKZ8c+cd+BjynzeH5n5ctlTJ7YBCB4i8r9ET1Y0e8uS1vmnyf5NOdVk4pHtyOs
        wHOs9IxHTeJ0SRjXxUbsg/onuM7No/xFUChaUXJrW2xkQRRWv7+NL7vkoiQDK1yrkqf2DowgTey/4
        b63Uz4IeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk7E7-0002B9-4y; Thu, 17 Jan 2019 12:56:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F5A7202647CE; Thu, 17 Jan 2019 13:56:53 +0100 (CET)
Date:   Thu, 17 Jan 2019 13:56:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        acme@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, dsahern@gmail.com,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v10 perf, bpf-next 1/9] perf, bpf: Introduce
 PERF_RECORD_KSYMBOL
Message-ID: <20190117125653.GF10486@hirez.programming.kicks-ass.net>
References: <20190116162931.1542429-1-songliubraving@fb.com>
 <20190116162931.1542429-2-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20190116162931.1542429-2-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 16, 2019 at 08:29:23AM -0800, Song Liu wrote:
> For better performance analysis of dynamically JITed and loaded kernel
> functions, such as BPF programs, this patch introduces
> PERF_RECORD_KSYMBOL, a new perf_event_type that exposes kernel symbol
> register/unregister information to user space.
> 
> The following data structure is used for PERF_RECORD_KSYMBOL.
> 
>     /*
>      * struct {
>      *      struct perf_event_header        header;
>      *      u64                             addr;
>      *      u32                             len;
>      *      u16                             ksym_type;
>      *      u16                             flags;
>      *      char                            name[];
>      *      struct sample_id                sample_id;
>      * };
>      */

So I've cobbled together the attached patches to see how it would work
out..

I didn't convert ftrace trampolines; because ftrace code has this
uncanny ability to make my head hurt. But I don't think it should be
hard, once one figures out the right structure to stick that
kallsym_node thing in (ftrace_ops ?!).

It is compiled only, so no testing what so ever (also, no changelogs).

I didn't wire up the KSYM_TYPE thing; I'm wondering if we really need
that, OTOH it really doesn't hurt having it either.

One weird thing I noticed, wth does bpf_prog_kallsyms_add() check
CAP_ADMIN ?! Surely even a non-priv JIT'ed program generates symbols,
why hide those?

Anyway; with the one nit about the get_names() thing sorted:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

(thanks for sticking with this)

--sdtB3X0nJg68CQEu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-latch-next.patch"

Subject: 
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan 17 11:41:01 CET 2019



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rbtree_latch.h |   48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -211,4 +211,52 @@ latch_tree_find(void *key, struct latch_
 	return node;
 }
 
+static __always_inline struct latch_tree_node *
+latch_tree_first(struct latch_tree_root *root)
+{
+	struct latch_tree_node *ltn = NULL;
+	struct rb_node *node;
+	unsigned int seq;
+
+	do {
+		struct rb_root *rbr;
+
+		seq = raw_read_seqcount_latch(&root->seq);
+		rbr = &root->tree[seq & 1];
+		node = rb_first(rbr);
+	} while (read_seqcount_retry(&root->seq, seq));
+
+	if (node)
+		ltn = __lt_from_rb(node, seq & 1);
+
+	return ltn;
+}
+
+/**
+ * latch_tree_next() - find the next @ltn in @root per sort order
+ * @root: trees to which @ltn belongs
+ * @ltn: nodes to start from
+ *
+ * Does a lockless lookup in the trees @root for the next node starting at
+ * @ltn.
+ *
+ * Using this function outside of the write side lock is rather dodgy but given
+ * latch_tree_erase() doesn't re-init the nodes and the whole iteration is done
+ * under a single RCU critical section, it should be non-fatal and generate some
+ * semblance of order - albeit possibly missing chunks of the tree.
+ */
+static __always_inline struct latch_tree_node *
+latch_tree_next(struct latch_tree_root *root, struct latch_tree_node *ltn)
+{
+	struct rb_node *node;
+	unsigned int seq;
+
+	do {
+		seq = raw_read_seqcount_latch(&root->seq);
+		node = rb_next(&ltn->node[seq & 1]);
+	} while (read_seqcount_retry(&root->seq, seq));
+
+	return __lt_from_rb(node, seq & 1);
+}
+
 #endif /* RB_TREE_LATCH_H */

--sdtB3X0nJg68CQEu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-kallsym.patch"

Subject: 
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan 17 11:18:21 CET 2019



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/kallsyms.h |   14 +++
 kernel/extable.c         |    2 
 kernel/kallsyms.c        |  187 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 202 insertions(+), 1 deletion(-)

--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -11,6 +11,7 @@
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/rbtree_latch.h>
 
 #include <asm/sections.h>
 
@@ -20,6 +21,19 @@
 
 struct module;
 
+struct kallsym_node
+{
+	struct latch_tree_node kn_node;
+	unsigned long kn_addr;
+	unsigned long kn_len;
+	void (*kn_names)(struct kallsym_node *kn, char *sym_name, char **mod_name);
+};
+
+extern void kallsym_tree_add(struct kallsym_node *kn);
+extern void kallsym_tree_del(struct kallsym_node *kn);
+
+extern bool is_kallsym_tree_text_address(unsigned long addr);
+
 static inline int is_kernel_inittext(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -145,6 +145,8 @@ int kernel_text_address(unsigned long ad
 
 	if (is_module_text_address(addr))
 		goto out;
+	if (is_kallsym_tree_text_address(addr))
+		goto out;
 	if (is_ftrace_trampoline(addr))
 		goto out;
 	if (is_kprobe_optinsn_slot(addr) || is_kprobe_insn_slot(addr))
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -24,6 +24,8 @@
 #include <linux/filter.h>
 #include <linux/ftrace.h>
 #include <linux/compiler.h>
+#include <linux/spinlock.h>
+#include <linux/perf_event.h>
 
 /*
  * These will be re-linked against their real values
@@ -48,6 +50,164 @@ extern const u16 kallsyms_token_index[]
 
 extern const unsigned int kallsyms_markers[] __weak;
 
+static DEFINE_SPINLOCK(kallsym_lock);
+static struct latch_tree_root kallsym_tree __cacheline_aligned;
+
+static __always_inline unsigned long
+kallsym_node_addr(struct latch_tree_node *node)
+{
+	return ((struct kallsym_node *)node)->kn_addr;
+}
+
+static __always_inline bool kallsym_tree_less(struct latch_tree_node *a,
+					      struct latch_tree_node *b)
+{
+	return kallsym_node_addr(a) < kallsym_node_addr(b);
+}
+
+static __always_inline int kallsym_tree_comp(void *key,
+					     struct latch_tree_node *n)
+{
+	unsigned long val = (unsigned long)key;
+	unsigned long sym_start, sym_end;
+	const struct kallsym_node *kn;
+
+	kn = container_of(n, struct kallsym_node, kn_node);
+	sym_start = kn->kn_addr;
+	sym_end = sym_start + kn->kn_len;
+
+	if (val < sym_start)
+		return -1;
+	if (val >= sym_end)
+		return 1;
+
+	return 0;
+}
+
+static const struct latch_tree_ops kallsym_tree_ops = {
+	.less = kallsym_tree_less,
+	.comp = kallsym_tree_comp,
+};
+
+void kallsym_tree_add(struct kallsym_node *kn)
+{
+	char namebuf[KSYM_NAME_LEN] = "";
+	char *modname = NULL;
+
+	spin_lock_irq(&kallsym_lock);
+	latch_tree_insert(&kn->kn_node, &kallsym_tree, &kallsym_tree_ops);
+	spin_unlock_irq(&kallsym_lock);
+
+	kn->kn_names(kn, namebuf, &modname);
+
+	if (modname) {
+		int len = strlen(namebuf);
+
+		snprintf(namebuf + len, sizeof(namebuf) - len, " [%s]", modname);
+	}
+
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_UNKNOWN,
+			   kn->kn_addr, kn->kn_len, false, namebuf);
+}
+
+void kallsym_tree_del(struct kallsym_node *kn)
+{
+	char namebuf[KSYM_NAME_LEN] = "";
+	char *modname = NULL;
+
+	kn->kn_names(kn, namebuf, &modname);
+
+	if (modname) {
+		int len = strlen(namebuf);
+
+		snprintf(namebuf + len, sizeof(namebuf) - len, " [%s]", modname);
+	}
+
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_UNKNOWN,
+			   kn->kn_addr, kn->kn_len, true, namebuf);
+
+	spin_lock_irq(&kallsym_lock);
+	latch_tree_erase(&kn->kn_node, &kallsym_tree, &kallsym_tree_ops);
+	spin_unlock_irq(&kallsym_lock);
+}
+
+static struct kallsym_node *kallsym_tree_find(unsigned long addr)
+{
+	struct kallsym_node *kn = NULL;
+	struct latch_tree_node *n;
+
+	n = latch_tree_find((void *)addr, &kallsym_tree, &kallsym_tree_ops);
+	if (n)
+		kn = container_of(n, struct kallsym_node, kn_node);
+
+	return kn;
+}
+
+static char *kallsym_tree_address_lookup(unsigned long addr, unsigned long *size,
+					 unsigned long *off, char **modname, char *sym)
+{
+	struct kallsym_node *kn;
+	char *ret = NULL;
+
+	rcu_read_lock();
+	kn = kallsym_tree_find(addr);
+	if (kn) {
+		kn->kn_names(kn, sym, modname);
+
+		ret = sym;
+		if (size)
+			*size = kn->kn_len;
+		if (off)
+			*off = addr - kn->kn_addr;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+bool is_kallsym_tree_text_address(unsigned long addr)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = kallsym_tree_find(addr) != NULL;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int kallsym_tree_kallsym(unsigned int symnum, unsigned long *value, char *type,
+				char *sym, char *modname, int *exported)
+{
+	struct latch_tree_node *ltn;
+	int i, ret = -ERANGE;
+
+	rcu_read_lock();
+	for (i = 0, ltn = latch_tree_first(&kallsym_tree); i < symnum && ltn;
+	     i++, ltn = latch_tree_next(&kallsym_tree, ltn))
+		;
+
+	if (ltn) {
+		struct kallsym_node *kn;
+		char *mod;
+
+		kn = container_of(ltn, struct kallsym_node, kn_node);
+
+		kn->kn_names(kn, sym, &mod);
+		if (mod)
+			strlcpy(modname, mod, MODULE_NAME_LEN);
+		else
+			modname[0] = '\0';
+
+		*type = 't';
+		*exported = 0;
+		ret = 0;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
 /*
  * Expand a compressed symbol data into the resulting uncompressed string,
  * if uncompressed string is too long (>= maxlen), it will be truncated,
@@ -265,6 +425,7 @@ int kallsyms_lookup_size_offset(unsigned
 	if (is_ksym_addr(addr))
 		return !!get_symbol_pos(addr, symbolsize, offset);
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
+	       !!kallsym_tree_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
@@ -301,6 +462,10 @@ const char *kallsyms_lookup(unsigned lon
 	ret = module_address_lookup(addr, symbolsize, offset,
 				    modname, namebuf);
 	if (!ret)
+		ret = kallsym_tree_address_lookup(addr, symbolsize,
+						  offset, modname, namebuf);
+
+	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
 					 offset, modname, namebuf);
 
@@ -434,6 +599,7 @@ struct kallsym_iter {
 	loff_t pos;
 	loff_t pos_arch_end;
 	loff_t pos_mod_end;
+	loff_t pos_tree_end;
 	loff_t pos_ftrace_mod_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
@@ -478,9 +644,24 @@ static int get_ksymbol_mod(struct kallsy
 	return 1;
 }
 
+static int get_ksymbol_tree(struct kallsym_iter *iter)
+{
+	int ret = kallsym_tree_kallsym(iter->pos - iter->pos_mod_end,
+				       &iter->value, &iter->type,
+				       iter->name, iter->module_name,
+				       &iter->exported);
+
+	if (ret < 0) {
+		iter->pos_tree_end = iter->pos;
+		return 0;
+	}
+
+	return 1;
+}
+
 static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 {
-	int ret = ftrace_mod_get_kallsym(iter->pos - iter->pos_mod_end,
+	int ret = ftrace_mod_get_kallsym(iter->pos - iter->pos_tree_end,
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
@@ -545,6 +726,10 @@ static int update_iter_mod(struct kallsy
 	    get_ksymbol_mod(iter))
 		return 1;
 
+	if ((!iter->pos_tree_end || iter->pos_tree_end > pos) &&
+	    get_ksymbol_tree(iter))
+		return 1;
+
 	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
 	    get_ksymbol_ftrace_mod(iter))
 		return 1;

--sdtB3X0nJg68CQEu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="peterz-kallsym-bpf.patch"

Subject: 
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Jan 17 13:19:25 CET 2019



Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/bpf.h    |    7 +-
 include/linux/filter.h |   42 ------------
 kernel/bpf/core.c      |  164 ++++---------------------------------------------
 kernel/extable.c       |    4 -
 kernel/kallsyms.c      |   19 -----
 5 files changed, 22 insertions(+), 214 deletions(-)

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -13,7 +13,7 @@
 #include <linux/file.h>
 #include <linux/percpu.h>
 #include <linux/err.h>
-#include <linux/rbtree_latch.h>
+#include <linux/kallsyms.h>
 #include <linux/numa.h>
 #include <linux/wait.h>
 
@@ -307,8 +307,9 @@ struct bpf_prog_aux {
 	bool offload_requested;
 	struct bpf_prog **func;
 	void *jit_data; /* JIT specific data. arch dependent */
-	struct latch_tree_node ksym_tnode;
-	struct list_head ksym_lnode;
+
+	struct kallsym_node ktn;
+
 	const struct bpf_prog_ops *ops;
 	struct bpf_map **used_maps;
 	struct bpf_prog *prog;
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -932,23 +932,6 @@ static inline bool bpf_jit_kallsyms_enab
 	return false;
 }
 
-const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
-				 unsigned long *off, char *sym);
-bool is_bpf_text_address(unsigned long addr);
-int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-		    char *sym);
-
-static inline const char *
-bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
-{
-	const char *ret = __bpf_address_lookup(addr, size, off, sym);
-
-	if (ret && modname)
-		*modname = NULL;
-	return ret;
-}
-
 void bpf_prog_kallsyms_add(struct bpf_prog *fp);
 void bpf_prog_kallsyms_del(struct bpf_prog *fp);
 
@@ -974,31 +957,6 @@ static inline bool bpf_jit_kallsyms_enab
 	return false;
 }
 
-static inline const char *
-__bpf_address_lookup(unsigned long addr, unsigned long *size,
-		     unsigned long *off, char *sym)
-{
-	return NULL;
-}
-
-static inline bool is_bpf_text_address(unsigned long addr)
-{
-	return false;
-}
-
-static inline int bpf_get_kallsym(unsigned int symnum, unsigned long *value,
-				  char *type, char *sym)
-{
-	return -ERANGE;
-}
-
-static inline const char *
-bpf_address_lookup(unsigned long addr, unsigned long *size,
-		   unsigned long *off, char **modname, char *sym)
-{
-	return NULL;
-}
-
 static inline void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
 }
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -30,7 +30,6 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/frame.h>
-#include <linux/rbtree_latch.h>
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
 #include <linux/perf_event.h>
@@ -100,8 +99,6 @@ struct bpf_prog *bpf_prog_alloc(unsigned
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 
-	INIT_LIST_HEAD_RCU(&fp->aux->ksym_lnode);
-
 	return fp;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_alloc);
@@ -530,86 +527,35 @@ static void bpf_get_prog_name(const stru
 		*sym = 0;
 }
 
-static __always_inline unsigned long
-bpf_get_prog_addr_start(struct latch_tree_node *n)
-{
-	unsigned long symbol_start, symbol_end;
-	const struct bpf_prog_aux *aux;
-
-	aux = container_of(n, struct bpf_prog_aux, ksym_tnode);
-	bpf_get_prog_addr_region(aux->prog, &symbol_start, &symbol_end);
-
-	return symbol_start;
-}
-
-static __always_inline bool bpf_tree_less(struct latch_tree_node *a,
-					  struct latch_tree_node *b)
-{
-	return bpf_get_prog_addr_start(a) < bpf_get_prog_addr_start(b);
-}
-
-static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
-{
-	unsigned long val = (unsigned long)key;
-	unsigned long symbol_start, symbol_end;
-	const struct bpf_prog_aux *aux;
-
-	aux = container_of(n, struct bpf_prog_aux, ksym_tnode);
-	bpf_get_prog_addr_region(aux->prog, &symbol_start, &symbol_end);
-
-	if (val < symbol_start)
-		return -1;
-	if (val >= symbol_end)
-		return  1;
-
-	return 0;
-}
-
-static const struct latch_tree_ops bpf_tree_ops = {
-	.less	= bpf_tree_less,
-	.comp	= bpf_tree_comp,
-};
-
-static DEFINE_SPINLOCK(bpf_lock);
-static LIST_HEAD(bpf_kallsyms);
-static struct latch_tree_root bpf_tree __cacheline_aligned;
-
-static void bpf_prog_ksym_node_add(struct bpf_prog_aux *aux)
-{
-	WARN_ON_ONCE(!list_empty(&aux->ksym_lnode));
-	list_add_tail_rcu(&aux->ksym_lnode, &bpf_kallsyms);
-	latch_tree_insert(&aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
-}
-
-static void bpf_prog_ksym_node_del(struct bpf_prog_aux *aux)
-{
-	if (list_empty(&aux->ksym_lnode))
-		return;
-
-	latch_tree_erase(&aux->ksym_tnode, &bpf_tree, &bpf_tree_ops);
-	list_del_rcu(&aux->ksym_lnode);
-}
 
 static bool bpf_prog_kallsyms_candidate(const struct bpf_prog *fp)
 {
 	return fp->jited && !bpf_prog_was_classic(fp);
 }
 
-static bool bpf_prog_kallsyms_verify_off(const struct bpf_prog *fp)
+static void bpf_kn_names(struct kallsym_node *kn, char *sym, char **modname)
 {
-	return list_empty(&fp->aux->ksym_lnode) ||
-	       fp->aux->ksym_lnode.prev == LIST_POISON2;
+	struct bpf_prog_aux *aux = container_of(kn, struct bpf_prog_aux, ktn);
+
+	*modname = "eBPF-jit";
+	bpf_get_prog_name(aux->prog, sym);
 }
 
 void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 {
+	unsigned long sym_start, sym_end;
+
 	if (!bpf_prog_kallsyms_candidate(fp) ||
 	    !capable(CAP_SYS_ADMIN))
 		return;
 
-	spin_lock_bh(&bpf_lock);
-	bpf_prog_ksym_node_add(fp->aux);
-	spin_unlock_bh(&bpf_lock);
+	bpf_get_prog_addr_region(fp, &sym_start, &sym_end);
+
+	fp->aux->ktn.kn_addr = sym_start;
+	fp->aux->ktn.kn_len = sym_end - sym_start;
+	fp->aux->ktn.kn_names = bpf_kn_names;
+
+	kallsym_tree_add(&fp->aux->ktn);
 }
 
 void bpf_prog_kallsyms_del(struct bpf_prog *fp)
@@ -617,85 +563,7 @@ void bpf_prog_kallsyms_del(struct bpf_pr
 	if (!bpf_prog_kallsyms_candidate(fp))
 		return;
 
-	spin_lock_bh(&bpf_lock);
-	bpf_prog_ksym_node_del(fp->aux);
-	spin_unlock_bh(&bpf_lock);
-}
-
-static struct bpf_prog *bpf_prog_kallsyms_find(unsigned long addr)
-{
-	struct latch_tree_node *n;
-
-	if (!bpf_jit_kallsyms_enabled())
-		return NULL;
-
-	n = latch_tree_find((void *)addr, &bpf_tree, &bpf_tree_ops);
-	return n ?
-	       container_of(n, struct bpf_prog_aux, ksym_tnode)->prog :
-	       NULL;
-}
-
-const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
-				 unsigned long *off, char *sym)
-{
-	unsigned long symbol_start, symbol_end;
-	struct bpf_prog *prog;
-	char *ret = NULL;
-
-	rcu_read_lock();
-	prog = bpf_prog_kallsyms_find(addr);
-	if (prog) {
-		bpf_get_prog_addr_region(prog, &symbol_start, &symbol_end);
-		bpf_get_prog_name(prog, sym);
-
-		ret = sym;
-		if (size)
-			*size = symbol_end - symbol_start;
-		if (off)
-			*off  = addr - symbol_start;
-	}
-	rcu_read_unlock();
-
-	return ret;
-}
-
-bool is_bpf_text_address(unsigned long addr)
-{
-	bool ret;
-
-	rcu_read_lock();
-	ret = bpf_prog_kallsyms_find(addr) != NULL;
-	rcu_read_unlock();
-
-	return ret;
-}
-
-int bpf_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-		    char *sym)
-{
-	struct bpf_prog_aux *aux;
-	unsigned int it = 0;
-	int ret = -ERANGE;
-
-	if (!bpf_jit_kallsyms_enabled())
-		return ret;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(aux, &bpf_kallsyms, ksym_lnode) {
-		if (it++ != symnum)
-			continue;
-
-		bpf_get_prog_name(aux->prog, sym);
-
-		*value = (unsigned long)aux->prog->bpf_func;
-		*type  = BPF_SYM_ELF_TYPE;
-
-		ret = 0;
-		break;
-	}
-	rcu_read_unlock();
-
-	return ret;
+	kallsym_tree_del(&fp->aux->ktn);
 }
 
 static atomic_long_t bpf_jit_current;
@@ -806,8 +674,6 @@ void __weak bpf_jit_free(struct bpf_prog
 
 		bpf_jit_binary_unlock_ro(hdr);
 		bpf_jit_binary_free(hdr);
-
-		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
 
 	bpf_prog_unlock_free(fp);
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -135,7 +135,7 @@ int kernel_text_address(unsigned long ad
 	 * coming back from idle, or cpu on or offlining.
 	 *
 	 * is_module_text_address() as well as the kprobe slots
-	 * and is_bpf_text_address() require RCU to be watching.
+	 * and is_kallsym_tree_text_address() require RCU to be watching.
 	 */
 	no_rcu = !rcu_is_watching();
 
@@ -151,8 +151,6 @@ int kernel_text_address(unsigned long ad
 		goto out;
 	if (is_kprobe_optinsn_slot(addr) || is_kprobe_insn_slot(addr))
 		goto out;
-	if (is_bpf_text_address(addr))
-		goto out;
 	ret = 0;
 out:
 	if (no_rcu)
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -425,8 +425,7 @@ int kallsyms_lookup_size_offset(unsigned
 	if (is_ksym_addr(addr))
 		return !!get_symbol_pos(addr, symbolsize, offset);
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
-	       !!kallsym_tree_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
-	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
+	       !!kallsym_tree_address_lookup(addr, symbolsize, offset, NULL, namebuf);
 }
 
 /*
@@ -464,11 +463,6 @@ const char *kallsyms_lookup(unsigned lon
 	if (!ret)
 		ret = kallsym_tree_address_lookup(addr, symbolsize,
 						  offset, modname, namebuf);
-
-	if (!ret)
-		ret = bpf_address_lookup(addr, symbolsize,
-					 offset, modname, namebuf);
-
 	if (!ret)
 		ret = ftrace_mod_address_lookup(addr, symbolsize,
 						offset, modname, namebuf);
@@ -673,15 +667,6 @@ static int get_ksymbol_ftrace_mod(struct
 	return 1;
 }
 
-static int get_ksymbol_bpf(struct kallsym_iter *iter)
-{
-	iter->module_name[0] = '\0';
-	iter->exported = 0;
-	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
-			       &iter->value, &iter->type,
-			       iter->name) < 0 ? 0 : 1;
-}
-
 /* Returns space to next name. */
 static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 {
@@ -734,7 +719,7 @@ static int update_iter_mod(struct kallsy
 	    get_ksymbol_ftrace_mod(iter))
 		return 1;
 
-	return get_ksymbol_bpf(iter);
+	return 0;
 }
 
 /* Returns false if pos at or past end of file. */

--sdtB3X0nJg68CQEu--

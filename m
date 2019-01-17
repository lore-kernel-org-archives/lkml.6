Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A9120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JZAwXmoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfAQXRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:17:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37254 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbfAQXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:17:44 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HNDWXT011466
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:17:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=VxKTSBhcMiX7Im063mreaOqNtB4COubIUusgpLvH83c=;
 b=JZAwXmoYTT328kP9dyJAwSkTxDN0MfsKrC2MD+5+RHyn8N6W0eCPlCOrKhXtF9eB5Ltv
 K7bM1xU7x8Wo65iaWf6txkthmaOfdJB+x5wpDQg99CuduVL5W0f1GiRtjg5yRbFKqBmY
 JJdLhDXzxJ7NK+RD3S3wW7XblbemwoRlH1I= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q303vrnhk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:17:42 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 17 Jan 2019 15:17:40 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4195562E214C; Thu, 17 Jan 2019 15:17:32 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>, <acme@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH kallsyms, bpf 3/3] bpf: migrate symbols for BPF programs to kallsym_tree
Date:   Thu, 17 Jan 2019 15:17:30 -0800
Message-ID: <20190117231730.2413466-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117231730.2413466-1-songliubraving@fb.com>
References: <20190117231730.2413466-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This patch migrates BPF program symbols from bpf_tree to kallsym_tree.
Since kallsym_tree_add/del already calls perf_event_ksymbol(), this patch
also removes unnecessary perf_event_bpf_emit_ksymbols().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/bpf.h    |   7 +-
 include/linux/filter.h |  42 -----------
 kernel/bpf/core.c      | 167 +++++------------------------------------
 kernel/events/core.c   |  35 ---------
 kernel/extable.c       |   4 +-
 kernel/kallsyms.c      |  19 +----
 6 files changed, 25 insertions(+), 249 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e734f163bd0b..403e1f88a1fa 100644
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
diff --git a/include/linux/filter.h b/include/linux/filter.h
index d531d4250bff..61264a3f944c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -932,23 +932,6 @@ static inline bool bpf_jit_kallsyms_enabled(void)
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
 void bpf_get_prog_name(const struct bpf_prog *prog, char *sym);
@@ -975,31 +958,6 @@ static inline bool bpf_jit_kallsyms_enabled(void)
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
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 19c49313c709..e53912234a91 100644
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
@@ -100,8 +99,6 @@ struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags)
 	fp->aux->prog = fp;
 	fp->jit_requested = ebpf_jit_enabled();
 
-	INIT_LIST_HEAD_RCU(&fp->aux->ksym_lnode);
-
 	return fp;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_alloc);
@@ -530,86 +527,38 @@ void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
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
+#ifdef CONFIG_PERF_EVENTS
+	fp->aux->ktn.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF;
+#endif
+
+	kallsym_tree_add(&fp->aux->ktn);
 }
 
 void bpf_prog_kallsyms_del(struct bpf_prog *fp)
@@ -617,85 +566,7 @@ void bpf_prog_kallsyms_del(struct bpf_prog *fp)
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
@@ -806,8 +677,6 @@ void __weak bpf_jit_free(struct bpf_prog *fp)
 
 		bpf_jit_binary_unlock_ro(hdr);
 		bpf_jit_binary_free(hdr);
-
-		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
 
 	bpf_prog_unlock_free(fp);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0a8dab322111..5f6ab55f77cf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7790,31 +7790,6 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 	perf_output_end(&handle);
 }
 
-static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
-					 enum perf_bpf_event_type type)
-{
-	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
-	char sym[KSYM_NAME_LEN];
-	int i;
-
-	if (prog->aux->func_cnt == 0) {
-		bpf_get_prog_name(prog, sym);
-		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
-				   (u64)(unsigned long)prog->bpf_func,
-				   prog->jited_len, unregister, sym);
-	} else {
-		for (i = 0; i < prog->aux->func_cnt; i++) {
-			struct bpf_prog *subprog = prog->aux->func[i];
-
-			bpf_get_prog_name(subprog, sym);
-			perf_event_ksymbol(
-				PERF_RECORD_KSYMBOL_TYPE_BPF,
-				(u64)(unsigned long)subprog->bpf_func,
-				subprog->jited_len, unregister, sym);
-		}
-	}
-}
-
 void perf_event_bpf_event(struct bpf_prog *prog,
 			  enum perf_bpf_event_type type,
 			  u16 flags)
@@ -7825,16 +7800,6 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 	    type >= PERF_BPF_EVENT_MAX)
 		return;
 
-	switch (type) {
-	case PERF_BPF_EVENT_PROG_LOAD:
-	case PERF_BPF_EVENT_PROG_UNLOAD:
-		if (atomic_read(&nr_ksymbol_events))
-			perf_event_bpf_emit_ksymbols(prog, type);
-		break;
-	default:
-		break;
-	}
-
 	if (!atomic_read(&nr_bpf_events))
 		return;
 
diff --git a/kernel/extable.c b/kernel/extable.c
index 5271e9b649b1..c7b7bd8e24f6 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -135,7 +135,7 @@ int kernel_text_address(unsigned long addr)
 	 * coming back from idle, or cpu on or offlining.
 	 *
 	 * is_module_text_address() as well as the kprobe slots
-	 * and is_bpf_text_address() require RCU to be watching.
+	 * and is_kallsym_tree_text_address() require RCU to be watching.
 	 */
 	no_rcu = !rcu_is_watching();
 
@@ -151,8 +151,6 @@ int kernel_text_address(unsigned long addr)
 		goto out;
 	if (is_kprobe_optinsn_slot(addr) || is_kprobe_insn_slot(addr))
 		goto out;
-	if (is_bpf_text_address(addr))
-		goto out;
 	ret = 0;
 out:
 	if (no_rcu)
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 30611a5379fd..17bcc6815cf3 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -426,8 +426,7 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 	if (is_ksym_addr(addr))
 		return !!get_symbol_pos(addr, symbolsize, offset);
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
-	       !!kallsym_tree_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
-	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
+	       !!kallsym_tree_address_lookup(addr, symbolsize, offset, NULL, namebuf);
 }
 
 /*
@@ -465,11 +464,6 @@ const char *kallsyms_lookup(unsigned long addr,
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
@@ -674,15 +668,6 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 	return 1;
 }
 
-static int get_ksymbol_bpf(struct kallsym_iter *iter)
-{
-	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
-	iter->exported = 0;
-	return bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
-			       &iter->value, &iter->type,
-			       iter->name) < 0 ? 0 : 1;
-}
-
 /* Returns space to next name. */
 static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
 {
@@ -735,7 +720,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 	    get_ksymbol_ftrace_mod(iter))
 		return 1;
 
-	return get_ksymbol_bpf(iter);
+	return 0;
 }
 
 /* Returns false if pos at or past end of file. */
-- 
2.17.1


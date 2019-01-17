Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F356C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8C820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RXr2JzIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfAQXRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:17:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36166 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbfAQXRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:17:54 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HNFN41012735
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:17:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=C2DagUQrToVBOlXFmrmNKwWs8EUdFsVTIbbGz7MLRyY=;
 b=RXr2JzIrEJVk1JyahBFtaXCmiayRsuoupVoIPSER0V0JY9KjjBXm3wLA5vEw4vx8GAmf
 boNKH7AIYMu5fGN8LnFixXyIvHHdlIPLjTJn83Ls5ogcAJJPN4IvQ2x4RZf9kl/qQwgF
 Zi4/pS8bNgvjVh0VCbXzyH2cfNsItKRJhk0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q32y5g1vc-18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 15:17:53 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 17 Jan 2019 15:17:32 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 3449262E2174; Thu, 17 Jan 2019 15:17:32 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>, <acme@kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH kallsyms, bpf 2/3] kallsyms: Introduce kallsym_tree for dynamic symbols
Date:   Thu, 17 Jan 2019 15:17:29 -0800
Message-ID: <20190117231730.2413466-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117231730.2413466-1-songliubraving@fb.com>
References: <20190117231730.2413466-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

kallsym_tree is based on rbtree_latch. It is designed to hold dynamic
kernel symbols like bpf program, ftrace kallsyms, etc.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/kallsyms.h |  16 ++++
 kernel/extable.c         |   2 +
 kernel/kallsyms.c        | 188 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
index 657a83b943f0..be83ac3d8228 100644
--- a/include/linux/kallsyms.h
+++ b/include/linux/kallsyms.h
@@ -11,6 +11,8 @@
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/rbtree_latch.h>
+#include <uapi/linux/perf_event.h>
 
 #include <asm/sections.h>
 
@@ -20,6 +22,20 @@
 
 struct module;
 
+struct kallsym_node
+{
+	struct latch_tree_node kn_node;
+	unsigned long kn_addr;
+	unsigned long kn_len;
+	enum perf_record_ksymbol_type ksym_type;
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
diff --git a/kernel/extable.c b/kernel/extable.c
index 6a5b61ebc66c..5271e9b649b1 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -145,6 +145,8 @@ int kernel_text_address(unsigned long addr)
 
 	if (is_module_text_address(addr))
 		goto out;
+	if (is_kallsym_tree_text_address(addr))
+		goto out;
 	if (is_ftrace_trampoline(addr))
 		goto out;
 	if (is_kprobe_optinsn_slot(addr) || is_kprobe_insn_slot(addr))
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 14934afa9e68..30611a5379fd 100644
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
@@ -48,6 +50,165 @@ extern const u16 kallsyms_token_index[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
+static DEFINE_SPINLOCK(kallsym_lock);
+static struct latch_tree_root kallsym_tree __cacheline_aligned;
+
+static __always_inline unsigned long
+kallsym_node_addr(struct latch_tree_node *node)
+{
+	struct kallsym_node *kn;
+
+	kn = container_of(node, struct kallsym_node, kn_node);
+	return kn->kn_addr;
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
+	perf_event_ksymbol(kn->ksym_type, kn->kn_addr, kn->kn_len, false, namebuf);
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
+	perf_event_ksymbol(kn->ksym_type, kn->kn_addr, kn->kn_len, true, namebuf);
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
@@ -265,6 +426,7 @@ int kallsyms_lookup_size_offset(unsigned long addr, unsigned long *symbolsize,
 	if (is_ksym_addr(addr))
 		return !!get_symbol_pos(addr, symbolsize, offset);
 	return !!module_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
+	       !!kallsym_tree_address_lookup(addr, symbolsize, offset, NULL, namebuf) ||
 	       !!__bpf_address_lookup(addr, symbolsize, offset, namebuf);
 }
 
@@ -300,6 +462,10 @@ const char *kallsyms_lookup(unsigned long addr,
 	/* See if it's in a module or a BPF JITed image. */
 	ret = module_address_lookup(addr, symbolsize, offset,
 				    modname, namebuf);
+	if (!ret)
+		ret = kallsym_tree_address_lookup(addr, symbolsize,
+						  offset, modname, namebuf);
+
 	if (!ret)
 		ret = bpf_address_lookup(addr, symbolsize,
 					 offset, modname, namebuf);
@@ -434,6 +600,7 @@ struct kallsym_iter {
 	loff_t pos;
 	loff_t pos_arch_end;
 	loff_t pos_mod_end;
+	loff_t pos_tree_end;
 	loff_t pos_ftrace_mod_end;
 	unsigned long value;
 	unsigned int nameoff; /* If iterating in core kernel symbols. */
@@ -478,9 +645,24 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
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
@@ -545,6 +727,10 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 	    get_ksymbol_mod(iter))
 		return 1;
 
+	if ((!iter->pos_tree_end || iter->pos_tree_end > pos) &&
+	    get_ksymbol_tree(iter))
+		return 1;
+
 	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
 	    get_ksymbol_ftrace_mod(iter))
 		return 1;
-- 
2.17.1


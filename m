Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E4A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E4A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390390AbeGTNga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:36:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58322 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388476AbeGTNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:36:29 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0CD9D65;
        Fri, 20 Jul 2018 12:38:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+3b889862e65a98317058@syzkaller.appspotmail.com,
        syzbot+9e762b52dd17e616a7a5@syzkaller.appspotmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.17 076/101] bpf: reject any prog that failed read-only lock
Date:   Fri, 20 Jul 2018 14:14:22 +0200
Message-Id: <20180720121426.517812503@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

commit 9facc336876f7ecf9edba4c67b90426fde4ec898 upstream.

We currently lock any JITed image as read-only via bpf_jit_binary_lock_ro()
as well as the BPF image as read-only through bpf_prog_lock_ro(). In
the case any of these would fail we throw a WARN_ON_ONCE() in order to
yell loudly to the log. Perhaps, to some extend, this may be comparable
to an allocation where __GFP_NOWARN is explicitly not set.

Added via 65869a47f348 ("bpf: improve read-only handling"), this behavior
is slightly different compared to any of the other in-kernel set_memory_ro()
users who do not check the return code of set_memory_ro() and friends /at
all/ (e.g. in the case of module_enable_ro() / module_disable_ro()). Given
in BPF this is mandatory hardening step, we want to know whether there
are any issues that would leave both BPF data writable. So it happens
that syzkaller enabled fault injection and it triggered memory allocation
failure deep inside x86's change_page_attr_set_clr() which was triggered
from set_memory_ro().

Now, there are two options: i) leaving everything as is, and ii) reworking
the image locking code in order to have a final checkpoint out of the
central bpf_prog_select_runtime() which probes whether any of the calls
during prog setup weren't successful, and then bailing out with an error.
Option ii) is a better approach since this additional paranoia avoids
altogether leaving any potential W+X pages from BPF side in the system.
Therefore, lets be strict about it, and reject programs in such unlikely
occasion. While testing I noticed also that one bpf_prog_lock_ro()
call was missing on the outer dummy prog in case of calls, e.g. in the
destructor we call bpf_prog_free_deferred() on the main prog where we
try to bpf_prog_unlock_free() the program, and since we go via
bpf_prog_select_runtime() do that as well.

Reported-by: syzbot+3b889862e65a98317058@syzkaller.appspotmail.com
Reported-by: syzbot+9e762b52dd17e616a7a5@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/filter.h |   60 +++++++++++++++++++++++++++++++------------------
 kernel/bpf/core.c      |   53 ++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c   |    4 ---
 3 files changed, 86 insertions(+), 31 deletions(-)

--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -453,7 +453,8 @@ struct sock_fprog_kern {
 };
 
 struct bpf_binary_header {
-	unsigned int pages;
+	u16 pages;
+	u16 locked:1;
 	u8 image[];
 };
 
@@ -644,15 +645,18 @@ bpf_ctx_narrow_access_ok(u32 off, u32 si
 
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
-#ifdef CONFIG_ARCH_HAS_SET_MEMORY
 static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
 {
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
 	fp->locked = 1;
-	WARN_ON_ONCE(set_memory_ro((unsigned long)fp, fp->pages));
+	if (set_memory_ro((unsigned long)fp, fp->pages))
+		fp->locked = 0;
+#endif
 }
 
 static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
 {
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
 	if (fp->locked) {
 		WARN_ON_ONCE(set_memory_rw((unsigned long)fp, fp->pages));
 		/* In case set_memory_rw() fails, we want to be the first
@@ -660,34 +664,30 @@ static inline void bpf_prog_unlock_ro(st
 		 */
 		fp->locked = 0;
 	}
+#endif
 }
 
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
-	WARN_ON_ONCE(set_memory_ro((unsigned long)hdr, hdr->pages));
-}
-
-static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hdr)
-{
-	WARN_ON_ONCE(set_memory_rw((unsigned long)hdr, hdr->pages));
-}
-#else
-static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
-{
-}
-
-static inline void bpf_prog_unlock_ro(struct bpf_prog *fp)
-{
-}
-
-static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
-{
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+	hdr->locked = 1;
+	if (set_memory_ro((unsigned long)hdr, hdr->pages))
+		hdr->locked = 0;
+#endif
 }
 
 static inline void bpf_jit_binary_unlock_ro(struct bpf_binary_header *hdr)
 {
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+	if (hdr->locked) {
+		WARN_ON_ONCE(set_memory_rw((unsigned long)hdr, hdr->pages));
+		/* In case set_memory_rw() fails, we want to be the first
+		 * to crash here instead of some random place later on.
+		 */
+		hdr->locked = 0;
+	}
+#endif
 }
-#endif /* CONFIG_ARCH_HAS_SET_MEMORY */
 
 static inline struct bpf_binary_header *
 bpf_jit_binary_hdr(const struct bpf_prog *fp)
@@ -698,6 +698,22 @@ bpf_jit_binary_hdr(const struct bpf_prog
 	return (void *)addr;
 }
 
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+static inline int bpf_prog_check_pages_ro_single(const struct bpf_prog *fp)
+{
+	if (!fp->locked)
+		return -ENOLCK;
+	if (fp->jited) {
+		const struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
+
+		if (!hdr->locked)
+			return -ENOLCK;
+	}
+
+	return 0;
+}
+#endif
+
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
 static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
 {
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -583,6 +583,8 @@ bpf_jit_binary_alloc(unsigned int progle
 	bpf_fill_ill_insns(hdr, size);
 
 	hdr->pages = size / PAGE_SIZE;
+	hdr->locked = 0;
+
 	hole = min_t(unsigned int, size - (proglen + sizeof(*hdr)),
 		     PAGE_SIZE - sizeof(*hdr));
 	start = (get_random_int() % hole) & ~(alignment - 1);
@@ -1513,6 +1515,33 @@ static int bpf_check_tail_call(const str
 	return 0;
 }
 
+static int bpf_prog_check_pages_ro_locked(const struct bpf_prog *fp)
+{
+#ifdef CONFIG_ARCH_HAS_SET_MEMORY
+	int i, err;
+
+	for (i = 0; i < fp->aux->func_cnt; i++) {
+		err = bpf_prog_check_pages_ro_single(fp->aux->func[i]);
+		if (err)
+			return err;
+	}
+
+	return bpf_prog_check_pages_ro_single(fp);
+#endif
+	return 0;
+}
+
+static void bpf_prog_select_func(struct bpf_prog *fp)
+{
+#ifndef CONFIG_BPF_JIT_ALWAYS_ON
+	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+
+	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
+#else
+	fp->bpf_func = __bpf_prog_ret0_warn;
+#endif
+}
+
 /**
  *	bpf_prog_select_runtime - select exec runtime for BPF program
  *	@fp: bpf_prog populated with internal BPF program
@@ -1523,13 +1552,13 @@ static int bpf_check_tail_call(const str
  */
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 {
-#ifndef CONFIG_BPF_JIT_ALWAYS_ON
-	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
+	/* In case of BPF to BPF calls, verifier did all the prep
+	 * work with regards to JITing, etc.
+	 */
+	if (fp->bpf_func)
+		goto finalize;
 
-	fp->bpf_func = interpreters[(round_up(stack_depth, 32) / 32) - 1];
-#else
-	fp->bpf_func = __bpf_prog_ret0_warn;
-#endif
+	bpf_prog_select_func(fp);
 
 	/* eBPF JITs can rewrite the program in case constant
 	 * blinding is active. However, in case of error during
@@ -1550,6 +1579,8 @@ struct bpf_prog *bpf_prog_select_runtime
 		if (*err)
 			return fp;
 	}
+
+finalize:
 	bpf_prog_lock_ro(fp);
 
 	/* The tail call compatibility check can only be done at
@@ -1558,7 +1589,17 @@ struct bpf_prog *bpf_prog_select_runtime
 	 * all eBPF JITs might immediately support all features.
 	 */
 	*err = bpf_check_tail_call(fp);
+	if (*err)
+		return fp;
 
+	/* Checkpoint: at this point onwards any cBPF -> eBPF or
+	 * native eBPF program is read-only. If we failed to change
+	 * the page attributes (e.g. allocation failure from
+	 * splitting large pages), then reject the whole program
+	 * in order to guarantee not ending up with any W+X pages
+	 * from BPF side in kernel.
+	 */
+	*err = bpf_prog_check_pages_ro_locked(fp);
 	return fp;
 }
 EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1328,9 +1328,7 @@ static int bpf_prog_load(union bpf_attr
 	if (err < 0)
 		goto free_used_maps;
 
-	/* eBPF program is ready to be JITed */
-	if (!prog->bpf_func)
-		prog = bpf_prog_select_runtime(prog, &err);
+	prog = bpf_prog_select_runtime(prog, &err);
 	if (err < 0)
 		goto free_used_maps;
 



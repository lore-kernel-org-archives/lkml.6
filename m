Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZPoWLCRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FDCE607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeFFNyB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:54:01 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:18425 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeFFNx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:53:59 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="744767920"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 1/7] net: reorder filter code
Date: Wed, 6 Jun 2018 15:53:20 +0200
Message-ID: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit reorders the definition of functions and struct in the
file filter.c, such that in the next step we can easily cut the file
into a commonly used part, as well as a part that is only required in
case CONFIG_NET is actually set.

This is part of the effort to split CONFIG_SECCOMP_FILTER and
CONFIG_NET.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 net/core/filter.c | 330 +++++++++++++++++++++++++++---------------------------
 1 file changed, 165 insertions(+), 165 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 201ff36b..0d980e9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -59,58 +59,6 @@
 #include <net/tcp.h>
 #include <linux/bpf_trace.h>
 
-/**
- *	sk_filter_trim_cap - run a packet through a socket filter
- *	@sk: sock associated with &sk_buff
- *	@skb: buffer to filter
- *	@cap: limit on how short the eBPF program may trim the packet
- *
- * Run the eBPF program and then cut skb->data to correct size returned by
- * the program. If pkt_len is 0 we toss packet. If skb->len is smaller
- * than pkt_len we keep whole skb->data. This is the socket level
- * wrapper to BPF_PROG_RUN. It returns 0 if the packet should
- * be accepted or -EPERM if the packet should be tossed.
- *
- */
-int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
-{
-	int err;
-	struct sk_filter *filter;
-
-	/*
-	 * If the skb was allocated from pfmemalloc reserves, only
-	 * allow SOCK_MEMALLOC sockets to use it as this socket is
-	 * helping free memory
-	 */
-	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
-		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
-		return -ENOMEM;
-	}
-	err = BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb);
-	if (err)
-		return err;
-
-	err = security_sock_rcv_skb(sk, skb);
-	if (err)
-		return err;
-
-	rcu_read_lock();
-	filter = rcu_dereference(sk->sk_filter);
-	if (filter) {
-		struct sock *save_sk = skb->sk;
-		unsigned int pkt_len;
-
-		skb->sk = sk;
-		pkt_len = bpf_prog_run_save_cb(filter->prog, skb);
-		skb->sk = save_sk;
-		err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;
-	}
-	rcu_read_unlock();
-
-	return err;
-}
-EXPORT_SYMBOL(sk_filter_trim_cap);
-
 BPF_CALL_1(__skb_get_pay_offset, struct sk_buff *, skb)
 {
 	return skb_get_poff(skb);
@@ -165,12 +113,6 @@ BPF_CALL_0(__get_raw_cpu_id)
 	return raw_smp_processor_id();
 }
 
-static const struct bpf_func_proto bpf_get_raw_smp_processor_id_proto = {
-	.func		= __get_raw_cpu_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
 static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 			      struct bpf_insn *insn_buf)
 {
@@ -954,71 +896,6 @@ static void __bpf_prog_release(struct bpf_prog *prog)
 	}
 }
 
-static void __sk_filter_release(struct sk_filter *fp)
-{
-	__bpf_prog_release(fp->prog);
-	kfree(fp);
-}
-
-/**
- * 	sk_filter_release_rcu - Release a socket filter by rcu_head
- *	@rcu: rcu_head that contains the sk_filter to free
- */
-static void sk_filter_release_rcu(struct rcu_head *rcu)
-{
-	struct sk_filter *fp = container_of(rcu, struct sk_filter, rcu);
-
-	__sk_filter_release(fp);
-}
-
-/**
- *	sk_filter_release - release a socket filter
- *	@fp: filter to remove
- *
- *	Remove a filter from a socket and release its resources.
- */
-static void sk_filter_release(struct sk_filter *fp)
-{
-	if (refcount_dec_and_test(&fp->refcnt))
-		call_rcu(&fp->rcu, sk_filter_release_rcu);
-}
-
-void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp)
-{
-	u32 filter_size = bpf_prog_size(fp->prog->len);
-
-	atomic_sub(filter_size, &sk->sk_omem_alloc);
-	sk_filter_release(fp);
-}
-
-/* try to charge the socket memory if there is space available
- * return true on success
- */
-static bool __sk_filter_charge(struct sock *sk, struct sk_filter *fp)
-{
-	u32 filter_size = bpf_prog_size(fp->prog->len);
-
-	/* same check as in sock_kmalloc() */
-	if (filter_size <= sysctl_optmem_max &&
-	    atomic_read(&sk->sk_omem_alloc) + filter_size < sysctl_optmem_max) {
-		atomic_add(filter_size, &sk->sk_omem_alloc);
-		return true;
-	}
-	return false;
-}
-
-bool sk_filter_charge(struct sock *sk, struct sk_filter *fp)
-{
-	if (!refcount_inc_not_zero(&fp->refcnt))
-		return false;
-
-	if (!__sk_filter_charge(sk, fp)) {
-		sk_filter_release(fp);
-		return false;
-	}
-	return true;
-}
-
 static struct bpf_prog *bpf_migrate_filter(struct bpf_prog *fp)
 {
 	struct sock_filter *old_prog;
@@ -1127,19 +1004,22 @@ static struct bpf_prog *bpf_prepare_filter(struct bpf_prog *fp,
 }
 
 /**
- *	bpf_prog_create - create an unattached filter
+ *	bpf_prog_create_from_user - create an unattached filter from user buffer
  *	@pfp: the unattached filter that is created
  *	@fprog: the filter program
+ *	@trans: post-classic verifier transformation handler
+ *	@save_orig: save classic BPF program
  *
- * Create a filter independent of any socket. We first run some
- * sanity checks on it to make sure it does not explode on us later.
- * If an error occurs or there is insufficient memory for the filter
- * a negative errno code is returned. On success the return is zero.
+ * This function effectively does the same as bpf_prog_create(), only
+ * that it builds up its insns buffer from user space provided buffer.
+ * It also allows for passing a bpf_aux_classic_check_t handler.
  */
-int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog)
+int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
+			      bpf_aux_classic_check_t trans, bool save_orig)
 {
 	unsigned int fsize = bpf_classic_proglen(fprog);
 	struct bpf_prog *fp;
+	int err;
 
 	/* Make sure new filter is there and in the right amounts. */
 	if (!bpf_check_basics_ok(fprog->filter, fprog->len))
@@ -1149,44 +1029,177 @@ int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog)
 	if (!fp)
 		return -ENOMEM;
 
-	memcpy(fp->insns, fprog->filter, fsize);
+	if (copy_from_user(fp->insns, fprog->filter, fsize)) {
+		__bpf_prog_free(fp);
+		return -EFAULT;
+	}
 
 	fp->len = fprog->len;
-	/* Since unattached filters are not copied back to user
-	 * space through sk_get_filter(), we do not need to hold
-	 * a copy here, and can spare us the work.
-	 */
 	fp->orig_prog = NULL;
 
+	if (save_orig) {
+		err = bpf_prog_store_orig_filter(fp, fprog);
+		if (err) {
+			__bpf_prog_free(fp);
+			return -ENOMEM;
+		}
+	}
+
 	/* bpf_prepare_filter() already takes care of freeing
 	 * memory in case something goes wrong.
 	 */
-	fp = bpf_prepare_filter(fp, NULL);
+	fp = bpf_prepare_filter(fp, trans);
 	if (IS_ERR(fp))
 		return PTR_ERR(fp);
 
 	*pfp = fp;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bpf_prog_create);
+EXPORT_SYMBOL_GPL(bpf_prog_create_from_user);
+
+void bpf_prog_destroy(struct bpf_prog *fp)
+{
+	__bpf_prog_release(fp);
+}
+EXPORT_SYMBOL_GPL(bpf_prog_destroy);
 
 /**
- *	bpf_prog_create_from_user - create an unattached filter from user buffer
+ *	sk_filter_trim_cap - run a packet through a socket filter
+ *	@sk: sock associated with &sk_buff
+ *	@skb: buffer to filter
+ *	@cap: limit on how short the eBPF program may trim the packet
+ *
+ * Run the eBPF program and then cut skb->data to correct size returned by
+ * the program. If pkt_len is 0 we toss packet. If skb->len is smaller
+ * than pkt_len we keep whole skb->data. This is the socket level
+ * wrapper to BPF_PROG_RUN. It returns 0 if the packet should
+ * be accepted or -EPERM if the packet should be tossed.
+ *
+ */
+int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
+{
+	int err;
+	struct sk_filter *filter;
+
+	/*
+	 * If the skb was allocated from pfmemalloc reserves, only
+	 * allow SOCK_MEMALLOC sockets to use it as this socket is
+	 * helping free memory
+	 */
+	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
+		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
+		return -ENOMEM;
+	}
+	err = BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb);
+	if (err)
+		return err;
+
+	err = security_sock_rcv_skb(sk, skb);
+	if (err)
+		return err;
+
+	rcu_read_lock();
+	filter = rcu_dereference(sk->sk_filter);
+	if (filter) {
+		struct sock *save_sk = skb->sk;
+		unsigned int pkt_len;
+
+		skb->sk = sk;
+		pkt_len = bpf_prog_run_save_cb(filter->prog, skb);
+		skb->sk = save_sk;
+		err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;
+	}
+	rcu_read_unlock();
+
+	return err;
+}
+EXPORT_SYMBOL(sk_filter_trim_cap);
+
+static const struct bpf_func_proto bpf_get_raw_smp_processor_id_proto = {
+	.func		= __get_raw_cpu_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+static void __sk_filter_release(struct sk_filter *fp)
+{
+	__bpf_prog_release(fp->prog);
+	kfree(fp);
+}
+
+/**
+ * 	sk_filter_release_rcu - Release a socket filter by rcu_head
+ *	@rcu: rcu_head that contains the sk_filter to free
+ */
+static void sk_filter_release_rcu(struct rcu_head *rcu)
+{
+	struct sk_filter *fp = container_of(rcu, struct sk_filter, rcu);
+
+	__sk_filter_release(fp);
+}
+
+/**
+ *	sk_filter_release - release a socket filter
+ *	@fp: filter to remove
+ *
+ *	Remove a filter from a socket and release its resources.
+ */
+static void sk_filter_release(struct sk_filter *fp)
+{
+	if (refcount_dec_and_test(&fp->refcnt))
+		call_rcu(&fp->rcu, sk_filter_release_rcu);
+}
+
+void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp)
+{
+	u32 filter_size = bpf_prog_size(fp->prog->len);
+
+	atomic_sub(filter_size, &sk->sk_omem_alloc);
+	sk_filter_release(fp);
+}
+
+/* try to charge the socket memory if there is space available
+ * return true on success
+ */
+static bool __sk_filter_charge(struct sock *sk, struct sk_filter *fp)
+{
+	u32 filter_size = bpf_prog_size(fp->prog->len);
+
+	/* same check as in sock_kmalloc() */
+	if (filter_size <= sysctl_optmem_max &&
+	    atomic_read(&sk->sk_omem_alloc) + filter_size < sysctl_optmem_max) {
+		atomic_add(filter_size, &sk->sk_omem_alloc);
+		return true;
+	}
+	return false;
+}
+
+bool sk_filter_charge(struct sock *sk, struct sk_filter *fp)
+{
+	if (!refcount_inc_not_zero(&fp->refcnt))
+		return false;
+
+	if (!__sk_filter_charge(sk, fp)) {
+		sk_filter_release(fp);
+		return false;
+	}
+	return true;
+}
+
+/**
+ *	bpf_prog_create - create an unattached filter
  *	@pfp: the unattached filter that is created
  *	@fprog: the filter program
- *	@trans: post-classic verifier transformation handler
- *	@save_orig: save classic BPF program
  *
- * This function effectively does the same as bpf_prog_create(), only
- * that it builds up its insns buffer from user space provided buffer.
- * It also allows for passing a bpf_aux_classic_check_t handler.
+ * Create a filter independent of any socket. We first run some
+ * sanity checks on it to make sure it does not explode on us later.
+ * If an error occurs or there is insufficient memory for the filter
+ * a negative errno code is returned. On success the return is zero.
  */
-int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
-			      bpf_aux_classic_check_t trans, bool save_orig)
+int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog)
 {
 	unsigned int fsize = bpf_classic_proglen(fprog);
 	struct bpf_prog *fp;
-	int err;
 
 	/* Make sure new filter is there and in the right amounts. */
 	if (!bpf_check_basics_ok(fprog->filter, fprog->len))
@@ -1196,39 +1209,26 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
 	if (!fp)
 		return -ENOMEM;
 
-	if (copy_from_user(fp->insns, fprog->filter, fsize)) {
-		__bpf_prog_free(fp);
-		return -EFAULT;
-	}
+	memcpy(fp->insns, fprog->filter, fsize);
 
 	fp->len = fprog->len;
+	/* Since unattached filters are not copied back to user
+	 * space through sk_get_filter(), we do not need to hold
+	 * a copy here, and can spare us the work.
+	 */
 	fp->orig_prog = NULL;
 
-	if (save_orig) {
-		err = bpf_prog_store_orig_filter(fp, fprog);
-		if (err) {
-			__bpf_prog_free(fp);
-			return -ENOMEM;
-		}
-	}
-
 	/* bpf_prepare_filter() already takes care of freeing
 	 * memory in case something goes wrong.
 	 */
-	fp = bpf_prepare_filter(fp, trans);
+	fp = bpf_prepare_filter(fp, NULL);
 	if (IS_ERR(fp))
 		return PTR_ERR(fp);
 
 	*pfp = fp;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(bpf_prog_create_from_user);
-
-void bpf_prog_destroy(struct bpf_prog *fp)
-{
-	__bpf_prog_release(fp);
-}
-EXPORT_SYMBOL_GPL(bpf_prog_destroy);
+EXPORT_SYMBOL_GPL(bpf_prog_create);
 
 static int __sk_attach_prog(struct bpf_prog *prog, struct sock *sk)
 {
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

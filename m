Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5151EC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30872729B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="t+YseCUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30872729B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965864AbeF1Mq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:46:28 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:36079 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965788AbeF1MqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1530189984; x=1561725984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WhJ0nqbDGuuIUTblEDDfSxHZP/phjV7nKEW20b07xEE=;
  b=t+YseCUTODXU9Gmcqt92mY2Ss99MjZmqNxSa0Kuk64C8nSU343VxamvQ
   mLmuzXu0ug/DMBOPgBX2M+yn8rGKaSvSg8bTVodQhDRDJ3LlZnGxj44I9
   bcuZ0NvkDt5akfawqbLZv83ChuexehQI+7wuRm3MtwZ4IGf9skayJ8I6l
   Q=;
X-IronPort-AV: E=Sophos;i="5.51,283,1526342400"; 
   d="scan'208";a="726297568"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Jun 2018 12:46:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5SCkGxM123284
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 Jun 2018 12:46:21 GMT
Received: from EX13D02EUC002.ant.amazon.com (10.43.164.14) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:21 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D02EUC002.ant.amazon.com (10.43.164.14) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 28 Jun 2018 12:46:20 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.28.85.80) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 28 Jun 2018 12:46:19 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [less-CONFIG_NET v2 1/8] net: reorder filter code
Date:   Thu, 28 Jun 2018 14:45:29 +0200
Message-ID: <1530189936-25780-2-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
References: <ef0fe0ef-3620-3628-2a7e-c8b73e466a21@amazon.de>
 <1530189936-25780-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index e7f12e9..61c24c9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -69,58 +69,6 @@
 #include <net/seg6.h>
 #include <net/seg6_local.h>
 
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
 BPF_CALL_1(bpf_skb_get_pay_offset, struct sk_buff *, skb)
 {
 	return skb_get_poff(skb);
@@ -256,12 +204,6 @@ BPF_CALL_0(bpf_get_raw_cpu_id)
 	return raw_smp_processor_id();
 }
 
-static const struct bpf_func_proto bpf_get_raw_smp_processor_id_proto = {
-	.func		= bpf_get_raw_cpu_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
 static u32 convert_skb_access(int skb_field, int dst_reg, int src_reg,
 			      struct bpf_insn *insn_buf)
 {
@@ -1138,71 +1080,6 @@ static void __bpf_prog_release(struct bpf_prog *prog)
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
@@ -1314,19 +1191,22 @@ static struct bpf_prog *bpf_prepare_filter(struct bpf_prog *fp,
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
@@ -1336,44 +1216,177 @@ int bpf_prog_create(struct bpf_prog **pfp, struct sock_fprog_kern *fprog)
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
+	.func		= bpf_get_raw_cpu_id,
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
@@ -1383,39 +1396,26 @@ int bpf_prog_create_from_user(struct bpf_prog **pfp, struct sock_fprog *fprog,
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


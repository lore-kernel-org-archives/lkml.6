Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CBCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3A22087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbW7YYjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3A22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbeJKGhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbeJKGht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:49 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 363102075C;
        Wed, 10 Oct 2018 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213207;
        bh=JctZqJS+KPkkFvTddHs6szLMgiOQiN+x0Lz0RnTP2Vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbW7YYjgh+qzoKZn44G8g+Eyz1/UiqcWMgo+XsjApyvyD5uFX9CgnUfrRcBrIYfjn
         jnjCTAKDsXSEkYUKp8tEigOcuNs5lYiTQOeAZGgFZUq/gmxDxEb70BN5ikoP0Gvf86
         ACrbiGatQ2fb8CmCaXePxyLgx1TUO/ZUMt/SDGbQ=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 18/30] softirq: Prepare local_bh_disable() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:05 +0200
Message-Id: <1539213137-13953-19-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to disable softirqs at the vector level, we'll need
to be able to:

1) Pass as parameter the vector mask we want to disable. By default it's
   going to be all of them (SOFTIRQ_ALL_MASK) to keep the current
   behaviour. Each callsite will later need to be audited in the long
   run in order to narrow down to the relevant vectors.

2) Return the saved vector enabled state prior to the call to
   local_bh_disable(). This saved mask will be pushed and restored to
   the symetric call to local_bh_enable(), following the current model
   we have with local_irq_save/restore(). This will allow us to safely
   stack up the bh disable calls, which is a common situation:

	bh = local_bh_disable(BIT(BLOCK_SOFTIRQ));
		...
		bh2 = spin_lock_bh(..., BIT(NET_RX_SOFTIRQ));
		...
		spin_unlock_bh(..., bh2);
		...
	local_bh_disable(bh);

Prepare all the callers so far, we'll care about pushing down the masks
to the softirq core in a subsequent patch.

Thanks to coccinelle that helped a lot with scripts such as the
following:

	@bh exists@
	identifier func;
	@@
	func(...) {
	+ unsigned int bh;
	...
	- local_bh_disable();
	+ bh = local_bh_disable(SOFTIRQ_ALL_MASK);
	...
	- local_bh_enable();
	+ local_bh_enable(bh);
	...
	}

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/arm64/kernel/fpsimd.c                         | 37 ++++++++++--------
 arch/s390/lib/delay.c                              |  5 ++-
 arch/x86/crypto/sha1-mb/sha1_mb.c                  |  9 +++--
 arch/x86/crypto/sha256-mb/sha256_mb.c              |  9 +++--
 arch/x86/crypto/sha512-mb/sha512_mb.c              |  9 +++--
 crypto/cryptd.c                                    | 25 +++++++-----
 crypto/mcryptd.c                                   | 25 +++++++-----
 drivers/crypto/chelsio/chcr_algo.c                 |  5 ++-
 drivers/crypto/chelsio/chtls/chtls_cm.c            | 25 +++++++-----
 drivers/crypto/inside-secure/safexcel.c            |  5 ++-
 drivers/crypto/marvell/cesa.c                      |  5 ++-
 drivers/gpu/drm/i915/i915_gem.c                    |  5 ++-
 drivers/gpu/drm/i915/i915_request.c                |  5 ++-
 drivers/gpu/drm/i915/intel_breadcrumbs.c           |  5 ++-
 drivers/gpu/drm/i915/intel_engine_cs.c             |  5 ++-
 drivers/hsi/clients/cmt_speech.c                   | 15 +++++---
 drivers/infiniband/sw/rdmavt/cq.c                  |  5 ++-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c            |  5 ++-
 drivers/isdn/i4l/isdn_net.h                        |  2 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    |  5 ++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  5 ++-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |  5 ++-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c |  5 ++-
 drivers/net/ethernet/chelsio/cxgb3/sge.c           |  5 ++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    |  5 ++-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           | 22 ++++++-----
 drivers/net/ethernet/emulex/benet/be_cmds.c        |  5 ++-
 drivers/net/ethernet/emulex/benet/be_main.c        |  5 ++-
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |  5 ++-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  5 ++-
 drivers/net/ethernet/sfc/ptp.c                     | 10 +++--
 drivers/net/ipvlan/ipvlan_core.c                   |  5 ++-
 drivers/net/ppp/ppp_generic.c                      |  7 ++--
 drivers/net/tun.c                                  | 40 ++++++++++---------
 drivers/net/virtio_net.c                           |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  5 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 19 +++++----
 drivers/net/wireless/mac80211_hwsim.c              | 14 ++++---
 drivers/net/wireless/mediatek/mt76/agg-rx.c        |  5 ++-
 .../net/wireless/mediatek/mt76/mt76x2_phy_common.c |  5 ++-
 drivers/s390/char/sclp.c                           |  5 ++-
 drivers/s390/cio/cio.c                             |  5 ++-
 drivers/s390/crypto/zcrypt_api.c                   | 20 ++++++----
 drivers/tty/hvc/hvc_iucv.c                         |  5 ++-
 include/linux/bottom_half.h                        |  5 ++-
 include/linux/netdevice.h                          | 11 +++---
 include/linux/rcupdate.h                           |  8 ++--
 include/net/mac80211.h                             | 15 +++++---
 include/net/snmp.h                                 | 10 +++--
 include/net/tcp.h                                  |  2 +-
 kernel/bpf/cpumap.c                                |  5 ++-
 kernel/irq/manage.c                                |  5 ++-
 kernel/locking/spinlock.c                          |  2 +-
 kernel/padata.c                                    | 15 +++++---
 kernel/rcu/rcutorture.c                            |  5 ++-
 kernel/rcu/srcutiny.c                              |  5 ++-
 kernel/rcu/srcutree.c                              |  5 ++-
 kernel/rcu/tiny.c                                  |  5 ++-
 kernel/rcu/tree_plugin.h                           | 12 ++++--
 kernel/rcu/update.c                                |  5 ++-
 kernel/softirq.c                                   |  6 +--
 kernel/time/hrtimer.c                              |  5 ++-
 lib/locking-selftest.c                             |  8 ++--
 net/ax25/ax25_subr.c                               |  5 ++-
 net/bridge/br_fdb.c                                |  5 ++-
 net/can/gw.c                                       |  5 ++-
 net/core/dev.c                                     | 20 ++++++----
 net/core/gen_estimator.c                           |  5 ++-
 net/core/neighbour.c                               |  2 +-
 net/core/pktgen.c                                  |  9 +++--
 net/core/sock.c                                    |  4 +-
 net/dccp/input.c                                   |  5 ++-
 net/dccp/ipv4.c                                    |  5 ++-
 net/dccp/minisocks.c                               |  5 ++-
 net/dccp/proto.c                                   |  5 ++-
 net/decnet/dn_route.c                              |  5 ++-
 net/ipv4/fib_frontend.c                            |  5 ++-
 net/ipv4/icmp.c                                    | 10 +++--
 net/ipv4/inet_connection_sock.c                    |  5 ++-
 net/ipv4/inet_hashtables.c                         | 14 ++++---
 net/ipv4/inet_timewait_sock.c                      |  5 ++-
 net/ipv4/netfilter/arp_tables.c                    | 10 +++--
 net/ipv4/netfilter/ip_tables.c                     | 10 +++--
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  7 ++--
 net/ipv4/netfilter/nf_defrag_ipv4.c                |  5 ++-
 net/ipv4/tcp.c                                     | 19 ++++-----
 net/ipv4/tcp_input.c                               |  5 ++-
 net/ipv4/tcp_ipv4.c                                | 10 +++--
 net/ipv4/tcp_minisocks.c                           |  5 ++-
 net/ipv6/icmp.c                                    | 10 +++--
 net/ipv6/inet6_hashtables.c                        |  5 ++-
 net/ipv6/ipv6_sockglue.c                           |  9 +++--
 net/ipv6/netfilter/ip6_tables.c                    | 10 +++--
 net/ipv6/route.c                                   |  5 ++-
 net/ipv6/seg6_hmac.c                               |  5 ++-
 net/iucv/iucv.c                                    | 45 +++++++++++++---------
 net/l2tp/l2tp_ppp.c                                | 10 +++--
 net/llc/llc_conn.c                                 |  5 ++-
 net/mac80211/agg-tx.c                              |  5 ++-
 net/mac80211/cfg.c                                 |  5 ++-
 net/mac80211/sta_info.c                            |  5 ++-
 net/mac80211/tdls.c                                |  5 ++-
 net/mac80211/tx.c                                  | 10 +++--
 net/mpls/internal.h                                | 10 +++--
 net/netfilter/ipvs/ip_vs_core.c                    | 20 ++++++----
 net/netfilter/ipvs/ip_vs_ctl.c                     |  5 ++-
 net/netfilter/nf_conntrack_core.c                  | 41 ++++++++++++--------
 net/netfilter/nf_conntrack_ecache.c                |  5 ++-
 net/netfilter/nf_conntrack_netlink.c               |  5 ++-
 net/netfilter/nf_log.c                             |  4 +-
 net/netfilter/nf_queue.c                           |  5 ++-
 net/netfilter/nf_tables_core.c                     |  5 ++-
 net/netfilter/nft_counter.c                        | 10 +++--
 net/netfilter/x_tables.c                           |  7 ++--
 net/netfilter/xt_hashlimit.c                       | 11 +++---
 net/netlink/af_netlink.c                           | 10 +++--
 net/openvswitch/datapath.c                         |  5 ++-
 net/sctp/input.c                                   | 15 +++++---
 net/sctp/sm_make_chunk.c                           |  9 +++--
 net/sctp/socket.c                                  | 20 ++++++----
 net/sunrpc/svcsock.c                               |  7 ++--
 net/unix/af_unix.c                                 | 10 +++--
 net/xdp/xsk.c                                      | 10 +++--
 net/xfrm/xfrm_ipcomp.c                             |  7 ++--
 security/smack/smack_lsm.c                         |  5 ++-
 126 files changed, 658 insertions(+), 459 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 58c53bc..fddeac4 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -90,7 +90,7 @@
  * To prevent this from racing with the manipulation of the task's FPSIMD state
  * from task context and thereby corrupting the state, it is necessary to
  * protect any manipulation of a task's fpsimd_state or TIF_FOREIGN_FPSTATE
- * flag with local_bh_disable() unless softirqs are already masked.
+ * flag with local_bh_disable(SOFTIRQ_ALL_MASK) unless softirqs are already masked.
  *
  * For a certain task, the sequence may look something like this:
  * - the task gets scheduled in; if both the task's fpsimd_cpu field
@@ -510,6 +510,7 @@ void sve_sync_from_fpsimd_zeropad(struct task_struct *task)
 int sve_set_vector_length(struct task_struct *task,
 			  unsigned long vl, unsigned long flags)
 {
+	unsigned int bh;
 	if (flags & ~(unsigned long)(PR_SVE_VL_INHERIT |
 				     PR_SVE_SET_VL_ONEXEC))
 		return -EINVAL;
@@ -547,7 +548,7 @@ int sve_set_vector_length(struct task_struct *task,
 	 * non-SVE thread.
 	 */
 	if (task == current) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 		fpsimd_save();
 		set_thread_flag(TIF_FOREIGN_FPSTATE);
@@ -558,7 +559,7 @@ int sve_set_vector_length(struct task_struct *task,
 		sve_to_fpsimd(task);
 
 	if (task == current)
-		local_bh_enable();
+		local_bh_enable(bh);
 
 	/*
 	 * Force reallocation of task SVE state to the correct size
@@ -805,6 +806,7 @@ void fpsimd_release_task(struct task_struct *dead_task)
  */
 asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
+	unsigned int bh;
 	/* Even if we chose not to use SVE, the hardware could still trap: */
 	if (unlikely(!system_supports_sve()) || WARN_ON(is_compat_task())) {
 		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
@@ -813,7 +815,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 
 	sve_alloc(current);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	fpsimd_save();
 	fpsimd_to_sve(current);
@@ -825,7 +827,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		WARN_ON(1); /* SVE access shouldn't have trapped */
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /*
@@ -891,12 +893,13 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 void fpsimd_flush_thread(void)
 {
+	unsigned int bh;
 	int vl, supported_vl;
 
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	memset(&current->thread.uw.fpsimd_state, 0,
 	       sizeof(current->thread.uw.fpsimd_state));
@@ -939,7 +942,7 @@ void fpsimd_flush_thread(void)
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /*
@@ -948,12 +951,13 @@ void fpsimd_flush_thread(void)
  */
 void fpsimd_preserve_current_state(void)
 {
+	unsigned int bh;
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	fpsimd_save();
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /*
@@ -1008,17 +1012,18 @@ void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *st)
  */
 void fpsimd_restore_current_state(void)
 {
+	unsigned int bh;
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		task_fpsimd_load();
 		fpsimd_bind_task_to_cpu();
 	}
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /*
@@ -1028,10 +1033,11 @@ void fpsimd_restore_current_state(void)
  */
 void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 {
+	unsigned int bh;
 	if (!system_supports_fpsimd())
 		return;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	current->thread.uw.fpsimd_state = *state;
 	if (system_supports_sve() && test_thread_flag(TIF_SVE))
@@ -1042,7 +1048,7 @@ void fpsimd_update_current_state(struct user_fpsimd_state const *state)
 
 	clear_thread_flag(TIF_FOREIGN_FPSTATE);
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /*
@@ -1083,12 +1089,13 @@ EXPORT_PER_CPU_SYMBOL(kernel_neon_busy);
  */
 void kernel_neon_begin(void)
 {
+	unsigned int bh;
 	if (WARN_ON(!system_supports_fpsimd()))
 		return;
 
 	BUG_ON(!may_use_simd());
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	__this_cpu_write(kernel_neon_busy, true);
 
@@ -1100,7 +1107,7 @@ void kernel_neon_begin(void)
 
 	preempt_disable();
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 3f83ee9..05a4fce 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -74,6 +74,7 @@ static void __udelay_enabled(unsigned long long usecs)
 void __udelay(unsigned long long usecs)
 {
 	unsigned long flags;
+	unsigned int bh;
 
 	preempt_disable();
 	local_irq_save(flags);
@@ -89,9 +90,9 @@ void __udelay(unsigned long long usecs)
 		goto out;
 	}
 	if (raw_irqs_disabled_flags(flags)) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		__udelay_disabled(usecs);
-		local_bh_enable_no_softirq();
+		local_bh_enable_no_softirq(bh);
 		goto out;
 	}
 	__udelay_enabled(usecs);
diff --git a/arch/x86/crypto/sha1-mb/sha1_mb.c b/arch/x86/crypto/sha1-mb/sha1_mb.c
index b938056..d1d2d9f 100644
--- a/arch/x86/crypto/sha1-mb/sha1_mb.c
+++ b/arch/x86/crypto/sha1-mb/sha1_mb.c
@@ -435,6 +435,7 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 			    struct mcryptd_alg_cstate *cstate,
 			    int err)
 {
+	unsigned int bh;
 	struct ahash_request *req = cast_mcryptd_ctx_to_req(rctx);
 	struct sha1_hash_ctx *sha_ctx;
 	struct mcryptd_hash_request_ctx *req_ctx;
@@ -448,9 +449,9 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 	if (irqs_disabled())
 		rctx->complete(&req->base, err);
 	else {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rctx->complete(&req->base, err);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/* check to see if there are other jobs that are done */
@@ -467,9 +468,9 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 			if (irqs_disabled())
 				req_ctx->complete(&req->base, ret);
 			else {
-				local_bh_disable();
+				bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 				req_ctx->complete(&req->base, ret);
-				local_bh_enable();
+				local_bh_enable(bh);
 			}
 		}
 		sha_ctx = sha1_ctx_mgr_get_comp_ctx(cstate->mgr);
diff --git a/arch/x86/crypto/sha256-mb/sha256_mb.c b/arch/x86/crypto/sha256-mb/sha256_mb.c
index 97c5fc4..f357cfd 100644
--- a/arch/x86/crypto/sha256-mb/sha256_mb.c
+++ b/arch/x86/crypto/sha256-mb/sha256_mb.c
@@ -434,6 +434,7 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 			    struct mcryptd_alg_cstate *cstate,
 			    int err)
 {
+	unsigned int bh;
 	struct ahash_request *req = cast_mcryptd_ctx_to_req(rctx);
 	struct sha256_hash_ctx *sha_ctx;
 	struct mcryptd_hash_request_ctx *req_ctx;
@@ -447,9 +448,9 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 	if (irqs_disabled())
 		rctx->complete(&req->base, err);
 	else {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rctx->complete(&req->base, err);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/* check to see if there are other jobs that are done */
@@ -466,9 +467,9 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 			if (irqs_disabled())
 				req_ctx->complete(&req->base, ret);
 			else {
-				local_bh_disable();
+				bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 				req_ctx->complete(&req->base, ret);
-				local_bh_enable();
+				local_bh_enable(bh);
 			}
 		}
 		sha_ctx = sha256_ctx_mgr_get_comp_ctx(cstate->mgr);
diff --git a/arch/x86/crypto/sha512-mb/sha512_mb.c b/arch/x86/crypto/sha512-mb/sha512_mb.c
index 26b8567..f8ab09d 100644
--- a/arch/x86/crypto/sha512-mb/sha512_mb.c
+++ b/arch/x86/crypto/sha512-mb/sha512_mb.c
@@ -463,6 +463,7 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 			    struct mcryptd_alg_cstate *cstate,
 			    int err)
 {
+	unsigned int bh;
 	struct ahash_request *req = cast_mcryptd_ctx_to_req(rctx);
 	struct sha512_hash_ctx *sha_ctx;
 	struct mcryptd_hash_request_ctx *req_ctx;
@@ -477,9 +478,9 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 	if (irqs_disabled())
 		rctx->complete(&req->base, err);
 	else {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rctx->complete(&req->base, err);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/* check to see if there are other jobs that are done */
@@ -496,9 +497,9 @@ static int sha_complete_job(struct mcryptd_hash_request_ctx *rctx,
 			if (irqs_disabled())
 				req_ctx->complete(&req->base, ret);
 			else {
-				local_bh_disable();
+				bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 				req_ctx->complete(&req->base, ret);
-				local_bh_enable();
+				local_bh_enable(bh);
 			}
 		}
 		sha_ctx = sha512_ctx_mgr_get_comp_ctx(cstate);
diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index addca7b..ee245c9 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -168,6 +168,7 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
  * do. */
 static void cryptd_queue_worker(struct work_struct *work)
 {
+	unsigned int bh;
 	struct cryptd_cpu_queue *cpu_queue;
 	struct crypto_async_request *req, *backlog;
 
@@ -178,12 +179,12 @@ static void cryptd_queue_worker(struct work_struct *work)
 	 * cryptd_enqueue_request(). local_bh_disable/enable is used to prevent
 	 * cryptd_enqueue_request() being accessed from software interrupts.
 	 */
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	preempt_disable();
 	backlog = crypto_get_backlog(&cpu_queue->queue);
 	req = crypto_dequeue_request(&cpu_queue->queue);
 	preempt_enable();
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (!req)
 		return;
@@ -240,6 +241,7 @@ static void cryptd_blkcipher_crypt(struct ablkcipher_request *req,
 						struct scatterlist *src,
 						unsigned int len))
 {
+	unsigned int bh;
 	struct cryptd_blkcipher_request_ctx *rctx;
 	struct cryptd_blkcipher_ctx *ctx;
 	struct crypto_ablkcipher *tfm;
@@ -264,9 +266,9 @@ static void cryptd_blkcipher_crypt(struct ablkcipher_request *req,
 	ctx = crypto_ablkcipher_ctx(tfm);
 	refcnt = atomic_read(&ctx->refcnt);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (err != -EINPROGRESS && refcnt && atomic_dec_and_test(&ctx->refcnt))
 		crypto_free_ablkcipher(tfm);
@@ -463,14 +465,15 @@ static int cryptd_skcipher_setkey(struct crypto_skcipher *parent,
 
 static void cryptd_skcipher_complete(struct skcipher_request *req, int err)
 {
+	unsigned int bh;
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct cryptd_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct cryptd_skcipher_request_ctx *rctx = skcipher_request_ctx(req);
 	int refcnt = atomic_read(&ctx->refcnt);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (err != -EINPROGRESS && refcnt && atomic_dec_and_test(&ctx->refcnt))
 		crypto_free_skcipher(tfm);
@@ -713,14 +716,15 @@ static int cryptd_hash_enqueue(struct ahash_request *req,
 
 static void cryptd_hash_complete(struct ahash_request *req, int err)
 {
+	unsigned int bh;
 	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
 	struct cryptd_hash_ctx *ctx = crypto_ahash_ctx(tfm);
 	struct cryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
 	int refcnt = atomic_read(&ctx->refcnt);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (err != -EINPROGRESS && refcnt && atomic_dec_and_test(&ctx->refcnt))
 		crypto_free_ahash(tfm);
@@ -952,6 +956,7 @@ static void cryptd_aead_crypt(struct aead_request *req,
 			int err,
 			int (*crypt)(struct aead_request *req))
 {
+	unsigned int bh;
 	struct cryptd_aead_request_ctx *rctx;
 	struct cryptd_aead_ctx *ctx;
 	crypto_completion_t compl;
@@ -972,9 +977,9 @@ static void cryptd_aead_crypt(struct aead_request *req,
 	ctx = crypto_aead_ctx(tfm);
 	refcnt = atomic_read(&ctx->refcnt);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	compl(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (err != -EINPROGRESS && refcnt && atomic_dec_and_test(&ctx->refcnt))
 		crypto_free_aead(tfm);
diff --git a/crypto/mcryptd.c b/crypto/mcryptd.c
index f141521..1c8e1b8 100644
--- a/crypto/mcryptd.c
+++ b/crypto/mcryptd.c
@@ -331,6 +331,7 @@ static int mcryptd_hash_enqueue(struct ahash_request *req,
 
 static void mcryptd_hash_init(struct crypto_async_request *req_async, int err)
 {
+	unsigned int bh;
 	struct mcryptd_hash_ctx *ctx = crypto_tfm_ctx(req_async->tfm);
 	struct crypto_ahash *child = ctx->child;
 	struct ahash_request *req = ahash_request_cast(req_async);
@@ -348,9 +349,9 @@ static void mcryptd_hash_init(struct crypto_async_request *req_async, int err)
 	err = crypto_ahash_init(desc);
 
 out:
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static int mcryptd_hash_init_enqueue(struct ahash_request *req)
@@ -360,6 +361,7 @@ static int mcryptd_hash_init_enqueue(struct ahash_request *req)
 
 static void mcryptd_hash_update(struct crypto_async_request *req_async, int err)
 {
+	unsigned int bh;
 	struct ahash_request *req = ahash_request_cast(req_async);
 	struct mcryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
 
@@ -375,9 +377,9 @@ static void mcryptd_hash_update(struct crypto_async_request *req_async, int err)
 
 	return;
 out:
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static int mcryptd_hash_update_enqueue(struct ahash_request *req)
@@ -387,6 +389,7 @@ static int mcryptd_hash_update_enqueue(struct ahash_request *req)
 
 static void mcryptd_hash_final(struct crypto_async_request *req_async, int err)
 {
+	unsigned int bh;
 	struct ahash_request *req = ahash_request_cast(req_async);
 	struct mcryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
 
@@ -402,9 +405,9 @@ static void mcryptd_hash_final(struct crypto_async_request *req_async, int err)
 
 	return;
 out:
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static int mcryptd_hash_final_enqueue(struct ahash_request *req)
@@ -414,6 +417,7 @@ static int mcryptd_hash_final_enqueue(struct ahash_request *req)
 
 static void mcryptd_hash_finup(struct crypto_async_request *req_async, int err)
 {
+	unsigned int bh;
 	struct ahash_request *req = ahash_request_cast(req_async);
 	struct mcryptd_hash_request_ctx *rctx = ahash_request_ctx(req);
 
@@ -429,9 +433,9 @@ static void mcryptd_hash_finup(struct crypto_async_request *req_async, int err)
 
 	return;
 out:
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static int mcryptd_hash_finup_enqueue(struct ahash_request *req)
@@ -441,6 +445,7 @@ static int mcryptd_hash_finup_enqueue(struct ahash_request *req)
 
 static void mcryptd_hash_digest(struct crypto_async_request *req_async, int err)
 {
+	unsigned int bh;
 	struct mcryptd_hash_ctx *ctx = crypto_tfm_ctx(req_async->tfm);
 	struct crypto_ahash *child = ctx->child;
 	struct ahash_request *req = ahash_request_cast(req_async);
@@ -458,9 +463,9 @@ static void mcryptd_hash_digest(struct crypto_async_request *req_async, int err)
 	err = crypto_ahash_init(desc) ?: crypto_ahash_finup(desc);
 
 out:
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rctx->complete(&req->base, err);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static int mcryptd_hash_digest_enqueue(struct ahash_request *req)
diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 5c539af..72fce32 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -559,19 +559,20 @@ static inline int get_cryptoalg_subtype(struct crypto_tfm *tfm)
 
 static int cxgb4_is_crypto_q_full(struct net_device *dev, unsigned int idx)
 {
+	unsigned int bh;
 	struct adapter *adap = netdev2adap(dev);
 	struct sge_uld_txq_info *txq_info =
 		adap->sge.uld_txq_info[CXGB4_TX_CRYPTO];
 	struct sge_uld_txq *txq;
 	int ret = 0;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	txq = &txq_info->uldtxq[idx];
 	spin_lock(&txq->sendq.lock);
 	if (txq->full)
 		ret = -1;
 	spin_unlock(&txq->sendq.lock);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return ret;
 }
 
diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 0997e16..8af8c84 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -298,6 +298,7 @@ static int make_close_transition(struct sock *sk)
 
 void chtls_close(struct sock *sk, long timeout)
 {
+	unsigned int bh;
 	int data_lost, prev_state;
 	struct chtls_sock *csk;
 
@@ -333,7 +334,7 @@ void chtls_close(struct sock *sk, long timeout)
 
 	release_sock(sk);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	bh_lock_sock(sk);
 
 	if (prev_state != TCP_CLOSE && sk->sk_state == TCP_CLOSE)
@@ -353,7 +354,7 @@ void chtls_close(struct sock *sk, long timeout)
 
 out:
 	bh_unlock_sock(sk);
-	local_bh_enable();
+	local_bh_enable(bh);
 	sock_put(sk);
 }
 
@@ -470,6 +471,7 @@ static void reset_listen_child(struct sock *child)
 
 static void chtls_disconnect_acceptq(struct sock *listen_sk)
 {
+	unsigned int bh;
 	struct request_sock **pprev;
 
 	pprev = ACCEPT_QUEUE(listen_sk);
@@ -483,12 +485,12 @@ static void chtls_disconnect_acceptq(struct sock *listen_sk)
 			sk_acceptq_removed(listen_sk);
 			reqsk_put(req);
 			sock_hold(child);
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			bh_lock_sock(child);
 			release_tcp_port(child);
 			reset_listen_child(child);
 			bh_unlock_sock(child);
-			local_bh_enable();
+			local_bh_enable(bh);
 			sock_put(child);
 		} else {
 			pprev = &req->dl_next;
@@ -577,6 +579,7 @@ static void cleanup_syn_rcv_conn(struct sock *child, struct sock *parent)
 
 static void chtls_reset_synq(struct listen_ctx *listen_ctx)
 {
+	unsigned int bh;
 	struct sock *listen_sk = listen_ctx->lsk;
 
 	while (!skb_queue_empty(&listen_ctx->synq)) {
@@ -587,12 +590,12 @@ static void chtls_reset_synq(struct listen_ctx *listen_ctx)
 
 		cleanup_syn_rcv_conn(child, listen_sk);
 		sock_hold(child);
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		bh_lock_sock(child);
 		release_tcp_port(child);
 		reset_listen_child(child);
 		bh_unlock_sock(child);
-		local_bh_enable();
+		local_bh_enable(bh);
 		sock_put(child);
 	}
 }
@@ -993,9 +996,10 @@ static void chtls_pass_accept_rpl(struct sk_buff *skb,
 static void inet_inherit_port(struct inet_hashinfo *hash_info,
 			      struct sock *lsk, struct sock *newsk)
 {
-	local_bh_disable();
+	unsigned int bh;
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	__inet_inherit_port(lsk, newsk);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static int chtls_backlog_rcv(struct sock *sk, struct sk_buff *skb)
@@ -1329,9 +1333,10 @@ static DECLARE_WORK(reap_task, process_reap_list);
 
 static void add_to_reap_list(struct sock *sk)
 {
+	unsigned int bh;
 	struct chtls_sock *csk = sk->sk_user_data;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	bh_lock_sock(sk);
 	release_tcp_port(sk); /* release the port immediately */
 
@@ -1342,7 +1347,7 @@ static void add_to_reap_list(struct sock *sk)
 		schedule_work(&reap_task);
 	spin_unlock(&reap_list_lock);
 	bh_unlock_sock(sk);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static void add_pass_open_to_parent(struct sock *child, struct sock *lsk,
diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 7e71043..2532cce 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -684,6 +684,7 @@ int safexcel_invalidate_cache(struct crypto_async_request *async,
 static inline void safexcel_handle_result_descriptor(struct safexcel_crypto_priv *priv,
 						     int ring)
 {
+	unsigned int bh;
 	struct crypto_async_request *req;
 	struct safexcel_context *ctx;
 	int ret, i, nreq, ndesc, tot_descs, handled = 0;
@@ -710,9 +711,9 @@ static inline void safexcel_handle_result_descriptor(struct safexcel_crypto_priv
 		}
 
 		if (should_complete) {
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			req->complete(req, ret);
-			local_bh_enable();
+			local_bh_enable(bh);
 		}
 
 		tot_descs += ndesc;
diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index a4aa681..bee4bb8 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -107,10 +107,11 @@ static inline void
 mv_cesa_complete_req(struct mv_cesa_ctx *ctx, struct crypto_async_request *req,
 		     int res)
 {
+	unsigned int bh;
 	ctx->ops->cleanup(req);
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	req->complete(req, res);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static irqreturn_t mv_cesa_int(int irq, void *priv)
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index fcc73a6..ae4dc5b 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -575,6 +575,7 @@ i915_gem_object_wait_reservation(struct reservation_object *resv,
 static void __fence_set_priority(struct dma_fence *fence,
 				 const struct i915_sched_attr *attr)
 {
+	unsigned int bh;
 	struct i915_request *rq;
 	struct intel_engine_cs *engine;
 
@@ -584,12 +585,12 @@ static void __fence_set_priority(struct dma_fence *fence,
 	rq = to_request(fence);
 	engine = rq->engine;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rcu_read_lock(); /* RCU serialisation for set-wedged protection */
 	if (engine->schedule)
 		engine->schedule(rq, attr);
 	rcu_read_unlock();
-	local_bh_enable(); /* kick the tasklets if queues were reprioritised */
+	local_bh_enable(bh); /* kick the tasklets if queues were reprioritised */
 }
 
 static void fence_set_priority(struct dma_fence *fence,
diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 5c2c93c..4bc4a12 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -1043,6 +1043,7 @@ void i915_request_skip(struct i915_request *rq, int error)
  */
 void i915_request_add(struct i915_request *request)
 {
+	unsigned int bh;
 	struct intel_engine_cs *engine = request->engine;
 	struct i915_timeline *timeline = request->timeline;
 	struct intel_ring *ring = request->ring;
@@ -1124,13 +1125,13 @@ void i915_request_add(struct i915_request *request)
 	 * decide whether to preempt the entire chain so that it is ready to
 	 * run at the earliest possible convenience.
 	 */
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rcu_read_lock(); /* RCU serialisation for set-wedged protection */
 	if (engine->schedule)
 		engine->schedule(request, &request->gem_context->sched);
 	rcu_read_unlock();
 	i915_sw_fence_commit(&request->submit);
-	local_bh_enable(); /* Kick the execlists tasklet if just scheduled */
+	local_bh_enable(bh); /* Kick the execlists tasklet if just scheduled */
 
 	/*
 	 * In typical scenarios, we do not expect the previous request on
diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
index 1db6ba7..31e8d73 100644
--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -615,6 +615,7 @@ static void signaler_set_rtpriority(void)
 
 static int intel_breadcrumbs_signaler(void *arg)
 {
+	unsigned int bh;
 	struct intel_engine_cs *engine = arg;
 	struct intel_breadcrumbs *b = &engine->breadcrumbs;
 	struct i915_request *rq, *n;
@@ -669,13 +670,13 @@ static int intel_breadcrumbs_signaler(void *arg)
 		spin_unlock_irq(&b->rb_lock);
 
 		if (!list_empty(&list)) {
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			list_for_each_entry_safe(rq, n, &list, signaling.link) {
 				dma_fence_signal(&rq->fence);
 				GEM_BUG_ON(!i915_request_completed(rq));
 				i915_request_put(rq);
 			}
-			local_bh_enable(); /* kick start the tasklets */
+			local_bh_enable(bh); /* kick start the tasklets */
 
 			/*
 			 * If the engine is saturated we may be continually
diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
index 2d19528..cbf7776 100644
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -973,6 +973,7 @@ static bool ring_is_idle(struct intel_engine_cs *engine)
  */
 bool intel_engine_is_idle(struct intel_engine_cs *engine)
 {
+	unsigned int bh;
 	struct drm_i915_private *dev_priv = engine->i915;
 
 	/* More white lies, if wedged, hw state is inconsistent */
@@ -991,14 +992,14 @@ bool intel_engine_is_idle(struct intel_engine_cs *engine)
 	if (READ_ONCE(engine->execlists.active)) {
 		struct tasklet_struct *t = &engine->execlists.tasklet;
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		if (tasklet_trylock(t)) {
 			/* Must wait for any GPU reset in progress. */
 			if (__tasklet_is_enabled(t))
 				t->func(t->data);
 			tasklet_unlock(t);
 		}
-		local_bh_enable();
+		local_bh_enable(bh);
 
 		if (READ_ONCE(engine->execlists.active))
 			return false;
diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index a1d4b93..a3de8f3 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -752,9 +752,10 @@ static unsigned int cs_hsi_get_state(struct cs_hsi_iface *hi)
 
 static int cs_hsi_command(struct cs_hsi_iface *hi, u32 cmd)
 {
+	unsigned int bh;
 	int ret = 0;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	switch (cmd & TARGET_MASK) {
 	case TARGET_REMOTE:
 		ret = cs_hsi_write_on_control(hi, cmd);
@@ -769,7 +770,7 @@ static int cs_hsi_command(struct cs_hsi_iface *hi, u32 cmd)
 		ret = -EINVAL;
 		break;
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return ret;
 }
@@ -937,6 +938,7 @@ static void cs_hsi_data_disable(struct cs_hsi_iface *hi, int old_state)
 static int cs_hsi_buf_config(struct cs_hsi_iface *hi,
 					struct cs_buffer_config *buf_cfg)
 {
+	unsigned int bh;
 	int r = 0;
 	unsigned int old_state = hi->iface_state;
 
@@ -981,9 +983,9 @@ static int cs_hsi_buf_config(struct cs_hsi_iface *hi,
 			pm_qos_add_request(&hi->pm_qos_req,
 				PM_QOS_CPU_DMA_LATENCY,
 				CS_QOS_LATENCY_FOR_DATA_USEC);
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			cs_hsi_read_on_data(hi);
-			local_bh_enable();
+			local_bh_enable(bh);
 		} else if (old_state == CS_STATE_CONFIGURED) {
 			pm_qos_remove_request(&hi->pm_qos_req);
 		}
@@ -998,6 +1000,7 @@ static int cs_hsi_buf_config(struct cs_hsi_iface *hi,
 static int cs_hsi_start(struct cs_hsi_iface **hi, struct hsi_client *cl,
 			unsigned long mmap_base, unsigned long mmap_size)
 {
+	unsigned int bh;
 	int err = 0;
 	struct cs_hsi_iface *hsi_if = kzalloc(sizeof(*hsi_if), GFP_KERNEL);
 
@@ -1045,9 +1048,9 @@ static int cs_hsi_start(struct cs_hsi_iface **hi, struct hsi_client *cl,
 	}
 
 	hsi_if->iface_state = CS_STATE_OPENED;
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	cs_hsi_read_on_control(hsi_if);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	dev_dbg(&cl->device, "cs_hsi_start...done\n");
 
diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
index 4f1544a..7ffffd4 100644
--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -137,6 +137,7 @@ EXPORT_SYMBOL(rvt_cq_enter);
 
 static void send_complete(struct work_struct *work)
 {
+	unsigned int bh;
 	struct rvt_cq *cq = container_of(work, struct rvt_cq, comptask);
 
 	/*
@@ -155,9 +156,9 @@ static void send_complete(struct work_struct *work)
 		 * See the implementation for ipoib_cm_handle_tx_wc(),
 		 * netif_tx_lock_bh() and netif_tx_lock().
 		 */
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
-		local_bh_enable();
+		local_bh_enable(bh);
 
 		if (cq->triggered == triggered)
 			return;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 87f2a5c..ec3f30d 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -967,6 +967,7 @@ void ipoib_ib_dev_down(struct net_device *dev)
 
 void ipoib_drain_cq(struct net_device *dev)
 {
+	unsigned int bh;
 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
 	int i, n;
 
@@ -975,7 +976,7 @@ void ipoib_drain_cq(struct net_device *dev)
 	 * called from the BH-disabled NAPI poll context, so disable
 	 * BHs here too.
 	 */
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	do {
 		n = ib_poll_cq(priv->recv_cq, IPOIB_NUM_WC, priv->ibwc);
@@ -1002,7 +1003,7 @@ void ipoib_drain_cq(struct net_device *dev)
 	while (poll_tx(priv))
 		; /* nothing */
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /*
diff --git a/drivers/isdn/i4l/isdn_net.h b/drivers/isdn/i4l/isdn_net.h
index f4621b1..bb87788 100644
--- a/drivers/isdn/i4l/isdn_net.h
+++ b/drivers/isdn/i4l/isdn_net.h
@@ -95,7 +95,7 @@ static __inline__ isdn_net_local *isdn_net_get_locked_lp(isdn_net_dev *nd,
 	nd->queue = nd->queue->next;
 	spin_unlock_irqrestore(&nd->queue_lock, flags);
 	spin_lock(&lp->xmit_lock);
-	local_bh_disable();
+	*bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	return lp;
 errout:
 	spin_unlock_irqrestore(&nd->queue_lock, flags);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index a4a90b6c..c4974142 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -2460,6 +2460,7 @@ static void bnx2x_wait_for_link(struct bnx2x *bp, u8 link_up, u8 is_serdes)
 
 static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
 {
+	unsigned int bh;
 	unsigned int pkt_size, num_pkts, i;
 	struct sk_buff *skb;
 	unsigned char *packet;
@@ -2616,9 +2617,9 @@ static int bnx2x_run_loopback(struct bnx2x *bp, int loopback_mode)
 		 * sch_direct_xmit() and bnx2x_run_loopback() (calling
 		 * bnx2x_tx_int()), as both are taking netif_tx_lock().
 		 */
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		bnx2x_tx_int(bp, txdata);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	rx_idx = le16_to_cpu(*fp_rx->rx_cons_sb);
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 71362b7..f37973e 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -5661,6 +5661,7 @@ static void bnx2x_eq_int(struct bnx2x *bp)
 
 static void bnx2x_sp_task(struct work_struct *work)
 {
+	unsigned int bh;
 	struct bnx2x *bp = container_of(work, struct bnx2x, sp_task.work);
 
 	DP(BNX2X_MSG_SP, "sp task invoked\n");
@@ -5691,9 +5692,9 @@ static void bnx2x_sp_task(struct work_struct *work)
 				/* Prevent local bottom-halves from running as
 				 * we are going to change the local NAPI list.
 				 */
-				local_bh_disable();
+				bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 				napi_schedule(&bnx2x_fcoe(bp, napi));
-				local_bh_enable();
+				local_bh_enable(bh);
 			}
 
 			/* Handle EQ completions */
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index a19172d..b736aed 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -893,11 +893,12 @@ static const struct attribute_group offload_attr_group = {
  */
 static inline int offload_tx(struct t3cdev *tdev, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int ret;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = t3_offload_tx(tdev, skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
index 50cd660..462c3e4 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_offload.c
@@ -1042,11 +1042,12 @@ static int process_rx(struct t3cdev *dev, struct sk_buff **skbs, int n)
  */
 int cxgb3_ofld_send(struct t3cdev *dev, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int r;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	r = dev->send(dev, skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return r;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb3/sge.c b/drivers/net/ethernet/chelsio/cxgb3/sge.c
index 20b6e1b..4d1fe4b 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/sge.c
@@ -1562,10 +1562,11 @@ static void restart_ctrlq(unsigned long data)
  */
 int t3_mgmt_tx(struct adapter *adap, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int ret;
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = ctrl_xmit(adap, &adap->sge.qs[0].txq[TXQ_CTRL], skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 961e3087..f6cc11d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -441,6 +441,7 @@ static int set_rxmode(struct net_device *dev, int mtu, bool sleep_ok)
  */
 static int link_start(struct net_device *dev)
 {
+	unsigned int bh;
 	int ret;
 	struct port_info *pi = netdev_priv(dev);
 	unsigned int mb = pi->adapter->pf;
@@ -464,10 +465,10 @@ static int link_start(struct net_device *dev)
 		ret = t4_link_l1cfg(pi->adapter, mb, pi->tx_chan,
 				    &pi->link_cfg);
 	if (ret == 0) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		ret = t4_enable_pi_params(pi->adapter, mb, pi, true,
 					  true, CXGB4_DCB_ENABLED);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	return ret;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index a9799ce..f85d437 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -2071,11 +2071,12 @@ static void restart_ctrlq(unsigned long data)
  */
 int t4_mgmt_tx(struct adapter *adap, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int ret;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = ctrl_xmit(&adap->sge.ctrlq[0], skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return ret;
 }
 
@@ -2385,11 +2386,12 @@ static inline int uld_send(struct adapter *adap, struct sk_buff *skb,
  */
 int t4_ofld_send(struct adapter *adap, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int ret;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = uld_send(adap, skb, CXGB4_TX_OFLD);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return ret;
 }
 
@@ -2482,6 +2484,7 @@ static int ofld_xmit_direct(struct sge_uld_txq *q, const void *src,
 int cxgb4_immdata_send(struct net_device *dev, unsigned int idx,
 		       const void *src, unsigned int len)
 {
+	unsigned int bh;
 	struct sge_uld_txq_info *txq_info;
 	struct sge_uld_txq *txq;
 	struct adapter *adap;
@@ -2489,17 +2492,17 @@ int cxgb4_immdata_send(struct net_device *dev, unsigned int idx,
 
 	adap = netdev2adap(dev);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	txq_info = adap->sge.uld_txq_info[CXGB4_TX_OFLD];
 	if (unlikely(!txq_info)) {
 		WARN_ON(true);
-		local_bh_enable();
+		local_bh_enable(bh);
 		return NET_XMIT_DROP;
 	}
 	txq = &txq_info->uldtxq[idx];
 
 	ret = ofld_xmit_direct(txq, src, len);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return net_xmit_eval(ret);
 }
 EXPORT_SYMBOL(cxgb4_immdata_send);
@@ -2515,11 +2518,12 @@ EXPORT_SYMBOL(cxgb4_immdata_send);
  */
 static int t4_crypto_send(struct adapter *adap, struct sk_buff *skb)
 {
+	unsigned int bh;
 	int ret;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = uld_send(adap, skb, CXGB4_TX_CRYPTO);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 1e9d882..c6bdc33 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -577,6 +577,7 @@ int be_process_mcc(struct be_adapter *adapter)
 /* Wait till no more pending mcc requests are present */
 static int be_mcc_wait_compl(struct be_adapter *adapter)
 {
+	unsigned int bh;
 #define mcc_timeout		12000 /* 12s timeout */
 	int i, status = 0;
 	struct be_mcc_obj *mcc_obj = &adapter->mcc_obj;
@@ -585,9 +586,9 @@ static int be_mcc_wait_compl(struct be_adapter *adapter)
 		if (be_check_error(adapter, BE_ERROR_ANY))
 			return -EIO;
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		status = be_process_mcc(adapter);
-		local_bh_enable();
+		local_bh_enable(bh);
 
 		if (atomic_read(&mcc_obj->q.used) == 0)
 			break;
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 74d1226..dc7d2ad 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5616,6 +5616,7 @@ static void be_log_sfp_info(struct be_adapter *adapter)
 
 static void be_worker(struct work_struct *work)
 {
+	unsigned int bh;
 	struct be_adapter *adapter =
 		container_of(work, struct be_adapter, work.work);
 	struct be_rx_obj *rxo;
@@ -5629,9 +5630,9 @@ static void be_worker(struct work_struct *work)
 	 * mcc completions
 	 */
 	if (!netif_running(adapter->netdev)) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		be_process_mcc(adapter);
-		local_bh_enable();
+		local_bh_enable(bh);
 		goto reschedule;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index 666708a..a5c7e70 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1621,6 +1621,7 @@ static void mlx4_en_init_recycle_ring(struct mlx4_en_priv *priv,
 
 int mlx4_en_start_port(struct net_device *dev)
 {
+	unsigned int bh;
 	struct mlx4_en_priv *priv = netdev_priv(dev);
 	struct mlx4_en_dev *mdev = priv->mdev;
 	struct mlx4_en_cq *cq;
@@ -1835,9 +1836,9 @@ int mlx4_en_start_port(struct net_device *dev)
 	 * the queues freezing if they are full
 	 */
 	for (i = 0; i < priv->rx_ring_num; i++) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		napi_schedule(&priv->rx_cq[i]->napi);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	netif_tx_start_all_queues(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
index a1aeeb8..4616e1a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
@@ -395,6 +395,7 @@ int mlx4_en_activate_rx_rings(struct mlx4_en_priv *priv)
  */
 void mlx4_en_recover_from_oom(struct mlx4_en_priv *priv)
 {
+	unsigned int bh;
 	int ring;
 
 	if (!priv->port_up)
@@ -402,9 +403,9 @@ void mlx4_en_recover_from_oom(struct mlx4_en_priv *priv)
 
 	for (ring = 0; ring < priv->rx_ring_num; ring++) {
 		if (mlx4_en_is_ring_empty(priv->rx_ring[ring])) {
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			napi_reschedule(&priv->rx_cq[ring]->napi);
-			local_bh_enable();
+			local_bh_enable(bh);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index f216615..5148b1f 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -805,12 +805,13 @@ static int efx_ptp_disable(struct efx_nic *efx)
 
 static void efx_ptp_deliver_rx_queue(struct sk_buff_head *q)
 {
+	unsigned int bh;
 	struct sk_buff *skb;
 
 	while ((skb = skb_dequeue(q))) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		netif_receive_skb(skb);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 }
 
@@ -1225,9 +1226,10 @@ static void efx_ptp_process_events(struct efx_nic *efx, struct sk_buff_head *q)
 /* Complete processing of a received packet */
 static inline void efx_ptp_process_rx(struct efx_nic *efx, struct sk_buff *skb)
 {
-	local_bh_disable();
+	unsigned int bh;
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	netif_receive_skb(skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static void efx_ptp_remove_multicast_filters(struct efx_nic *efx)
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 1a8132e..193c473 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -229,6 +229,7 @@ unsigned int ipvlan_mac_hash(const unsigned char *addr)
 
 void ipvlan_process_multicast(struct work_struct *work)
 {
+	unsigned int bh;
 	struct ipvl_port *port = container_of(work, struct ipvl_port, wq);
 	struct ethhdr *ethh;
 	struct ipvl_dev *ipvlan;
@@ -270,7 +271,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 			ret = NET_RX_DROP;
 			len = skb->len + ETH_HLEN;
 			nskb = skb_clone(skb, GFP_ATOMIC);
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			if (nskb) {
 				consumed = true;
 				nskb->pkt_type = pkt_type;
@@ -281,7 +282,7 @@ void ipvlan_process_multicast(struct work_struct *work)
 					ret = netif_rx(nskb);
 			}
 			ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, true);
-			local_bh_enable();
+			local_bh_enable(bh);
 		}
 		rcu_read_unlock();
 
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 02ad03a..c505ecb 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1425,7 +1425,8 @@ static void __ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 
 static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
-	local_bh_disable();
+	unsigned int bh;
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	if (unlikely(*this_cpu_ptr(ppp->xmit_recursion)))
 		goto err;
@@ -1434,12 +1435,12 @@ static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 	__ppp_xmit_process(ppp, skb);
 	(*this_cpu_ptr(ppp->xmit_recursion))--;
 
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return;
 
 err:
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	kfree_skb(skb);
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ebd07ad..172a5da 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1482,6 +1482,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
 					    size_t len,
 					    const struct iov_iter *it)
 {
+	unsigned int bh;
 	struct sk_buff *skb;
 	size_t linear;
 	int err;
@@ -1490,9 +1491,9 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
 	if (it->nr_segs > MAX_SKB_FRAGS + 1)
 		return ERR_PTR(-ENOMEM);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	skb = napi_get_frags(&tfile->napi);
-	local_bh_enable();
+	local_bh_enable(bh);
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
 
@@ -1562,15 +1563,16 @@ static struct sk_buff *tun_alloc_skb(struct tun_file *tfile,
 static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
 			   struct sk_buff *skb, int more)
 {
+	unsigned int bh;
 	struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
 	struct sk_buff_head process_queue;
 	u32 rx_batched = tun->rx_batched;
 	bool rcv = false;
 
 	if (!rx_batched || (!more && skb_queue_empty(queue))) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		netif_receive_skb(skb);
-		local_bh_enable();
+		local_bh_enable(bh);
 		return;
 	}
 
@@ -1587,11 +1589,11 @@ static void tun_rx_batched(struct tun_struct *tun, struct tun_file *tfile,
 	if (rcv) {
 		struct sk_buff *nskb;
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		while ((nskb = __skb_dequeue(&process_queue)))
 			netif_receive_skb(nskb);
 		netif_receive_skb(skb);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 }
 
@@ -1623,6 +1625,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct virtio_net_hdr *hdr,
 				     int len, int *skb_xdp)
 {
+	unsigned int bh;
 	struct page_frag *alloc_frag = &current->task_frag;
 	struct sk_buff *skb;
 	struct bpf_prog *xdp_prog;
@@ -1659,7 +1662,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	else
 		*skb_xdp = 0;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rcu_read_lock();
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog && !*skb_xdp) {
@@ -1684,7 +1687,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			if (err)
 				goto err_redirect;
 			rcu_read_unlock();
-			local_bh_enable();
+			local_bh_enable(bh);
 			return NULL;
 		case XDP_TX:
 			get_page(alloc_frag->page);
@@ -1692,7 +1695,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 			if (tun_xdp_tx(tun->dev, &xdp) < 0)
 				goto err_redirect;
 			rcu_read_unlock();
-			local_bh_enable();
+			local_bh_enable(bh);
 			return NULL;
 		case XDP_PASS:
 			delta = orig_data - xdp.data;
@@ -1712,7 +1715,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	skb = build_skb(buf, buflen);
 	if (!skb) {
 		rcu_read_unlock();
-		local_bh_enable();
+		local_bh_enable(bh);
 		return ERR_PTR(-ENOMEM);
 	}
 
@@ -1722,7 +1725,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	alloc_frag->offset += buflen;
 
 	rcu_read_unlock();
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return skb;
 
@@ -1730,7 +1733,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	put_page(alloc_frag->page);
 err_xdp:
 	rcu_read_unlock();
-	local_bh_enable();
+	local_bh_enable(bh);
 	this_cpu_inc(tun->pcpu_stats->rx_dropped);
 	return NULL;
 }
@@ -1740,6 +1743,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			    void *msg_control, struct iov_iter *from,
 			    int noblock, bool more)
 {
+	unsigned int bh;
 	struct tun_pi pi = { 0, cpu_to_be16(ETH_P_IP) };
 	struct sk_buff *skb;
 	size_t total_len = iov_iter_count(from);
@@ -1926,19 +1930,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		struct bpf_prog *xdp_prog;
 		int ret;
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rcu_read_lock();
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
 			ret = do_xdp_generic(xdp_prog, skb);
 			if (ret != XDP_PASS) {
 				rcu_read_unlock();
-				local_bh_enable();
+				local_bh_enable(bh);
 				return total_len;
 			}
 		}
 		rcu_read_unlock();
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/* Compute the costly rx hash only if needed for flow updates.
@@ -1961,9 +1965,9 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 			return -ENOMEM;
 		}
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		napi_gro_frags(&tfile->napi);
-		local_bh_enable();
+		local_bh_enable(bh);
 		mutex_unlock(&tfile->napi_mutex);
 	} else if (tfile->napi_enabled) {
 		struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
@@ -1977,7 +1981,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 		if (!more || queue_len > NAPI_POLL_WEIGHT)
 			napi_schedule(&tfile->napi);
 
-		local_bh_enable();
+		local_bh_enable(0);
 	} else if (!IS_ENABLED(CONFIG_4KSTACKS)) {
 		tun_rx_batched(tun, tfile, skb, more);
 	} else {
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7659209..4a15c36 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1224,15 +1224,16 @@ static void skb_recv_done(struct virtqueue *rvq)
 
 static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
+	unsigned int bh;
 	napi_enable(napi);
 
 	/* If all buffers were filled by other side before we napi_enabled, we
 	 * won't get another interrupt, so process any outstanding packets now.
 	 * Call local_bh_enable after to trigger softIRQ processing.
 	 */
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	virtqueue_napi_schedule(napi, vq);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static void virtnet_napi_tx_enable(struct virtnet_info *vi,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 05b7741..061903e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1141,6 +1141,7 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 					     char *buf, size_t count,
 					     loff_t *ppos)
 {
+	unsigned int bh;
 	struct iwl_rx_cmd_buffer rxb = {
 		._rx_page_order = 0,
 		.truesize = 0, /* not used */
@@ -1186,9 +1187,9 @@ static ssize_t iwl_dbgfs_inject_packet_write(struct iwl_mvm *mvm,
 	    (bin_len - mpdu_cmd_hdr_size - sizeof(*pkt)))
 		goto out;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	iwl_mvm_rx_mpdu_mq(mvm, NULL, &rxb, 0);
-	local_bh_enable();
+	local_bh_enable(bh);
 	ret = 0;
 
 out:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 18db1ed..d3c43c5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1040,6 +1040,7 @@ static inline u8 iwl_mvm_tid_to_ac_queue(int tid)
 static void iwl_mvm_tx_deferred_stream(struct iwl_mvm *mvm,
 				       struct ieee80211_sta *sta, int tid)
 {
+	unsigned int bh;
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_tid_data *tid_data = &mvmsta->tid_data[tid];
 	struct sk_buff *skb;
@@ -1075,7 +1076,7 @@ static void iwl_mvm_tx_deferred_stream(struct iwl_mvm *mvm,
 	__skb_queue_head_init(&deferred_tx);
 
 	/* Disable bottom-halves when entering TX path */
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	spin_lock(&mvmsta->lock);
 	skb_queue_splice_init(&tid_data->deferred_tx_frames, &deferred_tx);
 	mvmsta->deferred_traffic_tid_map &= ~BIT(tid);
@@ -1084,7 +1085,7 @@ static void iwl_mvm_tx_deferred_stream(struct iwl_mvm *mvm,
 	while ((skb = __skb_dequeue(&deferred_tx)))
 		if (no_queue || iwl_mvm_tx_skb(mvm, skb, sta))
 			ieee80211_free_txskb(mvm->hw, skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	/* Wake queue */
 	iwl_mvm_start_mac_queues(mvm, BIT(mac_queue));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index d017aa2..aded2e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1485,6 +1485,7 @@ static struct iwl_trans_pcie *iwl_pcie_get_trans_pcie(struct msix_entry *entry)
  */
 irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 {
+	unsigned int bh;
 	struct msix_entry *entry = dev_id;
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
@@ -1496,9 +1497,9 @@ irqreturn_t iwl_pcie_irq_rx_msix_handler(int irq, void *dev_id)
 
 	lock_map_acquire(&trans->sync_cmd_lockdep_map);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	iwl_pcie_rx_handle(trans, entry->entry);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	iwl_pcie_clear_irq(trans, entry);
 
@@ -1664,6 +1665,7 @@ void iwl_pcie_handle_rfkill_irq(struct iwl_trans *trans)
 
 irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 {
+	unsigned int bh;
 	struct iwl_trans *trans = dev_id;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct isr_statistics *isr_stats = &trans_pcie->isr_stats;
@@ -1860,9 +1862,9 @@ irqreturn_t iwl_pcie_irq_handler(int irq, void *dev_id)
 
 		isr_stats->rx++;
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		iwl_pcie_rx_handle(trans, 0);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/* This "Tx" DMA channel is used only for loading uCode */
@@ -2014,6 +2016,7 @@ irqreturn_t iwl_pcie_msix_isr(int irq, void *data)
 
 irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 {
+	unsigned int bh;
 	struct msix_entry *entry = dev_id;
 	struct iwl_trans_pcie *trans_pcie = iwl_pcie_get_trans_pcie(entry);
 	struct iwl_trans *trans = trans_pcie->trans;
@@ -2047,16 +2050,16 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	if ((trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX) &&
 	    inta_fh & MSIX_FH_INT_CAUSES_Q0) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		iwl_pcie_rx_handle(trans, 0);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	if ((trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_FIRST_RSS) &&
 	    inta_fh & MSIX_FH_INT_CAUSES_Q1) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		iwl_pcie_rx_handle(trans, 1);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/* This "Tx" DMA channel is used only for loading uCode */
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 1068757..323456e 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -738,6 +738,7 @@ static int hwsim_fops_ps_read(void *dat, u64 *val)
 
 static int hwsim_fops_ps_write(void *dat, u64 val)
 {
+	unsigned int bh;
 	struct mac80211_hwsim_data *data = dat;
 	enum ps_mode old_ps;
 
@@ -748,17 +749,17 @@ static int hwsim_fops_ps_write(void *dat, u64 val)
 	if (val == PS_MANUAL_POLL) {
 		if (data->ps != PS_ENABLED)
 			return -EINVAL;
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_ps_poll, data);
-		local_bh_enable();
+		local_bh_enable(bh);
 		return 0;
 	}
 	old_ps = data->ps;
 	data->ps = val;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	if (old_ps == PS_DISABLED && val != PS_DISABLED) {
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
@@ -768,7 +769,7 @@ static int hwsim_fops_ps_write(void *dat, u64 val)
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_nullfunc_no_ps, data);
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return 0;
 }
@@ -2033,6 +2034,7 @@ static void mac80211_hwsim_flush(struct ieee80211_hw *hw,
 
 static void hw_scan_work(struct work_struct *work)
 {
+	unsigned int bh;
 	struct mac80211_hwsim_data *hwsim =
 		container_of(work, struct mac80211_hwsim_data, hw_scan.work);
 	struct cfg80211_scan_request *req = hwsim->hw_scan_request;
@@ -2083,10 +2085,10 @@ static void hw_scan_work(struct work_struct *work)
 			if (req->ie_len)
 				skb_put_data(probe, req->ie, req->ie_len);
 
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			mac80211_hwsim_tx_frame(hwsim->hw, probe,
 						hwsim->tmp_chan);
-			local_bh_enable();
+			local_bh_enable(bh);
 		}
 	}
 	ieee80211_queue_delayed_work(hwsim->hw, &hwsim->hw_scan,
diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 73c8b28..145e81f 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -94,6 +94,7 @@ mt76_rx_aggr_check_release(struct mt76_rx_tid *tid, struct sk_buff_head *frames)
 static void
 mt76_rx_aggr_reorder_work(struct work_struct *work)
 {
+	unsigned int bh;
 	struct mt76_rx_tid *tid = container_of(work, struct mt76_rx_tid,
 					       reorder_work.work);
 	struct mt76_dev *dev = tid->dev;
@@ -102,7 +103,7 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
 
 	__skb_queue_head_init(&frames);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rcu_read_lock();
 
 	spin_lock(&tid->lock);
@@ -116,7 +117,7 @@ mt76_rx_aggr_reorder_work(struct work_struct *work)
 	mt76_rx_complete(dev, &frames, NULL);
 
 	rcu_read_unlock();
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2_phy_common.c b/drivers/net/wireless/mediatek/mt76/mt76x2_phy_common.c
index 9fd6ab4..0f7c895 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2_phy_common.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2_phy_common.c
@@ -303,12 +303,13 @@ EXPORT_SYMBOL_GPL(mt76x2_phy_set_band);
 
 int mt76x2_phy_get_min_avg_rssi(struct mt76x2_dev *dev)
 {
+	unsigned int bh;
 	struct mt76x2_sta *sta;
 	struct mt76_wcid *wcid;
 	int i, j, min_rssi = 0;
 	s8 cur_rssi;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	rcu_read_lock();
 
 	for (i = 0; i < ARRAY_SIZE(dev->wcid_mask); i++) {
@@ -339,7 +340,7 @@ int mt76x2_phy_get_min_avg_rssi(struct mt76x2_dev *dev)
 	}
 
 	rcu_read_unlock();
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (!min_rssi)
 		return -75;
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 6c6b745..a2231b5 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -535,6 +535,7 @@ sclp_sync_wait(void)
 	unsigned long long old_tick;
 	unsigned long flags;
 	unsigned long cr0, cr0_sync;
+	unsigned int bh;
 	u64 timeout;
 	int irq_context;
 
@@ -551,7 +552,7 @@ sclp_sync_wait(void)
 	/* Prevent bottom half from executing once we force interrupts open */
 	irq_context = in_interrupt();
 	if (!irq_context)
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	/* Enable service-signal interruption, disable timer interrupts */
 	old_tick = local_tick_disable();
 	trace_hardirqs_on();
@@ -572,7 +573,7 @@ sclp_sync_wait(void)
 	local_irq_disable();
 	__ctl_load(cr0, 0, 0);
 	if (!irq_context)
-		local_bh_enable_no_softirq();
+		local_bh_enable_no_softirq(bh);
 	local_tick_enable(old_tick);
 	local_irq_restore(flags);
 }
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index e3fb83b..3484e95 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -587,6 +587,7 @@ void cio_tsch(struct subchannel *sch)
 {
 	struct irb *irb;
 	int irq_context;
+	unsigned int bh;
 
 	irb = this_cpu_ptr(&cio_irb);
 	/* Store interrupt response block to lowcore. */
@@ -597,7 +598,7 @@ void cio_tsch(struct subchannel *sch)
 	/* Call interrupt handler with updated status. */
 	irq_context = in_interrupt();
 	if (!irq_context) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		irq_enter();
 	}
 	kstat_incr_irq_this_cpu(IO_INTERRUPT);
@@ -607,7 +608,7 @@ void cio_tsch(struct subchannel *sch)
 		inc_irq_stat(IRQIO_CIO);
 	if (!irq_context) {
 		irq_exit();
-		local_bh_enable_no_softirq();
+		local_bh_enable_no_softirq(bh);
 	}
 }
 
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index e685412..4d3757a 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -691,13 +691,14 @@ static void zcrypt_status_mask(char status[], size_t max_adapters)
 
 static void zcrypt_qdepth_mask(char qdepth[], size_t max_adapters)
 {
+	unsigned int bh;
 	struct zcrypt_card *zc;
 	struct zcrypt_queue *zq;
 	int card;
 
 	memset(qdepth, 0, max_adapters);
 	spin_lock(&zcrypt_list_lock);
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	for_each_zcrypt_card(zc) {
 		for_each_zcrypt_queue(zq, zc) {
 			card = AP_QID_CARD(zq->queue->qid);
@@ -711,19 +712,20 @@ static void zcrypt_qdepth_mask(char qdepth[], size_t max_adapters)
 			spin_unlock(&zq->queue->lock);
 		}
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 	spin_unlock(&zcrypt_list_lock);
 }
 
 static void zcrypt_perdev_reqcnt(int reqcnt[], size_t max_adapters)
 {
+	unsigned int bh;
 	struct zcrypt_card *zc;
 	struct zcrypt_queue *zq;
 	int card;
 
 	memset(reqcnt, 0, sizeof(int) * max_adapters);
 	spin_lock(&zcrypt_list_lock);
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	for_each_zcrypt_card(zc) {
 		for_each_zcrypt_queue(zq, zc) {
 			card = AP_QID_CARD(zq->queue->qid);
@@ -735,19 +737,20 @@ static void zcrypt_perdev_reqcnt(int reqcnt[], size_t max_adapters)
 			spin_unlock(&zq->queue->lock);
 		}
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 	spin_unlock(&zcrypt_list_lock);
 }
 
 static int zcrypt_pendingq_count(void)
 {
+	unsigned int bh;
 	struct zcrypt_card *zc;
 	struct zcrypt_queue *zq;
 	int pendingq_count;
 
 	pendingq_count = 0;
 	spin_lock(&zcrypt_list_lock);
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	for_each_zcrypt_card(zc) {
 		for_each_zcrypt_queue(zq, zc) {
 			if (AP_QID_QUEUE(zq->queue->qid) != ap_domain_index)
@@ -757,20 +760,21 @@ static int zcrypt_pendingq_count(void)
 			spin_unlock(&zq->queue->lock);
 		}
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 	spin_unlock(&zcrypt_list_lock);
 	return pendingq_count;
 }
 
 static int zcrypt_requestq_count(void)
 {
+	unsigned int bh;
 	struct zcrypt_card *zc;
 	struct zcrypt_queue *zq;
 	int requestq_count;
 
 	requestq_count = 0;
 	spin_lock(&zcrypt_list_lock);
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	for_each_zcrypt_card(zc) {
 		for_each_zcrypt_queue(zq, zc) {
 			if (AP_QID_QUEUE(zq->queue->qid) != ap_domain_index)
@@ -780,7 +784,7 @@ static int zcrypt_requestq_count(void)
 			spin_unlock(&zq->queue->lock);
 		}
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 	spin_unlock(&zcrypt_list_lock);
 	return requestq_count;
 }
diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index 2af1e57..dccf50f 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -975,11 +975,12 @@ static void hvc_iucv_msg_complete(struct iucv_path *path,
  */
 static int hvc_iucv_pm_freeze(struct device *dev)
 {
+	unsigned int bh;
 	struct hvc_iucv_private *priv = dev_get_drvdata(dev);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	hvc_iucv_hangup(priv);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return 0;
 }
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 192a71c..31fcdae 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -46,9 +46,10 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
 }
 #endif
 
-static inline void local_bh_disable(void)
+static inline unsigned int local_bh_disable(unsigned int mask)
 {
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
+	return 0;
 }
 
 extern void local_bh_enable_no_softirq(void);
@@ -59,7 +60,7 @@ static inline void local_bh_enable_ip(unsigned long ip)
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
 }
 
-static inline void local_bh_enable(void)
+static inline void local_bh_enable(unsigned int bh)
 {
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b3617fe..46675d6 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3870,9 +3870,9 @@ static inline void netif_tx_lock(struct net_device *dev)
 
 static inline unsigned int netif_tx_lock_bh(struct net_device *dev)
 {
-	unsigned int bh = 0;
+	unsigned int bh;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	netif_tx_lock(dev);
 
 	return bh;
@@ -3899,7 +3899,7 @@ static inline void netif_tx_unlock_bh(struct net_device *dev,
 				      unsigned int bh)
 {
 	netif_tx_unlock(dev);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 #define HARD_TX_LOCK(dev, txq, cpu) {			\
@@ -3925,10 +3925,11 @@ static inline void netif_tx_unlock_bh(struct net_device *dev,
 
 static inline void netif_tx_disable(struct net_device *dev)
 {
+	unsigned int bh;
 	unsigned int i;
 	int cpu;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	cpu = smp_processor_id();
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		struct netdev_queue *txq = netdev_get_tx_queue(dev, i);
@@ -3937,7 +3938,7 @@ static inline void netif_tx_disable(struct net_device *dev)
 		netif_tx_stop_queue(txq);
 		__netif_tx_unlock(txq);
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static inline void netif_addr_lock(struct net_device *dev)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 60fbd15..853fb52 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -702,12 +702,14 @@ static inline void rcu_read_unlock(void)
  */
 static inline unsigned int rcu_read_lock_bh(void)
 {
-	local_bh_disable();
+	unsigned int bh;
+
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	__acquire(RCU_BH);
 	rcu_lock_acquire(&rcu_bh_lock_map);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_lock_bh() used illegally while idle");
-	return 0;
+	return bh;
 }
 
 /*
@@ -721,7 +723,7 @@ static inline void rcu_read_unlock_bh(unsigned int bh)
 			 "rcu_read_unlock_bh() used illegally while idle");
 	rcu_lock_release(&rcu_bh_lock_map);
 	__release(RCU_BH);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /**
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 5790f55..1ad54c7 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4140,9 +4140,10 @@ void ieee80211_rx_irqsafe(struct ieee80211_hw *hw, struct sk_buff *skb);
 static inline void ieee80211_rx_ni(struct ieee80211_hw *hw,
 				   struct sk_buff *skb)
 {
-	local_bh_disable();
+	unsigned int bh;
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ieee80211_rx(hw, skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /**
@@ -4180,11 +4181,12 @@ int ieee80211_sta_ps_transition(struct ieee80211_sta *sta, bool start);
 static inline int ieee80211_sta_ps_transition_ni(struct ieee80211_sta *sta,
 						  bool start)
 {
+	unsigned int bh;
 	int ret;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = ieee80211_sta_ps_transition(sta, start);
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	return ret;
 }
@@ -4371,9 +4373,10 @@ static inline void ieee80211_tx_status_noskb(struct ieee80211_hw *hw,
 static inline void ieee80211_tx_status_ni(struct ieee80211_hw *hw,
 					  struct sk_buff *skb)
 {
-	local_bh_disable();
+	unsigned int bh;
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ieee80211_tx_status(hw, skb);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /**
diff --git a/include/net/snmp.h b/include/net/snmp.h
index c9228ad..2ee8363 100644
--- a/include/net/snmp.h
+++ b/include/net/snmp.h
@@ -166,9 +166,10 @@ struct linux_xfrm_mib {
 
 #define SNMP_ADD_STATS64(mib, field, addend) 				\
 	do {								\
-		local_bh_disable();					\
+		unsigned int bh;					\
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);				\
 		__SNMP_ADD_STATS64(mib, field, addend);			\
-		local_bh_enable();				\
+		local_bh_enable(bh);				\
 	} while (0)
 
 #define __SNMP_INC_STATS64(mib, field) SNMP_ADD_STATS64(mib, field, 1)
@@ -184,9 +185,10 @@ struct linux_xfrm_mib {
 	} while (0)
 #define SNMP_UPD_PO_STATS64(mib, basefield, addend)			\
 	do {								\
-		local_bh_disable();					\
+		unsigned int bh;					\
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);				\
 		__SNMP_UPD_PO_STATS64(mib, basefield, addend);		\
-		local_bh_enable();				\
+		local_bh_enable(bh);				\
 	} while (0)
 #else
 #define __SNMP_INC_STATS64(mib, field)		__SNMP_INC_STATS(mib, field)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7fe357a..4caf43e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1556,7 +1556,7 @@ bool tcp_alloc_md5sig_pool(void);
 struct tcp_md5sig_pool *tcp_get_md5sig_pool(unsigned int *bh);
 static inline void tcp_put_md5sig_pool(unsigned int bh)
 {
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 int tcp_md5_hash_skb_data(struct tcp_md5sig_pool *, const struct sk_buff *,
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 24aac0d..11d0073 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -235,6 +235,7 @@ static void put_cpu_map_entry(struct bpf_cpu_map_entry *rcpu)
 
 static int cpu_map_kthread_run(void *data)
 {
+	unsigned int bh;
 	struct bpf_cpu_map_entry *rcpu = data;
 
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -263,7 +264,7 @@ static int cpu_map_kthread_run(void *data)
 		}
 
 		/* Process packets in rcpu->queue */
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		/*
 		 * The bpf_cpu_map_entry is single consumer, with this
 		 * kthread CPU pinned. Lockless access to ptr_ring
@@ -291,7 +292,7 @@ static int cpu_map_kthread_run(void *data)
 		/* Feedback loop via tracepoint */
 		trace_xdp_cpumap_kthread(rcpu->map_id, processed, drops, sched);
 
-		local_bh_enable(); /* resched point, may call do_softirq() */
+		local_bh_enable(bh); /* resched point, may call do_softirq() */
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fb86146..0a96cd4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -923,12 +923,13 @@ irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) { }
 static irqreturn_t
 irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 {
+	unsigned int bh;
 	irqreturn_t ret;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	ret = action->thread_fn(action->irq, action->dev_id);
 	irq_finalize_oneshot(desc, action);
-	local_bh_enable();
+	local_bh_enable(bh);
 	return ret;
 }
 
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 936f3d1..5304ff4 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -103,7 +103,7 @@ void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
 	/* function:						*/	\
 	/**/								\
 	flags = _raw_##op##_lock_irqsave(lock);				\
-	local_bh_disable();						\
+	local_bh_disable(SOFTIRQ_ALL_MASK);						\
 	local_irq_restore(flags);					\
 }									\
 
diff --git a/kernel/padata.c b/kernel/padata.c
index 8a2fbd4..a111a61 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -64,10 +64,11 @@ static int padata_cpu_hash(struct parallel_data *pd)
 
 static void padata_parallel_worker(struct work_struct *parallel_work)
 {
+	unsigned int bh;
 	struct padata_parallel_queue *pqueue;
 	LIST_HEAD(local_list);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	pqueue = container_of(parallel_work,
 			      struct padata_parallel_queue, work);
 
@@ -86,7 +87,7 @@ static void padata_parallel_worker(struct work_struct *parallel_work)
 		padata->parallel(padata);
 	}
 
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /**
@@ -280,14 +281,15 @@ static void padata_reorder(struct parallel_data *pd)
 
 static void invoke_padata_reorder(struct work_struct *work)
 {
+	unsigned int bh;
 	struct padata_parallel_queue *pqueue;
 	struct parallel_data *pd;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	pqueue = container_of(work, struct padata_parallel_queue, reorder_work);
 	pd = pqueue->pd;
 	padata_reorder(pd);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static void padata_reorder_timer(struct timer_list *t)
@@ -327,11 +329,12 @@ static void padata_reorder_timer(struct timer_list *t)
 
 static void padata_serial_worker(struct work_struct *serial_work)
 {
+	unsigned int bh;
 	struct padata_serial_queue *squeue;
 	struct parallel_data *pd;
 	LIST_HEAD(local_list);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	squeue = container_of(serial_work, struct padata_serial_queue, work);
 	pd = squeue->pd;
 
@@ -350,7 +353,7 @@ static void padata_serial_worker(struct work_struct *serial_work)
 		padata->serial(padata);
 		atomic_dec(&pd->refcnt);
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 /**
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index cb3abdc..1a8d1c7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1201,6 +1201,7 @@ static void rcu_torture_timer_cb(struct rcu_head *rhp)
 static void rcutorture_one_extend(int *readstate, int newstate,
 				  struct torture_random_state *trsp)
 {
+	unsigned int bh;
 	int idxnew = -1;
 	int idxold = *readstate;
 	int statesnew = ~*readstate & newstate;
@@ -1211,7 +1212,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 
 	/* First, put new protection in place to avoid critical-section gap. */
 	if (statesnew & RCUTORTURE_RDR_BH)
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	if (statesnew & RCUTORTURE_RDR_IRQ)
 		local_irq_disable();
 	if (statesnew & RCUTORTURE_RDR_PREEMPT)
@@ -1223,7 +1224,7 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 	if (statesold & RCUTORTURE_RDR_IRQ)
 		local_irq_enable();
 	if (statesold & RCUTORTURE_RDR_BH)
-		local_bh_enable();
+		local_bh_enable(bh);
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
 	if (statesold & RCUTORTURE_RDR_RCU)
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index 04fc2ed..7a57103 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -121,6 +121,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  */
 void srcu_drive_gp(struct work_struct *wp)
 {
+	unsigned int bh;
 	int idx;
 	struct rcu_head *lh;
 	struct rcu_head *rhp;
@@ -147,9 +148,9 @@ void srcu_drive_gp(struct work_struct *wp)
 	while (lh) {
 		rhp = lh;
 		lh = lh->next;
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rhp->func(rhp);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/*
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6c9866a..d31ccc7c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1168,6 +1168,7 @@ static void srcu_advance_state(struct srcu_struct *sp)
  */
 static void srcu_invoke_callbacks(struct work_struct *work)
 {
+	unsigned int bh;
 	bool more;
 	struct rcu_cblist ready_cbs;
 	struct rcu_head *rhp;
@@ -1193,9 +1194,9 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rhp = rcu_cblist_dequeue(&ready_cbs);
 	for (; rhp != NULL; rhp = rcu_cblist_dequeue(&ready_cbs)) {
 		debug_rcu_head_unqueue(rhp);
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rhp->func(rhp);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 
 	/*
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index befc932..45a7fd7 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -132,6 +132,7 @@ void rcu_check_callbacks(int user)
  */
 static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp)
 {
+	unsigned int bh;
 	struct rcu_head *next, *list;
 	unsigned long flags;
 
@@ -155,9 +156,9 @@ static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp)
 		next = list->next;
 		prefetch(next);
 		debug_rcu_head_unqueue(list);
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		__rcu_reclaim("", list);
-		local_bh_enable();
+		local_bh_enable(bh);
 		list = next;
 	}
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index a97c20e..c67d87a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1279,8 +1279,10 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	int spincnt;
 
 	for (spincnt = 0; spincnt < 10; spincnt++) {
+		unsigned int bh;
+
 		trace_rcu_utilization(TPS("Start CPU kthread@rcu_wait"));
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		*statusp = RCU_KTHREAD_RUNNING;
 		this_cpu_inc(rcu_cpu_kthread_loops);
 		local_irq_disable();
@@ -1289,7 +1291,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 		local_irq_enable();
 		if (work)
 			rcu_kthread_do_work();
-		local_bh_enable();
+		local_bh_enable(bh);
 		if (*workp == 0) {
 			trace_rcu_utilization(TPS("End CPU kthread@rcu_wait"));
 			*statusp = RCU_KTHREAD_WAITING;
@@ -2320,6 +2322,8 @@ static int rcu_nocb_kthread(void *arg)
 				      atomic_long_read(&rdp->nocb_q_count), -1);
 		c = cl = 0;
 		while (list) {
+			unsigned int bh;
+
 			next = list->next;
 			/* Wait for enqueuing to complete, if needed. */
 			while (next == NULL && &list->next != tail) {
@@ -2331,11 +2335,11 @@ static int rcu_nocb_kthread(void *arg)
 				next = list->next;
 			}
 			debug_rcu_head_unqueue(list);
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			if (__rcu_reclaim(rdp->rsp->name, list))
 				cl++;
 			c++;
-			local_bh_enable();
+			local_bh_enable(bh);
 			cond_resched_tasks_rcu_qs();
 			list = next;
 		}
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 39cb23d..06e252e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -662,6 +662,7 @@ static void check_holdout_task(struct task_struct *t,
 /* RCU-tasks kthread that detects grace periods and invokes callbacks. */
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
+	unsigned int bh;
 	unsigned long flags;
 	struct task_struct *g, *t;
 	unsigned long lastreport;
@@ -808,9 +809,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		/* Invoke the callbacks. */
 		while (list) {
 			next = list->next;
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			list->func(list);
-			local_bh_enable();
+			local_bh_enable(bh);
 			list = next;
 			cond_resched();
 		}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 730a5c9..ae9e29f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -199,12 +199,12 @@ EXPORT_SYMBOL(__local_bh_enable_ip);
 
 void local_bh_disable_all(void)
 {
-	local_bh_disable();
+	local_bh_disable(SOFTIRQ_ALL_MASK);
 }
 
 void local_bh_enable_all(void)
 {
-	local_bh_enable();
+	local_bh_enable(SOFTIRQ_ALL_MASK);
 }
 
 /*
@@ -359,7 +359,7 @@ void irq_enter(void)
 		 * Prevent raise_softirq from needlessly waking up ksoftirqd
 		 * here, as softirq will be serviced on return from interrupt.
 		 */
-		local_bh_disable();
+		local_bh_disable(SOFTIRQ_ALL_MASK);
 		tick_irq_enter();
 		local_bh_enable_no_softirq();
 	}
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e1a549c..2c7d27a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1855,6 +1855,7 @@ static void migrate_hrtimer_list(struct hrtimer_clock_base *old_base,
 
 int hrtimers_dead_cpu(unsigned int scpu)
 {
+	unsigned int bh;
 	struct hrtimer_cpu_base *old_base, *new_base;
 	int i;
 
@@ -1866,7 +1867,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	 * not wakeup ksoftirqd (and acquire the pi-lock) while
 	 * holding the cpu_base lock
 	 */
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	local_irq_disable();
 	old_base = &per_cpu(hrtimer_bases, scpu);
 	new_base = this_cpu_ptr(&hrtimer_bases);
@@ -1894,7 +1895,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
 	/* Check, if we got expired work to do */
 	__hrtimer_peek_ahead_timers();
 	local_irq_enable();
-	local_bh_enable();
+	local_bh_enable(bh);
 	return 0;
 }
 
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf1..35aa1fb 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -191,11 +191,11 @@ static void init_shared_classes(void)
 	__irq_exit();				\
 	local_irq_enable();
 
-#define SOFTIRQ_DISABLE		local_bh_disable
-#define SOFTIRQ_ENABLE		local_bh_enable
+#define SOFTIRQ_DISABLE		local_bh_disable_all
+#define SOFTIRQ_ENABLE		local_bh_enable_all
 
 #define SOFTIRQ_ENTER()				\
-		local_bh_disable();		\
+		local_bh_disable_all();		\
 		local_irq_disable();		\
 		lockdep_softirq_enter();	\
 		WARN_ON(!in_softirq());
@@ -203,7 +203,7 @@ static void init_shared_classes(void)
 #define SOFTIRQ_EXIT()				\
 		lockdep_softirq_exit();		\
 		local_irq_enable();		\
-		local_bh_enable();
+		local_bh_enable_all();
 
 /*
  * Shortcuts for lock/unlock API variants, to keep
diff --git a/net/ax25/ax25_subr.c b/net/ax25/ax25_subr.c
index 038b109..b63d27a 100644
--- a/net/ax25/ax25_subr.c
+++ b/net/ax25/ax25_subr.c
@@ -262,6 +262,7 @@ void ax25_calculate_rtt(ax25_cb *ax25)
 
 void ax25_disconnect(ax25_cb *ax25, int reason)
 {
+	unsigned int bh;
 	ax25_clear_queues(ax25);
 
 	if (!ax25->sk || !sock_flag(ax25->sk, SOCK_DESTROY))
@@ -276,7 +277,7 @@ void ax25_disconnect(ax25_cb *ax25, int reason)
 	ax25_link_failed(ax25, reason);
 
 	if (ax25->sk != NULL) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		bh_lock_sock(ax25->sk);
 		ax25->sk->sk_state     = TCP_CLOSE;
 		ax25->sk->sk_err       = reason;
@@ -286,6 +287,6 @@ void ax25_disconnect(ax25_cb *ax25, int reason)
 			sock_set_flag(ax25->sk, SOCK_DEAD);
 		}
 		bh_unlock_sock(ax25->sk);
-		local_bh_enable();
+		local_bh_enable(bh);
 	}
 }
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 502f663..38fc0ab 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -847,6 +847,7 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 			struct net_bridge_port *p, const unsigned char *addr,
 			u16 nlh_flags, u16 vid)
 {
+	unsigned int bh;
 	int err = 0;
 
 	if (ndm->ndm_flags & NTF_USE) {
@@ -855,11 +856,11 @@ static int __br_fdb_add(struct ndmsg *ndm, struct net_bridge *br,
 				br->dev->name);
 			return -EINVAL;
 		}
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		rcu_read_lock();
 		br_fdb_update(br, p, addr, vid, true);
 		rcu_read_unlock();
-		local_bh_enable();
+		local_bh_enable(bh);
 	} else if (ndm->ndm_flags & NTF_EXT_LEARNED) {
 		err = br_fdb_external_learn_add(br, p, addr, vid, true);
 	} else {
diff --git a/net/can/gw.c b/net/can/gw.c
index faa3da8..48484e2 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -810,6 +810,7 @@ static int cgw_parse_attr(struct nlmsghdr *nlh, struct cf_mod *mod,
 static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
+	unsigned int bh;
 	struct net *net = sock_net(skb->sk);
 	struct rtcanmsg *r;
 	struct cgw_job *gwj;
@@ -851,9 +852,9 @@ static int cgw_create_job(struct sk_buff *skb,  struct nlmsghdr *nlh,
 				return -EINVAL;
 
 			/* update modifications with disabled softirq & quit */
-			local_bh_disable();
+			bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 			memcpy(&gwj->mod, &mod, sizeof(mod));
-			local_bh_enable();
+			local_bh_enable(bh);
 			return 0;
 		}
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 2898fb8..5103840 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3845,6 +3845,7 @@ EXPORT_SYMBOL(dev_queue_xmit_accel);
 
 int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 {
+	unsigned int bh;
 	struct net_device *dev = skb->dev;
 	struct sk_buff *orig_skb = skb;
 	struct netdev_queue *txq;
@@ -3862,14 +3863,14 @@ int dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
 	skb_set_queue_mapping(skb, queue_id);
 	txq = skb_get_tx_queue(dev, skb);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	HARD_TX_LOCK(dev, txq, smp_processor_id());
 	if (!netif_xmit_frozen_or_drv_stopped(txq))
 		ret = netdev_start_xmit(skb, dev, txq, false);
 	HARD_TX_UNLOCK(dev, txq);
 
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	if (!dev_xmit_complete(ret))
 		kfree_skb(skb);
@@ -5206,10 +5207,11 @@ DEFINE_PER_CPU(struct work_struct, flush_works);
 /* Network device is going away, flush any packets still pending */
 static void flush_backlog(struct work_struct *work)
 {
+	unsigned int bh;
 	struct sk_buff *skb, *tmp;
 	struct softnet_data *sd;
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	sd = this_cpu_ptr(&softnet_data);
 
 	local_irq_disable();
@@ -5231,7 +5233,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 static void flush_all_backlogs(void)
@@ -5975,6 +5977,7 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
 
 static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock)
 {
+	unsigned int bh;
 	int rc;
 
 	/* Busy polling means there is a high chance device driver hard irq
@@ -5989,7 +5992,7 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock)
 	clear_bit(NAPI_STATE_MISSED, &napi->state);
 	clear_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	/* All we really want here is to re-enable device interrupts.
 	 * Ideally, a new ndo_busy_poll_stop() could avoid another round.
@@ -5999,13 +6002,14 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock)
 	netpoll_poll_unlock(have_poll_lock);
 	if (rc == BUSY_POLL_BUDGET)
 		__napi_schedule(napi);
-	local_bh_enable();
+	local_bh_enable(bh);
 }
 
 void napi_busy_loop(unsigned int napi_id,
 		    bool (*loop_end)(void *, unsigned long),
 		    void *loop_end_arg)
 {
+	unsigned int bh;
 	unsigned long start_time = loop_end ? busy_loop_current_time() : 0;
 	int (*napi_poll)(struct napi_struct *napi, int budget);
 	void *have_poll_lock = NULL;
@@ -6024,7 +6028,7 @@ void napi_busy_loop(unsigned int napi_id,
 	for (;;) {
 		int work = 0;
 
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		if (!napi_poll) {
 			unsigned long val = READ_ONCE(napi->state);
 
@@ -6047,7 +6051,7 @@ void napi_busy_loop(unsigned int napi_id,
 		if (work > 0)
 			__NET_ADD_STATS(dev_net(napi->dev),
 					LINUX_MIB_BUSYPOLLRXPACKETS, work);
-		local_bh_enable();
+		local_bh_enable(bh);
 
 		if (!loop_end || loop_end(loop_end_arg, start_time))
 			break;
diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index e4e442d..9da3c36 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -132,6 +132,7 @@ int gen_new_estimator(struct gnet_stats_basic_packed *bstats,
 		      seqcount_t *running,
 		      struct nlattr *opt)
 {
+	unsigned int bh;
 	struct gnet_estimator *parm = nla_data(opt);
 	struct net_rate_estimator *old, *est;
 	struct gnet_stats_basic_packed b;
@@ -161,10 +162,10 @@ int gen_new_estimator(struct gnet_stats_basic_packed *bstats,
 	est->cpu_bstats = cpu_bstats;
 
 	if (lock)
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 	est_fetch_counters(est, &b);
 	if (lock)
-		local_bh_enable();
+		local_bh_enable(bh);
 	est->last_bytes = b.bytes;
 	est->last_packets = b.packets;
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 98cc21c..ec55470 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1068,7 +1068,7 @@ int __neigh_event_send(struct neighbour *neigh, struct sk_buff *skb)
 		neigh_probe(neigh);
 	else
 		write_unlock(&neigh->lock);
-	local_bh_enable();
+	local_bh_enable(0);
 	return rc;
 
 out_dead:
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 6e2bea0..1c0d2bd 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3294,6 +3294,7 @@ static void pktgen_wait_for_skb(struct pktgen_dev *pkt_dev)
 
 static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 {
+	unsigned int bh;
 	unsigned int burst = READ_ONCE(pkt_dev->burst);
 	struct net_device *odev = pkt_dev->odev;
 	struct netdev_queue *txq;
@@ -3338,7 +3339,7 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		skb = pkt_dev->skb;
 		skb->protocol = eth_type_trans(skb, skb->dev);
 		refcount_add(burst, &skb->users);
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		do {
 			ret = netif_receive_skb(skb);
 			if (ret == NET_RX_DROP)
@@ -3362,7 +3363,7 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 		} while (--burst > 0);
 		goto out; /* Skips xmit_mode M_START_XMIT */
 	} else if (pkt_dev->xmit_mode == M_QUEUE_XMIT) {
-		local_bh_disable();
+		bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 		refcount_inc(&pkt_dev->skb->users);
 
 		ret = dev_queue_xmit(pkt_dev->skb);
@@ -3395,7 +3396,7 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 
 	txq = skb_get_tx_queue(odev, pkt_dev->skb);
 
-	local_bh_disable();
+	bh = local_bh_disable(SOFTIRQ_ALL_MASK);
 
 	HARD_TX_LOCK(odev, txq, smp_processor_id());
 
@@ -3439,7 +3440,7 @@ static void pktgen_xmit(struct pktgen_dev *pkt_dev)
 	HARD_TX_UNLOCK(odev, txq);
 
 out:
-	local_bh_enable();
+	local_bh_enable(bh);
 
 	/* If pkt_dev->count is zero, then run forever */
 	if ((pkt_dev->count != 0) && (pkt_dev->sofar >= pkt_dev->count)) {

-- 
2.7.4


Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B59DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAF92086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNGRidZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAF92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeJYWvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbeJYWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7570D20854;
        Thu, 25 Oct 2018 14:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477081;
        bh=VjZYaRhET/TyBGUZuU8nqdsDyipPD/55MZxXfbWZrgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNGRidZoG0u1iQunUDGUdwhK6uHBAK+gzm63cOTlmJ/xYlxbw50TiImC5V9Hll/d0
         e4GooMArSKKjTORR/0mokAkHOz1LsPtrm4gODpOpE2BkXyqSjo2ECPn8XhRRxwdSys
         D/ylAcGkxnXe4A/iaHkq8KmUhARDPDC6ocvmyQUk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 33/65] bpf: generally move prog destruction to RCU deferral
Date:   Thu, 25 Oct 2018 10:16:33 -0400
Message-Id: <20181025141705.213937-33-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 1aacde3d22c42281236155c1ef6d7a5aa32a826b ]

Jann Horn reported following analysis that could potentially result
in a very hard to trigger (if not impossible) UAF race, to quote his
event timeline:

 - Set up a process with threads T1, T2 and T3
 - Let T1 set up a socket filter F1 that invokes another filter F2
   through a BPF map [tail call]
 - Let T1 trigger the socket filter via a unix domain socket write,
   don't wait for completion
 - Let T2 call PERF_EVENT_IOC_SET_BPF with F2, don't wait for completion
 - Now T2 should be behind bpf_prog_get(), but before bpf_prog_put()
 - Let T3 close the file descriptor for F2, dropping the reference
   count of F2 to 2
 - At this point, T1 should have looked up F2 from the map, but not
   finished executing it
 - Let T3 remove F2 from the BPF map, dropping the reference count of
   F2 to 1
 - Now T2 should call bpf_prog_put() (wrong BPF program type), dropping
   the reference count of F2 to 0 and scheduling bpf_prog_free_deferred()
   via schedule_work()
 - At this point, the BPF program could be freed
 - BPF execution is still running in a freed BPF program

While at PERF_EVENT_IOC_SET_BPF time it's only guaranteed that the perf
event fd we're doing the syscall on doesn't disappear from underneath us
for whole syscall time, it may not be the case for the bpf fd used as
an argument only after we did the put. It needs to be a valid fd pointing
to a BPF program at the time of the call to make the bpf_prog_get() and
while T2 gets preempted, F2 must have dropped reference to 1 on the other
CPU. The fput() from the close() in T3 should also add additionally delay
to the reference drop via exit_task_work() when bpf_prog_release() gets
called as well as scheduling bpf_prog_free_deferred().

That said, it makes nevertheless sense to move the BPF prog destruction
generally after RCU grace period to guarantee that such scenario above,
but also others as recently fixed in ceb56070359b ("bpf, perf: delay release
of BPF prog after grace period") with regards to tail calls won't happen.
Integrating bpf_prog_free_deferred() directly into the RCU callback is
not allowed since the invocation might happen from either softirq or
process context, so we're not permitted to block. Reviewing all bpf_prog_put()
invocations from eBPF side (note, cBPF -> eBPF progs don't use this for
their destruction) with call_rcu() look good to me.

Since we don't know whether at the time of attaching the program, we're
already part of a tail call map, we need to use RCU variant. However, due
to this, there won't be severely more stress on the RCU callback queue:
situations with above bpf_prog_get() and bpf_prog_put() combo in practice
normally won't lead to releases, but even if they would, enough effort/
cycles have to be put into loading a BPF program into the kernel already.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h   |  5 -----
 kernel/bpf/arraymap.c |  4 +---
 kernel/bpf/syscall.c  | 13 +++----------
 kernel/events/core.c  |  2 +-
 4 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 132585a7fbd8..bae3da5bcda0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -177,7 +177,6 @@ void bpf_register_map_type(struct bpf_map_type_list *tl);
 struct bpf_prog *bpf_prog_get(u32 ufd);
 struct bpf_prog *bpf_prog_inc(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
-void bpf_prog_put_rcu(struct bpf_prog *prog);
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
@@ -208,10 +207,6 @@ static inline struct bpf_prog *bpf_prog_get(u32 ufd)
 static inline void bpf_prog_put(struct bpf_prog *prog)
 {
 }
-
-static inline void bpf_prog_put_rcu(struct bpf_prog *prog)
-{
-}
 #endif /* CONFIG_BPF_SYSCALL */
 
 /* verifier prototypes for helper functions called from eBPF programs */
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0eb11b4ac4c7..daa4e0782cf7 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -270,9 +270,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map, int fd)
 
 static void prog_fd_array_put_ptr(void *ptr)
 {
-	struct bpf_prog *prog = ptr;
-
-	bpf_prog_put_rcu(prog);
+	bpf_prog_put(ptr);
 }
 
 /* decrement refcnt of all bpf_progs that are stored in this map */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4b9bbfe764e8..04fc1022ad9f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -487,7 +487,7 @@ static void bpf_prog_uncharge_memlock(struct bpf_prog *prog)
 	free_uid(user);
 }
 
-static void __prog_put_common(struct rcu_head *rcu)
+static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 {
 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
 
@@ -496,17 +496,10 @@ static void __prog_put_common(struct rcu_head *rcu)
 	bpf_prog_free(aux->prog);
 }
 
-/* version of bpf_prog_put() that is called after a grace period */
-void bpf_prog_put_rcu(struct bpf_prog *prog)
-{
-	if (atomic_dec_and_test(&prog->aux->refcnt))
-		call_rcu(&prog->aux->rcu, __prog_put_common);
-}
-
 void bpf_prog_put(struct bpf_prog *prog)
 {
 	if (atomic_dec_and_test(&prog->aux->refcnt))
-		__prog_put_common(&prog->aux->rcu);
+		call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
 }
 EXPORT_SYMBOL_GPL(bpf_prog_put);
 
@@ -514,7 +507,7 @@ static int bpf_prog_release(struct inode *inode, struct file *filp)
 {
 	struct bpf_prog *prog = filp->private_data;
 
-	bpf_prog_put_rcu(prog);
+	bpf_prog_put(prog);
 	return 0;
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 68b75dfceb0c..21e825250402 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7139,7 +7139,7 @@ static void perf_event_free_bpf_prog(struct perf_event *event)
 	prog = event->tp_event->prog;
 	if (prog && event->tp_event->bpf_prog_owner == event) {
 		event->tp_event->prog = NULL;
-		bpf_prog_put_rcu(prog);
+		bpf_prog_put(prog);
 	}
 }
 
-- 
2.17.1


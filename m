Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E20C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6EC20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihJVLw05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6EC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeKIHhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730146AbeKIHhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:17 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC80920989;
        Thu,  8 Nov 2018 21:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714388;
        bh=RcA3ve5WOoQgOdU/2OwIxBY8p7StI2MCkHpUGcV/UsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ihJVLw05iD9xijMdzGdEp6mGf/581jnr3GxtRBdckdIfK4btIV0PHfuLXgQA6mjoH
         IQiQvlXJdX9Ke88jGyYV7icY9J+tJgsZBWrZI+kEXfCXjoVt/PJbY9HPmL6ZYQ8J6Q
         nK19WeTx6x2/0gKvuOb21/Md8MlbuyhrS/EciUQU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 051/114] bpf: generally move prog destruction to RCU deferral
Date:   Thu,  8 Nov 2018 13:51:06 -0800
Message-Id: <20181108215105.757515152@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
 include/linux/bpf.h   |    5 -----
 kernel/bpf/arraymap.c |    4 +---
 kernel/bpf/syscall.c  |   13 +++----------
 kernel/events/core.c  |    2 +-
 4 files changed, 5 insertions(+), 19 deletions(-)

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -177,7 +177,6 @@ void bpf_register_map_type(struct bpf_ma
 struct bpf_prog *bpf_prog_get(u32 ufd);
 struct bpf_prog *bpf_prog_inc(struct bpf_prog *prog);
 void bpf_prog_put(struct bpf_prog *prog);
-void bpf_prog_put_rcu(struct bpf_prog *prog);
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd);
 struct bpf_map *__bpf_map_get(struct fd f);
@@ -208,10 +207,6 @@ static inline struct bpf_prog *bpf_prog_
 static inline void bpf_prog_put(struct bpf_prog *prog)
 {
 }
-
-static inline void bpf_prog_put_rcu(struct bpf_prog *prog)
-{
-}
 #endif /* CONFIG_BPF_SYSCALL */
 
 /* verifier prototypes for helper functions called from eBPF programs */
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -270,9 +270,7 @@ static void *prog_fd_array_get_ptr(struc
 
 static void prog_fd_array_put_ptr(void *ptr)
 {
-	struct bpf_prog *prog = ptr;
-
-	bpf_prog_put_rcu(prog);
+	bpf_prog_put(ptr);
 }
 
 /* decrement refcnt of all bpf_progs that are stored in this map */
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -487,7 +487,7 @@ static void bpf_prog_uncharge_memlock(st
 	free_uid(user);
 }
 
-static void __prog_put_common(struct rcu_head *rcu)
+static void __bpf_prog_put_rcu(struct rcu_head *rcu)
 {
 	struct bpf_prog_aux *aux = container_of(rcu, struct bpf_prog_aux, rcu);
 
@@ -496,17 +496,10 @@ static void __prog_put_common(struct rcu
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
 
@@ -514,7 +507,7 @@ static int bpf_prog_release(struct inode
 {
 	struct bpf_prog *prog = filp->private_data;
 
-	bpf_prog_put_rcu(prog);
+	bpf_prog_put(prog);
 	return 0;
 }
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7141,7 +7141,7 @@ static void perf_event_free_bpf_prog(str
 	prog = event->tp_event->prog;
 	if (prog && event->tp_event->bpf_prog_owner == event) {
 		event->tp_event->prog = NULL;
-		bpf_prog_put_rcu(prog);
+		bpf_prog_put(prog);
 	}
 }
 



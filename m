Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C9C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399C220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115110;
	bh=YxpMiCrGG4FUGvT7xPmFlQoEvp8u9dj+zlJJN2w5smk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ohsiJvTLgfCmUUOakKVDayD4Hy1NFAkTgKgSzPtBFjqwmntY3nKcFeFBdzns5hwf
	 ofi85mLOiz4liUbVO1vC5gzwNTwNEihgMHs2Dh5UOOEwaU23cMnNvoBbrQk+MAu8pD
	 v+ar2T79WEdZ4cxvFwmfPBib7ekv50+W4lavRuNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfAUX62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAUX61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:27 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3778A21736;
        Mon, 21 Jan 2019 23:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115105;
        bh=YxpMiCrGG4FUGvT7xPmFlQoEvp8u9dj+zlJJN2w5smk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwGgPL2WH3cCXaEfNVcaH+OiLTE1Pd8cYVGkee90OWz3t6WTdYFid0C1zFrriqZbE
         fa8Vd07mrbQsBiJ3Y4YxyPV+WLMUxQomE7O2dEOCBP5xWp9HoP8k78p58BAA0ZC03M
         jBld9fV9b+l088mYMAP70sgupkQWeiVREK4cJUyw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 13/24] perf: Make perf_event_output() propagate the output() return
Date:   Mon, 21 Jan 2019 20:56:55 -0300
Message-Id: <20190121235706.20005-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For the original mode of operation it isn't needed, since we report back
errors via PERF_RECORD_LOST records in the ring buffer, but for use in
bpf_perf_event_output() it is convenient to return the errors, basically
-ENOSPC.

Currently bpf_perf_event_output() returns an error indication, the last
thing it does, which is to push it to the ring buffer is that can fail
and if so, this failure won't be reported back to its users, fix it.

Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190118150938.GN5823@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/perf_event.h                       |  6 +++---
 kernel/events/core.c                             | 11 +++++++----
 kernel/trace/bpf_trace.c                         |  3 +--
 tools/perf/examples/bpf/augmented_raw_syscalls.c |  4 ++--
 tools/perf/examples/bpf/augmented_syscalls.c     | 14 +++++++-------
 tools/perf/examples/bpf/etcsnoop.c               | 10 +++++-----
 6 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f8ec36197718..4eb88065a9b5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -978,9 +978,9 @@ extern void perf_event_output_forward(struct perf_event *event,
 extern void perf_event_output_backward(struct perf_event *event,
 				       struct perf_sample_data *data,
 				       struct pt_regs *regs);
-extern void perf_event_output(struct perf_event *event,
-			      struct perf_sample_data *data,
-			      struct pt_regs *regs);
+extern int perf_event_output(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs);
 
 static inline bool
 is_default_overflow_handler(struct perf_event *event)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fbe59b793b36..bc525cd1615c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6489,7 +6489,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		data->phys_addr = perf_virt_to_phys(data->addr);
 }
 
-static __always_inline void
+static __always_inline int
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
 		    struct pt_regs *regs,
@@ -6499,13 +6499,15 @@ __perf_event_output(struct perf_event *event,
 {
 	struct perf_output_handle handle;
 	struct perf_event_header header;
+	int err;
 
 	/* protect the callchain buffers */
 	rcu_read_lock();
 
 	perf_prepare_sample(&header, data, event, regs);
 
-	if (output_begin(&handle, event, header.size))
+	err = output_begin(&handle, event, header.size);
+	if (err)
 		goto exit;
 
 	perf_output_sample(&handle, &header, data, event);
@@ -6514,6 +6516,7 @@ __perf_event_output(struct perf_event *event,
 
 exit:
 	rcu_read_unlock();
+	return err;
 }
 
 void
@@ -6532,12 +6535,12 @@ perf_event_output_backward(struct perf_event *event,
 	__perf_event_output(event, data, regs, perf_output_begin_backward);
 }
 
-void
+int
 perf_event_output(struct perf_event *event,
 		  struct perf_sample_data *data,
 		  struct pt_regs *regs)
 {
-	__perf_event_output(event, data, regs, perf_output_begin);
+	return __perf_event_output(event, data, regs, perf_output_begin);
 }
 
 /*
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8b068adb9da1..088c2032ceaf 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -431,8 +431,7 @@ __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
 	if (unlikely(event->oncpu != cpu))
 		return -EOPNOTSUPP;
 
-	perf_event_output(event, sd, regs);
-	return 0;
+	return perf_event_output(event, sd, regs);
 }
 
 BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 53c233370fae..9e9d4c66e53c 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -141,8 +141,8 @@ int sys_enter(struct syscall_enter_args *args)
 		len = sizeof(augmented_args.args);
 	}
 
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
-	return 0;
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
 }
 
 SEC("raw_syscalls:sys_exit")
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 2ae44813ef2d..b7dba114e36c 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -55,9 +55,9 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 		len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;	\
 		len &= sizeof(augmented_args.filename.value) - 1;				\
 	}											\
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
-			  &augmented_args, len);						\
-	return 0;										\
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */	\
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 		\
+				 &augmented_args, len);						\
 }												\
 int syscall_exit(syscall)(struct syscall_exit_args *args)					\
 {												\
@@ -125,10 +125,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 /*		addrlen = augmented_args.args.addrlen;				     */		\
 /*										     */		\
 	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 				\
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
-			  &augmented_args, 							\
-			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);	\
-	return 0;										\
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */	\
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 		\
+				 &augmented_args, 						\
+				sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);\
 }												\
 int syscall_exit(syscall)(struct syscall_exit_args *args)					\
 {												\
diff --git a/tools/perf/examples/bpf/etcsnoop.c b/tools/perf/examples/bpf/etcsnoop.c
index b59e8812ee8c..550e69c2e8d1 100644
--- a/tools/perf/examples/bpf/etcsnoop.c
+++ b/tools/perf/examples/bpf/etcsnoop.c
@@ -49,11 +49,11 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 						      args->filename_ptr); 			\
 	if (__builtin_memcmp(augmented_args.filename.value, etc, 4) != 0)			\
 		return 0;									\
-	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
-			  &augmented_args, 							\
-			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
-			   augmented_args.filename.size));					\
-	return 0;										\
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */	\
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 		\
+				 &augmented_args,						\
+				 (sizeof(augmented_args) - sizeof(augmented_args.filename.value) + \
+				 augmented_args.filename.size));				\
 }
 
 struct syscall_enter_openat_args {
-- 
2.20.1


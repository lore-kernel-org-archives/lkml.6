Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA35C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544B22085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfAVKSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:18:13 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58519 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfAVKSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:18:12 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAHcWR2907054
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:17:38 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAHbuQ2907051;
        Tue, 22 Jan 2019 02:17:37 -0800
Date:   Tue, 22 Jan 2019 02:17:37 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-5620196951192f7cd2da0a04e7c0113f40bfc14e@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        acme@redhat.com, mingo@kernel.org, jhs@mojatatu.com,
        adrian.hunter@intel.com, hpa@zytor.com, namhyung@kernel.org
Reply-To: acme@redhat.com, daniel@iogearbox.net, peterz@infradead.org,
          alexei.starovoitov@gmail.com, tglx@linutronix.de,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, hpa@zytor.com, jhs@mojatatu.com,
          adrian.hunter@intel.com, mingo@kernel.org
In-Reply-To: <20190118150938.GN5823@kernel.org>
References: <20190118150938.GN5823@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf: Make perf_event_output() propagate the
 output() return
Git-Commit-ID: 5620196951192f7cd2da0a04e7c0113f40bfc14e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5620196951192f7cd2da0a04e7c0113f40bfc14e
Gitweb:     https://git.kernel.org/tip/5620196951192f7cd2da0a04e7c0113f40bfc14e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 11 Jan 2019 13:20:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:00:57 -0300

perf: Make perf_event_output() propagate the output() return

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

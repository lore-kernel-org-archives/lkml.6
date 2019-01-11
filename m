Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43101C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C721848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547222144;
	bh=aZ+iU4NnSiExjNpf2JvFrRWoSzs3TMMIbdxypyKl51U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BBTCM7837eG59W6/KPd6RNms6zMCa/vWO5gSPGxIRnuJSAQOjW3HEB21ZEEyk78iG
	 OafYmM8+PXrUGhaEikgz+P8+Q5qDJyTgkDdzJXGV1wtWGcHomT6G2W1Mx5jiAI52Xi
	 BfpGx1oBvfkZICfYj436HTTeItefWtXN+at0673E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfAKPzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbfAKPzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:55:42 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08CB20874;
        Fri, 11 Jan 2019 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547222141;
        bh=aZ+iU4NnSiExjNpf2JvFrRWoSzs3TMMIbdxypyKl51U=;
        h=Date:From:To:Cc:Subject:From;
        b=q2MbPgF8hsPhQWEy/nKCP1+OBYV7fss4oDsektPADkgdHDh5hn3wFfWzi8CJ+xGnG
         FShkV8Z/W7CecGWAmHsfEATmxf9H1lV/jtTLbd7fIWFf/8ahCmSCJCH/tkEV+tfkyj
         Vbq7enrgQXoIDy0aKR9XLSliowfMhYQnrI0xdNtA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8FFDD41AB5; Fri, 11 Jan 2019 12:55:38 -0300 (-03)
Date:   Fri, 11 Jan 2019 12:55:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: [PATCH/RFC] Make perf_event_open() propagate errors for use in
 bpf_perf_event_open()
Message-ID: <20190111155538.GX22483@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

	bpf_perf_event_open() already returns a value, but if
perf_event_output's output_begin (mostly perf_output_begin) fails,
the only way to know about that is looking before/after the rb->lost,
right?

	For ring buffer users that is ok, we'll get a PERF_RECORD_LOST,
etc, but for BPF programs it would be convenient to get that -ENOSPC and
do some fallback, whatever makes sense, like in my augmented_syscalls
stuff for 'perf trace', i.e. don't augment it (i.e. push stuff at the
end of the normal payload), just don't filter the
raw_syscalls:sys_enter, 'perf trace' will get the enter syscall enter
event without the pointer dereference at the end, etc, warn the user but
don't lose a syscall in the strace-like output.	

	What do you think? Am I missing something? Probably ;-)

	Ah, its just test built.

- Arnaldo

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551a5add..9ed2af2abd6d 100644
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
index 3cd13a30f732..dcbb2b508034 100644
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

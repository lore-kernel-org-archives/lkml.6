Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E5C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1824721DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xX41NXV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1824721DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733195AbeHIR1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:27:01 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B07FA2183D;
        Thu,  9 Aug 2018 15:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826903;
        bh=Xa5Mgrew4nlGAz+7SkdJfsFo/xmk2b74r7iqxPz+sqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xX41NXV9xi32Aev5KaFpMv52vqwfQJhgu3Pgn0AeRZ2tEFeggV7kPOU8RVuLqk3Tk
         s0C/aDuEixaLtnuPywNqgUg8NOye6+P9NTlyr3o7HcbA2zQoI1gELHX2KXVnIEUKNc
         mrnRbxJNAtJ58Af2urTcigfk9xnhoWNFO6GvBPk4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 39/44] perf trace: Handle "bpf-output" events associated with "__augmented_syscalls__" BPF map
Date:   Thu,  9 Aug 2018 11:58:17 -0300
Message-Id: <20180809145822.21391-40-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add an example BPF script that writes syscalls:sys_enter_openat raw
tracepoint payloads augmented with the first 64 bytes of the "filename"
syscall pointer arg.

Then catch it and print it just like with things written to the
"__bpf_stdout__" map associated with a PERF_COUNT_SW_BPF_OUTPUT software
event, by just letting the default tracepoint handler in 'perf trace',
trace__event_handler(), to use bpf_output__fprintf(trace, sample), just
like it does with all other PERF_COUNT_SW_BPF_OUTPUT events, i.e. just
do a dump on the payload, so that we can check if what is being printed
has at least the first 64 bytes of the "filename" arg:

The augmented_syscalls.c eBPF script:

  # cat tools/perf/examples/bpf/augmented_syscalls.c
  // SPDX-License-Identifier: GPL-2.0

  #include <stdio.h>

  struct bpf_map SEC("maps") __augmented_syscalls__ = {
       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
       .key_size = sizeof(int),
       .value_size = sizeof(u32),
       .max_entries = __NR_CPUS__,
  };

  struct syscall_enter_openat_args {
	unsigned long long common_tp_fields;
	long		   syscall_nr;
	long		   dfd;
	char		   *filename_ptr;
	long		   flags;
	long		   mode;
  };

  struct augmented_enter_openat_args {
	struct syscall_enter_openat_args args;
	char				 filename[64];
  };

  int syscall_enter(openat)(struct syscall_enter_openat_args *args)
  {
	struct augmented_enter_openat_args augmented_args;

	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
			  &augmented_args, sizeof(augmented_args));
	return 1;
  }

  license(GPL);
  #

So it will just prepare a raw_syscalls:sys_enter payload for the
"openat" syscall.

This will eventually be done for all syscalls with pointer args,
globally or just when the user asks, using some spec, which args of
which syscalls it wants "expanded" this way, we'll probably start with
just all the syscalls that have char * pointers with familiar names, the
ones we already handle with the probe:vfs_getname kprobe if it is in
place hooking the kernel getname_flags() function used to copy from user
the paths.

Running it we get:

  # perf trace -e perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:X?.C......................`\..................../etc/ld.so.cache..#......,....ao.k...............k......1.".........
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x5c600da8, flags: CLOEXEC
     0.008 ( 0.005 ms): cat/31292 openat(dfd: CWD, filename: 0x5c600da8, flags: CLOEXEC                 ) = 3
     0.036 (         ): __augmented_syscalls__:X?.C.......................\..................../lib64/libc.so.6......... .\....#........?.......=.C..../.".........
     0.037 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x5c808ce0, flags: CLOEXEC
     0.039 ( 0.007 ms): cat/31292 openat(dfd: CWD, filename: 0x5c808ce0, flags: CLOEXEC                 ) = 3
     0.323 (         ): __augmented_syscalls__:X?.C.....................P....................../etc/passwd......>.C....@................>.C.....,....ao.>.C........
     0.325 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0xe8be50d6
     0.327 ( 0.004 ms): cat/31292 openat(dfd: CWD, filename: 0xe8be50d6                                 ) = 3
  #

We need to go on optimizing this to avoid seding trash or zeroes in the
pointer content payload, using the return from bpf_probe_read_str(), but
to keep things simple at this stage and make incremental progress, lets
leave it at that for now.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-g360n1zbj6bkbk6q0qo11c28@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   |  7 ++++
 tools/perf/examples/bpf/augmented_syscalls.c | 55 ++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/perf/examples/bpf/augmented_syscalls.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7232a7302580..9b4e24217c46 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3240,6 +3240,13 @@ int cmd_trace(int argc, const char **argv)
 				       "cgroup monitoring only available in system-wide mode");
 	}
 
+	err = bpf__setup_output_event(trace.evlist, "__augmented_syscalls__");
+	if (err) {
+		bpf__strerror_setup_output_event(trace.evlist, err, bf, sizeof(bf));
+		pr_err("ERROR: Setup trace syscalls enter failed: %s\n", bf);
+		goto out;
+	}
+
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
 		bpf__strerror_setup_stdout(trace.evlist, err, bf, sizeof(bf));
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
new file mode 100644
index 000000000000..69a31386d8cd
--- /dev/null
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Augment the openat syscall with the contents of the filename pointer argument.
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat /etc/passwd > /dev/null
+ *
+ * It'll catch some openat syscalls related to the dynamic linked and
+ * the last one should be the one for '/etc/passwd'.
+ *
+ * This matches what is marshalled into the raw_syscall:sys_enter payload
+ * expected by the 'perf trace' beautifiers, and can be used by them unmodified,
+ * which will be done as that feature is implemented in the next csets, for now
+ * it will appear in a dump done by the default tracepoint handler in 'perf trace',
+ * that uses bpf_output__fprintf() to just dump those contents, as done with
+ * the bpf-output event associated with the __bpf_output__ map declared in
+ * tools/perf/include/bpf/stdio.h.
+ */
+
+#include <stdio.h>
+
+struct bpf_map SEC("maps") __augmented_syscalls__ = {
+       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+       .key_size = sizeof(int),
+       .value_size = sizeof(u32),
+       .max_entries = __NR_CPUS__,
+};
+
+struct syscall_enter_openat_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   dfd;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+struct augmented_enter_openat_args {
+	struct syscall_enter_openat_args args;
+	char				 filename[64];
+};
+
+int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+{
+	struct augmented_enter_openat_args augmented_args;
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
+			  &augmented_args, sizeof(augmented_args));
+	return 1;
+}
+
+license(GPL);
-- 
2.14.4


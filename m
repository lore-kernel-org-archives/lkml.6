Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6682C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8189E214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xy7ByFMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8189E214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbeHIR0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732712AbeHIR0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:38 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58CB21D62;
        Thu,  9 Aug 2018 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826880;
        bh=7bJuzvCx4cdc3cgLxW6+ZZmE5Cjw9iVEw6d8CjkMe6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xy7ByFMtK/R1dmwCifNvB6tjgl9nueV7gL/gDs5Pr7DI55jFvH2DqAn5LwhylJJRS
         VTjyWlK6CVWQXAy4S46DeBx+bVV88cWHVPZYU4xT/X2G0rmoraYSkDnIAH7yMJt9t3
         BRAdhQ4/hQywhRkh1+dm/nM9FHFglIi11Jl4iZ2E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 34/44] perf bpf: Add bpf/stdio.h wrapper to bpf_perf_event_output function
Date:   Thu,  9 Aug 2018 11:58:12 -0300
Message-Id: <20180809145822.21391-35-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That, together with the map __bpf_output__ that is already handled by
'perf trace' to print that event's contents as strings provides a
debugging facility, to show it in use, print a simple string everytime
the syscalls:sys_enter_openat() syscall tracepoint is hit:

  # cat tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
	  puts("Hello, world\n");
	  return 0;
  }

  license(GPL);
  #
  # perf trace -e openat,tools/perf/examples/bpf/hello.c cat /etc/passwd > /dev/null
     0.016 (         ): __bpf_stdout__:Hello, world
     0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.057 (         ): __bpf_stdout__:Hello, world
     0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.417 (         ): __bpf_stdout__:Hello, world
     0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd) = 3
  #

This is part of an ongoing experimentation on making eBPF scripts as
consumed by perf to be as concise as possible and using familiar
concepts such as stdio.h functions, that end up just wrapping the
existing BPF functions, trying to hide as much boilerplate as possible
while using just conventions and C preprocessor tricks.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4tiaqlx5crf0fwpe7a6j84x7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/hello.c |  9 +++++++++
 tools/perf/include/bpf/stdio.h  | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tools/perf/examples/bpf/hello.c
 create mode 100644 tools/perf/include/bpf/stdio.h

diff --git a/tools/perf/examples/bpf/hello.c b/tools/perf/examples/bpf/hello.c
new file mode 100644
index 000000000000..cf3c2fdc7f79
--- /dev/null
+++ b/tools/perf/examples/bpf/hello.c
@@ -0,0 +1,9 @@
+#include <stdio.h>
+
+int syscall_enter(openat)(void *args)
+{
+	puts("Hello, world\n");
+	return 0;
+}
+
+license(GPL);
diff --git a/tools/perf/include/bpf/stdio.h b/tools/perf/include/bpf/stdio.h
new file mode 100644
index 000000000000..2899cb7bfed8
--- /dev/null
+++ b/tools/perf/include/bpf/stdio.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <bpf.h>
+
+struct bpf_map SEC("maps") __bpf_stdout__ = {
+       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+       .key_size = sizeof(int),
+       .value_size = sizeof(u32),
+       .max_entries = __NR_CPUS__,
+};
+
+static int (*perf_event_output)(void *, struct bpf_map *, int, void *, unsigned long) =
+	(void *)BPF_FUNC_perf_event_output;
+
+#define puts(from) \
+	({ const int __len = sizeof(from); \
+	   char __from[__len] = from; \
+	   perf_event_output(args, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
+			  &__from, __len & (sizeof(from) - 1)); })
-- 
2.14.4


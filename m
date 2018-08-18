Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661F1C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF62188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EF62188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeHROoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:44:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:44:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBb1gD1287228
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:37:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBb1Br1287225;
        Sat, 18 Aug 2018 04:37:01 -0700
Date:   Sat, 18 Aug 2018 04:37:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4tiaqlx5crf0fwpe7a6j84x7@git.kernel.org>
Cc:     namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        wangnan0@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        dsahern@gmail.com, hpa@zytor.com
Reply-To: dsahern@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          adrian.hunter@intel.com, wangnan0@huawei.com,
          namhyung@kernel.org, jolsa@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Add bpf/stdio.h wrapper to
 bpf_perf_event_output function
Git-Commit-ID: 53a5d7b80032fcf48cdc5a6c96c8dc8a120b64ef
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

Commit-ID:  53a5d7b80032fcf48cdc5a6c96c8dc8a120b64ef
Gitweb:     https://git.kernel.org/tip/53a5d7b80032fcf48cdc5a6c96c8dc8a120b64ef
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 6 Aug 2018 09:15:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:55 -0300

perf bpf: Add bpf/stdio.h wrapper to bpf_perf_event_output function

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

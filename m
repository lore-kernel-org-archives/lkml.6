Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43FCC43143
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1A920839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x2tYt4ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A1A920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeIFChK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:10 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 721D42077C;
        Wed,  5 Sep 2018 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185098;
        bh=3cPm6dPWGsgT4eEKf2tLfrb7CkVC1KEd/Zd9b3zli7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x2tYt4kalgSHz7SBytcJCSwGSl+VwvFmtwUTCuPYJJnNouKo9OTFTl9FX8AJf8+8N
         kl2CLQbiLexEeixjZx2vEXPRUhCzQfi0/OxMFzlmtTenVv4wmhB8McZzRoV3t/jZOK
         sI8mogrlaVk+Jr+CruUrLZLrzohYZZCk6aWXiuUU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/77] perf trace: Make the augmented_syscalls filter out the tracepoint event
Date:   Wed,  5 Sep 2018 19:03:25 -0300
Message-Id: <20180905220440.20256-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we attach a eBPF object to a tracepoint, if we return 1, then that
tracepoint will be stored in the perf's ring buffer. In the
augmented_syscalls.c case we want to just attach and _override_ the
tracepoint payload with an augmented, extended one.

In this example, tools/perf/examples/bpf/augmented_syscalls.c, we are
attaching to the 'openat' syscall, and adding, after the
syscalls:sys_enter_openat usual payload as defined by
/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format, a
snapshot of its sole pointer arg:

  # grep 'field:.*\*' /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
	field:const char * filename;	offset:24;	size:8;	signed:0;
  #

For now this is not being considered, the next csets will make use of
it, but as this is overriding the syscall tracepoint enter, we don't
want that event appearing on the ring buffer, just our synthesized one.

Before:

  # perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: , flags: CLOEXEC
     0.007 ( 0.004 ms): cat/24044 openat(dfd: CWD, filename: 0x216dda8, flags: CLOEXEC                  ) = 3
     0.028 (         ): __augmented_syscalls__:dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC
     0.030 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: , flags: CLOEXEC
     0.031 ( 0.006 ms): cat/24044 openat(dfd: CWD, filename: 0x2375ce0, flags: CLOEXEC                  ) = 3
     0.291 (         ): __augmented_syscalls__:dfd: CWD, filename: /etc/passwd
     0.293 (         ): syscalls:sys_enter_openat:dfd: CWD, filename:
     0.294 ( 0.004 ms): cat/24044 openat(dfd: CWD, filename: 0x637db06b                                 ) = 3
  #

After:

  # perf trace -e ~acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x9c6a1da8, flags: CLOEXEC
     0.005 ( 0.015 ms): cat/27341 openat(dfd: CWD, filename: 0x9c6a1da8, flags: CLOEXEC                 ) = 3
     0.040 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x9c8a9ce0, flags: CLOEXEC
     0.041 ( 0.006 ms): cat/27341 openat(dfd: CWD, filename: 0x9c8a9ce0, flags: CLOEXEC                 ) = 3
     0.294 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x482a706b
     0.296 ( 0.067 ms): cat/27341 openat(dfd: CWD, filename: 0x482a706b                                 ) = 3
  #

Now lets replace that __augmented_syscalls__ name with the syscall name,
using:

  # grep 'field:.*syscall_nr' /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/format
	field:int __syscall_nr;	offset:8;	size:4;	signed:1;
  #

That the synthesized payload has exactly where the syscall enter
tracepoint puts it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-og4r9k87mzp9hv7el046idmd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 69a31386d8cd..10e7997ab481 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -49,7 +49,7 @@ int syscall_enter(openat)(struct syscall_enter_openat_args *args)
 	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
 			  &augmented_args, sizeof(augmented_args));
-	return 1;
+	return 0;
 }
 
 license(GPL);
-- 
2.14.4


Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB65AC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939052086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKAyFrqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939052086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbeKFVbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387745AbeKFVbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:33 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B08382086C;
        Tue,  6 Nov 2018 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541505998;
        bh=qIyxkFr3A3buuUY6Ibr+0yg4X/FpTfXy4VDxVrSELHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKAyFrqBMR93v5FkziK6lhv8N0iwMTpD2eu466HRW0TqzsJaCo0itokqWSaMDg40T
         7177JG+zfvRrvwARxT6S8C7GtOKbARTwN36QfCUv56zf1oO5Pi684ZWgErexjoLXLx
         M+u+o8GHes+cKo0IqncW+Gss1q9gaKqhREZhEDiY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 03/18] perf trace: When augmenting raw_syscalls plug raw_syscalls:sys_exit too
Date:   Tue,  6 Nov 2018 09:05:57 -0300
Message-Id: <20181106120612.8262-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

With just this commit we get to support all syscalls via hooking
raw_syscalls:sys_{enter,exit} to the trace__sys_{enter,exit} routines
to combine, strace-like, those tracepoints.

  # trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
         ? (         ): sleep/31680  ... [continued]: execve()) = 0
     0.043 ( 0.004 ms): sleep/31680 brk() = 0x55652a851000
     0.070 ( 0.009 ms): sleep/31680 access(filename:, mode: R) = -1 ENOENT No such file or directory
     0.087 ( 0.006 ms): sleep/31680 openat(dfd: CWD, filename: , flags: CLOEXEC) = 3
     0.096 ( 0.003 ms): sleep/31680 fstat(fd: 3, statbuf: 0x7ffc5269e190) = 0
     0.101 ( 0.005 ms): sleep/31680 mmap(len: 103334, prot: READ, flags: PRIVATE, fd: 3) = 0x7f709c239000
     0.109 ( 0.002 ms): sleep/31680 close(fd: 3) = 0
     0.126 ( 0.006 ms): sleep/31680 openat(dfd: CWD, filename: , flags: CLOEXEC) = 3
     0.135 ( 0.003 ms): sleep/31680 read(fd: 3, buf: 0x7ffc5269e358, count: 832) = 832
     0.141 ( 0.002 ms): sleep/31680 fstat(fd: 3, statbuf: 0x7ffc5269e1f0) = 0
     0.146 ( 0.005 ms): sleep/31680 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7f709c237000
     0.159 ( 0.007 ms): sleep/31680 mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3) = 0x7f709bc79000
     0.168 ( 0.009 ms): sleep/31680 mprotect(start: 0x7f709be26000, len: 2093056) = 0
     0.179 ( 0.010 ms): sleep/31680 mmap(addr: 0x7f709c025000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 1753088) = 0x7f709c025000
     0.196 ( 0.005 ms): sleep/31680 mmap(addr: 0x7f709c02b000, len: 14976, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7f709c02b000
     0.210 ( 0.002 ms): sleep/31680 close(fd: 3) = 0
     0.230 ( 0.002 ms): sleep/31680 arch_prctl(option: 4098, arg2: 140121632638208) = 0
     0.306 ( 0.009 ms): sleep/31680 mprotect(start: 0x7f709c025000, len: 16384, prot: READ) = 0
     0.338 ( 0.005 ms): sleep/31680 mprotect(start: 0x556529607000, len: 4096, prot: READ) = 0
     0.348 ( 0.005 ms): sleep/31680 mprotect(start: 0x7f709c253000, len: 4096, prot: READ) = 0
     0.356 ( 0.019 ms): sleep/31680 munmap(addr: 0x7f709c239000, len: 103334) = 0
     0.463 ( 0.002 ms): sleep/31680 brk() = 0x55652a851000
     0.468 ( 0.004 ms): sleep/31680 brk(brk: 0x55652a872000) = 0x55652a872000
     0.474 ( 0.002 ms): sleep/31680 brk() = 0x55652a872000
     0.484 ( 0.008 ms): sleep/31680 open(filename: , flags: CLOEXEC) = 3
     0.497 ( 0.002 ms): sleep/31680 fstat(fd: 3, statbuf: 0x7f709c02aaa0) = 0
     0.501 ( 0.006 ms): sleep/31680 mmap(len: 113045344, prot: READ, flags: PRIVATE, fd: 3) = 0x7f70950aa000
     0.514 ( 0.002 ms): sleep/31680 close(fd: 3) = 0
     0.554 (1000.140 ms): sleep/31680 nanosleep(rqtp: 0x7ffc5269eed0) = 0
  1000.734 ( 0.007 ms): sleep/31680 close(fd: 1) = 0
  1000.748 ( 0.004 ms): sleep/31680 close(fd: 2) = 0
  1000.769 (         ): sleep/31680 exit_group()
  #

Now to allow selecting which syscalls should be traced, using a map.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-votqqmqhag8e1i9mgyzfez3o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index dc8a6c4986ce..f582ca575883 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3501,7 +3501,8 @@ int cmd_trace(int argc, const char **argv)
 		evsel->handler = trace__sys_enter;
 
 		evlist__for_each_entry(trace.evlist, evsel) {
-			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
+			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_") ||
+			    strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_exit") == 0) {
 				perf_evsel__init_augmented_syscall_tp(evsel);
 				perf_evsel__init_augmented_syscall_tp_ret(evsel);
 				evsel->handler = trace__sys_exit;
-- 
2.14.4


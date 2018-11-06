Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B55C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5409A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5409A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbeKGEiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:38:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387928AbeKGEh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:37:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JB9Qx910147
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:11:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JB9rs910142;
        Tue, 6 Nov 2018 11:11:09 -0800
Date:   Tue, 6 Nov 2018 11:11:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-votqqmqhag8e1i9mgyzfez3o@git.kernel.org>
Cc:     hpa@zytor.com, wangnan0@huawei.com, dsahern@gmail.com,
        acme@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de
Reply-To: acme@redhat.com, wangnan0@huawei.com, dsahern@gmail.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: When augmenting raw_syscalls plug
 raw_syscalls:sys_exit too
Git-Commit-ID: 3c5e3dabf3722a883227623a4adf61976c2224ff
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

Commit-ID:  3c5e3dabf3722a883227623a4adf61976c2224ff
Gitweb:     https://git.kernel.org/tip/3c5e3dabf3722a883227623a4adf61976c2224ff
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 1 Nov 2018 13:50:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 1 Nov 2018 14:11:52 -0300

perf trace: When augmenting raw_syscalls plug raw_syscalls:sys_exit too

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

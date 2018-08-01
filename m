Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B869C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF45E208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVTzdm61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF45E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbeHAXZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388793AbeHAXZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:57 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB16208A5;
        Wed,  1 Aug 2018 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159490;
        bh=7Q1Rpe6lOnyLdqgItwVEuQcBGyIqsSosclH1F/f0yUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sVTzdm61GIHoq+lR3g0ym5Bg22tJV8PSHElugdspdHs0k4gvBacZmKDJnZnlumxNX
         inUJASS7NmSto+A5n3fi3gRiUTX3HeG+bxKTfIDn60aFIURccDPi3/VpugJUsYmQ5d
         05HmOHZFWTArR75DNqsZ2dQ+n9rlkzy8RZYT3xa4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 21/21] perf trace: Do not require --no-syscalls to suppress strace like output
Date:   Wed,  1 Aug 2018 18:36:48 -0300
Message-Id: <20180801213648.4814-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So far the --syscalls option was the default, requiring explicit
--no-syscalls when wanting to process just some other event, invert that
and assume it only when no other event was specified, allowing its
explicit enablement when wanting to see all syscalls together with some
other event:

E.g:

The existing default is maintained for a single workload:

  # perf trace sleep 1
<SNIP>
     0.264 ( 0.003 ms): sleep/12762 mmap(len: 113045344, prot: READ, flags: PRIVATE, fd: 3) = 0x7f62cbf04000
     0.271 ( 0.001 ms): sleep/12762 close(fd: 3) = 0
     0.295 (1000.130 ms): sleep/12762 nanosleep(rqtp: 0x7ffd15194fd0) = 0
  1000.469 ( 0.006 ms): sleep/12762 close(fd: 1) = 0
  1000.480 ( 0.004 ms): sleep/12762 close(fd: 2) = 0
  1000.502 (         ): sleep/12762 exit_group()
  #

For a pid:

  # pidof ssh
  7826 3961 3226 2628 2493
  # perf trace -p 3961
         ? (         ):  ... [continued]: select()) = 1
     0.023 ( 0.005 ms): clock_gettime(which_clock: BOOTTIME, tp: 0x7ffcc8fce870               ) = 0
     0.036 ( 0.009 ms): read(fd: 5</dev/pts/7>, buf: 0x7ffcc8fca7b0, count: 16384             ) = 3
     0.060 ( 0.004 ms): getpid(                                                               ) = 3961 (ssh)
     0.079 ( 0.004 ms): clock_gettime(which_clock: BOOTTIME, tp: 0x7ffcc8fce8e0               ) = 0
     0.088 ( 0.003 ms): clock_gettime(which_clock: BOOTTIME, tp: 0x7ffcc8fce7c0               ) = 0
<SNIP>

For system wide, threads, cgroups, user, etc when no event is specified,
the existing behaviour is maintained, i.e. --syscalls is selected.

When some event is specified, then --no-syscalls doesn't need to be
specified:

  # perf trace -e tcp:tcp_probe ssh localhost
     0.000 tcp:tcp_probe:src=[::1]:22 dest=[::1]:39074 mark=0 length=53 snd_nxt=0xb67ce8f7 snd_una=0xb67ce8f7 snd_cwnd=10 ssthresh=2147483647 snd_wnd=43776 srtt=18 rcv_wnd=43690
     0.010 tcp:tcp_probe:src=[::1]:39074 dest=[::1]:22 mark=0 length=32 snd_nxt=0xa8f9ef38 snd_una=0xa8f9ef23 snd_cwnd=10 ssthresh=2147483647 snd_wnd=43690 srtt=31 rcv_wnd=43776
     4.525 tcp:tcp_probe:src=[::1]:22 dest=[::1]:39074 mark=0 length=1240 snd_nxt=0xb67ce90c snd_una=0xb67ce90c snd_cwnd=10 ssthresh=2147483647 snd_wnd=43776 srtt=18 rcv_wnd=43776
     7.242 tcp:tcp_probe:src=[::1]:22 dest=[::1]:39074 mark=0 length=80 snd_nxt=0xb67ced44 snd_una=0xb67ce90c snd_cwnd=10 ssthresh=2147483647 snd_wnd=43776 srtt=18 rcv_wnd=174720
  The authenticity of host 'localhost (::1)' can't be established.
  ECDSA key fingerprint is SHA256:TKZS58923458203490asekfjaklskljmkjfgPMBfHzY.
  ECDSA key fingerprint is MD5:d8:29:54:40:71:fa:b8:44:89:52:64:8a:35:42:d0:e8.
  Are you sure you want to continue connecting (yes/no)?
^C
  #

To get the previous behaviour just use --syscalls and get all syscalls formatted
strace like + the specified extra events:

  # trace -e sched:*switch --syscalls sleep 1
  <SNIP>
     0.160 ( 0.003 ms): sleep/12877 mprotect(start: 0x7fdfe2361000, len: 4096, prot: READ) = 0
     0.164 ( 0.009 ms): sleep/12877 munmap(addr: 0x7fdfe2345000, len: 113155) = 0
     0.211 ( 0.001 ms): sleep/12877 brk() = 0x55d3ce68e000
     0.212 ( 0.002 ms): sleep/12877 brk(brk: 0x55d3ce6af000) = 0x55d3ce6af000
     0.215 ( 0.001 ms): sleep/12877 brk() = 0x55d3ce6af000
     0.219 ( 0.004 ms): sleep/12877 open(filename: 0xe1f07c00, flags: CLOEXEC) = 3
     0.225 ( 0.001 ms): sleep/12877 fstat(fd: 3, statbuf: 0x7fdfe2138aa0) = 0
     0.227 ( 0.003 ms): sleep/12877 mmap(len: 113045344, prot: READ, flags: PRIVATE, fd: 3) = 0x7fdfdb1b8000
     0.234 ( 0.001 ms): sleep/12877 close(fd: 3) = 0
     0.257 (         ): sleep/12877 nanosleep(rqtp: 0x7fffb36b6020) ...
     0.260 (         ): sched:sched_switch:prev_comm=sleep prev_pid=12877 prev_prio=120 prev_state=D ==> next_comm=swapper/3 next_pid=0 next_prio=120
     0.257 (1000.134 ms): sleep/12877  ... [continued]: nanosleep()) = 0
  1000.428 ( 0.006 ms): sleep/12877 close(fd: 1) = 0
  1000.440 ( 0.004 ms): sleep/12877 close(fd: 2) = 0
  1000.461 (         ): sleep/12877 exit_group()
  #

When specifiying just some syscalls, the behaviour doesn't change, i.e.:

  # trace -e nanosleep -e sched:*switch sleep 1
     0.000 (         ): sleep/14974 nanosleep(rqtp: 0x7ffc344ba9c0                                        ) ...
     0.007 (         ): sched:sched_switch:prev_comm=sleep prev_pid=14974 prev_prio=120 prev_state=D ==> next_comm=swapper/2 next_pid=0 next_prio=120
     0.000 (1000.139 ms): sleep/14974  ... [continued]: nanosleep()) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-om2fulll97ytnxv40ler8jkf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9aca65e6b9aa..88561eed7950 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2992,6 +2992,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 
 		if (trace__validate_ev_qualifier(trace))
 			goto out;
+		trace->trace_syscalls = true;
 	}
 
 	err = 0;
@@ -3047,7 +3048,7 @@ int cmd_trace(int argc, const char **argv)
 		},
 		.output = stderr,
 		.show_comm = true,
-		.trace_syscalls = true,
+		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
 	};
@@ -3193,13 +3194,7 @@ int cmd_trace(int argc, const char **argv)
 
 	if (!trace.trace_syscalls && !trace.trace_pgfaults &&
 	    trace.evlist->nr_entries == 0 /* Was --events used? */) {
-		pr_err("Please specify something to trace.\n");
-		return -1;
-	}
-
-	if (!trace.trace_syscalls && trace.ev_qualifier) {
-		pr_err("The -e option can't be used with --no-syscalls.\n");
-		goto out;
+		trace.trace_syscalls = true;
 	}
 
 	if (output_name != NULL) {
-- 
2.14.4


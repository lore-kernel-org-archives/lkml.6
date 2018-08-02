Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90442146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90442146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeHBKIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:08:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeHBKIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:08:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728Hsnj3431838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:17:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728Hs7g3431835;
        Thu, 2 Aug 2018 01:17:54 -0700
Date:   Thu, 2 Aug 2018 01:17:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-om2fulll97ytnxv40ler8jkf@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, dsahern@gmail.com, mingo@kernel.org,
        adrian.hunter@intel.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de,
          adrian.hunter@intel.com, mingo@kernel.org, dsahern@gmail.com,
          wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Do not require --no-syscalls to
 suppress strace like output
Git-Commit-ID: b912885ab75c7c8aa841c615108afd755d0b97f8
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

Commit-ID:  b912885ab75c7c8aa841c615108afd755d0b97f8
Gitweb:     https://git.kernel.org/tip/b912885ab75c7c8aa841c615108afd755d0b97f8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 1 Aug 2018 16:20:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 1 Aug 2018 16:20:28 -0300

perf trace: Do not require --no-syscalls to suppress strace like output

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

Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024EFC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AFB20834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AFB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeJZQLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:11:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:11:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7ZbZJ137408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:35:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7Zb28137405;
        Fri, 26 Oct 2018 00:35:37 -0700
Date:   Fri, 26 Oct 2018 00:35:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-s4jswltvh660ughvg9nwngah@git.kernel.org>
Cc:     dsahern@gmail.com, hpa@zytor.com, acme@redhat.com,
        jolsa@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: dsahern@gmail.com, hpa@zytor.com, acme@redhat.com,
          jolsa@kernel.org, adrian.hunter@intel.com, wangnan0@huawei.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Introduce per-event maximum number of
 events property
Git-Commit-ID: a9c5e6c1e9bff42ca5f01ceb3092a27a010755fb
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

Commit-ID:  a9c5e6c1e9bff42ca5f01ceb3092a27a010755fb
Gitweb:     https://git.kernel.org/tip/a9c5e6c1e9bff42ca5f01ceb3092a27a010755fb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 22 Oct 2018 14:14:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 14:27:12 -0300

perf trace: Introduce per-event maximum number of events property

Call it 'nr', as in this context it should be expressive enough, i.e.:

  # perf trace -e sched:*waking/nr=8,call-graph=fp/
     0.000 :0/0 sched:sched_waking:comm=rcu_sched pid=10 prio=120 target_cpu=001
                                       try_to_wake_up ([kernel.kallsyms])
                                       sched_clock ([kernel.kallsyms])
     3.933 :0/0 sched:sched_waking:comm=rcu_sched pid=10 prio=120 target_cpu=001
                                       try_to_wake_up ([kernel.kallsyms])
                                       sched_clock ([kernel.kallsyms])
     3.970 IPDL Backgroun/3622 sched:sched_waking:comm=Gecko_IOThread pid=3569 prio=120 target_cpu=003
                                       try_to_wake_up ([kernel.kallsyms])
                                       __libc_write (/usr/lib64/libpthread-2.26.so)
    20.069 IPDL Backgroun/3622 sched:sched_waking:comm=Gecko_IOThread pid=3569 prio=120 target_cpu=003
                                       try_to_wake_up ([kernel.kallsyms])
                                       __libc_write (/usr/lib64/libpthread-2.26.so)
    37.170 IPDL Backgroun/3622 sched:sched_waking:comm=Gecko_IOThread pid=3569 prio=120 target_cpu=003
                                       try_to_wake_up ([kernel.kallsyms])
                                       __libc_write (/usr/lib64/libpthread-2.26.so)
    53.267 IPDL Backgroun/3622 sched:sched_waking:comm=Gecko_IOThread pid=3569 prio=120 target_cpu=003
                                       try_to_wake_up ([kernel.kallsyms])
                                       __libc_write (/usr/lib64/libpthread-2.26.so)
    70.365 IPDL Backgroun/3622 sched:sched_waking:comm=Gecko_IOThread pid=3569 prio=120 target_cpu=003
                                       try_to_wake_up ([kernel.kallsyms])
                                       __libc_write (/usr/lib64/libpthread-2.26.so)
    75.781 Web Content/3649 sched:sched_waking:comm=JS Helper pid=3670 prio=120 target_cpu=000
                                       try_to_wake_up ([kernel.kallsyms])
                                       try_to_wake_up ([kernel.kallsyms])
                                       wake_up_q ([kernel.kallsyms])
                                       futex_wake ([kernel.kallsyms])
                                       do_futex ([kernel.kallsyms])
                                       __x64_sys_futex ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64_after_hwframe ([kernel.kallsyms])
                                       pthread_cond_signal@@GLIBC_2.3.2 (/usr/lib64/libpthread-2.26.so)
  #

  # perf trace -e sched:*switch/nr=2/,block:*_plug/nr=4/,block:*_unplug/nr=1/,net:*dev_queue/nr=3,max-stack=16/
     0.000 :0/0 sched:sched_switch:swapper/0:0 [120] S ==> trace:3367 [120]
     0.046 :0/0 sched:sched_switch:swapper/1:0 [120] S ==> kworker/u16:58:2722 [120]
   570.670 irq/50-iwlwifi/680 net:net_dev_queue:dev=wlp3s0 skbaddr=0xffff93498051ef00 len=66
                                       __dev_queue_xmit ([kernel.kallsyms])
  1106.141 jbd2/dm-0-8/476 block:block_plug:[jbd2/dm-0-8]
  1106.175 jbd2/dm-0-8/476 block:block_unplug:[jbd2/dm-0-8] 1
  1618.088 kworker/u16:30/2694 block:block_plug:[kworker/u16:30]
  1810.000 :0/0 net:net_dev_queue:dev=vnet0 skbaddr=0xffff93498051ef00 len=52
                                       __dev_queue_xmit ([kernel.kallsyms])
  3857.974 :0/0 net:net_dev_queue:dev=vnet0 skbaddr=0xffff93498051f900 len=52
                                       __dev_queue_xmit ([kernel.kallsyms])
  4790.277 jbd2/dm-2-8/748 block:block_plug:[jbd2/dm-2-8]
  4790.448 jbd2/dm-2-8/748 block:block_plug:[jbd2/dm-2-8]
  #

The global --max-events has precendence:

  # trace --max-events 3 -e sched:*switch/nr=2/,block:*_plug/nr=4/,block:*_unplug/nr=1/,net:*dev_queue/nr=3,max-stack=16/
     0.000 :0/0 sched:sched_switch:swapper/0:0 [120] S ==> qemu-system-x86:2252 [120]
     0.029 qemu-system-x8/2252 sched:sched_switch:qemu-system-x86:2252 [120] D ==> swapper/0:0 [120]
    58.047 DNS Res~er #14/31661 net:net_dev_queue:dev=wlp3s0 skbaddr=0xffff9346966af100 len=84
                                       __dev_queue_xmit ([kernel.kallsyms])
                                       __libc_send (/usr/lib64/libpthread-2.26.so)
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-s4jswltvh660ughvg9nwngah@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt | 20 ++++++++++++++++++++
 tools/perf/builtin-trace.c              | 19 +++++++++++++++++--
 tools/perf/util/evsel.h                 |  1 +
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 0d1a1cd4d328..e113450503d2 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -285,6 +285,26 @@ Trace the next min page page fault to take place on the first CPU:
                                        [0x18b26e6bc2bd] (/tmp/perf-17136.map)
   #
 
+Trace the next two sched:sched_switch events, four block:*_plug events, the
+next block:*_unplug and the next three net:*dev_queue events, this last one
+with a backtrace of at most 16 entries, system wide:
+
+  # perf trace -e sched:*switch/nr=2/,block:*_plug/nr=4/,block:*_unplug/nr=1/,net:*dev_queue/nr=3,max-stack=16/
+     0.000 :0/0 sched:sched_switch:swapper/2:0 [120] S ==> rcu_sched:10 [120]
+     0.015 rcu_sched/10 sched:sched_switch:rcu_sched:10 [120] R ==> swapper/2:0 [120]
+   254.198 irq/50-iwlwifi/680 net:net_dev_queue:dev=wlp3s0 skbaddr=0xffff93498051f600 len=66
+                                       __dev_queue_xmit ([kernel.kallsyms])
+   273.977 :0/0 net:net_dev_queue:dev=wlp3s0 skbaddr=0xffff93498051f600 len=78
+                                       __dev_queue_xmit ([kernel.kallsyms])
+   274.007 :0/0 net:net_dev_queue:dev=wlp3s0 skbaddr=0xffff93498051ff00 len=78
+                                       __dev_queue_xmit ([kernel.kallsyms])
+  2930.140 kworker/u16:58/2722 block:block_plug:[kworker/u16:58]
+  2930.162 kworker/u16:58/2722 block:block_unplug:[kworker/u16:58] 1
+  4466.094 jbd2/dm-2-8/748 block:block_plug:[jbd2/dm-2-8]
+  8050.123 kworker/u16:30/2694 block:block_plug:[kworker/u16:30]
+  8050.271 kworker/u16:30/2694 block:block_plug:[kworker/u16:30]
+  #
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-script[1]
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 589e0412652a..7081d7ea12e5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2092,8 +2092,18 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
 {
-	struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	struct thread *thread;
 	int callchain_ret = 0;
+	/*
+	 * Check if we called perf_evsel__disable(evsel) due to, for instance,
+	 * this event's max_events having been hit and this is an entry coming
+	 * from the ring buffer that we should discard, since the max events
+	 * have already been considered/printed.
+	 */
+	if (evsel->disabled)
+		return 0;
+
+	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 
 	if (sample->callchain) {
 		callchain_ret = trace__resolve_callchain(trace, evsel, sample, &callchain_cursor);
@@ -2142,6 +2152,11 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 					      sample->raw_data, sample->raw_size,
 					      trace->output);
 			++trace->nr_events_printed;
+
+			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
+				perf_evsel__disable(evsel);
+				perf_evsel__close(evsel);
+			}
 		}
 	}
 
@@ -2726,7 +2741,7 @@ next_event:
 		int timeout = done ? 100 : -1;
 
 		if (!draining && perf_evlist__poll(evlist, timeout) > 0) {
-			if (perf_evlist__filter_pollfd(evlist, POLLERR | POLLHUP) == 0)
+			if (perf_evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
 				draining = true;
 
 			goto again;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4ef50f157b50..3147ca76c6fc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -102,6 +102,7 @@ struct perf_evsel {
 	int			idx;
 	u32			ids;
 	unsigned long		max_events;
+	unsigned long		nr_events_printed;
 	char			*name;
 	double			scale;
 	const char		*unit;

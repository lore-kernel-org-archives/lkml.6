Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326120684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6326120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeGSPR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:17:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731811AbeGSPR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:17:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BC6D401C7E9;
        Thu, 19 Jul 2018 14:33:58 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-211.brq.redhat.com [10.40.204.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFB1B2026D6B;
        Thu, 19 Jul 2018 14:33:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/4] perf tools: Use last_match threads cache only in single thread mode
Date:   Thu, 19 Jul 2018 16:33:44 +0200
Message-Id: <20180719143345.12963-4-jolsa@kernel.org>
In-Reply-To: <20180719143345.12963-1-jolsa@kernel.org>
References: <20180719143345.12963-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 19 Jul 2018 14:33:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 19 Jul 2018 14:33:58 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an issue with using threads::last_match in multithread
mode which is enabled during the perf top synthesize. It might
crash with following assertion:

  perf: ...include/linux/refcount.h:109: refcount_inc:
        Assertion `!(!refcount_inc_not_zero(r))' failed.

The gdb backtrace looks like this:

  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  (gdb)
  #0  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  #1  0x00007ffff5085800 in abort () from /lib64/libc.so.6
  #2  0x00007ffff507c0da in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00007ffff507c152 in __assert_fail () from /lib64/libc.so.6
  #4  0x0000000000535ff9 in refcount_inc (r=0x7fffe8009a70)
      at ...include/linux/refcount.h:109
  #5  0x0000000000536771 in thread__get (thread=0x7fffe8009a40)
      at util/thread.c:115
  #6  0x0000000000523cd0 in ____machine__findnew_thread (machine=0xbfde38,
      threads=0xbfdf28, pid=2, tid=2, create=true) at util/machine.c:432
  #7  0x0000000000523eb4 in __machine__findnew_thread (machine=0xbfde38,
      pid=2, tid=2) at util/machine.c:489
  #8  0x0000000000523f24 in machine__findnew_thread (machine=0xbfde38,
      pid=2, tid=2) at util/machine.c:499
  #9  0x0000000000526fbe in machine__process_fork_event (machine=0xbfde38,
  ...

The failing assertion is this one:

  REFCOUNT_WARN(!refcount_inc_not_zero(r), ...

the problem is that we don't serialize access to threads::last_match.
We serialize the access to the threads tree, but we don't care how's
threads::last_match being accessed. Both locked/unlocked paths use
that data and can set it. In multithreaded mode we can end up with
invalid object in thread__get call, like in following paths race:

  thread 1
    ...
    machine__findnew_thread
      down_write(&threads->lock);
      __machine__findnew_thread
        ____machine__findnew_thread
          th = threads->last_match;
          if (th->tid == tid) {
            thread__get

  thread 2
    ...
    machine__find_thread
      down_read(&threads->lock);
      __machine__findnew_thread
        ____machine__findnew_thread
          th = threads->last_match;
          if (th->tid == tid) {
            thread__get

  thread 3
    ...
    machine__process_fork_event
      machine__remove_thread
        __machine__remove_thread
          threads->last_match = NULL
          thread__put
      thread__put

Thread 1 and 2 might got stale last_match, before thread 3 clears
it. Thread 1 and 2 then race with thread 3's thread__put and they
might trigger the refcnt == 0 assertion above.

The patch is disabling the last_match cache for multiple thread
mode. It was originally meant for single thread scenarios, where
it's common to have multiple sequential searches of the same
thread.

In multithread mode this does not make sense, because top's threads
processes different /proc entries and so the 'struct threads' object
is queried for various threads. Moreover we'd need to add more locks
to make it work.

Link: http://lkml.kernel.org/n/tip-rq60pig3u8kx9kbzdckbyby0@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 090ff42615bb..175f963f5729 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -413,8 +413,8 @@ static void machine__update_thread_pid(struct machine *machine,
  * the full rbtree:
  */
 static struct thread*
-threads__get_last_match(struct threads *threads, struct machine *machine,
-			int pid, int tid)
+__threads__get_last_match(struct threads *threads, struct machine *machine,
+			  int pid, int tid)
 {
 	struct thread *th;
 
@@ -431,12 +431,31 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 	return NULL;
 }
 
+static struct thread*
+threads__get_last_match(struct threads *threads, struct machine *machine,
+			int pid, int tid)
+{
+	struct thread *th = NULL;
+
+	if (perf_singlethreaded)
+		th = __threads__get_last_match(threads, machine, pid, tid);
+
+	return th;
+}
+
 static void
-threads__set_last_match(struct threads *threads, struct thread *th)
+__threads__set_last_match(struct threads *threads, struct thread *th)
 {
 	threads->last_match = th;
 }
 
+static void
+threads__set_last_match(struct threads *threads, struct thread *th)
+{
+	if (perf_singlethreaded)
+		__threads__set_last_match(threads, th);
+}
+
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
-- 
2.17.1


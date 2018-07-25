Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF162C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E64820671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E64820671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbeGYWFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:05:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:05:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKpZud501584
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:51:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKpYNn501581;
        Wed, 25 Jul 2018 13:51:34 -0700
Date:   Wed, 25 Jul 2018 13:51:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-b57334b9453949bf81281321d14d86d60aee6fde@git.kernel.org>
Cc:     tglx@linutronix.de, ak@linux.intel.com, peterz@infradead.org,
        lukasz.odzioba@intel.com, dsahern@gmail.com, acme@redhat.com,
        jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        wangnan0@huawei.com, alexander.shishkin@linux.intel.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: ak@linux.intel.com, peterz@infradead.org,
          lukasz.odzioba@intel.com, dsahern@gmail.com, tglx@linutronix.de,
          jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
          namhyung@kernel.org, kan.liang@linux.intel.com,
          alexander.shishkin@linux.intel.com, wangnan0@huawei.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180719143345.12963-4-jolsa@kernel.org>
References: <20180719143345.12963-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Use last_match threads cache only in
 single thread mode
Git-Commit-ID: b57334b9453949bf81281321d14d86d60aee6fde
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

Commit-ID:  b57334b9453949bf81281321d14d86d60aee6fde
Gitweb:     https://git.kernel.org/tip/b57334b9453949bf81281321d14d86d60aee6fde
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 19 Jul 2018 16:33:44 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:53:52 -0300

perf machine: Use last_match threads cache only in single thread mode

There's an issue with using threads::last_match in multithread mode
which is enabled during the perf top synthesize. It might crash with
following assertion:

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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180719143345.12963-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8992fcf42257..b300a3973448 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -413,8 +413,8 @@ out_err:
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

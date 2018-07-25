Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E99C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252C720895
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGhYN/dq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252C720895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbeGYTPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:15:15 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B7520894;
        Wed, 25 Jul 2018 18:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541749;
        bh=x6oHRloCfoKG3ptgm6K/1Ss8Vh6Ehkc4nEZKtfRgqGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGhYN/dq1T4vQs4841raccnftvfQxSFj6N1OXCPLxkNVdsMHVnsgAGlai8M/YqneN
         AZ+6yfePu7pXYKj7S+gMQbs8DRfH/cREbjwJU9YYFprXAmEZqNpR6vcQIPgMieWl4M
         ydRQHqPhAU/ZBHA/8OkcqHRG7nLYdeZvzLAp4U+4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/27] perf machine: Use last_match threads cache only in single thread mode
Date:   Wed, 25 Jul 2018 14:59:57 -0300
Message-Id: <20180725180001.15108-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
2.14.4


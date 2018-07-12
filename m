Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E376DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87AE213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A87AE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbeGLOaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:30:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727440AbeGLOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:30:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CCF2C818F042;
        Thu, 12 Jul 2018 14:20:30 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16F3B10FFE4C;
        Thu, 12 Jul 2018 14:20:27 +0000 (UTC)
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
Subject: [PATCH 1/4] perf tools: Fix struct comm_str removal crash
Date:   Thu, 12 Jul 2018 16:20:20 +0200
Message-Id: <20180712142023.16915-2-jolsa@kernel.org>
In-Reply-To: <20180712142023.16915-1-jolsa@kernel.org>
References: <20180712142023.16915-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 14:20:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 12 Jul 2018 14:20:30 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We occasionaly hit following assert failure in perf top,
when processing the /proc info in multiple threads.

  perf: ...include/linux/refcount.h:109: refcount_inc:
        Assertion `!(!refcount_inc_not_zero(r))' failed.

The gdb backtrace looks like this:

  [Switching to Thread 0x7ffff11ba700 (LWP 13749)]
  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  (gdb)
  #0  0x00007ffff50839fb in raise () from /lib64/libc.so.6
  #1  0x00007ffff5085800 in abort () from /lib64/libc.so.6
  #2  0x00007ffff507c0da in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00007ffff507c152 in __assert_fail () from /lib64/libc.so.6
  #4  0x0000000000535373 in refcount_inc (r=0x7fffdc009be0)
      at ...include/linux/refcount.h:109
  #5  0x00000000005354f1 in comm_str__get (cs=0x7fffdc009bc0)
      at util/comm.c:24
  #6  0x00000000005356bd in __comm_str__findnew (str=0x7fffd000b260 ":2",
      root=0xbed5c0 <comm_str_root>) at util/comm.c:72
  #7  0x000000000053579e in comm_str__findnew (str=0x7fffd000b260 ":2",
      root=0xbed5c0 <comm_str_root>) at util/comm.c:95
  #8  0x000000000053582e in comm__new (str=0x7fffd000b260 ":2",
      timestamp=0, exec=false) at util/comm.c:111
  #9  0x00000000005363bc in thread__new (pid=2, tid=2) at util/thread.c:57
  #10 0x0000000000523da0 in ____machine__findnew_thread (machine=0xbfde38,
      threads=0xbfdf28, pid=2, tid=2, create=true) at util/machine.c:457
  #11 0x0000000000523eb4 in __machine__findnew_thread (machine=0xbfde38,
  ...

The failing assertion is this one:

  REFCOUNT_WARN(!refcount_inc_not_zero(r), ...

The problem is that we keep global comm_str_root list, which
is accessed by multiple threads during the perf top startup
and following 2 paths can race:

  thread 1:
    ...
    thread__new
      comm__new
        comm_str__findnew
          down_write(&comm_str_lock);
          __comm_str__findnew
            comm_str__get

  thread 2:
    ...
    comm__override or comm__free
      comm_str__put
        refcount_dec_and_test
          down_write(&comm_str_lock);
          rb_erase(&cs->rb_node, &comm_str_root);

Because thread 2 first decrements the refcnt and only after then it
removes the struct comm_str from the list, the thread 1 can find this
object on the list with refcnt equls to 0 and hit the assert.

This patch fixes the thread 2 path, by removing the struct comm_str
FIRST from the list and only AFTER calling comm_str__put on it. This
way the thread 1 finds only valid objects on the list.

We also need to ensure now, that only one caller removes the struct
comm_str, from the list. Adding 'removed' bool to track that.

Link: http://lkml.kernel.org/n/tip-vrizt6sw1lu1ybsrl9l0wwln@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/comm.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 7798a2cc8a86..7f1c6e63e3e6 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -12,6 +12,7 @@ struct comm_str {
 	char *str;
 	struct rb_node rb_node;
 	refcount_t refcnt;
+	bool removed;
 };
 
 /* Should perhaps be moved to struct machine */
@@ -28,9 +29,6 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
 static void comm_str__put(struct comm_str *cs)
 {
 	if (cs && refcount_dec_and_test(&cs->refcnt)) {
-		down_write(&comm_str_lock);
-		rb_erase(&cs->rb_node, &comm_str_root);
-		up_write(&comm_str_lock);
 		zfree(&cs->str);
 		free(cs);
 	}
@@ -117,6 +115,28 @@ struct comm *comm__new(const char *str, u64 timestamp, bool exec)
 	return comm;
 }
 
+static void __comm_str__remove(struct comm_str *cs)
+{
+	down_write(&comm_str_lock);
+	if (!cs->removed) {
+		rb_erase(&cs->rb_node, &comm_str_root);
+		cs->removed = true;
+	}
+	up_write(&comm_str_lock);
+}
+
+static void comm_str__remove(struct comm_str *cs)
+{
+	if (!cs->removed)
+		__comm_str__remove(cs);
+}
+
+static void comm_str__exit(struct comm_str *cs)
+{
+	comm_str__remove(cs);
+	comm_str__put(cs);
+}
+
 int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 {
 	struct comm_str *new, *old = comm->comm_str;
@@ -125,7 +145,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 	if (!new)
 		return -ENOMEM;
 
-	comm_str__put(old);
+	comm_str__exit(old);
 	comm->comm_str = new;
 	comm->start = timestamp;
 	if (exec)
@@ -136,7 +156,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 
 void comm__free(struct comm *comm)
 {
-	comm_str__put(comm->comm_str);
+	comm_str__exit(comm->comm_str);
 	free(comm);
 }
 
-- 
2.17.1


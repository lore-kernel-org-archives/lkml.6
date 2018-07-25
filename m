Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97A4C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbeGYWHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:07:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbeGYWG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:06:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKq7NF501675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:52:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKq7SG501672;
        Wed, 25 Jul 2018 13:52:07 -0700
Date:   Wed, 25 Jul 2018 13:52:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-46b3722cc7765582354488da633aafffcb138458@git.kernel.org>
Cc:     mingo@kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, lukasz.odzioba@intel.com,
        acme@redhat.com, dsahern@gmail.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          jolsa@kernel.org, peterz@infradead.org, ak@linux.intel.com,
          kan.liang@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org, lukasz.odzioba@intel.com,
          dsahern@gmail.com, acme@redhat.com
In-Reply-To: <20180720101740.GA27176@krava>
References: <20180720101740.GA27176@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Fix struct comm_str removal crash
Git-Commit-ID: 46b3722cc7765582354488da633aafffcb138458
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

Commit-ID:  46b3722cc7765582354488da633aafffcb138458
Gitweb:     https://git.kernel.org/tip/46b3722cc7765582354488da633aafffcb138458
Author:     Jiri Olsa <jolsa@redhat.com>
AuthorDate: Fri, 20 Jul 2018 12:17:40 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:54:03 -0300

perf tools: Fix struct comm_str removal crash

We occasionaly hit following assert failure in 'perf top', when processing the
/proc info in multiple threads.

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
is accessed by multiple threads during the 'perf top' startup
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

Because thread 2 first decrements the refcnt and only after then it removes the
struct comm_str from the list, the thread 1 can find this object on the list
with refcnt equls to 0 and hit the assert.

This patch fixes the thread 1 __comm_str__findnew path, by ignoring objects
that already dropped the refcnt to 0. For the rest of the objects we take the
refcnt before comparing its name and release it afterwards with comm_str__put,
which can also release the object completely.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20180720101740.GA27176@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 7798a2cc8a86..31279a7bd919 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -20,9 +20,10 @@ static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,}
 
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
-	if (cs)
-		refcount_inc(&cs->refcnt);
-	return cs;
+	if (cs && refcount_inc_not_zero(&cs->refcnt))
+		return cs;
+
+	return NULL;
 }
 
 static void comm_str__put(struct comm_str *cs)
@@ -67,9 +68,14 @@ struct comm_str *__comm_str__findnew(const char *str, struct rb_root *root)
 		parent = *p;
 		iter = rb_entry(parent, struct comm_str, rb_node);
 
+		/*
+		 * If we race with comm_str__put, iter->refcnt is 0
+		 * and it will be removed within comm_str__put call
+		 * shortly, ignore it in this search.
+		 */
 		cmp = strcmp(str, iter->str);
-		if (!cmp)
-			return comm_str__get(iter);
+		if (!cmp && comm_str__get(iter))
+			return iter;
 
 		if (cmp < 0)
 			p = &(*p)->rb_left;

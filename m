Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359E1C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB27921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB27921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbeIXSbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:31:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732454AbeIXSbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:31:32 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F68D1018;
        Mon, 24 Sep 2018 12:29:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 052/235] perf tools: Fix struct comm_str removal crash
Date:   Mon, 24 Sep 2018 13:50:38 +0200
Message-Id: <20180924113110.348449800@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit 46b3722cc7765582354488da633aafffcb138458 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/comm.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -20,9 +20,10 @@ static struct rw_semaphore comm_str_lock
 
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
@@ -67,9 +68,14 @@ struct comm_str *__comm_str__findnew(con
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



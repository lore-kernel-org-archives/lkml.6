Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26681ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E091E208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E091E208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeGPK4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:56:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727596AbeGPK4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:56:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 634D3401EF04;
        Mon, 16 Jul 2018 10:29:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id 103BC111E40D;
        Mon, 16 Jul 2018 10:29:34 +0000 (UTC)
Date:   Mon, 16 Jul 2018 12:29:34 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 1/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180716102934.GA14153@krava>
References: <20180712142023.16915-1-jolsa@kernel.org>
 <20180712142023.16915-2-jolsa@kernel.org>
 <20180715130827.GA5071@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180715130827.GA5071@danjae.aot.lge.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 10:29:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 16 Jul 2018 10:29:38 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 10:08:27PM +0900, Namhyung Kim wrote:

SNIP

> > Because thread 2 first decrements the refcnt and only after then it
> > removes the struct comm_str from the list, the thread 1 can find this
> > object on the list with refcnt equls to 0 and hit the assert.
> > 
> > This patch fixes the thread 2 path, by removing the struct comm_str
> > FIRST from the list and only AFTER calling comm_str__put on it. This
> > way the thread 1 finds only valid objects on the list.
> 
> I'm not sure we can unconditionally remove the comm_str from the tree.
> It should be removed only if refcount is going to zero IMHO.
> Otherwise it could end up having multiple comm_str entry for a same
> name.

right, but it wouldn't crash ;-)

how about attached change, that actualy deals with the refcnt
race I'm running the tests now, seems ok so far

jirka


---
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 7798a2cc8a86..592b03548021 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -18,22 +18,27 @@ struct comm_str {
 static struct rb_root comm_str_root;
 static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,};
 
-static struct comm_str *comm_str__get(struct comm_str *cs)
+static bool comm_str__get(struct comm_str *cs)
 {
-	if (cs)
-		refcount_inc(&cs->refcnt);
-	return cs;
+	return cs ? refcount_inc_not_zero(&cs->refcnt) : false;
 }
 
-static void comm_str__put(struct comm_str *cs)
+static int comm_str__put(struct comm_str *cs, bool lock)
 {
-	if (cs && refcount_dec_and_test(&cs->refcnt)) {
+	if (!cs || !refcount_dec_and_test(&cs->refcnt))
+		return 0;
+
+	if (lock)
 		down_write(&comm_str_lock);
-		rb_erase(&cs->rb_node, &comm_str_root);
+
+	rb_erase(&cs->rb_node, &comm_str_root);
+
+	if (lock)
 		up_write(&comm_str_lock);
-		zfree(&cs->str);
-		free(cs);
-	}
+
+	zfree(&cs->str);
+	free(cs);
+	return 1;
 }
 
 static struct comm_str *comm_str__alloc(const char *str)
@@ -67,9 +72,22 @@ struct comm_str *__comm_str__findnew(const char *str, struct rb_root *root)
 		parent = *p;
 		iter = rb_entry(parent, struct comm_str, rb_node);
 
-		cmp = strcmp(str, iter->str);
-		if (!cmp)
-			return comm_str__get(iter);
+		/*
+		 * If we race with comm_str__put, iter->refcnt == 0
+		 * and it will be removed within comm_str__put
+		 * thread shortly, ignore it in this search.
+		 */
+		if (comm_str__get(iter)) {
+			cmp = strcmp(str, iter->str);
+			if (!cmp)
+				return iter;
+			/*
+			 * If we actualy had to remove the item, restart
+			 * the search to have the clean tree search.
+			 */
+			if (comm_str__put(iter, false))
+				return __comm_str__findnew(str, root);
+		}
 
 		if (cmp < 0)
 			p = &(*p)->rb_left;
@@ -125,7 +143,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 	if (!new)
 		return -ENOMEM;
 
-	comm_str__put(old);
+	comm_str__put(old, true);
 	comm->comm_str = new;
 	comm->start = timestamp;
 	if (exec)
@@ -136,7 +154,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
 
 void comm__free(struct comm *comm)
 {
-	comm_str__put(comm->comm_str);
+	comm_str__put(comm->comm_str, true);
 	free(comm);
 }
 

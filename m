Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D8C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3E9213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3E9213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbeGLOaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:30:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727440AbeGLOaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:30:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D27577742;
        Thu, 12 Jul 2018 14:20:33 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3F810FFE4C;
        Thu, 12 Jul 2018 14:20:30 +0000 (UTC)
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
Subject: [PATCH 2/4] perf tools: Add threads__get_last_match function
Date:   Thu, 12 Jul 2018 16:20:21 +0200
Message-Id: <20180712142023.16915-3-jolsa@kernel.org>
In-Reply-To: <20180712142023.16915-1-jolsa@kernel.org>
References: <20180712142023.16915-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 12 Jul 2018 14:20:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 12 Jul 2018 14:20:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating threads::last_match cache read/check into
separate threads__get_last_match function. This will
be useful in following patch.

Link: http://lkml.kernel.org/n/tip-z4zzlpp3vusjued0gzp5uycq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e7b4a8b513f2..7156812818dc 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -408,23 +408,16 @@ static void machine__update_thread_pid(struct machine *machine,
 }
 
 /*
- * Caller must eventually drop thread->refcnt returned with a successful
- * lookup/new thread inserted.
+ * Front-end cache - TID lookups come in blocks,
+ * so most of the time we dont have to look up
+ * the full rbtree:
  */
-static struct thread *____machine__findnew_thread(struct machine *machine,
-						  struct threads *threads,
-						  pid_t pid, pid_t tid,
-						  bool create)
+static struct thread*
+threads__get_last_match(struct threads *threads, struct machine *machine,
+			int pid, int tid)
 {
-	struct rb_node **p = &threads->entries.rb_node;
-	struct rb_node *parent = NULL;
 	struct thread *th;
 
-	/*
-	 * Front-end cache - TID lookups come in blocks,
-	 * so most of the time we dont have to look up
-	 * the full rbtree:
-	 */
 	th = threads->last_match;
 	if (th != NULL) {
 		if (th->tid == tid) {
@@ -435,6 +428,26 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		threads->last_match = NULL;
 	}
 
+	return NULL;
+}
+
+/*
+ * Caller must eventually drop thread->refcnt returned with a successful
+ * lookup/new thread inserted.
+ */
+static struct thread *____machine__findnew_thread(struct machine *machine,
+						  struct threads *threads,
+						  pid_t pid, pid_t tid,
+						  bool create)
+{
+	struct rb_node **p = &threads->entries.rb_node;
+	struct rb_node *parent = NULL;
+	struct thread *th;
+
+	th = threads__get_last_match(threads, machine, pid, tid);
+	if (th)
+		return thread__get(th);
+
 	while (*p != NULL) {
 		parent = *p;
 		th = rb_entry(parent, struct thread, rb_node);
-- 
2.17.1


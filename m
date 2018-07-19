Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274C8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC58420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC58420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbeGSPRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731811AbeGSPRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:17:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7065772622;
        Thu, 19 Jul 2018 14:33:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-211.brq.redhat.com [10.40.204.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8218C2026D6B;
        Thu, 19 Jul 2018 14:33:52 +0000 (UTC)
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
Subject: [PATCH 2/4] perf tools: Add threads__set_last_match function
Date:   Thu, 19 Jul 2018 16:33:43 +0200
Message-Id: <20180719143345.12963-3-jolsa@kernel.org>
In-Reply-To: <20180719143345.12963-1-jolsa@kernel.org>
References: <20180719143345.12963-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 14:33:55 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 19 Jul 2018 14:33:55 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separating threads::last_match cache set into
separate threads__set_last_match function.
This will be useful in following patch.

Link: http://lkml.kernel.org/n/tip-r2phhluimtb4747rug66mpra@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7a5236a4ced7..090ff42615bb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -431,6 +431,12 @@ threads__get_last_match(struct threads *threads, struct machine *machine,
 	return NULL;
 }
 
+static void
+threads__set_last_match(struct threads *threads, struct thread *th)
+{
+	threads->last_match = th;
+}
+
 /*
  * Caller must eventually drop thread->refcnt returned with a successful
  * lookup/new thread inserted.
@@ -453,7 +459,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		th = rb_entry(parent, struct thread, rb_node);
 
 		if (th->tid == tid) {
-			threads->last_match = th;
+			threads__set_last_match(threads, th);
 			machine__update_thread_pid(machine, th, pid);
 			return thread__get(th);
 		}
@@ -490,7 +496,7 @@ static struct thread *____machine__findnew_thread(struct machine *machine,
 		 * It is now in the rbtree, get a ref
 		 */
 		thread__get(th);
-		threads->last_match = th;
+		threads__set_last_match(threads, th);
 		++threads->nr;
 	}
 
@@ -1648,7 +1654,7 @@ static void __machine__remove_thread(struct machine *machine, struct thread *th,
 	struct threads *threads = machine__threads(machine, th->tid);
 
 	if (threads->last_match == th)
-		threads->last_match = NULL;
+		threads__set_last_match(threads, NULL);
 
 	BUG_ON(refcount_read(&th->refcnt) == 0);
 	if (lock)
-- 
2.17.1


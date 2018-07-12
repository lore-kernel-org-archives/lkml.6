Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03025C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B790921486
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B790921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGLOaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47900 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732413AbeGLOaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A02934022909;
        Thu, 12 Jul 2018 14:20:35 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA8210FFE4C;
        Thu, 12 Jul 2018 14:20:33 +0000 (UTC)
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
Subject: [PATCH 3/4] perf tools: Add threads__set_last_match function
Date:   Thu, 12 Jul 2018 16:20:22 +0200
Message-Id: <20180712142023.16915-4-jolsa@kernel.org>
In-Reply-To: <20180712142023.16915-1-jolsa@kernel.org>
References: <20180712142023.16915-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 14:20:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 14:20:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
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
index 7156812818dc..32e3e2c835e6 100644
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


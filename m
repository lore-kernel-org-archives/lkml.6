Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F71C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043CE20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpn5OIKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043CE20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbeGYTPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:15:09 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6F220891;
        Wed, 25 Jul 2018 18:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541743;
        bh=L9rkregEyoqgmTdEovZL6XBQ9cYpT2idnT2RoLJP1YA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpn5OIKhhkoRFD7F19OFmv8enK6qXJ1P7kqBBbX3bDH07KuZxPl5MLTQeFomifCEj
         Ry5781usq7ihDzlYoyzQzDJ7hinqkUeRoqhJuqvi34r5S1tNQBNTir2tn9qKU4m63f
         PWGuQ6tw1xNom0uZolyaTrytDcW+eJ+gSiW6Kwlk=
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
Subject: [PATCH 22/27] perf machine: Add threads__set_last_match function
Date:   Wed, 25 Jul 2018 14:59:56 -0300
Message-Id: <20180725180001.15108-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Separating threads::last_match cache set into separate
threads__set_last_match function.  This will be useful in following
patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180719143345.12963-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index df41aa1a4cf9..8992fcf42257 100644
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
2.14.4


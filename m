Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2830A20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSDkl4k9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2830A20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGYTPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:15:02 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790CB20833;
        Wed, 25 Jul 2018 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541737;
        bh=fhoRIqJaLH/o4xKtKPtQW4n4bIHUS3LxlbcuZ9L3Bpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSDkl4k9HImLG4gSSUwPvq+LrDUwsFqRWWvqF79x47PsIOSLoM20JqAd9NZU0K4GO
         3dso1jR6D7P3NM/qKbtHZODgu0cwnPUVvCmU7ZSq5YlZ3NPpIbr2zl2hdfrQ47VpsH
         xcrsm4J2CPhliDfoT6mUnN4i5RjJ5kZG9F00gpkA=
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
Subject: [PATCH 21/27] perf machine: Add threads__get_last_match function
Date:   Wed, 25 Jul 2018 14:59:55 -0300
Message-Id: <20180725180001.15108-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Separating threads::last_match cache read/check into separate
threads__get_last_match function. This will be useful in following
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
Link: http://lkml.kernel.org/r/20180719143345.12963-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 22dbb6612b41..df41aa1a4cf9 100644
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
+		return th;
+
 	while (*p != NULL) {
 		parent = *p;
 		th = rb_entry(parent, struct thread, rb_node);
-- 
2.14.4


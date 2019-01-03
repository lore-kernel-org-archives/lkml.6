Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066EFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C105E2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519686;
	bh=nOAjhDrx+tOZouM8HsSzam7dnpLJMDgtjUXLWgqkDz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ojcHgc7C6AAnTCyvcIUwvc2B7E1onNQq5GY49tC4exmFQjHvLTnoevLX43kmucz81
	 19tUiUP7ug24E+vVTSrNgKt1yH5FFqG2dgUTHQdfLQWTS5vuRzkKWvlWKKvQZ1LStg
	 P17n9CVl+8+KR7d1+ulFg8Afx81llt67x7BBxZFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfACMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfACMrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:35 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9340217D9;
        Thu,  3 Jan 2019 12:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519654;
        bh=nOAjhDrx+tOZouM8HsSzam7dnpLJMDgtjUXLWgqkDz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbzkqicFVMiknP0rPEfew/KidBujXMUufyxfly8FaolcY+LLgB+aOnu+u57Chap/K
         aweMBzKwlVN0nLlweXTNUW70CUR1KEHm/YV2XJngGizWKbmjU1J9SQkSeLs/doy45l
         GWi/uhs54O3Bu6khRgV8DOQLkL91ggXKnsCYpfs0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/29] perf thread-stack: Allow for a thread stack array
Date:   Thu,  3 Jan 2019 09:46:05 -0300
Message-Id: <20190103124609.29672-26-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for fixing thread stack processing for the idle task,
allow for a thread stack array.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index d93cd286b048..a5f7b9d8fc23 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -60,6 +60,7 @@ struct thread_stack_entry {
  * @last_time: last timestamp
  * @crp: call/return processor
  * @comm: current comm
+ * @arr_sz: size of array if this is the first element of an array
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -71,6 +72,7 @@ struct thread_stack {
 	u64 last_time;
 	struct call_return_processor *crp;
 	struct comm *comm;
+	unsigned int arr_sz;
 };
 
 static int thread_stack__grow(struct thread_stack *ts)
@@ -100,6 +102,8 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 	if (!ts)
 		return NULL;
 
+	ts->arr_sz = 1;
+
 	if (thread_stack__grow(ts)) {
 		free(ts);
 		return NULL;
@@ -234,11 +238,19 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 int thread_stack__flush(struct thread *thread)
 {
 	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
+	int err = 0;
 
-	if (ts)
-		return __thread_stack__flush(thread, ts);
+	if (ts) {
+		for (pos = 0; pos < ts->arr_sz; pos++) {
+			int ret = __thread_stack__flush(thread, ts + pos);
 
-	return 0;
+			if (ret)
+				err = ret;
+		}
+	}
+
+	return err;
 }
 
 int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
@@ -314,13 +326,29 @@ void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
 	}
 }
 
+static void __thread_stack__free(struct thread *thread, struct thread_stack *ts)
+{
+	__thread_stack__flush(thread, ts);
+	zfree(&ts->stack);
+}
+
+static void thread_stack__reset(struct thread *thread, struct thread_stack *ts)
+{
+	unsigned int arr_sz = ts->arr_sz;
+
+	__thread_stack__free(thread, ts);
+	memset(ts, 0, sizeof(*ts));
+	ts->arr_sz = arr_sz;
+}
+
 void thread_stack__free(struct thread *thread)
 {
 	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
 
 	if (ts) {
-		__thread_stack__flush(thread, ts);
-		zfree(&ts->stack);
+		for (pos = 0; pos < ts->arr_sz; pos++)
+			__thread_stack__free(thread, ts + pos);
 		zfree(&thread->ts);
 	}
 }
@@ -611,7 +639,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	if (ts && !ts->crp) {
 		/* Supersede thread_stack__event() */
-		thread_stack__free(thread);
+		thread_stack__reset(thread, ts);
 		ts = NULL;
 	}
 
-- 
2.19.2


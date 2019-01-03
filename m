Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B190C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D88218A4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519663;
	bh=9d5lVNeFtxtnCc0DBM+N2PusINJNOqoRZcJHgoT6efU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XaUgoIXWwRtoa94tnUMBzPGJPajdsr3gCP4H4aQ4kbieWFakidPlHz1TDT+fdtWtm
	 wWSc/rFhCf7u653R4b/df0QcDSeBYM2Q3/G543sCzalkr6aCBRkxK/lNejV5SdxbkZ
	 Z0DxvCX2IHQRltiePVuNGZc3HSS+2aDPx92y+xW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfACMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731374AbfACMrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:40 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3E812070D;
        Thu,  3 Jan 2019 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519659;
        bh=9d5lVNeFtxtnCc0DBM+N2PusINJNOqoRZcJHgoT6efU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xn2TzaOBOID/UZNNIYGRHNrmCC06yPtLvMYJpQrlIqBpHIpV4l+sy7QuE3eoQ0ZfD
         sIodVCUJOA7LlXz5M4E+fLNTLLNKhEYPt+t53WPrNciUUCw7w29zx0tKUcgl2DlHwd
         kqkR6BPB3YdjpBPLQC/I7jwNNn1GQ/0OqJihgeVY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/29] perf thread-stack: Allocate an array of thread stacks
Date:   Thu,  3 Jan 2019 09:46:07 -0300
Message-Id: <20190103124609.29672-28-acme@kernel.org>
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
allocate an array of thread stacks.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-7-adrian.hunter@intel.com
[ No need to check for NULL when calling zfree(), noticed by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 03770af9e5cd..248ed3945bec 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -114,20 +114,25 @@ static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
 static struct thread_stack *thread_stack__new(struct thread *thread,
 					      struct call_return_processor *crp)
 {
-	struct thread_stack *ts;
-
-	ts = zalloc(sizeof(struct thread_stack));
-	if (!ts)
-		return NULL;
-
-	ts->arr_sz = 1;
-
-	if (thread_stack__init(ts, thread, crp)) {
-		free(ts);
-		return NULL;
+	struct thread_stack *ts = thread->ts, *new_ts;
+	unsigned int old_sz = ts ? ts->arr_sz : 0;
+	unsigned int new_sz = 1;
+
+	if (!ts || new_sz > old_sz) {
+		new_ts = calloc(new_sz, sizeof(*ts));
+		if (!new_ts)
+			return NULL;
+		if (ts)
+			memcpy(new_ts, ts, old_sz * sizeof(*ts));
+		new_ts->arr_sz = new_sz;
+		zfree(&thread->ts);
+		thread->ts = new_ts;
+		ts = new_ts;
 	}
 
-	thread->ts = ts;
+	if (!ts->stack &&
+	    thread_stack__init(ts, thread, crp))
+		return NULL;
 
 	return ts;
 }
-- 
2.19.2


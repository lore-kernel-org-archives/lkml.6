Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A51C43612
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252D2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519650;
	bh=tGYkU8GxaOzxpmdZCQ0bOCrhtVmQt6VIPcebfVtjREA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LtixfxdrqZLM37R2bEYHOW2T5kQpfrO4o6TFfmBkkic2zUiB3oVnJVIUX4uOUCUwC
	 OtqLjIFOvA50g1iY7yOcXK/dvR2Oac65J/acVtE1T7Y+jnlh/KMEZD8C3127VEyOZF
	 NrgM/nedaC5HtQuRaXOOcyS/W4LHFS9t0I15ejLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfACMr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731593AbfACMr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:28 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 770332184B;
        Thu,  3 Jan 2019 12:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519647;
        bh=tGYkU8GxaOzxpmdZCQ0bOCrhtVmQt6VIPcebfVtjREA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGAuy8h07i8QM92tl345pypCaEl4PRJQonxKZQPahAToDmy+acFnD1BEjh+pma8xf
         LV7Zxu+NK/gL2nQr8KSLMEmRT6ZRhgQ6lhYK1wosg4hxojWhfsQl3tJf0ABDM2FnMH
         EDeIL+wQ4PHZpVOv/0jbPtPMV/SwZQFdsmZ7/T3g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/29] perf thread-stack: Simplify some code in thread_stack__process()
Date:   Thu,  3 Jan 2019 09:46:02 -0300
Message-Id: <20190103124609.29672-23-acme@kernel.org>
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
simplify some code in thread_stack__process().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 61a4286a74dc..115dc4b27a1b 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -593,17 +593,13 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	struct thread_stack *ts = thread->ts;
 	int err = 0;
 
-	if (ts) {
-		if (!ts->crp) {
-			/* Supersede thread_stack__event() */
-			thread_stack__free(thread);
-			thread->ts = thread_stack__new(thread, crp);
-			if (!thread->ts)
-				return -ENOMEM;
-			ts = thread->ts;
-			ts->comm = comm;
-		}
-	} else {
+	if (ts && !ts->crp) {
+		/* Supersede thread_stack__event() */
+		thread_stack__free(thread);
+		ts = NULL;
+	}
+
+	if (!ts) {
 		thread->ts = thread_stack__new(thread, crp);
 		if (!thread->ts)
 			return -ENOMEM;
-- 
2.19.2


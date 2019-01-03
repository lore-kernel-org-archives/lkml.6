Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F060C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EC921872
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519660;
	bh=nBqahrpSE1PvftHr6uQGsDlXhFWVEr0RcKiZesCkqtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gqgLTKpcHeURjwz8sZBln55ItNg15yuicKmP5USYMY86ypXGywxMbMn/UT7c3efYD
	 oLnuviIqeaeMLgspirUoUntfded5bpl6wGY/IVWy20tqC9g08mwp8M+OL6zftTEonv
	 ep+qCgxvtS4cXKjzkUBdCPBWCS/JcvAymLpldrcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbfACMrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbfACMri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:38 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DE3F21872;
        Thu,  3 Jan 2019 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519657;
        bh=nBqahrpSE1PvftHr6uQGsDlXhFWVEr0RcKiZesCkqtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmGwwVW9QegCmcnO3i5mVEBlB8+7tODBjSXGRvn3p0awcdGFWl3XbsclZdo3N9yIC
         8prYRXBOrZVmhtruNdGP0YvAbLecXr9vXNEbJBOTTOsAKM8020AZj3SZIFOW7cLBSy
         qylXwwvWXNFF4G2CSHaEyPVHTIL3YSCUVEu1IjkI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/29] perf thread-stack: Factor out thread_stack__init()
Date:   Thu,  3 Jan 2019 09:46:06 -0300
Message-Id: <20190103124609.29672-27-acme@kernel.org>
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
factor out thread_stack__init().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index a5f7b9d8fc23..03770af9e5cd 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -93,6 +93,24 @@ static int thread_stack__grow(struct thread_stack *ts)
 	return 0;
 }
 
+static int thread_stack__init(struct thread_stack *ts, struct thread *thread,
+			      struct call_return_processor *crp)
+{
+	int err;
+
+	err = thread_stack__grow(ts);
+	if (err)
+		return err;
+
+	if (thread->mg && thread->mg->machine)
+		ts->kernel_start = machine__kernel_start(thread->mg->machine);
+	else
+		ts->kernel_start = 1ULL << 63;
+	ts->crp = crp;
+
+	return 0;
+}
+
 static struct thread_stack *thread_stack__new(struct thread *thread,
 					      struct call_return_processor *crp)
 {
@@ -104,17 +122,11 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 
 	ts->arr_sz = 1;
 
-	if (thread_stack__grow(ts)) {
+	if (thread_stack__init(ts, thread, crp)) {
 		free(ts);
 		return NULL;
 	}
 
-	if (thread->mg && thread->mg->machine)
-		ts->kernel_start = machine__kernel_start(thread->mg->machine);
-	else
-		ts->kernel_start = 1ULL << 63;
-	ts->crp = crp;
-
 	thread->ts = ts;
 
 	return ts;
-- 
2.19.2


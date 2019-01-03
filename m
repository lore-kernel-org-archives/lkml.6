Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233CAC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F9321871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519655;
	bh=wgjUmUMNqrXJVqNURx77JlQyWMFhP7d+BlUNrF2qZLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wjgPSRwalIcsxMwlx+7I/DpLOWGb9zgcR6aTnSFpR8U5xufAveNlthk8vW4uzSb4s
	 e7IZrocRxe8f+XfIp0yRYBTS5i5EnAHV0mRdc1O1kqVGRiSbMUImX9uhJEHKpi3wcz
	 YLL6W0LnufSKTMQDV6/WUUemnQ//fMjjGLl4UCl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfACMre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:42868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731593AbfACMra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:47:30 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B61217D9;
        Thu,  3 Jan 2019 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519649;
        bh=wgjUmUMNqrXJVqNURx77JlQyWMFhP7d+BlUNrF2qZLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBZDGEFDLCllnPk7qMOi6OrQE93DvDXpT8PJI3VpO8f8P5G+sx0iY665ponZOK4Kk
         3tEsAtGsx9CoSsboqOxU3kRwIatyCM2y9W4DcMCfn6+5kqEGXfesVUnijAaVJ3ONQH
         7hN6XRXqLnPfdVeVDHlQJ6shabT+9JOwVG00rVPM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/29] perf thread-stack: Tidy thread_stack__bottom() usage
Date:   Thu,  3 Jan 2019 09:46:03 -0300
Message-Id: <20190103124609.29672-24-acme@kernel.org>
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
tidy thread_stack__bottom() usage. Specifically, the parameter 'thread'
is not needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 115dc4b27a1b..068c7c8db4be 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -449,7 +449,7 @@ static int thread_stack__pop_cp(struct thread *thread, struct thread_stack *ts,
 	return 1;
 }
 
-static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
+static int thread_stack__bottom(struct thread_stack *ts,
 				struct perf_sample *sample,
 				struct addr_location *from_al,
 				struct addr_location *to_al, u64 ref)
@@ -474,7 +474,7 @@ static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
 	if (!cp)
 		return -ENOMEM;
 
-	return thread_stack__push_cp(thread->ts, ip, sample->time, ref, cp,
+	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
 				     true, false);
 }
 
@@ -617,8 +617,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	/* If the stack is empty, put the current symbol on the stack */
 	if (!ts->cnt) {
-		err = thread_stack__bottom(thread, ts, sample, from_al, to_al,
-					   ref);
+		err = thread_stack__bottom(ts, sample, from_al, to_al, ref);
 		if (err)
 			return err;
 	}
-- 
2.19.2


Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE56C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61839217D6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095737;
	bh=vyYVlcgdN/GxCusPqnGtLT2VorVvcd5fskSCaq3cC6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXZnZyIv13kXrxHrxEFNcvO3NibcGeJ1CoUQ2tqsnlEg3xOwMt266FNoUaV0abpiV
	 lb+ytV/2z2KvkxQDRwazxpek76fkrakdNgUXCcptkX0DGZ6dmmzmE0qS+1TF17oreh
	 ht0Br4nHTuLKp6czFmRs4/B3VJdfTtSlFYe3GqQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfAUSfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:42890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfAUSfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:35:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E200E2089F;
        Mon, 21 Jan 2019 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548095733;
        bh=vyYVlcgdN/GxCusPqnGtLT2VorVvcd5fskSCaq3cC6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kECGo6qJT7WmNde3SfDeS6IZ4LMzgKV6ESL4sjkBi3N4FHk35c1w4EmEyvznfwmnS
         FjEDvkJb9CxCfSvJbagiwvlseqg2Yppwe2Ky34y3+0n9fzh0NHyJDHPJm7UJdAC+ea
         hbqospzX/nGQZeQbpsAm/jfuYjJOyBj0gMFoE1mo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <liu.song.a23@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/7] perf ordered_events: Fix crash in ordered_events__free
Date:   Mon, 21 Jan 2019 15:35:01 -0300
Message-Id: <20190121183507.23490-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Song Liu reported crash in 'perf record':

  > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
  > #1  0x0000000000500196 in ordered_events.reinit ()
  > #2  0x00000000004fe413 in perf_session.process_events ()
  > #3  0x0000000000440431 in cmd_record ()
  > #4  0x00000000004a439f in run_builtin ()
  > #5  0x000000000042b3e5 in main ()"

This can happen when we get out of buffers during event processing.

The subsequent ordered_events__free() call assumes oe->buffer != NULL
and crashes. Add a check to prevent that.

Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Song Liu <liu.song.a23@gmail.com>
Tested-by: Song Liu <liu.song.a23@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190117113017.12977-1-jolsa@kernel.org
Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 897589507d97..ea523d3b248f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
-- 
2.20.1


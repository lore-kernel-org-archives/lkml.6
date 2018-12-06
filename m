Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3311CC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0162146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131777;
	bh=zvP9LbdNpZ9ZpuM0xbnllaZ9fXO9qjph94YAccx+aNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O5t76MwrOYJobw7+/59c8t4PKnkOiHeLgBCViLXdmLi31xqcMkfGAAx1+qjWPa/e+
	 2rKg8pIp6pWQWT3EJaui5IpH/jjeY5y5MyRCDg91vpEhsL8RpQumMoa+/CLjE6zIg/
	 SXyEzVi4yaSKV56PZBoaJJra590PwKLQ2vKJZots=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0162146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbeLFV3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbeLFV3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:35 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 566A520989;
        Thu,  6 Dec 2018 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131774;
        bh=zvP9LbdNpZ9ZpuM0xbnllaZ9fXO9qjph94YAccx+aNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoCCmhcENXhXG6Ngyvf10scOgaqrt0DykD0tSX5uW4uu22dQ2dVXm3UOmG+7SHes1
         J2zRQCPo9HUqqNj1wFJtfAqTSn4/AJsz/Ys9j8sP0IdvQ7s6KxOvGfmpcveAG/BZPs
         68kH7cXXPfz2DBG6u8d3MMzX+68h/Kfoyybbeumo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 46/75] perf ordered_events: Rework show_progress for __ordered_events__flush
Date:   Thu,  6 Dec 2018 18:25:33 -0300
Message-Id: <20181206212602.20474-47-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Decide to use the progress bar one level higher, we will need this in
following patch.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-ocjdukp2a8ujikkmafd0j5zv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 1904e7f6ec84..28f0f5c95024 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -219,13 +219,13 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 	return 0;
 }
 
-static int __ordered_events__flush(struct ordered_events *oe)
+static int __ordered_events__flush(struct ordered_events *oe,
+				   bool show_progress)
 {
 	struct list_head *head = &oe->events;
 	struct ordered_event *tmp, *iter;
 	u64 limit = oe->next_flush;
 	u64 last_ts = oe->last ? oe->last->timestamp : 0ULL;
-	bool show_progress = limit == ULLONG_MAX;
 	struct ui_progress prog;
 	int ret;
 
@@ -272,6 +272,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		"HALF ",
 	};
 	int err;
+	bool show_progress = false;
 
 	if (oe->nr_events == 0)
 		return 0;
@@ -279,6 +280,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	switch (how) {
 	case OE_FLUSH__FINAL:
 		oe->next_flush = ULLONG_MAX;
+		show_progress = true;
 		break;
 
 	case OE_FLUSH__HALF:
@@ -308,7 +310,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		   str[how], oe->nr_events);
 	pr_oe_time(oe->max_timestamp, "max_timestamp\n");
 
-	err = __ordered_events__flush(oe);
+	err = __ordered_events__flush(oe, show_progress);
 
 	if (!err) {
 		if (how == OE_FLUSH__ROUND)
-- 
2.19.2


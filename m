Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EF3C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B912D2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025934;
	bh=p9Cnz2WgxXLR4c7HDleEbaGuc6IMCjoYt58q0fc/V0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bofZpPB0+5LlJoFiY/sEJ6QSrcKC3pShb0aTlzLuqny3ISXosqbri3YBHK12TBMLo
	 EX/J5U+zqX5kMr2r75PgR07LosJvon8lQGmXVIj0SYccZoMnePRF/r9gPHt8Tz7fhR
	 40Xv+whzmRbpgcMAku7gmUYczS34qGI1zE/3hffw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B912D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbeLEQFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46619 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeLEQFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:31 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6840B3DE04;
        Wed,  5 Dec 2018 16:05:30 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF1805C5FD;
        Wed,  5 Dec 2018 16:05:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 6/8] perf tools: Add ordered_events__flush_time interface
Date:   Wed,  5 Dec 2018 17:05:07 +0100
Message-Id: <20181205160509.1168-7-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 05 Dec 2018 16:05:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding OE_FLUSH__TIME flush type, to be able to flush
only certain amount of the queue based on the provided
timestamp. It will be used in following patches.

Link: http://lkml.kernel.org/n/tip-a3na77vemwr1g92lfhlrztg5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/ordered-events.c | 23 +++++++++++++++++++----
 tools/perf/util/ordered-events.h |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index c5412db05683..b5c6a854379f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -219,8 +219,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 	return 0;
 }
 
-static int __ordered_events__flush(struct ordered_events *oe,
-				   bool show_progress)
+static int do_flush(struct ordered_events *oe, bool show_progress)
 {
 	struct list_head *head = &oe->events;
 	struct ordered_event *tmp, *iter;
@@ -263,7 +262,8 @@ static int __ordered_events__flush(struct ordered_events *oe,
 	return 0;
 }
 
-int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
+static int __ordered_events__flush(struct ordered_events *oe, enum oe_flush how,
+				   u64 time)
 {
 	static const char * const str[] = {
 		"NONE",
@@ -302,6 +302,11 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		break;
 	}
 
+	case OE_FLUSH__TIME:
+		oe->next_flush = time;
+		show_progress = false;
+		break;
+
 	case OE_FLUSH__ROUND:
 	case OE_FLUSH__NONE:
 	default:
@@ -312,7 +317,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		   str[how], oe->nr_events);
 	pr_oe_time(oe->max_timestamp, "max_timestamp\n");
 
-	err = __ordered_events__flush(oe, show_progress);
+	err = do_flush(oe, show_progress);
 
 	if (!err) {
 		if (how == OE_FLUSH__ROUND)
@@ -328,6 +333,16 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	return err;
 }
 
+int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
+{
+	return __ordered_events__flush(oe, how, 0);
+}
+
+int ordered_events__flush_time(struct ordered_events *oe, u64 time)
+{
+	return __ordered_events__flush(oe, OE_FLUSH__TIME, time);
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 0c6e26aec0e3..6ef81e5be052 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -19,6 +19,7 @@ enum oe_flush {
 	OE_FLUSH__ROUND,
 	OE_FLUSH__HALF,
 	OE_FLUSH__TOP,
+	OE_FLUSH__TIME,
 };
 
 struct ordered_events;
@@ -55,6 +56,7 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 			  u64 timestamp, u64 file_offset);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
+int ordered_events__flush_time(struct ordered_events *oe, u64 time);
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
-- 
2.17.2


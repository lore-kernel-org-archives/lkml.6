Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68AC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0177E20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0177E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLAPUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 10:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeLAPU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 10:20:27 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D60214DB;
        Sat,  1 Dec 2018 04:08:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSwaL-0000J3-0Y; Fri, 30 Nov 2018 23:08:53 -0500
Message-Id: <20181201040852.913841066@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 23:08:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 6/6] tools/lib/traceevent: Remove tep_data_event_from_type() API
References: <20181201040807.154099010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API
should be straightforward. After discussion with Steven Rostedt,
we decided to remove the tep_data_event_from_type() API and to
replace it with tep_find_event(), as it does the same.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 12 ------------
 tools/lib/traceevent/event-parse.h |  1 -
 2 files changed, 13 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index b3c00d6b524e..f84ce3897ce6 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5264,18 +5264,6 @@ int tep_data_type(struct tep_handle *pevent, struct tep_record *rec)
 	return trace_parse_common_type(pevent, rec->data);
 }
 
-/**
- * tep_data_event_from_type - find the event by a given type
- * @pevent: a handle to the pevent
- * @type: the type of the event.
- *
- * This returns the event form a given @type;
- */
-struct tep_event *tep_data_event_from_type(struct tep_handle *pevent, int type)
-{
-	return tep_find_event(pevent, type);
-}
-
 /**
  * tep_data_pid - parse the PID from record
  * @pevent: a handle to the pevent
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index bd1bd9a27839..aec48f2aea8a 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -526,7 +526,6 @@ tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
 void tep_data_lat_fmt(struct tep_handle *pevent,
 		      struct trace_seq *s, struct tep_record *record);
 int tep_data_type(struct tep_handle *pevent, struct tep_record *rec);
-struct tep_event *tep_data_event_from_type(struct tep_handle *pevent, int type);
 int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec);
-- 
2.19.1



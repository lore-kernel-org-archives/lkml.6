Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7BC67839
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E828D2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131931;
	bh=EAyq0f+4B4VNW72bY1+/dzBcCl6FAgcUTswW27MGOQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Efyi7v3TjLUrH9zR4YoKk/kYYFhRUZbYtFzBQc2G7A9n1lkmuggOamrsk87uVZ5Ip
	 MxrIRnlUHHtrXYk2VSaPjsXjImkcsSQVsn8esR4sxoWU7qa4e0dRxwM02n/I234/7S
	 TU71tjqrJkVjLIXA/pXOc1LCVYluS3AqQS8XqAw8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E828D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeLFVbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbeLFVbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:31:11 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C62120989;
        Thu,  6 Dec 2018 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131871;
        bh=EAyq0f+4B4VNW72bY1+/dzBcCl6FAgcUTswW27MGOQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsbBINSd4yvmvcYX1VuRRntBvV/VF28a+gs5UpHegWU0x//vyS8PL55KmUV8KaBH9
         W61ePXslfBuunXRTd9EecE7kvjvUaf0d0BchcD/etVnwrqwj03mUROXMgKAP+SLCq3
         hLw58QR1p3cGiu9MvRohzPQ2D6wiAEMaCv+89AtU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dmitry Levin <ldv@altlinux.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@uudg.org>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 72/75] perf ordered_events: Add ordered_events__flush_time interface
Date:   Thu,  6 Dec 2018 18:25:59 -0300
Message-Id: <20181206212602.20474-73-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add OE_FLUSH__TIME flush type, to be able to flush only certain amount
of the queue based on the provided timestamp. It will be used in the
following patches.

Link: http://lkml.kernel.org/n/tip-a3na77vemwr1g92lfhlrztg5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dmitry Levin <ldv@altlinux.org>
Cc: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Luis Cláudio Gonçalves <lclaudio@uudg.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20181205160509.1168-7-jolsa@kernel.org
[ Fix the build on older systems such as centos 5 and 6 where 'time' shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 23 +++++++++++++++++++----
 tools/perf/util/ordered-events.h |  2 ++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index c5412db05683..46965643020b 100644
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
+				   u64 timestamp)
 {
 	static const char * const str[] = {
 		"NONE",
@@ -302,6 +302,11 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		break;
 	}
 
+	case OE_FLUSH__TIME:
+		oe->next_flush = timestamp;
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
+int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp)
+{
+	return __ordered_events__flush(oe, OE_FLUSH__TIME, timestamp);
+}
+
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data)
 {
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 0c6e26aec0e3..f352af20e167 100644
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
+int ordered_events__flush_time(struct ordered_events *oe, u64 timestamp);
 void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
 			  void *data);
 void ordered_events__free(struct ordered_events *oe);
-- 
2.19.2


Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2899AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276820873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLRN60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:58:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54243 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLRN60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:58:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDwHW22851935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:58:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDwH3k2851932;
        Tue, 18 Dec 2018 05:58:17 -0800
Date:   Tue, 18 Dec 2018 05:58:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-44e92f8389b2242efde77d5321ffa88decd47df6@git.kernel.org>
Cc:     hpa@zytor.com, tstoyanov@vmware.com, acme@redhat.com,
        mingo@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, kaslevs@vmware.com,
        tglx@linutronix.de, jolsa@redhat.com
Reply-To: jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, kaslevs@vmware.com,
          rostedt@goodmis.org, mingo@kernel.org, hpa@zytor.com,
          acme@redhat.com, tstoyanov@vmware.com
In-Reply-To: <20181128145552.68c4f87b@gandalf.local.home>
References: <20181128145552.68c4f87b@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add sanity check to
 is_timestamp_in_us()
Git-Commit-ID: 44e92f8389b2242efde77d5321ffa88decd47df6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  44e92f8389b2242efde77d5321ffa88decd47df6
Gitweb:     https://git.kernel.org/tip/44e92f8389b2242efde77d5321ffa88decd47df6
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Wed, 28 Nov 2018 14:55:52 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:19 -0300

tools lib traceevent: Add sanity check to is_timestamp_in_us()

This patch adds a sanity check to is_timestamp_in_us() input parameter
trace_clock. It avoids a potential segfault in this function for the
case trace_clock is NULL.

Reported-by: Slavomir Kaslev <kaslevs@vmware.com>
Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20181128145552.68c4f87b@gandalf.local.home
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index fbd6d6813fab..2b5cb33046ce 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5409,7 +5409,7 @@ void tep_event_info(struct trace_seq *s, struct tep_event_format *event,
 
 static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 {
-	if (!use_trace_clock)
+	if (!trace_clock || !use_trace_clock)
 		return true;
 
 	if (!strcmp(trace_clock, "local") || !strcmp(trace_clock, "global")

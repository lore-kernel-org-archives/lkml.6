Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BACEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774A1208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeLNUb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:31:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60655 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbeLNUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:31:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKVL4N1454257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:31:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKVLJu1454254;
        Fri, 14 Dec 2018 12:31:21 -0800
Date:   Fri, 14 Dec 2018 12:31:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-51d0337d01985d0cccb6e41f976cc0dbe921fd84@git.kernel.org>
Cc:     rostedt@goodmis.org, tstoyanov@vmware.com,
        linux-kernel@vger.kernel.org, kaslevs@vmware.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        jolsa@redhat.com, acme@redhat.com
Reply-To: jolsa@redhat.com, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, tglx@linutronix.de, kaslevs@vmware.com,
          linux-kernel@vger.kernel.org, tstoyanov@vmware.com,
          rostedt@goodmis.org
In-Reply-To: <20181128145552.68c4f87b@gandalf.local.home>
References: <20181128145552.68c4f87b@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Add sanity check to
 is_timestamp_in_us()
Git-Commit-ID: 51d0337d01985d0cccb6e41f976cc0dbe921fd84
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

Commit-ID:  51d0337d01985d0cccb6e41f976cc0dbe921fd84
Gitweb:     https://git.kernel.org/tip/51d0337d01985d0cccb6e41f976cc0dbe921fd84
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Wed, 28 Nov 2018 14:55:52 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:50 -0300

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

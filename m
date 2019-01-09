Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AC5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C547B20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbfAIHPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:15:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43443 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:15:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097F0fJ3856082
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:15:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097F0o03856078;
        Tue, 8 Jan 2019 23:15:00 -0800
Date:   Tue, 8 Jan 2019 23:15:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-f87ce7c43f36d4abff91b19edadd23939f99ff98@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        namhyung@kernel.org, akpm@linux-foundation.org,
        tstoyanov@vmware.com, mingo@kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com
Reply-To: rostedt@goodmis.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, acme@redhat.com, jolsa@redhat.com,
          mingo@kernel.org, tstoyanov@vmware.com,
          akpm@linux-foundation.org, namhyung@kernel.org
In-Reply-To: <20181201040852.628034497@goodmis.org>
References: <20181201040852.628034497@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Changed return logic of
 tep_register_event_handler() API
Git-Commit-ID: f87ce7c43f36d4abff91b19edadd23939f99ff98
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

Commit-ID:  f87ce7c43f36d4abff91b19edadd23939f99ff98
Gitweb:     https://git.kernel.org/tip/f87ce7c43f36d4abff91b19edadd23939f99ff98
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 23:08:11 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

tools lib traceevent: Changed return logic of tep_register_event_handler() API

In order to make libtraceevent into a proper library, its API
should be straightforward.

The tep_register_event_handler() functions returns -1 in case it
successfully registers the new event handler. Such return code is used
by the other library APIs in case of an error.

To unify the return logic of tep_register_event_handler() with the other
APIs, this patch introduces enum tep_reg_handler, which is used by this
function as return value, to handle all possible successful return
cases.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.628034497@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 10 ++++++++--
 tools/lib/traceevent/event-parse.h |  5 +++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index a850342baf86..54d94054eef0 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6632,6 +6632,12 @@ static struct tep_event *search_event(struct tep_handle *pevent, int id,
  *
  * If @id is >= 0, then it is used to find the event.
  * else @sys_name and @event_name are used.
+ *
+ * Returns:
+ *  TEP_REGISTER_SUCCESS_OVERWRITE if an existing handler is overwritten
+ *  TEP_REGISTER_SUCCESS if a new handler is registered successfully
+ *  negative TEP_ERRNO_... in case of an error
+ *
  */
 int tep_register_event_handler(struct tep_handle *pevent, int id,
 			       const char *sys_name, const char *event_name,
@@ -6649,7 +6655,7 @@ int tep_register_event_handler(struct tep_handle *pevent, int id,
 
 	event->handler = func;
 	event->context = context;
-	return 0;
+	return TEP_REGISTER_SUCCESS_OVERWRITE;
 
  not_found:
 	/* Save for later use. */
@@ -6679,7 +6685,7 @@ int tep_register_event_handler(struct tep_handle *pevent, int id,
 	pevent->handlers = handle;
 	handle->context = context;
 
-	return -1;
+	return TEP_REGISTER_SUCCESS;
 }
 
 static int handle_matches(struct event_handler *handler, int id,
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 77a4a1dd4b4d..ac377ae99008 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -485,6 +485,11 @@ int tep_print_func_field(struct trace_seq *s, const char *fmt,
 			 struct tep_event *event, const char *name,
 			 struct tep_record *record, int err);
 
+enum tep_reg_handler {
+	TEP_REGISTER_SUCCESS = 0,
+	TEP_REGISTER_SUCCESS_OVERWRITE,
+};
+
 int tep_register_event_handler(struct tep_handle *pevent, int id,
 			       const char *sys_name, const char *event_name,
 			       tep_event_handler_func func, void *context);

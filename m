Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257B9218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977599;
	bh=NPX6YQ1/CXHL0qQcYv6dkwgM06uxfgIj7I408T1+no4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LxI6v+amfTSykqjqbAip37WObQAo2+uoCcIo+Zh/dhM6f5TsMbv9sY2KY9QUQ7uzk
	 pfgoRz2YX7e/F9BpSoZhOSVq6jH54JvdkfTQnuOO2vrBw/m963JQ/Cn4VhzA8e6c+q
	 2ybkIGI7LgjGLXnYc9hrpPw0vk/KzyJyQ7rnGj48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbfAHT76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730601AbfAHT7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:54 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D25214C6;
        Tue,  8 Jan 2019 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977593;
        bh=NPX6YQ1/CXHL0qQcYv6dkwgM06uxfgIj7I408T1+no4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m9c6cfwcTFPIefcIsb5ogFv8feVnNukENrye27TfXIzVOWIJjgehkwicfTYvbHAo8
         vSqdPwoGeWpvGQ7FE2t9N/N3XDpHZxOZZRs7QuVQ1Q+yFefSUrwSvFKvzyeYZGWyc4
         nvmx5d5iJ89ERwYOMmIDEF0xNKD4+S27+mAn8YxY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/16] tools lib traceevent: Changed return logic of tep_register_event_handler() API
Date:   Tue,  8 Jan 2019 16:59:03 -0300
Message-Id: <20190108195910.17726-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

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
-- 
2.20.1


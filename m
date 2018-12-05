Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB338C65BB0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C09820645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C09820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeLEXsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:58592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728952AbeLEXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:34 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0F3722353;
        Wed,  5 Dec 2018 23:48:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu8-0000MD-Sk; Wed, 05 Dec 2018 18:48:32 -0500
Message-Id: <20181205234832.790474566@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 29/30] tracing: Add generic event-name based remove event method
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a generic method to remove event from dynamic event
list. This is same as other system under ftrace. You
just need to pass the event name with '!', e.g.

  # echo p:new_grp/new_event _do_fork > dynamic_events

This creates an event, and

  # echo '!p:new_grp/new_event _do_fork' > dynamic_events

Or,

  # echo '!p:new_grp/new_event' > dynamic_events

will remove new_grp/new_event event.

Note that this doesn't check the event prefix (e.g. "p:")
strictly, because the "group/event" name must be unique.

Link: http://lkml.kernel.org/r/154140869774.17322.8887303560398645347.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_dynevent.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index f17a887abb66..dd1f43588d70 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -37,10 +37,17 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 	char *system = NULL, *event, *p;
 	int ret = -ENOENT;
 
-	if (argv[0][1] != ':')
-		return -EINVAL;
+	if (argv[0][0] == '-') {
+		if (argv[0][1] != ':')
+			return -EINVAL;
+		event = &argv[0][2];
+	} else {
+		event = strchr(argv[0], ':');
+		if (!event)
+			return -EINVAL;
+		event++;
+	}
 
-	event = &argv[0][2];
 	p = strchr(event, '/');
 	if (p) {
 		system = event;
@@ -69,7 +76,7 @@ static int create_dyn_event(int argc, char **argv)
 	struct dyn_event_operations *ops;
 	int ret;
 
-	if (argv[0][0] == '-')
+	if (argv[0][0] == '-' || argv[0][0] == '!')
 		return dyn_event_release(argc, argv, NULL);
 
 	mutex_lock(&dyn_event_ops_mutex);
-- 
2.19.1



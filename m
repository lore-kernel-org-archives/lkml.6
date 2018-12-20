Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FD9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D066E217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbeLTSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:00:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36573 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbeLTSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:00:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI0Dt53679950
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:00:13 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI0DEd3679947;
        Thu, 20 Dec 2018 10:00:13 -0800
Date:   Thu, 20 Dec 2018 10:00:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Steven Rostedt (VMware)" <tipbot@zytor.com>
Message-ID: <tip-f024cf085c423bac7512479f45c34ee9a24af7ce@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com, namhyung@kernel.org
Reply-To: namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
          rostedt@goodmis.org, tglx@linutronix.de, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <20181210134522.3f71e2ca@gandalf.local.home>
References: <20181210134522.3f71e2ca@gandalf.local.home>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Fix processing of
 dereferenced args in bprintk events
Git-Commit-ID: f024cf085c423bac7512479f45c34ee9a24af7ce
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

Commit-ID:  f024cf085c423bac7512479f45c34ee9a24af7ce
Gitweb:     https://git.kernel.org/tip/f024cf085c423bac7512479f45c34ee9a24af7ce
Author:     Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate: Mon, 10 Dec 2018 13:45:22 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:21:44 -0300

tools lib traceevent: Fix processing of dereferenced args in bprintk events

In the case that a bprintk event has a dereferenced pointer that is
stored as a string, and there's more values to process (more args), the
arg was not updated to point to the next arg after processing the
dereferenced pointer, and it screwed up what was to be displayed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 37db96bb49629 ("tools lib traceevent: Handle new pointer processing of bprint strings")
Link: http://lkml.kernel.org/r/20181210134522.3f71e2ca@gandalf.local.home
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index a5ed291b8a9f..69a96e39f0ab 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4973,6 +4973,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 
 				if (arg->type == TEP_PRINT_BSTRING) {
 					trace_seq_puts(s, arg->string.string);
+					arg = arg->next;
 					break;
 				}
 

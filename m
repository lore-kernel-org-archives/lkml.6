Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149D5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E114C2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfAIHOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:14:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40103 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfAIHOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:14:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097EODh3856040
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:14:24 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097EOKt3856037;
        Tue, 8 Jan 2019 23:14:24 -0800
Date:   Tue, 8 Jan 2019 23:14:24 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-6d2d6fd7e3ee0daf0d8308741792b3ec41aafd0c@git.kernel.org>
Cc:     tstoyanov@vmware.com, akpm@linux-foundation.org, mingo@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, jolsa@redhat.com,
        hpa@zytor.com, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org,
          tstoyanov@vmware.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
          jolsa@redhat.com, rostedt@goodmis.org
In-Reply-To: <20181201040852.485792891@goodmis.org>
References: <20181201040852.485792891@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools lib traceevent: Changed return logic of
 trace_seq_printf() and trace_seq_vprintf() APIs
Git-Commit-ID: 6d2d6fd7e3ee0daf0d8308741792b3ec41aafd0c
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

Commit-ID:  6d2d6fd7e3ee0daf0d8308741792b3ec41aafd0c
Gitweb:     https://git.kernel.org/tip/6d2d6fd7e3ee0daf0d8308741792b3ec41aafd0c
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 23:08:10 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

tools lib traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs

In order to make libtraceevent into a proper library, its API should be
straightforward.

The trace_seq_printf() and trace_seq_vprintf() APIs have inconsistent
returned values with the other trace_seq_* APIs.

This path changes the return logic of trace_seq_printf() and
trace_seq_vprintf() to return the number of printed characters, as the
other trace_seq_* related APIs.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201040852.485792891@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/trace-seq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/lib/traceevent/trace-seq.c b/tools/lib/traceevent/trace-seq.c
index 8ff1d55954d1..8d5ecd2bf877 100644
--- a/tools/lib/traceevent/trace-seq.c
+++ b/tools/lib/traceevent/trace-seq.c
@@ -100,7 +100,8 @@ static void expand_buffer(struct trace_seq *s)
  * @fmt: printf format string
  *
  * It returns 0 if the trace oversizes the buffer's free
- * space, 1 otherwise.
+ * space, the number of characters printed, or a negative
+ * value in case of an error.
  *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formating of a trace
@@ -129,9 +130,10 @@ trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 		goto try_again;
 	}
 
-	s->len += ret;
+	if (ret > 0)
+		s->len += ret;
 
-	return 1;
+	return ret;
 }
 
 /**
@@ -139,6 +141,10 @@ trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
  * @s: trace sequence descriptor
  * @fmt: printf format string
  *
+ * It returns 0 if the trace oversizes the buffer's free
+ * space, the number of characters printed, or a negative
+ * value in case of an error.
+ * *
  * The tracer may use either sequence operations or its own
  * copy to user routines. To simplify formating of a trace
  * trace_seq_printf is used to store strings into a special
@@ -163,9 +169,10 @@ trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
 		goto try_again;
 	}
 
-	s->len += ret;
+	if (ret > 0)
+		s->len += ret;
 
-	return len;
+	return ret;
 }
 
 /**

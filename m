Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ACBC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A768820867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A768820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeLAPU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 10:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbeLAPU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 10:20:27 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84634214DA;
        Sat,  1 Dec 2018 04:08:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSwaK-0000HM-J4; Fri, 30 Nov 2018 23:08:52 -0500
Message-Id: <20181201040852.485792891@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 23:08:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 3/6] tools/lib/traceevent: Changed return logic of trace_seq_printf() and
 trace_seq_vprintf() APIs
References: <20181201040807.154099010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API
should be straightforward. The trace_seq_printf() and
trace_seq_vprintf() APIs have inconsistent returned values with
the other trace_seq_* APIs. This path changes the return logic of
trace_seq_printf() and trace_seq_vprintf() - to return the number
of printed characters, as the other trace_seq_* related APIs.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
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
-- 
2.19.1



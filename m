Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE33C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65911218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977596;
	bh=HW0eXZKriWSuuUtZHylVKD8H9nrRmLv65WRIlzbWZG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WnwQapJWNm+o2mnHYo1UfeGBc+WiEhbtOfUV4GRZ2slTahLvLD1w31WWOvr8a2Sjr
	 WtSi7CcMqzw1tE8FMweZK+S0dXeGOrtLYbyO28w/RPOxCBxzMAlL9QD1BMVTmR1JS0
	 k7WnYcdWaDGBLLbQLGTedps2ymErYxLwap8iNSrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbfAHT7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:56822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbfAHT7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:51 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EFC420660;
        Tue,  8 Jan 2019 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977590;
        bh=HW0eXZKriWSuuUtZHylVKD8H9nrRmLv65WRIlzbWZG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+1Tl4MSG2w2aj+ZfZyWSPBWQlut8q6cVyulqhgFvjOKxXgaFUbfTbbBfqXicH46s
         6CDWtCSmJIN/r7M8ioqdP9xnGM5PagrIpglrn562Duol1vTCecP14+qh44fi6QdWRK
         Am5bFK06sKzAYpO/hoJZb8YqO/kyUGb2eqCmHmXQ=
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
Subject: [PATCH 08/16] tools lib traceevent: Changed return logic of trace_seq_printf() and trace_seq_vprintf() APIs
Date:   Tue,  8 Jan 2019 16:59:02 -0300
Message-Id: <20190108195910.17726-9-acme@kernel.org>
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
-- 
2.20.1


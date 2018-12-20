Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CADCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B61B218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387966AbeLTRgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:36:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387591AbeLTRgY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:36:24 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D362186A;
        Thu, 20 Dec 2018 17:36:23 +0000 (UTC)
Date:   Thu, 20 Dec 2018 12:36:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] perf: Use strcmp() for "ftrace:function" check
Message-ID: <20181220123621.4a038031@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As strncmp(str, "const", sizeof("const") is exactly the same as
strcmp(str, "const") use that instead, otherwise it is confusing.

The test if the event name is "ftrace:function" in
perf_evsel__set_sample_id() is rather strange as it makes an
unnecessary macro of FUNCTION_EVENT to equal "ftrace:function" and uses
that twice so that it can do the sizeof(). But since sizeof("const")
includes the nul terminator ('\0') of the string "const" that compare
is the same as using strcmp().

With strcmp() there's no need to use the string twice, and that also
means the FUNCTION_EVENT macro is not needed.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d37bb1566cd9..58a452d77951 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -215,12 +215,7 @@ void perf_evsel__set_sample_id(struct perf_evsel *evsel,
  */
 bool perf_evsel__is_function_event(struct perf_evsel *evsel)
 {
-#define FUNCTION_EVENT "ftrace:function"
-
-	return evsel->name &&
-	       !strncmp(FUNCTION_EVENT, evsel->name, sizeof(FUNCTION_EVENT));
-
-#undef FUNCTION_EVENT
+	return evsel->name && !strcmp("ftrace:function", evsel->name);
 }
 
 void perf_evsel__init(struct perf_evsel *evsel,

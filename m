Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E43C8217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732874AbeLTR0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728221AbeLTR0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:26:04 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D56217D9;
        Thu, 20 Dec 2018 17:26:03 +0000 (UTC)
Date:   Thu, 20 Dec 2018 12:26:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: perf: Use strcmp(str, "const") instead of strncmp(str, "const",
 sizeof("const"))
Message-ID: <20181220122601.62bf8858@gandalf.local.home>
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

sizeof("const") includes the nul terminator ('\0') of the string
"const", and that means strncmp() will only return a match if str and
"const" are exactly the same, which is what strcmp() does.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 32ef7bdca1cf..eabf30f963a5 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -258,7 +258,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 
 	do {
 		/* Framepointer style */
-		if (!strncmp(name, "fp", sizeof("fp"))) {
+		if (!strcmp(name, "fp")) {
 			if (!strtok_r(NULL, ",", &saveptr)) {
 				param->record_mode = CALLCHAIN_FP;
 				ret = 0;
@@ -268,7 +268,7 @@ int parse_callchain_record(const char *arg, struct callchain_param *param)
 			break;
 
 		/* Dwarf style */
-		} else if (!strncmp(name, "dwarf", sizeof("dwarf"))) {
+		} else if (!strcmp(name, "dwarf")) {
 			const unsigned long default_stack_dump_size = 8192;
 
 			ret = 0;

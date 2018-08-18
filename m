Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C062CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8372921878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8372921878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeHRO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:28:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:28:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBKqCm1283530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:20:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBKqZB1283527;
        Sat, 18 Aug 2018 04:20:52 -0700
Date:   Sat, 18 Aug 2018 04:20:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-v59q5e0jrlzkpl9a1c7t81ni@git.kernel.org>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        mingo@kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, dsahern@gmail.com, acme@redhat.com
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          rostedt@goodmis.org, hpa@zytor.com, namhyung@kernel.org,
          wangnan0@huawei.com, tglx@linutronix.de, dsahern@gmail.com,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Allow setting up a syscall_tp struct
 without a format_field
Git-Commit-ID: aa823f58f7abf42f181fbaef4fdbe76eccea1c29
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

Commit-ID:  aa823f58f7abf42f181fbaef4fdbe76eccea1c29
Gitweb:     https://git.kernel.org/tip/aa823f58f7abf42f181fbaef4fdbe76eccea1c29
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 Aug 2018 15:03:02 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 Aug 2018 15:07:33 -0300

perf trace: Allow setting up a syscall_tp struct without a format_field

To avoid having to ask libtraceevent to find a field by name when
handling each tracepoint event, we setup a struct syscall_tp with
a tp_field struct having an extractor function + the offset for the
"id", "args" and "ret" raw_syscalls:sys_{enter,exit} tracepoints.

Now that we want to do the same with syscalls:sys_{entry,exit}_NAME
individual syscall tracepoints, where we have "id" as "__syscall_nr" and
"args" as the actual series of per syscall parameters, we need more
flexibility from the routines that set up these pre-looked up syscall
tracepoint arg fields.

The next cset will use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v59q5e0jrlzkpl9a1c7t81ni@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 039f94467968..7fca844ced0b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -156,13 +156,11 @@ TP_UINT_FIELD__SWAPPED(16);
 TP_UINT_FIELD__SWAPPED(32);
 TP_UINT_FIELD__SWAPPED(64);
 
-static int tp_field__init_uint(struct tp_field *field,
-			       struct format_field *format_field,
-			       bool needs_swap)
+static int __tp_field__init_uint(struct tp_field *field, int size, int offset, bool needs_swap)
 {
-	field->offset = format_field->offset;
+	field->offset = offset;
 
-	switch (format_field->size) {
+	switch (size) {
 	case 1:
 		field->integer = tp_field__u8;
 		break;
@@ -182,18 +180,28 @@ static int tp_field__init_uint(struct tp_field *field,
 	return 0;
 }
 
+static int tp_field__init_uint(struct tp_field *field, struct format_field *format_field, bool needs_swap)
+{
+	return __tp_field__init_uint(field, format_field->size, format_field->offset, needs_swap);
+}
+
 static void *tp_field__ptr(struct tp_field *field, struct perf_sample *sample)
 {
 	return sample->raw_data + field->offset;
 }
 
-static int tp_field__init_ptr(struct tp_field *field, struct format_field *format_field)
+static int __tp_field__init_ptr(struct tp_field *field, int offset)
 {
-	field->offset = format_field->offset;
+	field->offset = offset;
 	field->pointer = tp_field__ptr;
 	return 0;
 }
 
+static int tp_field__init_ptr(struct tp_field *field, struct format_field *format_field)
+{
+	return __tp_field__init_ptr(field, format_field->offset);
+}
+
 struct syscall_tp {
 	struct tp_field id;
 	union {

Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56095C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1130E2183D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/+LYwW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1130E2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbeHIRYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:22 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6078321D62;
        Thu,  9 Aug 2018 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826744;
        bh=dcxa7lghSDpBd4RYI9gIDpKiqdUthnW2YHI62ZzicGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/+LYwW6cQVTgzOR2Aa+c/NVxKcx/2fgfQuzTvMzSI/aLDJtPms5lKG5W251/kM6B
         /SCCaEjkcFJo+vZcdS2Oh6yt+8yfL2OE2l8Eb2cfW5joMdXqoOfm//Ty450iw6+7A4
         k1YeBmfKBuifZcLwphICr3ILtTMCCMrhX06PgyH0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/44] perf trace: Allow setting up a syscall_tp struct without a format_field
Date:   Thu,  9 Aug 2018 11:57:42 -0300
Message-Id: <20180809145822.21391-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4


Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C08C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C745520989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131729;
	bh=bJ2swmg0QGTh7EPYx+xP13BI0YQ9l+JUcNNr/cNPnK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sKhXPMwx6zPj78Wer5HmdGnQLy4C5qYImytv40frfIhEEMkDk9PzmfO2BY2WFOEJK
	 UMouf6S0O9uuBG44oM+TV21XQ6FXC3WrDOdga2BOHMOjTpyOuYt6lirQbv1+b8Epg4
	 2AHQQjALYT6ipus53FGLVT8GT9B9lq+ZZgQTbJd0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C745520989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLFV2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbeLFV2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:28:47 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38FF2082B;
        Thu,  6 Dec 2018 21:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131726;
        bh=bJ2swmg0QGTh7EPYx+xP13BI0YQ9l+JUcNNr/cNPnK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aD8O5tuUlDpWyt4p4t8N4dW5bOVvXJhpBykiw+jcgWAu/aEtJ3EKkLy16LJIXZRKt
         2mRHVCcIB8Xh+TzWQR31GvAVmZSqNT9i+i7FjQcf+mnJ+DCacJZxXQa5ZHah1o+aaT
         spyF1veEysJIC04Lo8xKKaqm7Ejdj4bFb04yvqTo=
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
Subject: [PATCH 33/75] tools lib traceevent: traceevent API cleanup
Date:   Thu,  6 Dec 2018 18:25:20 -0300
Message-Id: <20181206212602.20474-34-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, its API should be
straightforward. This patch hides few API functions, intended for
internal usage only:

tep_free_event(), tep_free_format_field(), __tep_data2host2(),
__tep_data2host4() and __tep_data2host8().
The patch also alignes the libtraceevent summary man page with
these API changes.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154647.891651290@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c   |  6 +++---
 tools/lib/traceevent/event-parse-local.h |  7 +++++++
 tools/lib/traceevent/event-parse.c       | 13 ++++++++-----
 tools/lib/traceevent/event-parse.h       | 16 ----------------
 4 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 0dc011154ee9..8b31c0e00ba3 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -51,7 +51,7 @@ void tep_set_flag(struct tep_handle *tep, int flag)
 		tep->flags |= flag;
 }
 
-unsigned short __tep_data2host2(struct tep_handle *pevent, unsigned short data)
+unsigned short tep_data2host2(struct tep_handle *pevent, unsigned short data)
 {
 	unsigned short swap;
 
@@ -64,7 +64,7 @@ unsigned short __tep_data2host2(struct tep_handle *pevent, unsigned short data)
 	return swap;
 }
 
-unsigned int __tep_data2host4(struct tep_handle *pevent, unsigned int data)
+unsigned int tep_data2host4(struct tep_handle *pevent, unsigned int data)
 {
 	unsigned int swap;
 
@@ -80,7 +80,7 @@ unsigned int __tep_data2host4(struct tep_handle *pevent, unsigned int data)
 }
 
 unsigned long long
-__tep_data2host8(struct tep_handle *pevent, unsigned long long data)
+tep_data2host8(struct tep_handle *pevent, unsigned long long data)
 {
 	unsigned long long swap;
 
diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
index 94746efef433..9a092dd4a86d 100644
--- a/tools/lib/traceevent/event-parse-local.h
+++ b/tools/lib/traceevent/event-parse-local.h
@@ -89,4 +89,11 @@ struct tep_handle {
 	char *trace_clock;
 };
 
+void tep_free_event(struct tep_event *event);
+void tep_free_format_field(struct tep_format_field *field);
+
+unsigned short tep_data2host2(struct tep_handle *pevent, unsigned short data);
+unsigned int tep_data2host4(struct tep_handle *pevent, unsigned int data);
+unsigned long long tep_data2host8(struct tep_handle *pevent, unsigned long long data);
+
 #endif /* _PARSE_EVENTS_INT_H */
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index a3e7d0a75e11..ffa656b868a9 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -3328,15 +3328,18 @@ tep_find_any_field(struct tep_event *event, const char *name)
 unsigned long long tep_read_number(struct tep_handle *pevent,
 				   const void *ptr, int size)
 {
+	unsigned long long val;
+
 	switch (size) {
 	case 1:
 		return *(unsigned char *)ptr;
 	case 2:
-		return tep_data2host2(pevent, ptr);
+		return tep_data2host2(pevent, *(unsigned short *)ptr);
 	case 4:
-		return tep_data2host4(pevent, ptr);
+		return tep_data2host4(pevent, *(unsigned int *)ptr);
 	case 8:
-		return tep_data2host8(pevent, ptr);
+		memcpy(&val, (ptr), sizeof(unsigned long long));
+		return tep_data2host8(pevent, val);
 	default:
 		/* BUG! */
 		return 0;
@@ -4062,7 +4065,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			f = tep_find_any_field(event, arg->string.string);
 			arg->string.offset = f->offset;
 		}
-		str_offset = tep_data2host4(pevent, data + arg->string.offset);
+		str_offset = tep_data2host4(pevent, *(unsigned int *)(data + arg->string.offset));
 		str_offset &= 0xffff;
 		print_str_to_seq(s, format, len_arg, ((char *)data) + str_offset);
 		break;
@@ -4080,7 +4083,7 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 			f = tep_find_any_field(event, arg->bitmask.bitmask);
 			arg->bitmask.offset = f->offset;
 		}
-		bitmask_offset = tep_data2host4(pevent, data + arg->bitmask.offset);
+		bitmask_offset = tep_data2host4(pevent, *(unsigned int *)(data + arg->bitmask.offset));
 		bitmask_size = bitmask_offset >> 16;
 		bitmask_offset &= 0xffff;
 		print_bitmask_to_seq(pevent, s, format, len_arg,
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 950ad185a5c4..35d37087d3c5 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -409,20 +409,6 @@ void tep_print_plugins(struct trace_seq *s,
 typedef char *(tep_func_resolver_t)(void *priv,
 				    unsigned long long *addrp, char **modp);
 void tep_set_flag(struct tep_handle *tep, int flag);
-unsigned short __tep_data2host2(struct tep_handle *pevent, unsigned short data);
-unsigned int __tep_data2host4(struct tep_handle *pevent, unsigned int data);
-unsigned long long
-__tep_data2host8(struct tep_handle *pevent, unsigned long long data);
-
-#define tep_data2host2(pevent, ptr)	__tep_data2host2(pevent, *(unsigned short *)(ptr))
-#define tep_data2host4(pevent, ptr)	__tep_data2host4(pevent, *(unsigned int *)(ptr))
-#define tep_data2host8(pevent, ptr)	\
-({								\
-	unsigned long long __val;				\
-								\
-	memcpy(&__val, (ptr), sizeof(unsigned long long));	\
-	__tep_data2host8(pevent, __val);				\
-})
 
 static inline int tep_host_bigendian(void)
 {
@@ -475,8 +461,6 @@ enum tep_errno tep_parse_format(struct tep_handle *pevent,
 				struct tep_event **eventp,
 				const char *buf,
 				unsigned long size, const char *sys);
-void tep_free_event(struct tep_event *event);
-void tep_free_format_field(struct tep_format_field *field);
 
 void *tep_get_field_raw(struct trace_seq *s, struct tep_event *event,
 			const char *name, struct tep_record *record,
-- 
2.19.2


Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB01FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDA020873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbeLROBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:01:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLROBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:01:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIE1EZb2852511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:01:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIE1EdX2852505;
        Tue, 18 Dec 2018 06:01:14 -0800
Date:   Tue, 18 Dec 2018 06:01:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-477be10ca781bbee29d6a1da958d63d5c9a2d83b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        akpm@linux-foundation.org, tstoyanov@vmware.com, acme@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, jolsa@redhat.com
Reply-To: jolsa@redhat.com, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          tstoyanov@vmware.com, akpm@linux-foundation.org,
          rostedt@goodmis.org, linux-kernel@vger.kernel.org
In-Reply-To: <20181130154646.890615385@goodmis.org>
References: <20181130154646.890615385@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Implement new API
 tep_get_ref()
Git-Commit-ID: 477be10ca781bbee29d6a1da958d63d5c9a2d83b
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

Commit-ID:  477be10ca781bbee29d6a1da958d63d5c9a2d83b
Gitweb:     https://git.kernel.org/tip/477be10ca781bbee29d6a1da958d63d5c9a2d83b
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Fri, 30 Nov 2018 10:44:04 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:55:52 -0300

tools lib traceevent: Implement new API tep_get_ref()

This patch implements a new API of the tracevent library:

  int tep_get_ref(struct tep_handle *tep);

The API returns the reference counter "ref_count" of the tep handler.
As "struct tep_handle" is internal only, its members cannot be accessed
by the library users, the API is used to get the reference counter.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154646.890615385@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 7 +++++++
 tools/lib/traceevent/event-parse.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 2b5cb33046ce..d1e6ee3d43cf 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -6730,6 +6730,13 @@ void tep_ref(struct tep_handle *pevent)
 	pevent->ref_count++;
 }
 
+int tep_get_ref(struct tep_handle *tep)
+{
+	if (tep)
+		return tep->ref_count;
+	return 0;
+}
+
 void tep_free_format_field(struct tep_format_field *field)
 {
 	free(field->type);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 16bf4c890b6f..44ec26c72c2e 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -581,6 +581,7 @@ struct tep_handle *tep_alloc(void);
 void tep_free(struct tep_handle *pevent);
 void tep_ref(struct tep_handle *pevent);
 void tep_unref(struct tep_handle *pevent);
+int tep_get_ref(struct tep_handle *tep);
 
 /* access to the internal parser */
 void tep_buffer_init(const char *buf, unsigned long long size);

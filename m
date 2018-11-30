Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5784A2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5784A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbeLAC4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:56:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:35362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbeLAC4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:56:32 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12F22145D;
        Fri, 30 Nov 2018 15:46:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSl0A-0005y4-W1; Fri, 30 Nov 2018 10:46:46 -0500
Message-Id: <20181130154646.890615385@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 10:44:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 1/9] tools/lib/traceevent: Implemented new API tep_get_ref()
References: <20181130154403.150474900@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch implements a new API of the tracevent library:

  int tep_get_ref(struct tep_handle *tep);

The API returns the reference counter "ref_count" of the tep handler.
As "struct tep_handle" is internal only, its members cannot be accessed
by the library users, the API is used to get the reference counter.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 7 +++++++
 tools/lib/traceevent/event-parse.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 3692f29fee46..a5f3e37f81b5 100644
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
-- 
2.19.1



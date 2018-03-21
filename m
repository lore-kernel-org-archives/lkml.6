Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752402AbeCUCXq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeCUCVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:21:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8258217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180321022130.824281975@goodmis.org>
User-Agent: quilt/0.63-1
Date: Tue, 20 Mar 2018 22:21:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 39/46] tracing: Remove BUG_ON() from append_filter_string()
References: <20180321022052.030055576@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0039-tracing-Remove-BUG_ON-from-append_filter_string.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's no reason to BUG if there's a bug in the filtering code. Simply do a
warning and return.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a764aec3c9a1..819a13c3e13c 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -681,7 +681,8 @@ static int append_filter_string(struct event_filter *filter,
 	int newlen;
 	char *new_filter_string;
 
-	BUG_ON(!filter->filter_string);
+	if (WARN_ON(!filter->filter_string))
+		return -EINVAL;
 	newlen = strlen(filter->filter_string) + strlen(string) + 1;
 	new_filter_string = kmalloc(newlen, GFP_KERNEL);
 	if (!new_filter_string)
-- 
2.15.1

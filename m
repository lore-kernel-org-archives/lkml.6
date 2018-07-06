Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6110C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6175724011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6175724011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbeGFBGp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932360AbeGFBGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E41724017;
        Fri,  6 Jul 2018 01:06:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fbFCo-0007Hj-6i; Thu, 05 Jul 2018 21:06:38 -0400
Message-Id: <20180706010638.104814314@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Jul 2018 21:06:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/6] tracing: Avoid string overflow
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

'err' is used as a NUL-terminated string, but using strncpy() with the length
equal to the buffer size may result in lack of the termination:

kernel/trace/trace_events_hist.c: In function 'hist_err_event':
kernel/trace/trace_events_hist.c:396:3: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
   strncpy(err, var, MAX_FILTER_STR_VAL);

This changes it to use the safer strscpy() instead.

Link: http://lkml.kernel.org/r/20180328140920.2842153-1-arnd@arndb.de

Cc: stable@vger.kernel.org
Fixes: f404da6e1d46 ("tracing: Add 'last error' error facility for hist triggers")
Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 046c716a6536..aae18af94c94 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
 	else if (system)
 		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
 	else
-		strncpy(err, var, MAX_FILTER_STR_VAL);
+		strscpy(err, var, MAX_FILTER_STR_VAL);
 
 	hist_err(str, err);
 }
-- 
2.17.1



Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DDBC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261C5208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C5208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbeGJSgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:36:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389774AbeGJSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:36:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33AD5EC2;
        Tue, 10 Jul 2018 18:36:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.17 08/56] tracing: Avoid string overflow
Date:   Tue, 10 Jul 2018 20:24:50 +0200
Message-Id: <20180710182503.907963075@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit cf4d418e653afc84c9c873236033e06be5d58f1c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -393,7 +393,7 @@ static void hist_err_event(char *str, ch
 	else if (system)
 		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
 	else
-		strncpy(err, var, MAX_FILTER_STR_VAL);
+		strscpy(err, var, MAX_FILTER_STR_VAL);
 
 	hist_err(str, err);
 }



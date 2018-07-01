Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B6EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700D22543F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700D22543F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032618AbeGAQrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:47:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032464AbeGAQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:47:01 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 53332ACD;
        Sun,  1 Jul 2018 16:47:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, air icy <icytxw@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.17 192/220] tracing: Check for no filter when processing event filters
Date:   Sun,  1 Jul 2018 18:23:36 +0200
Message-Id: <20180701160916.212100002@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

commit 70303420b5721c38998cf987e6b7d30cc62d4ff1 upstream.

The syzkaller detected a out-of-bounds issue with the events filter code,
specifically here:

	prog[N].pred = NULL;					/* #13 */
	prog[N].target = 1;		/* TRUE */
	prog[N+1].pred = NULL;
	prog[N+1].target = 0;		/* FALSE */
->	prog[N-1].target = N;
	prog[N-1].when_to_branch = false;

As that's the first reference to a "N-1" index, it appears that the code got
here with N = 0, which means the filter parser found no filter to parse
(which shouldn't ever happen, but apparently it did).

Add a new error to the parsing code that will check to make sure that N is
not zero before going into this part of the code. If N = 0, then -EINVAL is
returned, and a error message is added to the filter.

Cc: stable@vger.kernel.org
Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Reported-by: air icy <icytxw@gmail.com>
bugzilla url: https://bugzilla.kernel.org/show_bug.cgi?id=200019
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_filter.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -78,7 +78,8 @@ static const char * ops[] = { OPS };
 	C(TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
-	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"),
+	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
+	C(NO_FILTER,		"No filter found"),
 
 #undef C
 #define C(a, b)		FILT_ERR_##a
@@ -550,6 +551,13 @@ predicate_parse(const char *str, int nr_
 		goto out_free;
 	}
 
+	if (!N) {
+		/* No program? */
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_NO_FILTER, ptr - str);
+		goto out_free;
+	}
+
 	prog[N].pred = NULL;					/* #13 */
 	prog[N].target = 1;		/* TRUE */
 	prog[N+1].pred = NULL;



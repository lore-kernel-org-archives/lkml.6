Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14372ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C486520843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C486520843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeJ1QP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:15:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbeJ1QPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:15:25 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 457BB20882;
        Sun, 28 Oct 2018 07:31:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gGfXs-00089d-4P; Sun, 28 Oct 2018 03:31:36 -0400
Message-Id: <20181028073136.037955308@goodmis.org>
User-Agent: quilt/0.65
Date:   Sun, 28 Oct 2018 03:30:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 16/18] tracing: probeevent: Fix uninitialized used of offset in parse args
References: <20181028072948.693267247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Dan's smatch utility found an uninitialized use of offset in a path in
parse_probe_args(). Unless an offset is specifically specified for commands
that allow them, it should default to zero.

Link: http://lkml.kernel.org/r/20181012134246.5doqaobxunlqqs53@mwanda
Fixes: 533059281ee5 ("tracing: probeevent: Introduce new argument fetching code")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com> (smatch)
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5b3d573b3dcf..3ef15a6683c0 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -209,7 +209,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 {
 	struct fetch_insn *code = *pcode;
 	unsigned long param;
-	long offset;
+	long offset = 0;
 	char *tmp;
 	int ret = 0;
 
-- 
2.19.0



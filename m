Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE4C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFB0218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfBCNxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:53:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54246 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728542AbfBCNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:15 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIA0-0003tl-5C; Sun, 03 Feb 2019 13:50:12 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9s-0007Pe-Js; Sun, 03 Feb 2019 14:50:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.695007448@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 279/305] tracing: Fix memory leak of instance
 function hash filters
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 2840f84f74035e5a535959d5f17269c69fa6edc5 upstream.

The following commands will cause a memory leak:

 # cd /sys/kernel/tracing
 # mkdir instances/foo
 # echo schedule > instance/foo/set_ftrace_filter
 # rmdir instances/foo

The reason is that the hashes that hold the filters to set_ftrace_filter and
set_ftrace_notrace are not freed if they contain any data on the instance
and the instance is removed.

Found by kmemleak detector.

Fixes: 591dffdade9f ("ftrace: Allow for function tracing instance to filter functions")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4127,6 +4127,7 @@ void ftrace_destroy_filter_files(struct
 	if (ops->flags & FTRACE_OPS_FL_ENABLED)
 		ftrace_shutdown(ops, 0);
 	ops->flags |= FTRACE_OPS_FL_DELETED;
+	ftrace_free_filter(ops);
 	mutex_unlock(&ftrace_lock);
 }
 


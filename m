Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73F8C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3970E2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+RXQMjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3970E2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeJRUNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 16:13:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeJRUNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 16:13:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA172087A;
        Thu, 18 Oct 2018 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539864746;
        bh=KMCN64YzFI0LvpVXNVInl0F5SKOkz+74vNvWPncx1Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+RXQMjNjSdnXpgjjB+cIMB//DgWbGeEr0XXKtelk8fX4VgHuqn0JKqT7O4TdF6Yo
         NuoZIZRsUcF8HJYcVXBEKIFLpNNoX/pDekm18dR8A6pzF2jUo3jxn2+TcrIsBxjOa+
         UueyY+64pbkCbBlhCBV9UA0yZRMCKmMtwERkCdRw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH 2/3] tracing: Fix synthetic event to allow semicolon at end
Date:   Thu, 18 Oct 2018 21:12:03 +0900
Message-Id: <153986472359.1671.14765934058821057199.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153986466551.1671.11399119973192957474.stgit@devbox>
References: <153986466551.1671.11399119973192957474.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix synthetic event to allow independent semicolon at end.

The synthetic_events interface accepts a semicolon after the
last word if there is no space.

 # echo "myevent u64 var;" >> synthetic_events

But if there is a space, it returns an error.

 # echo "myevent u64 var ;" > synthetic_events
 sh: write error: Invalid argument

This behavior is difficult for users to understand. Let's
allow the last independent semicolon too.

Fixes: commit 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ff83941065a..d239004aaf29 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1088,7 +1088,7 @@ static int create_synth_event(int argc, char **argv)
 		i += consumed - 1;
 	}
 
-	if (i < argc) {
+	if (i < argc && strcmp(argv[i], ";") != 0) {
 		ret = -EINVAL;
 		goto err;
 	}


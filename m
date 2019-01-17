Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6150920855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547732989;
	bh=SMfcI1YMfN4bs8QiEE/WNdppYt3P8Bw73ZSObXZ8Tdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZtlreuFgIj1V46AG5FjHwIFjPsSN91T5+zAbBkjKACXZAi28K75fA2JDWitDCWa9i
	 wKH30GOtpUc0GuspGTXVNhj5v1RQowI6D6EXtfQ1qBzIHeZkFXDx7WH4eqWbkVuLmH
	 EuMbiwEho4/URl4HjWcvJO5wMiw4DhMgV50pJUlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfAQNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:49:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:44848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQNtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:49:47 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED8520851;
        Thu, 17 Jan 2019 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547732986;
        bh=SMfcI1YMfN4bs8QiEE/WNdppYt3P8Bw73ZSObXZ8Tdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDlwKLy8cIVsE8DjJZzI9UtKIHVq8qMAjcpH2EW5+xDu3QnzlPNbXmYMYtIE/YPAc
         d5v5zKPNJdBZMpNgmpLVBWGYysmYBIkdzyMXK0mnA/oRFZqGEVmzKBg693Nsx8hgWi
         s2kFxCiiKL0oj51yjrocCoADm4NGN0uOhbKDIbKY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tracing: probeevent: Fix to make the type of $comm string
Date:   Thu, 17 Jan 2019 22:49:24 +0900
Message-Id: <154773296388.2285.17899257841180721189.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154773287750.2285.5509629487576876823.stgit@devbox>
References: <154773287750.2285.5509629487576876823.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to make the type of $comm "string".
If we set the other type to $comm argument, it shows
meaningless value or wrong data. Currently probe events
allow us to set string array type (e.g. ":string[2]"), or
other digit types like x8 on $comm. But since clearly
$comm is just a string data, it should not be fetched
by other types including array.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9962cb5da8ac..44f078cda0ac 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -405,13 +405,14 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 				return -E2BIG;
 		}
 	}
-	/*
-	 * The default type of $comm should be "string", and it can't be
-	 * dereferenced.
-	 */
-	if (!t && strcmp(arg, "$comm") == 0)
+
+	/* Since $comm can not be dereferred, we can find $comm by strcmp */
+	if (strcmp(arg, "$comm") == 0) {
+		/* The type of $comm must be "string", and not an array. */
+		if (parg->count || (t && strcmp(t, "string")))
+			return -EINVAL;
 		parg->type = find_fetch_type("string");
-	else
+	} else
 		parg->type = find_fetch_type(t);
 	if (!parg->type) {
 		pr_info("Unsupported type: %s\n", t);


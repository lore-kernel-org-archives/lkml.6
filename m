Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81219C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE852073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc7QMB3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE852073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeH3SUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbeH3SUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:20:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C992073D;
        Thu, 30 Aug 2018 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638709;
        bh=8+Hg0Vp0ZPX3mNou94drPL8CPWR5vFdDHfnboF0FXiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sc7QMB3r/RgJcThPVC/DUFwAwmJUeRNh+0n5t9Vrzy9M50jhwTvHKnem34PVYE5N5
         LXsbX7sKBbGOEQjh75zjHDFVozM7mljG5Iv86PmHgoMhyakzHtrZGzC4yOobfoMNoT
         8NwKEQq/HC1vAC/XnWVu1czwV6Uc0R4GMQU+RtCk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/28] selftests/ftrace: Improve kprobe testcase to check log data
Date:   Thu, 30 Aug 2018 23:18:06 +0900
Message-Id: <153563868653.29700.11404885360098287401.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153563834333.29700.11242968505215651399.stgit@devbox>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve kprobe testcase to check the log data correctness
and ensure the event definition is corrctly including
argument definition.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args.tc  |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
index 9578535ccd67..bcdecf80a8f1 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args.tc
@@ -5,10 +5,14 @@
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 
 echo 'p:testprobe _do_fork $stack $stack0 +0($stack)' > kprobe_events
-grep testprobe kprobe_events
+grep testprobe kprobe_events | grep -q 'arg1=\$stack arg2=\$stack0 arg3=+0(\$stack)'
 test -d events/kprobes/testprobe
+
 echo 1 > events/kprobes/testprobe/enable
 ( echo "forked")
+grep testprobe trace | grep '_do_fork' | \
+  grep -q 'arg1=0x[[:xdigit:]]* arg2=0x[[:xdigit:]]* arg3=0x[[:xdigit:]]*$'
+
 echo 0 > events/kprobes/testprobe/enable
 echo "-:testprobe" >> kprobe_events
 clear_trace


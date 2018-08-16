Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE59E2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fua9C50C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE59E2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404341AbeHPTb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeHPTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:31:28 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8372148E;
        Thu, 16 Aug 2018 16:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437116;
        bh=qjQD5A82S61B/VvljxjHoPrJIfB5wMGDL2qBbc++C8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fua9C50CrUWc8Ii71p9wESSkN8lB1XcBz4hJwUQhxNr6nLnt6BR+H248yiMy6O+01
         0Qs4CMzsFapRPTemv4YGESuyKgJUn5r9FCrPWhJglqhnF1NacW9yd8bDg+22Kk7lLG
         wPANNxmNAsg//+nlc56LERFwU8PMVuAqo4MNsdU8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/32] selftests/ftrace: More initialize features in initialize_ftrace
Date:   Fri, 17 Aug 2018 01:31:33 +0900
Message-Id: <153443709338.23257.2179609309041817332.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear pid filter, synthetic_events, snapshots,
ftrace filter, and trace log in initialize_ftrace(),
since those are used in test cases.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v2:
   - Add reset_ftrace_filter
---
 tools/testing/selftests/ftrace/test.d/functions |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index e4645d5e3126..b2bfa4dd43f7 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -89,12 +89,17 @@ initialize_ftrace() { # Reset ftrace to initial-state
     reset_tracer
     reset_trigger
     reset_events_filter
+    reset_ftrace_filter
     disable_events
     echo > set_event_pid	# event tracer is always on
+    echo > set_ftrace_pid
     [ -f set_ftrace_filter ] && echo | tee set_ftrace_*
     [ -f set_graph_function ] && echo | tee set_graph_*
     [ -f stack_trace_filter ] && echo > stack_trace_filter
     [ -f kprobe_events ] && echo > kprobe_events
     [ -f uprobe_events ] && echo > uprobe_events
+    [ -f synthetic_events ] && echo > synthetic_events
+    [ -f snapshot ] && echo 0 > snapshot
+    clear_trace
     enable_tracing
 }


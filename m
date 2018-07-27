Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B23C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27D2208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vasnoDro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27D2208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeG0NeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbeG0NeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:34:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2070208AD;
        Fri, 27 Jul 2018 12:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693561;
        bh=0QyNKdMx4hKONdFfDH2C9An8ncsA6qk/CmZ1ECkKD+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vasnoDrogl1VLQOmNm059jf3PivCjc+Ufp1Vt/c0a4WpEi7e98U0w/Bich/qr3pVW
         V4UjgodUdUiuAQbuDqq6GQ1lg1D5uSgrBldVXP4qUzhqGHHCg38ODkLnj4Hc/nF8e2
         U/+P69z6tN6sfxiHOhKbBy3O5br8+5TkxhI5Ki+k=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/25] selftests/ftrace: More initialize features in initialize_ftrace
Date:   Fri, 27 Jul 2018 21:12:19 +0900
Message-Id: <153269353884.3084.8412677007260573415.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153269339575.3084.16279591141931053689.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear pid filter, synthetic_events, snapshots,
and trace log in initialize_ftrace(), since
those are used in test cases.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/test.d/functions |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index e4645d5e3126..f17eaf3582b2 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -91,10 +91,14 @@ initialize_ftrace() { # Reset ftrace to initial-state
     reset_events_filter
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


Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F0B208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBXcfqaT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F0B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbeHPT3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbeHPT3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:29:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA301208C4;
        Thu, 16 Aug 2018 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437002;
        bh=6+mUcTvXfm2gb+exOkb+FWgX7zyX9QkDjrZePXy+zuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBXcfqaTFQJkqw4AjMqLYIYiApT+VFffGQZqkyjozFVi393VHVpTzkcGFyVDsfX2p
         lyfdi9vwN/xnB4QG3FTebeguDytuK5q7F4E4XxE0H7stY30gRNN6rBWy/r57Q6gIxB
         TznfarWSzuxAAViAdzIX6mfl5P77qYsxTF1AbKjM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/32] tracing: Allow gcov profiling on only ftrace subsystem
Date:   Fri, 17 Aug 2018 01:29:39 +0900
Message-Id: <153443697980.23257.9233992547183322108.stgit@devbox>
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

Add GCOV_PROFILE_FTRACE to allow gcov profiling
on only files in ftrace subsystem. This kconfig
flag will be used for checking kselftest/ftrace
coverage.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/Kconfig  |   13 +++++++++++++
 kernel/trace/Makefile |    5 +++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fd6754b88f87..8decf6d8553a 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,19 @@ config TRACING_EVENTS_GPIO
 	help
 	  Enable tracing events for gpio subsystem
 
+config GCOV_PROFILE_FTRACE
+	bool "Enable GCOV profiling on ftrace subsystem"
+	depends on GCOV_KERNEL
+	help
+	  Enable GCOV profiling on ftrace subsystem for checking
+	  which functions/lines are tested.
+
+	  If unsure, say N.
+
+	  Note that on a kernel compiled with this flags, ftrace will be
+	  significantly run slower. So do not enable it for production
+	  kernel.
+
 endif # FTRACE
 
 endif # TRACING_SUPPORT
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 98d53b39a8ee..f81dadbc7c4a 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -23,6 +23,11 @@ ifdef CONFIG_TRACING_BRANCHES
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 endif
 
+# for GCOV coverage profiling
+ifdef CONFIG_GCOV_PROFILE_FTRACE
+GCOV_PROFILE := y
+endif
+
 CFLAGS_trace_benchmark.o := -I$(src)
 CFLAGS_trace_events_filter.o := -I$(src)
 


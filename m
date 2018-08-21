Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBC2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770422172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0u8o4mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770422172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHUKrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbeHUKrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:47:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88903216C4;
        Tue, 21 Aug 2018 07:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534836501;
        bh=1bw4w2Ki8jbZYAHOrrXRuXyFfwbZTzmJYqxeLo/tZ5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=e0u8o4mrB7Vj5ucdKOToGS1pyCLLfo1H9s6S277WjgAx8wOF+m92IuBWWA20IiUw7
         bfQwyYH/9XiM5ZSFoI8tK7CdnU69apOXplwzs8tMjrMmkpRa4z7g9eiYIY5/G9Cuk0
         OeU7IgZImBpGU1ecejWQxO+fbSK0i0NwsF2Ayx9o=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2.1] tracing: Allow gcov profiling on only ftrace subsystem
Date:   Tue, 21 Aug 2018 16:27:58 +0900
Message-Id: <153483647755.32472.4746349899604275441.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180820113349.4fefbe0e@gandalf.local.home>
References: <20180820113349.4fefbe0e@gandalf.local.home>
In-Reply-To: <20180820113349.4fefbe0e@gandalf.local.home>
References: <20180820113349.4fefbe0e@gandalf.local.home>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GCOV_PROFILE_FTRACE to allow gcov profiling
on only files in ftrace subsystem. This config
option will be used for checking kselftest/ftrace
coverage.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2.1:
  - Fix description according to Steve's comment.
---
 kernel/trace/Kconfig  |   12 ++++++++++++
 kernel/trace/Makefile |    5 +++++
 2 files changed, 17 insertions(+)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index fd6754b88f87..aec44d838283 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -774,6 +774,18 @@ config TRACING_EVENTS_GPIO
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
+	  Note that on a kernel compiled with this config, ftrace will
+	  run significantly slower.
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
 


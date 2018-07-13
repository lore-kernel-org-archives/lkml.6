Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2664CECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0C620850
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnStcpHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0C620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbeGMQnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbeGMQnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:43:02 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95F1220850;
        Fri, 13 Jul 2018 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531499261;
        bh=qn9ll6DAnyTNh6KgOctvtHxHYhFUy6UwYasfVP8wxFo=;
        h=From:To:Cc:Subject:Date:From;
        b=EnStcpHKxJzP/rln7c00vbhxyCcqM8JX+PfVbEL8udQeKbMKLEos7jpIK3iLRkuDL
         LYI3P/Lc0Fb8pPNJUDgaz+nhjjyebg1Yfm5atOiBiXzgH/ryl1g6j07zkfj/Jpb1YB
         fYq5am9/+rxqoiXcvx8AnozxnexQByAsG0MSzvdE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tracing: Fix bugs on snapshot feature
Date:   Sat, 14 Jul 2018 01:27:17 +0900
Message-Id: <153149923649.11274.14970833360963898112.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is 2 bugfixes and 1 testcase related to ftrace snapshot
feature. The 1st one is a double free bug and happens very rare.
It happened on my pc when I was cleaning up ftracetest
(but not reproducible). Anyway, it was easy to find the root
cause because I had a backtrace.
The 2nd one is an odd behavior of snapshotting. Since it is
easy to reproduce, I made a kselftest testcase for this bug too.

Thank you,

---

Masami Hiramatsu (3):
      [BUGFIX] tracing: Fix double free of event_trigger_data
      [BUGFIX] ring_buffer: tracing: Inherit the tracing setting to next ring buffer
      selftests/ftrace: Add snapshot and tracing_on test case


 include/linux/ring_buffer.h                        |    1 +
 kernel/trace/ring_buffer.c                         |   12 +++++++++
 kernel/trace/trace.c                               |   11 ++++++++
 kernel/trace/trace.h                               |    2 +
 kernel/trace/trace_events_trigger.c                |   10 ++++---
 .../selftests/ftrace/test.d/00basic/snapshot.tc    |   28 ++++++++++++++++++++
 6 files changed, 60 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

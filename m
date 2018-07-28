Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FF0C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0D020893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 13:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yY6skogy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0D020893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeG1PV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 11:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbeG1PV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 11:21:58 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47BF20878;
        Sat, 28 Jul 2018 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532786121;
        bh=tf5hxuOTv4vvPq3XyfvRuWhDWTDjLxaN+0fPIWFHhJs=;
        h=From:To:Cc:Subject:Date:From;
        b=yY6skogy8uwAX+x67Hs7q6CSreHiJYHThXlymZUjugj2oNa76hQH03rQlHMtXhmGi
         VpAKXXD/qECN2GS2pnVOM0+cHbGBVt+bup1GNqEdDvMGzn/3jQ2Lst+5dsIWB6aUQx
         Q7DqgPQv3eA1idMyZF4tm4XFX6lqW83+5dmIc+Gg=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] tracing: kprobes: Prohibit probing on notrace functions 
Date:   Sat, 28 Jul 2018 22:54:58 +0900
Message-Id: <153278609735.9401.5389431281006205214.stgit@devbox>
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

This is the 4th version of the series to prohibit kprobe
on notrace functions which Francis sent before.

This version fixes a build error when CONFIG_FUNCTION_TRACER=n,
since in that case notrace is just ignored and
ftrace_location_range() is not defined.

Thank you,

---

Francis Deslauriers (1):
      selftest/ftrace: Move kprobe selftest function to separate compile unit

Masami Hiramatsu (2):
      tracing: kprobes: Prohibit probing on notrace function
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function


 kernel/trace/Kconfig                               |   18 ++++++
 kernel/trace/Makefile                              |    5 ++
 kernel/trace/trace_kprobe.c                        |   59 +++++++++++++-------
 kernel/trace/trace_kprobe_selftest.c               |   10 +++
 kernel/trace/trace_kprobe_selftest.h               |    7 ++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++------
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 -
 7 files changed, 92 insertions(+), 39 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

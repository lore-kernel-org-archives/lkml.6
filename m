Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D54C67790
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E02420873
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 02:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gusVWI9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E02420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389361AbeG1DqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 23:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388894AbeG1DqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 23:46:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEF520862;
        Sat, 28 Jul 2018 02:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532744489;
        bh=mH5Vy4rvjd6yVhMnslgEFqn1gLtE2qg3K9C8JkHhTgw=;
        h=From:To:Cc:Subject:Date:From;
        b=gusVWI9sptsOlw+fVwDH6tDpiMplfjqbPTOh9HnyBBIXFaYUCsnGroVvt53DVhqkw
         PyLqmSj3ks+vlpweCFCEerNuoVw9LFBqYPIC9wLXacwLu9bxuhNlwVV/3CFSSkQzyc
         S+4mhhveCxJcFgj6rWXRm9UstiW3gAdee8LcEfCE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] tracing: kprobes: Prohibit probing on notrace functions 
Date:   Sat, 28 Jul 2018 11:21:06 +0900
Message-Id: <153274446603.14940.16028811307915635132.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the 3rd version of the series to prohibit kprobe
on notrace functions which Francis sent before.

This version fixes some issues on previous version. Fix
to handle the no-symbol kprobe-events correctly and Fix
probepoint.tc testcase to not use notrace function as
a probe point.

Thank you,

---

Francis Deslauriers (1):
      selftest/ftrace: Move kprobe selftest function to separate compile unit

Masami Hiramatsu (2):
      tracing: kprobes: Prohibit probing on notrace function
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function


 kernel/trace/Kconfig                               |   18 ++++++
 kernel/trace/Makefile                              |    5 ++
 kernel/trace/trace_kprobe.c                        |   58 +++++++++++++-------
 kernel/trace/trace_kprobe_selftest.c               |   10 +++
 kernel/trace/trace_kprobe_selftest.h               |    7 ++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++------
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 -
 7 files changed, 91 insertions(+), 39 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

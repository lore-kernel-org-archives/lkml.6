Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF6E13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F135A20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQo56Dqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F135A20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbeG3Ly1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbeG3Ly1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:54:27 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00B5420881;
        Mon, 30 Jul 2018 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532946009;
        bh=gFAm6JtEJYY5MZuiWgzEEQtisC3vBV7Tf7bu07ufJbg=;
        h=From:To:Cc:Subject:Date:From;
        b=iQo56Dqno2Zo/MwBFeZeGTHiCXBGqihjuWQOCiE+1qwTTs0FCFhNS2gqkPHpPnpVO
         HW4G5C2DKEZWk21vuDoXsdpJROuzjfmDCAhU5A3lu4CLmxE4lCIFhxDoXciSqbvtXX
         PKE6N1dzteFD2oGPGlNt7xqhyYZnfJDmIMPEumsA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, Shuah Khan <shuah@kernel.org>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] tracing: kprobes: Prohibit probing on notrace functions 
Date:   Mon, 30 Jul 2018 19:19:45 +0900
Message-Id: <153294598465.32740.17737878083872427008.stgit@devbox>
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

This is the 5th version of the series to prohibit kprobe
on notrace functions.

This fixes a build error when CONFIG_FUNCTION_TRACER=y but
DYNAMIC_FTRACE=n. Finally I decided to recover the approach
in the 1st version, made it depends on CONFIG_KPROBES_ON_FTRACE=y.
It is the simplest and enough to prohibiting kernel crash.

So, in summary, if CONFIG_KPROBES_ON_FTRACE=y (which depends
on CONFIG_DYNAMIC_FTRACE=y, so ftrace_location_range must be
there) && CONFIG_KPROBE_EVENTS_ON_NOTRACE=n (default),
kprobe events can not be defined on notrace function.
Otherwides (means CONFIG_KPROBES_ON_FTRACE=n or
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y), we can put kprobe events
on notrace functions.

Francis, I dropped your tested-by because I got many kbuild
errors and fixed it. If you can, could you test it again?

Thank you,

---

Francis Deslauriers (1):
      selftest/ftrace: Move kprobe selftest function to separate compile unit

Masami Hiramatsu (2):
      tracing: kprobes: Prohibit probing on notrace function
      selftests/ftrace: Fix kprobe string testcase to not probe notrace function


 kernel/trace/Kconfig                               |   20 +++++++
 kernel/trace/Makefile                              |    5 ++
 kernel/trace/trace_kprobe.c                        |   59 +++++++++++++-------
 kernel/trace/trace_kprobe_selftest.c               |   10 +++
 kernel/trace/trace_kprobe_selftest.h               |    7 ++
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++------
 .../selftests/ftrace/test.d/kprobe/probepoint.tc   |    2 -
 7 files changed, 94 insertions(+), 39 deletions(-)
 create mode 100644 kernel/trace/trace_kprobe_selftest.c
 create mode 100644 kernel/trace/trace_kprobe_selftest.h

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

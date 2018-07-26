Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD2AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1396F20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1396F20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeG0AZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbeG0AZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:25:50 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0989F20857;
        Thu, 26 Jul 2018 23:06:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fipLP-00068E-2H; Thu, 26 Jul 2018 19:06:51 -0400
Message-Id: <20180726230607.170310741@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 26 Jul 2018 19:06:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/7] [GIT PULL] tracing: Various fixes for v4.18-rc6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Various fixes to the tracing infrastructure:

 - Fix double free when the reg() call fails in event_trigger_callback()

 - Fix anomoly of snapshot causing tracing_on flag to change

 - Add selftest to test snapshot and tracing_on affecting each other

 - Fix setting of tracepoint flag on error that prevents probes from
   being deleted.

 - Fix another possible double free that is similar to event_trigger_callback()

 - Quiet a gcc warning of a false positive unused variable

 - Fix crash of partial exposed task->comm to trace events

Please pull the latest trace-v4.18-rc6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.18-rc6

Tag SHA1: bdddc1d679612af275e349e6cd6b223c0d4cb825
Head SHA1: 3e536e222f2930534c252c1cc7ae799c725c5ff9


Artem Savkov (1):
      tracing/kprobes: Fix trace_probe flags on enable_trace_kprobe() failure

Masami Hiramatsu (2):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer
      selftests/ftrace: Add snapshot and tracing_on test case

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthreads

Steven Rostedt (VMware) (3):
      tracing: Fix double free of event_trigger_data
      tracing: Fix possible double free in event_enable_trigger_func()
      tracing: Quiet gcc warning about maybe unused link variable

----
 include/linux/ring_buffer.h                        |  1 +
 kernel/kthread.c                                   |  8 ++++++-
 kernel/trace/ring_buffer.c                         | 16 +++++++++++++
 kernel/trace/trace.c                               |  6 +++++
 kernel/trace/trace_events_trigger.c                | 18 ++++++++++----
 kernel/trace/trace_kprobe.c                        | 15 ++++++++++--
 .../selftests/ftrace/test.d/00basic/snapshot.tc    | 28 ++++++++++++++++++++++
 7 files changed, 84 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc

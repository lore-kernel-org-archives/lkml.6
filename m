Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1636CC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB5F2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 03:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB5F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeK3O04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 09:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeK3O04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 09:26:56 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA51F2145D;
        Fri, 30 Nov 2018 03:19:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSZKd-0002kI-Kx; Thu, 29 Nov 2018 22:19:07 -0500
Message-Id: <20181130031829.268422593@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 29 Nov 2018 22:18:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] [GIT PULL] tracing: More fixes for 4.20
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

This includes two more fixes:

 - Change idx variable in DO_TRACE macro to __idx to avoid name conflicts.
   A kvm event had "idx" as a parameter and it confused the macro.

 - Fix a race where interrupts would be traced when set_graph_function was set.
   The previous patch set increased a race window that tricked the function graph
   tracer to think it should trace interrupts when it really should not have.
   The bug has been there before, but was seldom hit. Only the last patch series
   made it more common.

Note, this is on top of a previous git pull that I have submitted:

  http://lkml.kernel.org/r/20181127224031.76681fe0@vmware.local.home

Please pull the latest trace-v4.20-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.20-rc4

Tag SHA1: 9ecaefab677642b895cdb44889a2baff3e7436bc
Head SHA1: 5cf99a0f3161bc3ae2391269d134d6bf7e26f00e


Steven Rostedt (VMware) (1):
      tracing/fgraph: Fix set_graph_function from showing interrupts

Zenghui Yu (1):
      tracepoint: Use __idx instead of idx in DO_TRACE macro to make it unique

----
 include/linux/tracepoint.h           |  6 ++--
 kernel/trace/trace.h                 | 57 ++++++++++++++++++++++++++++++++++--
 kernel/trace/trace_functions_graph.c |  4 +++
 kernel/trace/trace_irqsoff.c         |  2 ++
 kernel/trace/trace_sched_wakeup.c    |  2 ++
 5 files changed, 65 insertions(+), 6 deletions(-)

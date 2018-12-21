Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E92218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbeLUMIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 07:08:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:34195 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732380AbeLUMIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 07:08:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 04:08:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,381,1539673200"; 
   d="scan'208";a="131862458"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.130])
  by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2018 04:08:03 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] perf thread-stack: Fix thread stack processing for the idle task
Date:   Fri, 21 Dec 2018 14:06:12 +0200
Message-Id: <20181221120620.9659-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are some patches that fix thread stack processing for the idle task.
Patches 1-6 are preparation.  The fix is patch 7.  Patch 8 is a comment to
explain the issue in perf_session__register_idle_thread().

perf creates a single 'struct thread' to represent the idle task. That is
because threads are identified by pid and tid, and the idle task always has
pid == tid == 0.  However, there are actually separate idle tasks for each
cpu. That creates a problem for thread stack processing which assumes that
each thread has a single stack, not one stack per cpu. Fix that by passing
through the cpu number, and in the case of the idle "thread", pick the
thread stack from an array based on the cpu number.


Adrian Hunter (8):
      perf thread-stack: Simplify some code in thread_stack__process()
      perf thread-stack: Tidy thread_stack__bottom() usage
      perf thread-stack: Avoid direct reference to the thread's stack
      perf thread-stack: Allow for a thread stack array
      perf thread-stack: Factor out thread_stack__init()
      perf thread-stack: Allocate an array of thread stacks
      perf thread-stack: Fix thread stack processing for the idle task
      perf session: Add comment for perf_session__register_idle_thread()

 tools/perf/builtin-script.c    |   4 +-
 tools/perf/util/intel-bts.c    |   4 +-
 tools/perf/util/intel-pt.c     |   6 +-
 tools/perf/util/session.c      |   7 ++
 tools/perf/util/thread-stack.c | 228 +++++++++++++++++++++++++++++------------
 tools/perf/util/thread-stack.h |   8 +-
 6 files changed, 183 insertions(+), 74 deletions(-)


Regards
Adrian

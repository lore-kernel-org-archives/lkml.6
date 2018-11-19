Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB23C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B4120823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B4120823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeKSWns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:43:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbeKSWns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:43:48 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 542523084258;
        Mon, 19 Nov 2018 12:20:20 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 994575C57B;
        Mon, 19 Nov 2018 12:20:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 00/12] perf top: Rework processing code
Date:   Mon, 19 Nov 2018 13:20:04 +0100
Message-Id: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 19 Nov 2018 12:20:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
David reported issues with perf top loosing side band events
so we moved mmap reading and hists processing into separated
threads.

This patchset also adds dropping sample logic when the processing
falls behind the reader thread. This way we get incomplete but
current data in perf top.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
David Miller (1):
      perf tools: Fix build on sparc

Jiri Olsa (11):
      perf tools: Rework show_progress for __ordered_events__flush
      perf tools: Add private data to struct ordered_events
      perf top: Save and display the lost count stats
      perf top: Moving lost events warning to helpline
      perf top: Add processing thread
      perf top: Use cond variable instead of the lock
      perf top: Set session_done when exiting
      perf top: Drop samples which are behind more than refresh rate
      perf top: Save and display the drop count stats
      perf top: Display slow reader warning for when droping samples
      perf top: Move perf_top__reset_sample_counters after counts display

 tools/perf/bench/epoll-ctl.c     |   7 +--
 tools/perf/bench/epoll-wait.c    |   6 ++-
 tools/perf/builtin-top.c         | 281 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
 tools/perf/ui/browsers/hists.c   |  11 +++++
 tools/perf/util/ordered-events.c |  16 ++++---
 tools/perf/util/ordered-events.h |   5 ++-
 tools/perf/util/session.c        |   3 +-
 tools/perf/util/top.c            |   8 ++--
 tools/perf/util/top.h            |  10 ++++-
 9 files changed, 258 insertions(+), 89 deletions(-)

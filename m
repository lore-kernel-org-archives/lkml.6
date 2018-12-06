Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA82C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722D7208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 722D7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLFTSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:18:42 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:57033 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeLFTSl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 14:18:41 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 12:18:30 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net
Subject: [PATCH v2 -tip 0/7] tools/perf: Update rbtree implementation and optimize users
Date:   Thu,  6 Dec 2018 11:18:12 -0800
Message-Id: <20181206191819.30182-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Per acme's request, this is a rebase (and basically rewrite) of v1.

The following optimizes the rb_first() lookups in perf tooling such that we
can avoid walking down the tree finding the first element. Tree traversals
(and overall computing the first node in the tree) is a surprisingly common
operation. On a Xeon E5-2450 @ 2.10GHz, the cost of an rb_first() was ~60 cycles
for 100 nodes, and ~75 cycles with 1000 nodes.

The first patch adds the updated implementation of rbtrees, including the
cached interfaces, taken from the kernel. The rest of the patches make use
of this for the users I thought might care the most.

With these patches I am able to build and use perf without anything going wrong
(but needs more testing no doubt, as changes while redundant can be a little tricky
depending on if the user get smart about the trees). I'm sorry if some patches
seem too big, I've tried to split them the best I could.

Applies on today's -tip tree. Please consider for v4.21.

Thanks!

Davidlohr Bueso (7):
  tools/perf: Update rbtree implementation
  perf machine: Use cached rbtrees
  perf callchain: Use cached rbtrees
  perf util: Use cached rbtree for rblists
  perf symbols: Use cached rbtrees
  perf hist: Use cached rbtrees
  perf sched: Use cached rbtrees

 tools/include/linux/rbtree.h           |  52 ++++++++-
 tools/include/linux/rbtree_augmented.h |  60 ++++++++--
 tools/lib/rbtree.c                     | 178 ++++++++++++++++++++++-------
 tools/perf/builtin-annotate.c          |   4 +-
 tools/perf/builtin-c2c.c               |   6 +-
 tools/perf/builtin-diff.c              |  10 +-
 tools/perf/builtin-report.c            |   3 +-
 tools/perf/builtin-sched.c             |  45 ++++----
 tools/perf/builtin-top.c               |   2 +-
 tools/perf/tests/hists_common.c        |   8 +-
 tools/perf/tests/hists_cumulate.c      |  14 +--
 tools/perf/tests/hists_link.c          |   8 +-
 tools/perf/tests/hists_output.c        |  32 +++---
 tools/perf/ui/browsers/hists.c         |   6 +-
 tools/perf/ui/gtk/hists.c              |   4 +-
 tools/perf/ui/stdio/hist.c             |   3 +-
 tools/perf/util/build-id.c             |  12 +-
 tools/perf/util/dso.c                  |   8 +-
 tools/perf/util/dso.h                  |  10 +-
 tools/perf/util/hist.c                 | 199 +++++++++++++++++++--------------
 tools/perf/util/hist.h                 |  10 +-
 tools/perf/util/intlist.h              |   2 +-
 tools/perf/util/machine.c              |  53 +++++----
 tools/perf/util/machine.h              |  12 +-
 tools/perf/util/map.c                  |   8 +-
 tools/perf/util/metricgroup.c          |   2 +-
 tools/perf/util/probe-event.c          |   3 +-
 tools/perf/util/rb_resort.h            |   8 +-
 tools/perf/util/rblist.c               |  28 +++--
 tools/perf/util/rblist.h               |   2 +-
 tools/perf/util/sort.h                 |   4 +-
 tools/perf/util/srcline.c              |  43 ++++---
 tools/perf/util/srcline.h              |  13 ++-
 tools/perf/util/stat-shadow.c          |   2 +-
 tools/perf/util/strlist.h              |   2 +-
 tools/perf/util/symbol.c               |  87 +++++++-------
 tools/perf/util/symbol.h               |  13 ++-
 tools/perf/util/symbol_fprintf.c       |   2 +-
 38 files changed, 598 insertions(+), 360 deletions(-)

-- 
2.16.4


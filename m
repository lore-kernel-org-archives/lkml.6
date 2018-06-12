Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ABEDBC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D02D208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D02D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933535AbeFLHvr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:51:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933242AbeFLHvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615819"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:43 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 0/6] perf: Add AUX data sampling
Date:   Tue, 12 Jun 2018 10:51:11 +0300
Message-Id: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces AUX data sampling for perf events, which in
case of our instruction/branch tracing PMUs like Intel PT, BTS, CS
ETM means execution flow history leading up to a perf event's
overflow.

In case of Intel PT, this can be used as an alternative to LBR, with
virtually as many as you like branches per sample. It doesn't support
some of the LBR features (branch prediction indication, basic block
level timing, etc [1]) and it can't be exposed as BRANCH_STACK, because
that would require decoding PT stream in kernel space, which is not
practical. Instead, we deliver the PT data to userspace as is, for
offline processing. The PT decoder already supports presenting PT as
virtual LBR.

AUX sampling is different from the snapshot mode in that it doesn't
require instrumentation (for when to take a snapshot) and is better
for generic data collection, when you don't yet know what you are
looking for. It's also useful for automated data collection, for
example, for feedback-driven compiler optimizaitions.

It's also different from the "full trace mode" in that it produces
much less data and, consequently, takes up less I/O bandwidth and
storage space, and takes less time to decode.

The bulk of code is in 4/6, which adds the user interface bits and
adds code to measure and copy out AUX data. 1/6 and 2/6 close the
races around the sampling code, 3/6 is a helper, 5/6 kills the
PERF_FLAG_FD_OUTPUT which has been effectively dead for about 8 years
now and 6/6 allows SET_OUTPUT between SW and HW contexts, which allows
the tool to not carry around additional file descriptors when sampling
a hardware event.

I'm not including the tooling patches, which Adrian will post separately.
Meanwhile, they can be found here [2].

Changes since the last time I posted patches to this effect [3]:
 - instead of creating kernel events with AUX data, have the user create
   them and pass on to the events that they wish to see AUX samples on;
 - as a result, dropped most of the code.

[1] https://marc.info/?l=linux-kernel&m=147467007714928&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/ash/linux.git/log/?h=perf-aux-sampling
[3] https://marc.info/?l=linux-kernel&m=147463007105836

Adrian Hunter (1):
  perf: Allow set-output for task contexts of different types

Alexander Shishkin (5):
  perf: Disable PMU around address filter adjustment
  perf: Disable IRQs in address filter sync path
  perf: Add an iterator for AUX data
  perf: Allow using AUX data in perf samples
  perf: Drop PERF_FLAG_FD_OUTPUT

 include/linux/perf_event.h      |  10 ++
 include/uapi/linux/perf_event.h |   8 +-
 kernel/events/core.c            | 206 +++++++++++++++++++++++++++++---
 kernel/events/internal.h        |   5 +
 kernel/events/ring_buffer.c     |  34 ++++++
 5 files changed, 247 insertions(+), 16 deletions(-)

-- 
2.17.1


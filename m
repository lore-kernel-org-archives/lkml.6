Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D03FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A932084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 19:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A932084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbeJBCjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:39:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:64347 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbeJBCjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:39:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 12:59:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="79016576"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 01 Oct 2018 12:59:39 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id D1F25301B79; Mon,  1 Oct 2018 12:59:39 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 2/2] perf record: Support weak groups
Date:   Mon,  1 Oct 2018 12:59:27 -0700
Message-Id: <20181001195927.14211-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001195927.14211-1-andi@firstfloor.org>
References: <20181001195927.14211-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement a weak group fallback for perf record, similar to the existing perf stat support.
This allows to use groups that might be longer than the available counters without
failing.

Before:

$ perf record  -e '{cycles,cache-misses,cache-references,cpu_clk_unhalted.thread,cycles,cycles,cycles}' -a sleep 1
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).
/bin/dmesg | grep -i perf may provide additional information.

After:

$ ./perf record  -e '{cycles,cache-misses,cache-references,cpu_clk_unhalted.thread,cycles,cycles,cycles}:W' -a sleep 1
WARNING: No sample_id_all support, falling back to unordered processing
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 8.136 MB perf.data (134069 samples) ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/Documentation/perf-list.txt | 1 -
 tools/perf/builtin-record.c            | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 11300dbe35c5..c50ed1177984 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -49,7 +49,6 @@ counted. The following modifiers exist:
  S - read sample value (PERF_SAMPLE_READ)
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
-     only supported in 'perf stat' for now.
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..504d89d67b3a 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -388,7 +388,12 @@ static int record__open(struct record *rec)
 					ui__warning("%s\n", msg);
 				goto try_again;
 			}
-
+			if ((errno == EINVAL || errno == EBADF) &&
+			    pos->leader != pos &&
+			    pos->weak_group) {
+			        pos = perf_evlist__reset_weak_group(evlist, pos);
+				goto try_again;
+			}
 			rc = -errno;
 			perf_evsel__open_strerror(pos, &opts->target,
 						  errno, msg, sizeof(msg));
-- 
2.17.1


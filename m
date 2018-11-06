Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F6C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F632086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2ln65ULr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F632086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388087AbeKFVbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFVbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:47 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4722F2086A;
        Tue,  6 Nov 2018 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506013;
        bh=RCrIL9Kw1r92OFqMRr3bjtfeqYJhjEhDqmZbgqjvZXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ln65ULrViLxyE+6StQTD53E8/00AOTJfSI9nVlJ/nImlmlhyzhuabwXpJBr5SS+4
         ULkRgsG8fQrbuTs+79HQmI6QAtOoBL9/xt3gfy7JXvq+o89SAAtWkQGFbS8wXft+R3
         bNmryCWFEJc50IJh8pVj2ikAshdyOurJgyUjGLfA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/18] perf record: Support weak groups
Date:   Tue,  6 Nov 2018 09:06:01 -0300
Message-Id: <20181106120612.8262-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Implement a weak group fallback for 'perf record', similar to the
existing 'perf stat' support.  This allows to use groups that might be
longer than the available counters without failing.

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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181001195927.14211-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-list.txt | 1 -
 tools/perf/builtin-record.c            | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 236b9b97dfdb..667c14e56031 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -55,7 +55,6 @@ counted. The following modifiers exist:
  S - read sample value (PERF_SAMPLE_READ)
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
-     only supported in 'perf stat' for now.
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 10cf889c6d75..488779bc4c8d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -391,7 +391,12 @@ static int record__open(struct record *rec)
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
2.14.4


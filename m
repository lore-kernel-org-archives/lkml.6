Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AFEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ABB20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ABB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388500AbeKGEkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:40:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387537AbeKGEkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:40:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JDVRb910904
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:13:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JDUeJ910900;
        Tue, 6 Nov 2018 11:13:30 -0800
Date:   Tue, 6 Nov 2018 11:13:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-cf99ad1424c54fc84b84d3a3deb57a48c340c30a@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, jolsa@kernel.org,
        ak@linux.intel.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        hpa@zytor.com
Reply-To: hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, jolsa@kernel.org, tglx@linutronix.de,
          mingo@kernel.org
In-Reply-To: <20181001195927.14211-2-andi@firstfloor.org>
References: <20181001195927.14211-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Support weak groups
Git-Commit-ID: cf99ad1424c54fc84b84d3a3deb57a48c340c30a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cf99ad1424c54fc84b84d3a3deb57a48c340c30a
Gitweb:     https://git.kernel.org/tip/cf99ad1424c54fc84b84d3a3deb57a48c340c30a
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 1 Oct 2018 12:59:27 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 14:37:10 -0300

perf record: Support weak groups

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
@@ -391,7 +391,12 @@ try_again:
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

Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 63030C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2410120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2410120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933682AbeFLHv4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:51:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:47405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933242AbeFLHvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:51:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 00:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,213,1526367600"; 
   d="scan'208";a="56615847"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2018 00:51:53 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 5/6] perf: Drop PERF_FLAG_FD_OUTPUT
Date:   Tue, 12 Jun 2018 10:51:16 +0300
Message-Id: <20180612075117.65420-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
References: <20180612075117.65420-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit:

  ac9721f3f54b ("perf_events: Fix races and clean up perf_event and perf_mmap_data interaction")

... PERF_FLAG_FD_OUTPUT has been always returning -EINVAL. This can be
either fixed by supplying enough context information to the set_output
path to validate the request, or it can simply be dropped. The fact that
in 8 years since it last worked, nobody (except Vince [1]) seems to
notice, this patch drops it.

[1] https://lkml.org/lkml/2015/1/9/479

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 70918ed33143..9bf5c7abb621 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -344,7 +344,6 @@ static void event_function_local(struct perf_event *event, event_f func, void *d
 }
 
 #define PERF_FLAG_ALL (PERF_FLAG_FD_NO_GROUP |\
-		       PERF_FLAG_FD_OUTPUT  |\
 		       PERF_FLAG_PID_CGROUP |\
 		       PERF_FLAG_FD_CLOEXEC |\
 		       PERF_FLAG_FD_SAMPLE)
@@ -9997,7 +9996,7 @@ SYSCALL_DEFINE5(perf_event_open,
 		struct perf_event_attr __user *, attr_uptr,
 		pid_t, pid, int, cpu, int, group_fd, unsigned long, flags)
 {
-	struct perf_event *group_leader = NULL, *output_event = NULL;
+	struct perf_event *group_leader = NULL;
 	struct perf_event *sample_event = NULL;
 	struct perf_event *event, *sibling;
 	struct perf_event_attr attr;
@@ -10067,8 +10066,6 @@ SYSCALL_DEFINE5(perf_event_open,
 		if (err)
 			goto err_fd;
 		group_leader = group.file->private_data;
-		if (flags & PERF_FLAG_FD_OUTPUT)
-			output_event = group_leader;
 		if (flags & PERF_FLAG_FD_SAMPLE)
 			sample_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
@@ -10223,12 +10220,6 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_context;
 	}
 
-	if (output_event) {
-		err = perf_event_set_output(event, output_event);
-		if (err)
-			goto err_context;
-	}
-
 	event_file = anon_inode_getfile("[perf_event]", &perf_fops, event,
 					f_flags);
 	if (IS_ERR(event_file)) {
-- 
2.17.1


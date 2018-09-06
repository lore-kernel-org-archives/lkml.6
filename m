Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86964C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4654E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4654E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeIFRjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:39:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42997 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbeIFRjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:39:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D3aud301451
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:03:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D3acT301448;
        Thu, 6 Sep 2018 06:03:36 -0700
Date:   Thu, 6 Sep 2018 06:03:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bf06278c3fdf8909c3a9283e2c270b0fc170fa90@git.kernel.org>
Cc:     hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
        chabbi.milind@gmail.com, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        oleg@redhat.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, oleg@redhat.com, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          peterz@infradead.org, chabbi.milind@gmail.com,
          namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com
In-Reply-To: <20180827091228.2878-6-jolsa@kernel.org>
References: <20180827091228.2878-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/hw_breakpoint: Simplify breakpoint enable in
 perf_event_modify_breakpoint
Git-Commit-ID: bf06278c3fdf8909c3a9283e2c270b0fc170fa90
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

Commit-ID:  bf06278c3fdf8909c3a9283e2c270b0fc170fa90
Gitweb:     https://git.kernel.org/tip/bf06278c3fdf8909c3a9283e2c270b0fc170fa90
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 27 Aug 2018 11:12:28 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:49:24 -0300

perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint

We can safely enable the breakpoint back for both the fail and success
paths by checking only the bp->attr.disabled, which either holds the new
'requested' disabled state or the original breakpoint state.

Committer testing:

At the end of the series, the 'perf test' entry introduced as the first
patch now runs to completion without finding the fixed issues:

  # perf test "bp modify"
  62: x86 bp modify                                         : Ok
  #

In verbose mode:

  # perf test -v "bp modify"
  62: x86 bp modify                                         :
  --- start ---
  test child forked, pid 5161
  rip 5950a0, bp_1 0x5950a0
  in bp_1
  rip 5950a0, bp_1 0x5950a0
  in bp_1
  test child finished with 0
  ---- end ----
  x86 bp modify: Ok

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f6ea33a9f904..22ede28ec07d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2867,16 +2867,11 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 	_perf_event_disable(bp);
 
 	err = modify_user_hw_breakpoint_check(bp, attr, true);
-	if (err) {
-		if (!bp->attr.disabled)
-			_perf_event_enable(bp);
 
-		return err;
-	}
-
-	if (!attr->disabled)
+	if (!bp->attr.disabled)
 		_perf_event_enable(bp);
-	return 0;
+
+	return err;
 }
 
 static int perf_event_modify_attr(struct perf_event *event,

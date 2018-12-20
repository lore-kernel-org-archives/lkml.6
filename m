Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4991CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233E9218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeLTSNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:13:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51615 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbeLTSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:13:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKICKvT3682308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:12:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKICKCO3682305;
        Thu, 20 Dec 2018 10:12:20 -0800
Date:   Thu, 20 Dec 2018 10:12:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-43fd56669c28cd354e9228bdb58e4bca1c1a8b66@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, namhyung@kernel.org,
        leo.yan@linaro.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mike.leach@linaro.org, robert.walker@arm.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: mike.leach@linaro.org, robert.walker@arm.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          mathieu.poirier@linaro.org, namhyung@kernel.org,
          leo.yan@linaro.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org
In-Reply-To: <1544513908-16805-2-git-send-email-leo.yan@linaro.org>
References: <1544513908-16805-2-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Correct packets swapping in
 cs_etm__flush()
Git-Commit-ID: 43fd56669c28cd354e9228bdb58e4bca1c1a8b66
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

Commit-ID:  43fd56669c28cd354e9228bdb58e4bca1c1a8b66
Gitweb:     https://git.kernel.org/tip/43fd56669c28cd354e9228bdb58e4bca1c1a8b66
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 11 Dec 2018 15:38:21 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:58 -0300

perf cs-etm: Correct packets swapping in cs_etm__flush()

The structure cs_etm_queue uses 'prev_packet' to point to previous
packet, this can be used to combine with new coming packet to generate
samples.

In function cs_etm__flush() it swaps packets only when the flag
'etm->synth_opts.last_branch' is true, this means that it will not swap
packets if without option '--itrace=il' to generate last branch entries;
thus for this case the 'prev_packet' doesn't point to the correct
previous packet and the stale packet still will be used to generate
sequential sample.  Thus if dump trace with 'perf script' command we can
see the incorrect flow with the stale packet's address info.

This patch corrects packets swapping in cs_etm__flush(); except using
the flag 'etm->synth_opts.last_branch' it also checks the another flag
'etm->sample_branches', if any flag is true then it swaps packets so can
save correct content to 'prev_packet'.  Finally this can fix the wrong
program flow dumping issue.

The patch has a minor refactoring to use 'etm->synth_opts.last_branch'
instead of 'etmq->etm->synth_opts.last_branch' for condition checking,
this is consistent with that is done in cs_etm__sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1544513908-16805-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 23159c33db2a..789707bc4e9e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1042,7 +1042,7 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
 	}
 
 swap_packet:
-	if (etmq->etm->synth_opts.last_branch) {
+	if (etm->sample_branches || etm->synth_opts.last_branch) {
 		/*
 		 * Swap PACKET with PREV_PACKET: PACKET becomes PREV_PACKET for
 		 * the next incoming packet.

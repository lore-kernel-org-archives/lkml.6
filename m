Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7119C222FD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393179AbfBOJk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:40:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390412AbfBOJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:40:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9eiYh1118439
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:40:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9eh7r1118436;
        Fri, 15 Feb 2019 01:40:43 -0800
Date:   Fri, 15 Feb 2019 01:40:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-d3267ad43dd8b3778f9b3deb9a3946c844bdc9dc@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
        jolsa@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        mingo@kernel.org, suzuki.poulose@arm.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
          suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
          linux-kernel@vger.kernel.org, leo.yan@linaro.org, hpa@zytor.com,
          jolsa@redhat.com, acme@redhat.com
In-Reply-To: <20190212171618.25355-4-mathieu.poirier@linaro.org>
References: <20190212171618.25355-4-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Fix wrong return values in error path
Git-Commit-ID: d3267ad43dd8b3778f9b3deb9a3946c844bdc9dc
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

Commit-ID:  d3267ad43dd8b3778f9b3deb9a3946c844bdc9dc
Gitweb:     https://git.kernel.org/tip/d3267ad43dd8b3778f9b3deb9a3946c844bdc9dc
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:08 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:06 -0300

perf cs-etm: Fix wrong return values in error path

Function cs_etm__mem_access() is supposed to return a u32 but the error
path returns negative values at a couple of places, something that really
throws off the clients using it.  Fix the situation by return '0'.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-4-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1d9419a0cf0c..f396fee9bb95 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -324,7 +324,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	struct	 addr_location al;
 
 	if (!etmq)
-		return -1;
+		return 0;
 
 	machine = etmq->etm->machine;
 	cpumode = cs_etm__cpu_mode(etmq, address);
@@ -332,7 +332,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 	thread = etmq->thread;
 	if (!thread) {
 		if (cpumode != PERF_RECORD_MISC_KERNEL)
-			return -EINVAL;
+			return 0;
 		thread = etmq->etm->unknown_thread;
 	}
 

Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E592C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B575208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeLNUXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:23:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:23:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKMxkV1451278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:22:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKMxIP1451275;
        Fri, 14 Dec 2018 12:22:59 -0800
Date:   Fri, 14 Dec 2018 12:22:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-cbf7c5b09202693cfc17ac87d7ad45f622ab4937@git.kernel.org>
Cc:     jolsa@redhat.com, mathieu.poirier@linaro.org, hpa@zytor.com,
        mingo@kernel.org, leo.yan@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, davem@davemloft.net, ak@linux.intel.com
Reply-To: adrian.hunter@intel.com, davem@davemloft.net, ak@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org, leo.yan@linaro.org,
          jolsa@redhat.com, mathieu.poirier@linaro.org, hpa@zytor.com
In-Reply-To: <20181106210712.12098-3-adrian.hunter@intel.com>
References: <20181106210712.12098-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use fallback for
 sample_addr_correlates_sym() cases
Git-Commit-ID: cbf7c5b09202693cfc17ac87d7ad45f622ab4937
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

Commit-ID:  cbf7c5b09202693cfc17ac87d7ad45f622ab4937
Gitweb:     https://git.kernel.org/tip/cbf7c5b09202693cfc17ac87d7ad45f622ab4937
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Nov 2018 23:07:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:47 -0300

perf tools: Use fallback for sample_addr_correlates_sym() cases

thread__resolve() is used in the sample_addr_correlates_sym() cases
where 'addr' is a destination of a branch which does not necessarily
have the same cpumode as the 'ip'. Use the fallback function in that
case.

This patch depends on patch "perf tools: Add fallback functions for
cases where cpumode is insufficient".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: stable@vger.kernel.org # 4.19
Link: http://lkml.kernel.org/r/20181106210712.12098-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 9431b20c1337..24493200cf80 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1706,7 +1706,7 @@ bool sample_addr_correlates_sym(struct perf_event_attr *attr)
 void thread__resolve(struct thread *thread, struct addr_location *al,
 		     struct perf_sample *sample)
 {
-	thread__find_map(thread, sample->cpumode, sample->addr, al);
+	thread__find_map_fb(thread, sample->cpumode, sample->addr, al);
 
 	al->cpu = sample->cpu;
 	al->sym = NULL;

Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EEC218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeLRNuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:50:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbeLRNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:50:13 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIDo5Yr2850562
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 05:50:05 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIDo5bh2850557;
        Tue, 18 Dec 2018 05:50:05 -0800
Date:   Tue, 18 Dec 2018 05:50:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-225f99e0c811e23836c4911a2ff147e167dd1fe8@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, tglx@linutronix.de, jolsa@redhat.com,
        acme@redhat.com, ak@linux.intel.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        leo.yan@linaro.org, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, davem@davemloft.net, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          acme@redhat.com, hpa@zytor.com, leo.yan@linaro.org,
          tglx@linutronix.de, jolsa@redhat.com, mathieu.poirier@linaro.org
In-Reply-To: <20181106210712.12098-3-adrian.hunter@intel.com>
References: <20181106210712.12098-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use fallback for
 sample_addr_correlates_sym() cases
Git-Commit-ID: 225f99e0c811e23836c4911a2ff147e167dd1fe8
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

Commit-ID:  225f99e0c811e23836c4911a2ff147e167dd1fe8
Gitweb:     https://git.kernel.org/tip/225f99e0c811e23836c4911a2ff147e167dd1fe8
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Nov 2018 23:07:11 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:54:16 -0300

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

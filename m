Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B117C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB80020844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB80020844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeIFRkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:40:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbeIFRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:40:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D4caX303058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:04:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D4cNR303053;
        Thu, 6 Sep 2018 06:04:38 -0700
Date:   Thu, 6 Sep 2018 06:04:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hisao Tanabe <tipbot@zytor.com>
Message-ID: <tip-e5plzjhx6595a5yjaf22jss3@git.kernel.org>
Cc:     xtanabe@gmail.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, namhyung@kernel.org, jolsa@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com
Reply-To: acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
          wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          xtanabe@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Fix potential null pointer dereference
 in perf_evsel__new_idx()
Git-Commit-ID: fd8d2702791a970c751f8b526a17d8e725a05b46
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

Commit-ID:  fd8d2702791a970c751f8b526a17d8e725a05b46
Gitweb:     https://git.kernel.org/tip/fd8d2702791a970c751f8b526a17d8e725a05b46
Author:     Hisao Tanabe <xtanabe@gmail.com>
AuthorDate: Sat, 25 Aug 2018 00:45:56 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:49:25 -0300

perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()

If evsel is NULL, we should return NULL to avoid a NULL pointer
dereference a bit later in the code.

Signed-off-by: Hisao Tanabe <xtanabe@gmail.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 03e0a7df3efd ("perf tools: Introduce bpf-output event")
LPU-Reference: 20180824154556.23428-1-xtanabe@gmail.com
Link: https://lkml.kernel.org/n/tip-e5plzjhx6595a5yjaf22jss3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c980bbff6353..1a61628a1c12 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -251,8 +251,9 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 {
 	struct perf_evsel *evsel = zalloc(perf_evsel__object.size);
 
-	if (evsel != NULL)
-		perf_evsel__init(evsel, attr, idx);
+	if (!evsel)
+		return NULL;
+	perf_evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |

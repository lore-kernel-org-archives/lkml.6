Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71346C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4977821841
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfBZDES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:04:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:1902 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfBZDEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:04:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 19:04:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,413,1544515200"; 
   d="scan'208";a="120792622"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2019 19:04:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id AB40E300309; Mon, 25 Feb 2019 19:04:15 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 09/11] perf tools: Add utility function to print ns time stamps
Date:   Mon, 25 Feb 2019 19:04:10 -0800
Message-Id: <20190226030412.23485-10-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190226030412.23485-1-andi@firstfloor.org>
References: <20190226030412.23485-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add a utility function to print nanosecond timestamps.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/time-utils.c | 8 ++++++++
 tools/perf/util/time-utils.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 6193b46050a5..a63bdf4cfd1b 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -404,6 +404,14 @@ int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 	return scnprintf(buf, sz, "%"PRIu64".%06"PRIu64, sec, usec);
 }
 
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz)
+{
+	u64  sec = timestamp / NSEC_PER_SEC;
+	u64 nsec = timestamp % NSEC_PER_SEC;
+
+	return scnprintf(buf, sz, "%"PRIu64".%09"PRIu64, sec, nsec);
+}
+
 int fetch_current_timestamp(char *buf, size_t sz)
 {
 	struct timeval tv;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index 70b177d2b98c..9266cf4a8e58 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -24,6 +24,7 @@ bool perf_time__ranges_skip_sample(struct perf_time_interval *ptime_buf,
 				   int num, u64 timestamp);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 
-- 
2.17.2


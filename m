Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E82C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D1F20842
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfBXPiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:38:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:4459 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728431AbfBXPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP; 24 Feb 2019 07:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="120396836"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B73903011D4; Sun, 24 Feb 2019 07:37:30 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 08/11] perf tools: Add perf_exe() helper to find perf binary
Date:   Sun, 24 Feb 2019 07:37:19 -0800
Message-Id: <20190224153722.27020-9-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190224153722.27020-1-andi@firstfloor.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Also convert one existing user.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/header.c | 12 +++---------
 tools/perf/util/util.c   | 10 ++++++++++
 tools/perf/util/util.h   |  2 ++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 61ce197c5362..2f290a0343d4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -526,17 +526,11 @@ static int write_event_desc(struct feat_fd *ff,
 static int write_cmdline(struct feat_fd *ff,
 			 struct perf_evlist *evlist __maybe_unused)
 {
-	char buf[MAXPATHLEN];
-	u32 n;
-	int i, ret;
+	char pbuf[MAXPATHLEN], *buf;
+	int i, ret, n;
 
 	/* actual path to perf binary */
-	ret = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
-	if (ret <= 0)
-		return -1;
-
-	/* readlink() does not add null termination */
-	buf[ret] = '\0';
+	buf = perf_exe(pbuf, MAXPATHLEN);
 
 	/* account for binary path */
 	n = perf_env.nr_cmdline + 1;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 320b0fef249a..dd693e018aef 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -507,3 +507,13 @@ const char *perf_tip(const char *dirpath)
 
 	return tip;
 }
+
+char *perf_exe(char *buf, int len)
+{
+	int n = readlink("/proc/self/exe", buf, len);
+	if (n > 0) {
+		buf[n] = 0;
+		return buf;
+	}
+	return strcpy(buf, "perf");
+}
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ece040b799f6..dc2a99ad5c96 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -76,6 +76,8 @@ extern bool perf_singlethreaded;
 void perf_set_singlethreaded(void);
 void perf_set_multithreaded(void);
 
+char *perf_exe(char *buf, int len);
+
 #ifndef O_CLOEXEC
 #ifdef __sparc__
 #define O_CLOEXEC      0x400000
-- 
2.17.2


Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF932147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131674;
	bh=aWsQrQ/q1IeV2lmGFmxvAFkjfPzVYvPwqhHeWhDyRGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bk5KbaJxXZFuVb/6D5DG9o15Hz8DqTpH3RGNHnvCIO8xjrktkBrBQRyDNPw4VZ/Gv
	 zB2YpCUlf7eII6spH+c2OnvzOPLlJI80Ij4xkU3DRhhK7mnoNxTCbcOBrGEoyMbcrx
	 9AUNI6EL8FSu0bq6Ez4NX14hmnHsTcfJIlWTH8pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730935AbfBYVyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:54:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729575AbfBYVWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:08 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD9321855;
        Mon, 25 Feb 2019 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129727;
        bh=aWsQrQ/q1IeV2lmGFmxvAFkjfPzVYvPwqhHeWhDyRGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpQ+YngscSiIyrW7xdicqNoF0ef4sm2Ie04mMtI7UXxgvVwkkEGKTC1bywI3WRxyr
         di5QA9fqvB0Chm7L2IqTQf3e+cDewLzWDUJn0KxfAs0T2qsGEoL/5qB6DyHoGDxo2r
         grxeJwmm3abb5WaLsOzUa0h6YjS71hd/xQLbKKAM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/37] perf tools: Add rm_rf_perf_data function
Date:   Mon, 25 Feb 2019 18:20:19 -0300
Message-Id: <20190225212035.24781-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To remove perf.data including the directory, with checking on expected
files and no other directories inside.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Andi Kleen <ak@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224190656.30163-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/util.c | 11 +++++++++++
 tools/perf/util/util.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 02b7a38f98ce..706818693086 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -202,6 +202,17 @@ static int rm_rf_depth_pat(const char *path, int depth, const char **pat)
 	return rmdir(path);
 }
 
+int rm_rf_perf_data(const char *path)
+{
+	const char *pat[] = {
+		"header",
+		"data.*",
+		NULL,
+	};
+
+	return rm_rf_depth_pat(path, 0, pat);
+}
+
 int rm_rf(const char *path)
 {
 	return rm_rf_depth_pat(path, INT_MAX, NULL);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index ece040b799f6..01c538027c6f 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -31,6 +31,7 @@ struct strlist;
 
 int mkdir_p(char *path, mode_t mode);
 int rm_rf(const char *path);
+int rm_rf_perf_data(const char *path);
 struct strlist *lsdir(const char *name, bool (*filter)(const char *, struct dirent *));
 bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
-- 
2.20.1


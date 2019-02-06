Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30409C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D2E218D2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479118;
	bh=pWlKb+ItqQrPFJBZuAHrmlH00PbjedlXD7/NLX/e+SE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yCQdhqHUrT2ID2La15/jDwLDOCASAQT4JwzfThOvAmth2CDJ1KLQrvxd1SXMOCCFM
	 9HgnPBimf2gQy2lqeh+MWXLZY0yiFnK15zCsSYRBi0WWzqRooRInssEDVRvC3KeBSP
	 PO1N8IId8FeyBzBGjXCYB1cY6IrcT+fcCtf8lpZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfBFSv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:46186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbfBFSvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:54 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B4D218C3;
        Wed,  6 Feb 2019 18:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479114;
        bh=pWlKb+ItqQrPFJBZuAHrmlH00PbjedlXD7/NLX/e+SE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wduxhXwtfQ4YPe/oiOPY7jC09Dd3PkQVM5+IipfEnk33EhwGI11aGtE3keqxwTkQ8
         WVns8yO1G2WhVfBLMZ1Ve/d4GOtJxjuRcUZYhzBB5GxSb2N1ic1XgehrkIXMVou8VQ
         y/mprtAsg1nd55UXrA1GOAJz4ZucIZp22Iai6sKM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/53] perf auxtrace: Define auxtrace record alignment
Date:   Wed,  6 Feb 2019 15:48:59 -0300
Message-Id: <20190206184903.24054-50-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Define auxtrace record alignment so that it can be referenced elsewhere.

Note this is preparation for patch "perf intel-pt: Fix overlap calculation
for padding"

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 4 ++--
 tools/perf/util/auxtrace.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 94a22cc8004c..ad186d3255d1 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1279,9 +1279,9 @@ static int __auxtrace_mmap__read(struct perf_mmap *map,
 	}
 
 	/* padding must be written by fn() e.g. record__process_auxtrace() */
-	padding = size & 7;
+	padding = size & (PERF_AUXTRACE_RECORD_ALIGNMENT - 1);
 	if (padding)
-		padding = 8 - padding;
+		padding = PERF_AUXTRACE_RECORD_ALIGNMENT - padding;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.auxtrace.header.type = PERF_RECORD_AUXTRACE;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8e50f96d4b23..fac32482db61 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -40,6 +40,9 @@ struct record_opts;
 struct auxtrace_info_event;
 struct events_stats;
 
+/* Auxtrace records must have the same alignment as perf event records */
+#define PERF_AUXTRACE_RECORD_ALIGNMENT 8
+
 enum auxtrace_type {
 	PERF_AUXTRACE_UNKNOWN,
 	PERF_AUXTRACE_INTEL_PT,
-- 
2.20.1


Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5B9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323FD21EA3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zGXVeqaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323FD21EA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732918AbeHIRZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:39 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96058214FF;
        Thu,  9 Aug 2018 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826821;
        bh=pWxuls/CLTjnXIYrnJS4WD/wDIoDqAOtYtlF1rCJ9x8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zGXVeqaXuczVvRYu3m4nT6Wne4qw5NTUwXY2XgKMRznhrqKiNhM4O2lvbjhI2Grl8
         2xZ5eGlPOuae8yVOCdsbP2HnbSVs0GJPNadEJW5s5eT4/HtA+fr3hXy3kocojfnNcX
         LwBr521o9CJ+KUNmStdJilo0Vbi/qcSnje2gLieE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/44] perf annotate: Add PERCENT_PERIOD_LOCAL percent value
Date:   Thu,  9 Aug 2018 11:58:00 -0300
Message-Id: <20180809145822.21391-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding and computing local period percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_PERIOD_LOCAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 2 ++
 tools/perf/util/annotate.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b7485a512da1..b37e8cc18668 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1781,6 +1781,8 @@ static void calc_percent(struct sym_hist *sym_hist,
 	if (hists->stats.nr_non_filtered_samples)
 		data->percent[PERCENT_HITS_GLOBAL] = 100.0 * hits / hists->stats.nr_non_filtered_samples;
 
+	if (sym_hist->period)
+		data->percent[PERCENT_PERIOD_LOCAL] = 100.0 * period / sym_hist->period;
 }
 
 static void annotation__calc_percent(struct annotation *notes,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3a06cb2b6e28..890b6869caa9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -104,6 +104,7 @@ struct sym_hist_entry {
 enum {
 	PERCENT_HITS_LOCAL,
 	PERCENT_HITS_GLOBAL,
+	PERCENT_PERIOD_LOCAL,
 	PERCENT_MAX,
 };
 
-- 
2.14.4


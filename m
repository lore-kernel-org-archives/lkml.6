Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC086C67838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6463F21708
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131994;
	bh=hDuSHjxenn8MLr0Lu3xlgLqoL1ch8u4nZ+J/jAsn3kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SR3z73EX3ps8R5O3NTvMADKVKu29mAl+XY/pL6hoe+8f8vDOk1tVq1oOgFNDaMySU
	 UrVvM7WDabERRu4Aq3R+WAH0VE8eC8azZa829hdl60HjPkOCGX9z2lARAXyG2DIM6o
	 ZX8IrfH6cNUuemhyusw2Z61fGpD/AJrdg0WpUvNU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6463F21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLFVcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:32:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbeLFV35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:57 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D262082B;
        Thu,  6 Dec 2018 21:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131796;
        bh=hDuSHjxenn8MLr0Lu3xlgLqoL1ch8u4nZ+J/jAsn3kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDue3FJlaoe2JpGsmoQ/8lwQzG1x18lXdaypCpEii1H4Pkef7Rdto0ImKCchoJdnr
         VBPRHj7HCpepEbWctJRD0RmXpJ3vEw/VPy/q/zUF51B5g2tyiFIbOMRXyxUhgXQlx3
         2pUjxJpwlluW7/7YKVQBHzpaIBpiMIW/+dUX8QuY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 52/75] perf top: Set the 'session_done' volatile variable when exiting
Date:   Thu,  6 Dec 2018 18:25:39 -0300
Message-Id: <20181206212602.20474-53-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So we can get out of hist processing ASAP on user request.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-r8aufbgbixr2f85s3wcoaw9v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aad58643102e..50ec01eb7f57 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -577,6 +577,12 @@ static void perf_top__sort_new_samples(void *arg)
 	perf_top__reset_sample_counters(t);
 }
 
+static void stop_top(void)
+{
+	session_done = 1;
+	done = 1;
+}
+
 static void *display_thread_tui(void *arg)
 {
 	struct perf_evsel *pos;
@@ -613,13 +619,13 @@ static void *display_thread_tui(void *arg)
 				      !top->record_opts.overwrite,
 				      &top->annotation_opts);
 
-	done = 1;
+	stop_top();
 	return NULL;
 }
 
 static void display_sig(int sig __maybe_unused)
 {
-	done = 1;
+	stop_top();
 }
 
 static void display_setup_sig(void)
@@ -672,7 +678,7 @@ static void *display_thread(void *arg)
 
 			if (perf_top__handle_keypress(top, c))
 				goto repeat;
-			done = 1;
+			stop_top();
 		}
 	}
 
-- 
2.19.2


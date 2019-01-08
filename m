Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F650C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC33218AD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977608;
	bh=no484zRzu9nULAp4N6/jBVNYsm18nKPChYAth/YtqcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o0Rh3c16qZCz56r9rGPyWCpEQipeG4aGlyeI3SbX+hXnTucl21qBpq5/IACUJJt02
	 GUx7MXa0EArhfAzvsdWtgT9G1ca/SEl9bIM6eQhhlL0F32n0onadHm3KEh0XzoMm1F
	 ZpFwF2KF4XSuLWwquTtOnGO8M4W0bX2z0wpForDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733054AbfAHUAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:57072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731188AbfAHUAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:00:03 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1AFA218A1;
        Tue,  8 Jan 2019 20:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977603;
        bh=no484zRzu9nULAp4N6/jBVNYsm18nKPChYAth/YtqcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=behVbBhSlC1ojhU4u2qKl8Gq5hbsMIAuDlcuHhYCaAnpwO4vVZ26meynNoEvL++wx
         IDr31BsWiy6FvM2FRudtqZx+ApsaJm2lFy3fotQ4Se6WnBCFMJpJH1Dg29dV18Kn7n
         5Xa+5gFHAkch7yXLYwt2IrLZQgP8Ii4HhcQVHkbA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 12/16] perf top: Lift restriction on using callchains without "sym" in --sort
Date:   Tue,  8 Jan 2019 16:59:06 -0300
Message-Id: <20190108195910.17726-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This restriction is not present in 'perf report' and since 'perf top'
uses the same hists browser, remove it from it as well.

With this we create per event buckets with callchain trees, so that

  # perf top --sort dso -g --no-children

Bucketizes samples by DSO and below it shows the callchains leading to
functions in this DSO.

Try also:

  # perf top -e sched:*switch -g --no-children

To see the callchains leading to sched switches, pressing 'E' to expand
all one can quickly see the most common scheduler switches and what
leads to them, for instance, calls to IO, futexes, etc.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190107140854.GA28965@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fe3ecfb2e64b..f64e312db787 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1028,12 +1028,7 @@ static int perf_top__start_counters(struct perf_top *top)
 
 static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 {
-	if (!perf_hpp_list.sym) {
-		if (callchain->enabled) {
-			ui__error("Selected -g but \"sym\" not present in --sort/-s.");
-			return -EINVAL;
-		}
-	} else if (callchain->mode != CHAIN_NONE) {
+	if (callchain->mode != CHAIN_NONE) {
 		if (callchain_register_param(callchain) < 0) {
 			ui__error("Can't register callchain params.\n");
 			return -EINVAL;
-- 
2.20.1


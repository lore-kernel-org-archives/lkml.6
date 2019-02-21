Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B252084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfBUMXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:23:12 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:48598 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726113AbfBUMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:23:12 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444tsp3631z8tpf;
        Thu, 21 Feb 2019 13:23:10 +0100 (CET)
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.18.64
Received: from fau.de (faustud-010-021-018-064.pool.uni-erlangen.de [10.21.18.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19/pJ2rqRpTBMZ1NcUXJ15Nc2/OxnsLyxg=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444tsm2Xsbz8sf8;
        Thu, 21 Feb 2019 13:23:08 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH] perf hist: fix memory leak if histogram entry is reused
Date:   Thu, 21 Feb 2019 13:23:06 +0100
Message-Id: <20190221122306.1511-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __hists__add_entry the srcline of the addr_location is duplicated
for the hist_entry. If hists__findnew_entry returns an already existing
hist_entry the srcline has to be freed again as no further reference to
that duplicated srcline would exists anymore.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/hist.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8aad8330e392..25b8dbdbbe87 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -623,6 +623,9 @@ __hists__add_entry(struct hists *hists,
 		.ops = ops,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
+	if (he && he->srcline != entry.srcline)
+		free(entry.srcline);
+
 	if (!hists->has_callchains && he && he->callchain_size != 0)
 		hists->has_callchains = true;
 	return he;
-- 
2.19.2


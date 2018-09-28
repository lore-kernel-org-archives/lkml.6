Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B48C004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5652172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wfKIz107"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5652172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbeI1St0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeI1St0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:49:26 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901A42173D;
        Fri, 28 Sep 2018 12:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538137553;
        bh=KjMvULOO9h+uJhGt6ealqI6Tj2i85PhN57W9xKqnHy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wfKIz107Ar/JXEXKwylekEnoG3Dn8grb6KCPoqtWj4VbA+WMK7J6DThxIwhvkstLS
         N9lh1xzsY+SvQZUxMa4WEkxeNguhVs6hSmI+k2kDne4do3R8B0F121yeKcnlagyzWi
         RGD2iCYdda6JGqy76hJhyR/cCbYzmXLgE+at09Lw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/6] perf script python: Fix export-to-sqlite.py sample columns
Date:   Fri, 28 Sep 2018 09:25:35 -0300
Message-Id: <20180928122539.29326-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180928122539.29326-1-acme@kernel.org>
References: <20180928122539.29326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

With the "branches" export option, not all sample columns are exported.
However the unwanted columns are not at the end of the tuple, as assumed
by the code. Fix by taking the first 15 and last 3 values, instead of
the first 18.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180911114504.28516-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/export-to-sqlite.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/export-to-sqlite.py b/tools/perf/scripts/python/export-to-sqlite.py
index f827bf77e9d2..e4bb82c8aba9 100644
--- a/tools/perf/scripts/python/export-to-sqlite.py
+++ b/tools/perf/scripts/python/export-to-sqlite.py
@@ -440,7 +440,11 @@ def branch_type_table(*x):
 
 def sample_table(*x):
 	if branches:
-		bind_exec(sample_query, 18, x)
+		for xx in x[0:15]:
+			sample_query.addBindValue(str(xx))
+		for xx in x[19:22]:
+			sample_query.addBindValue(str(xx))
+		do_query_(sample_query)
 	else:
 		bind_exec(sample_query, 22, x)
 
-- 
2.14.4


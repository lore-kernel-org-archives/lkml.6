Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859DDC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6F0213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg6v5DTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6F0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeJEXJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:09:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:09:52 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF3E4208E7;
        Fri,  5 Oct 2018 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538755830;
        bh=KjMvULOO9h+uJhGt6ealqI6Tj2i85PhN57W9xKqnHy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eg6v5DTHZOnz24yf2OVGj9cEsM2Gl4Nzj1V3ZEyoyI6ZGOuO2VEBcVSqtB6MmVaQw
         i1AsVA2st6A+WSETd+8xKDA+QmLvUoeTE4y52f5dK9trvj4YoVtNpx7Gv3GOKi+S/M
         Y0ODPtc6SC8G4gmSGrDE4FGqwVuxkMSYhIAEic0Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf script python: Fix export-to-sqlite.py sample columns
Date:   Fri,  5 Oct 2018 13:10:09 -0300
Message-Id: <20181005161012.18475-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181005161012.18475-1-acme@kernel.org>
References: <20181005161012.18475-1-acme@kernel.org>
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


Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D628C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3BB218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170907;
	bh=3NGSXHh4t7q77uVGjJyaxfie2RxmWZgduGacaAcSQLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m5C+G/mvIrrwJHzhYzaBig+RuzV8LAYi1k+1JbbFlvUGY0ZAd1RzoSqNN+G/xlH2D
	 OK8K4PUCtg1DJ66JFfmhRF1aYy1krQSHIzTC80YfT9epkOtAcwnYQphvjoHYapb9GQ
	 cPevV78Y76Ux2XiF+o2fTl+91qmuVsFEq9K5qljI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeLRWI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbeLRWIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:25 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9BF218A4;
        Tue, 18 Dec 2018 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170904;
        bh=3NGSXHh4t7q77uVGjJyaxfie2RxmWZgduGacaAcSQLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U7TzbMl1+BNL1sdTVCHCOabG3QCaXNFQt7rViDPV9UoDJbtxi9mlft5NKu2A7m5TF
         ZGtgowvXz9O6YQ7RwxYnGpp1DLAibML7L7D+cKmgBTBBkiI/32EtXSIJOS/d18EqJi
         pgUxm0PxE3KUb3wdCfDrbdo/gmP/iFqyXpZwmG2g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/63] perf auxtrace: Alter addr_filter__entire_dso() to work if there are no symbols
Date:   Tue, 18 Dec 2018 19:06:32 -0300
Message-Id: <20181218220733.15839-3-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

addr_filter__entire_dso() uses the first and last symbols from a dso,
and so does not work when there are no symbols.  Alter it to filter the
whole file instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
Link: http://lkml.kernel.org/r/20181127084634.12469-1-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72d5ba2479bf..f69961c4a4f3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1983,17 +1983,14 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 
 static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
 {
-	struct symbol *first_sym = dso__first_symbol(dso);
-	struct symbol *last_sym = dso__last_symbol(dso);
-
-	if (!first_sym || !last_sym) {
-		pr_err("Failed to determine filter for %s\nNo symbols found.\n",
+	if (dso__data_file_size(dso, NULL)) {
+		pr_err("Failed to determine filter for %s\nCannot determine file size.\n",
 		       filt->filename);
 		return -EINVAL;
 	}
 
-	filt->addr = first_sym->start;
-	filt->size = last_sym->end - first_sym->start;
+	filt->addr = 0;
+	filt->size = dso->data.file_size;
 
 	return 0;
 }
-- 
2.19.2


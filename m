Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31610C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B672146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B672146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeK3RLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:11:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:37819 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeK3RLg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:11:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 22:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,297,1539673200"; 
   d="scan'208";a="114083857"
Received: from skl.sh.intel.com ([10.239.161.125])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 22:03:25 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 2/4] perf annotate: Create a annotate2 flag in struct symbol
Date:   Fri, 30 Nov 2018 21:54:55 +0800
Message-Id: <1543586097-27632-3-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
References: <1543586097-27632-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We often use the symbol__annotate2() to annotate a specified symbol.
While annotating may take some time, so in order to avoid annotating
the same symbol repeatedly, the patch creates a new flag to indicate
the symbol has been annotated.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/annotate.c | 1 +
 tools/perf/util/symbol.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4b2b1b0..f69d8e1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2798,6 +2798,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	notes->nr_events = nr_pcnt;
 
 	annotation__update_column_widths(notes);
+	sym->annotate2 = true;
 
 	return 0;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d026d21..14d9d43 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -63,6 +63,7 @@ struct symbol {
 	u8		ignore:1;
 	u8		inlined:1;
 	u8		arch_sym;
+	bool		annotate2;
 	char		name[0];
 };
 
-- 
2.7.4


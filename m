Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BA2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612102084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfBUQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:07:21 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:36750 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbfBUQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:07:17 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444zrM23BLz1xsG;
        Thu, 21 Feb 2019 17:07:15 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.5.153
Received: from fau.de (faustud-010-021-005-153.pool.uni-erlangen.de [10.21.5.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19Oltf4og8Jup/A9kX/V4gmm9GS6dBr66U=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444zrJ5NLhz20Wd;
        Thu, 21 Feb 2019 17:07:12 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Gardner <rob.gardner@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 2/3] perf machine: use map__inlines in append_inlines
Date:   Thu, 21 Feb 2019 17:06:51 +0100
Message-Id: <20190221160652.1788-3-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch provides a generic way to lookup the root node of the
inlined symbols for a specific address. Reuse that implementation
instead of a duplicated version of the required steps.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/machine.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 143f7057d581..dce29c21e4ea 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2330,23 +2330,12 @@ static int append_inlines(struct callchain_cursor *cursor,
 {
 	struct inline_node *inline_node;
 	struct inline_list *ilist;
-	u64 addr;
 	int ret = 1;
 
-	if (!symbol_conf.inline_name || !map || !sym)
+	inline_node = map__inlines(map, ip, sym);
+	if (!inline_node)
 		return ret;
 
-	addr = map__map_ip(map, ip);
-	addr = map__rip_2objdump(map, addr);
-
-	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
-	if (!inline_node) {
-		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
-		if (!inline_node)
-			return ret;
-		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
-	}
-
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		ret = callchain_cursor_append(cursor, ip, map,
 					      ilist->symbol, false,
-- 
2.19.2


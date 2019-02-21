Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4421AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C11C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfBUQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:07:15 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:59808 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbfBUQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:07:14 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 444zrJ5NDVz20Wc;
        Thu, 21 Feb 2019 17:07:12 +0100 (CET)
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.21.5.153
Received: from fau.de (faustud-010-021-005-153.pool.uni-erlangen.de [10.21.5.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+vfbUDDE6dRkik2bxziMFt0V7b3jgl1bY=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 444zrG1JC9z20WN;
        Thu, 21 Feb 2019 17:07:10 +0100 (CET)
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
Subject: [PATCH 1/3] perf map: add function to lookup inline symbols
Date:   Thu, 21 Feb 2019 17:06:50 +0100
Message-Id: <20190221160652.1788-2-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
References: <20190221160652.1788-1-jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inlined symbols should always be added to the dso's inlined_nodes tree
in order to reuse them for a later lookup for the same address. Instead
of repeating those steps at the different users, provide a central
method to lookup and register inline symbols for a map.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 tools/perf/util/map.c | 23 +++++++++++++++++++++++
 tools/perf/util/map.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6751301a755c..0fe74e83ca8d 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -988,3 +988,26 @@ struct map_groups *map__kmaps(struct map *map)
 	}
 	return kmap->kmaps;
 }
+
+struct inline_node *map__inlines(struct map *map, u64 addr, struct symbol *sym)
+{
+	struct inline_node *node;
+
+	if (!symbol_conf.inline_name)
+		return NULL;
+
+	if (!map->dso)
+		return NULL;
+
+	addr = map->map_ip(map, addr);
+	addr = map__rip_2objdump(map, addr);
+
+	node = inlines__tree_find(&map->dso->inlined_nodes, addr);
+	if (node)
+		return node;
+
+	node = dso__parse_addr_inlines(map->dso, addr, sym);
+	if (node)
+		inlines__tree_insert(&map->dso->inlined_nodes, node);
+	return node;
+}
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 09282aa45c80..bdcc6e77e26e 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -270,4 +270,7 @@ static inline bool is_entry_trampoline(const char *name)
 	return !strcmp(name, ENTRY_TRAMPOLINE_NAME);
 }
 
+struct inline_node *map__inlines(struct map *map, u64 addr,
+				 struct symbol *sym);
+
 #endif /* __PERF_MAP_H */
-- 
2.19.2


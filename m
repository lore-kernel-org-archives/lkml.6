Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159D5C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E606420821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfAIJUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:20:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:13930 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbfAIJUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:20:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:20:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="105163016"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.56])
  by orsmga007.jf.intel.com with ESMTP; 09 Jan 2019 01:20:13 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] perf tools: Fix split_kallsyms_for_kcore for trampoline symbols
Date:   Wed,  9 Jan 2019 11:18:30 +0200
Message-Id: <20190109091835.5570-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109091835.5570-1-adrian.hunter@intel.com>
References: <20190109091835.5570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kallsyms symbols do not have a size, so the size becomes the distance to
the next symbol. Consequently the recently added trampoline symbols end up
with large sizes because the trampolines are some distance from one another
and the main kernel map. However, symbols that end outside their map can
disrupt the symbol tree because, after mapping, it can appear incorrectly
that they overlap other symbols. Add logic to truncate symbol size to the
end of the corresponding map.

Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 01f2c7385e38..baf6498d1835 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -709,6 +709,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		}
 
 		pos->start -= curr_map->start - curr_map->pgoff;
+		if (pos->end > curr_map->end)
+			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
 		symbols__insert(&curr_map->dso->symbols, pos);
-- 
2.17.1


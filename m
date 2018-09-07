Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656BBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C53D2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C53D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeIGNc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:32:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:61320 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbeIGNc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:32:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 01:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="83865380"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by fmsmga002.fm.intel.com with ESMTP; 07 Sep 2018 01:52:58 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] perf tools: Fix maps__find_symbol_by_name()
Date:   Fri,  7 Sep 2018 11:51:16 +0300
Message-Id: <20180907085116.25782-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry
trampolines") revealed a problem with maps__find_symbol_by_name() that
resulted in probes not being found e.g.

	$ sudo perf probe xsk_mmap
	xsk_mmap is out of .text, skip it.
	Probe point 'xsk_mmap' not found.
	   Error: Failed to add events.

maps__find_symbol_by_name() can optionally return the map of the found
symbol. It can get the map wrong because, in fact, the symbol is found
on the map's dso, not allowing for the possibility that the dso has more
than one map. Fix by always checking the map contains the symbol.

Reported-by: Björn Töpel <bjorn.topel@intel.com>
Tested-by: Björn Töpel <bjorn.topel@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Expanded commit message
	Corrected email address


 tools/perf/util/map.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 3f07a587c8e6..354e54550d2b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -574,6 +574,13 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
 	return NULL;
 }
 
+static bool map__contains_symbol(struct map *map, struct symbol *sym)
+{
+	u64 ip = map->unmap_ip(map, sym->start);
+
+	return ip >= map->start && ip < map->end;
+}
+
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 					 struct map **mapp)
 {
@@ -589,6 +596,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 
 		if (sym == NULL)
 			continue;
+		if (!map__contains_symbol(pos, sym)) {
+			sym = NULL;
+			continue;
+		}
 		if (mapp != NULL)
 			*mapp = pos;
 		goto out;
-- 
2.17.1


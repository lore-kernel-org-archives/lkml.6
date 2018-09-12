Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C945C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DB22146D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 18:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNZwy8PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DB22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIMABp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:01:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbeIMABp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:01:45 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CF5D2146D;
        Wed, 12 Sep 2018 18:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536778553;
        bh=H9S9vICc8pKf1RhFwtN/rUEBEbOiiQ0ToGGNjRE0TuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UNZwy8PG3bJuqik8CYXSNeJyc8e1F+ym3wFSNeOviOmNGgaCPNfNkvfppP2QxkJuD
         579h6bR+7k3oKPw7q9lzBtBguGeQMwBPlt/D2ty/zBQSYWSJI9TPyJ+ei+y324hqmY
         lYKwYqaRKsQ6RGFfWkP3LXggzyV6EAHpuRVbV7xg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 7/7] perf tools: Fix maps__find_symbol_by_name()
Date:   Wed, 12 Sep 2018 15:55:09 -0300
Message-Id: <20180912185509.32187-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180912185509.32187-1-acme@kernel.org>
References: <20180912185509.32187-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Björn Töpel <bjorn.topel@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry trampolines")
Link: http://lkml.kernel.org/r/20180907085116.25782-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 36d0763311ef..6a6929f208b4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -576,6 +576,13 @@ struct symbol *map_groups__find_symbol(struct map_groups *mg,
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
@@ -591,6 +598,10 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
 
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
2.14.4


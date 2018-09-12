Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D205C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78BF20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78BF20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeIMA2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:28:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeIMA2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:28:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8CJMAFU2744408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Sep 2018 12:22:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8CJMAUH2744405;
        Wed, 12 Sep 2018 12:22:10 -0700
Date:   Wed, 12 Sep 2018 12:22:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-03db8b583d1c3c84963e08e2abf6c79081da5c31@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        jolsa@redhat.com, hpa@zytor.com, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, jolsa@redhat.com,
          bjorn.topel@intel.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20180907085116.25782-1-adrian.hunter@intel.com>
References: <20180907085116.25782-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix maps__find_symbol_by_name()
Git-Commit-ID: 03db8b583d1c3c84963e08e2abf6c79081da5c31
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  03db8b583d1c3c84963e08e2abf6c79081da5c31
Gitweb:     https://git.kernel.org/tip/03db8b583d1c3c84963e08e2abf6c79081da5c31
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Fri, 7 Sep 2018 11:51:16 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Sep 2018 14:12:51 -0300

perf tools: Fix maps__find_symbol_by_name()

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

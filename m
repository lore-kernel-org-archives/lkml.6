Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26C1ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999DB2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 999DB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbeIXSkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:40:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58758 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388284AbeIXSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:40:40 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0CBF31092;
        Mon, 24 Sep 2018 12:38:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.18 139/235] perf tools: Fix maps__find_symbol_by_name()
Date:   Mon, 24 Sep 2018 13:52:05 +0200
Message-Id: <20180924113119.586592620@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Hunter <adrian.hunter@intel.com>

commit 03db8b583d1c3c84963e08e2abf6c79081da5c31 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/map.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -590,6 +590,13 @@ struct symbol *map_groups__find_symbol(s
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
@@ -605,6 +612,10 @@ struct symbol *maps__find_symbol_by_name
 
 		if (sym == NULL)
 			continue;
+		if (!map__contains_symbol(pos, sym)) {
+			sym = NULL;
+			continue;
+		}
 		if (mapp != NULL)
 			*mapp = pos;
 		goto out;



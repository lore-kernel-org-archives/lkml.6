Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB21C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D75F2174E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wrVNc42o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D75F2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeI1Stc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeI1Stb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:49:31 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858ED2170E;
        Fri, 28 Sep 2018 12:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538137558;
        bh=68RrylPgXeMWF5trrFSYoBU1ZfDLjti2LFeDoXkznes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrVNc42otQsZ7Igugkkp/tz/OFb/tFeztKRCxkZMZO6snL1ieBtmUVhs7wFfzpUnk
         mE7q9pJCCEtdGMm9vJoKSBRLIs+8qOqBCMbd9gMVLv+Aw504K45z3yO414RoJyX580
         eDpmtdFuho8Tnu+xJFkT/K4uTmg8vkqnRqA4xdFI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/6] perf report: Use the offset address to find inline frames
Date:   Fri, 28 Sep 2018 09:25:37 -0300
Message-Id: <20180928122539.29326-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180928122539.29326-1-acme@kernel.org>
References: <20180928122539.29326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

To correctly find inlined frames, we have to use the file offset instead
of the virtual memory address. This was already fixed for displaying
srcline information while displaying in commit 2a9d5050dc84fa20 ("perf
script: Show correct offsets for DWARF-based unwinding"). We just need
to use the same corrected address also when trying to find inline
frames.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cb4f8bf3ca7..73a651f10a0f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2317,9 +2317,6 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
 
-	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
-		return 0;
-
 	/*
 	 * Convert entry->ip from a virtual address to an offset in
 	 * its corresponding binary.
@@ -2327,6 +2324,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (entry->map)
 		addr = map__map_ip(entry->map, entry->ip);
 
+	if (append_inlines(cursor, entry->map, entry->sym, addr) == 0)
+		return 0;
+
 	srcline = callchain_srcline(entry->map, entry->sym, addr);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-- 
2.14.4


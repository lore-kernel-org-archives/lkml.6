Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0131EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D77218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479109;
	bh=2T+q5ZtG1CYW34drAF3kz4ggFF8j9nDsCq+TD124334=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y7kBSyt1ySPo7LXSrlzoaZvRLvMfUFTOdxX2pK5FUtExdx5tVBIFXpCbsuO2fQkKv
	 a4vvzGMxL6Rdds9YX371SdDDtdsO1cXoL3TLO5CouegwhRsWQQuo/70bElViRKJaZo
	 FNv7DNfc4Wa9WVt3/7RyMW79BNygXsLX7tWzIW1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbfBFSvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbfBFSvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:51:44 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD4E206DD;
        Wed,  6 Feb 2019 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479104;
        bh=2T+q5ZtG1CYW34drAF3kz4ggFF8j9nDsCq+TD124334=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QKZmPEyEtIorhkPJPkvQRbF9sKtwC/69Xm8oKPgwworxESmWNi+mNXO5MAMpRVeqB
         TmlZzsSZm44t3zdv8km4WaGR5CKPIBJiExrQtLGlffnO0nKd8riDitdlpXmoeiR0Fn
         CeaYVjfcB9TvpkjiZ2+uQ0pGebjMC20cL/T22Sko=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 45/53] perf tools: Fix split_kallsyms_for_kcore() for trampoline symbols
Date:   Wed,  6 Feb 2019 15:48:55 -0300
Message-Id: <20190206184903.24054-46-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Kallsyms symbols do not have a size, so the size becomes the distance to
the next symbol.

Consequently the recently added trampoline symbols end up with large
sizes because the trampolines are some distance from one another and the
main kernel map.

However, symbols that end outside their map can disrupt the symbol tree
because, after mapping, it can appear incorrectly that they overlap
other symbols.

Add logic to truncate symbol size to the end of the corresponding map.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: stable@vger.kernel.org
Fixes: d83212d5dd67 ("kallsyms, x86: Export addresses of PTI entry trampolines")
Link: http://lkml.kernel.org/r/20190109091835.5570-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 7b194cf53cc0..758bf5f74e6e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -718,6 +718,8 @@ static int map_groups__split_kallsyms_for_kcore(struct map_groups *kmaps, struct
 		}
 
 		pos->start -= curr_map->start - curr_map->pgoff;
+		if (pos->end > curr_map->end)
+			pos->end = curr_map->end;
 		if (pos->end)
 			pos->end -= curr_map->start - curr_map->pgoff;
 		symbols__insert(&curr_map->dso->symbols, pos);
-- 
2.20.1


Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0A0C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B082088F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgRRB+YL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B082088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeJVShi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeJVShh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:37 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094062087D;
        Mon, 22 Oct 2018 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203582;
        bh=fMyYOH+/W7FJeY5W8+3+idTit0MTRoUXmWxTqWAtE2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgRRB+YLzrMNsjDnxWd4OWFWzph+LCSqZLV0C+wpKPEXSfSOIMz03Co3wK0JgYENQ
         Lti1ZM1ompM9jUSwKLxdvK9+2lrKnCDRVWfgtoBEVnzTuEkTXb246kkJtdCicaPbIU
         dmmOwOZFthz2CUAMIiufJOPMNykQjYIjCdQH8mG4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 07/27] perf record: Use unmapped IP for inline callchain cursors
Date:   Mon, 22 Oct 2018 06:19:04 -0400
Message-Id: <20181022101924.40531-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

[ Upstream commit 7a8a8fcf7b860e4b2d4edc787c844d41cad9dfcf ]

Only use the mapped IP to find inline frames, but keep using the
unmapped IP for the callchain cursor. This ensures we properly show the
unmapped IP when displaying a frame we received via the
dso__parse_addr_inlines API for a module which does not contain
sufficient debug symbols to show the srcline.

This is another follow-up to commit 19610184693c ("perf script: Show
virtual addresses instead of offsets").

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sandipan Das <sandipan@linux.ibm.com>
Fixes: 19610184693c ("perf script: Show virtual addresses instead of offsets")
Link: http://lkml.kernel.org/r/20180926135207.30263-2-milian.wolff@kdab.com
Link: http://lkml.kernel.org/r/20181002073949.3297-1-milian.wolff@kdab.com
[ Squashed a fix from Milian for a problem reported by Ravi, fixed up space damage ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d49744dc46d7..b70cce40ca97 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2246,7 +2246,8 @@ static int append_inlines(struct callchain_cursor *cursor,
 	if (!symbol_conf.inline_name || !map || !sym)
 		return ret;
 
-	addr = map__rip_2objdump(map, ip);
+	addr = map__map_ip(map, ip);
+	addr = map__rip_2objdump(map, addr);
 
 	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
 	if (!inline_node) {
-- 
2.17.1


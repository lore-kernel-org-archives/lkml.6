Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14143C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A552082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131835;
	bh=0SoERqmIj2WdHgasbAEV+QJUOaeaYL6Q446XGMax03c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OfZPuZjIpO7JqpBOfWG1JuBUbfgXOaepJniGzBgqGDTNFjNfaG3tfFUGYHM4dsM4w
	 jAQeL95Yd4hpEYYLGnvNUARA07AVg9oLF5BUbqBEtfnxFQJlFexed6Ieh+3sfBdUhw
	 yelMPQvZyNSUK1TtPDSgdoaQjrMeEkt94wR5b+fo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A552082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbeLFVae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbeLFVab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:31 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01D6520989;
        Thu,  6 Dec 2018 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131830;
        bh=0SoERqmIj2WdHgasbAEV+QJUOaeaYL6Q446XGMax03c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuOa0vDfFT0pVwrsxFy1r5R/EjSUm+cEAPGt6k3EooeAUSk3dzlVbDFjqrI83hhii
         fA2WPCwZ5vScJZ3aA2pAOfdaPyUqIXHk7i1V1DLHbLfPaM+Vqc0pW1nX1Wax2bIzeJ
         HF9yxP4SN8fkDoi/sxYAG/HXuF8Cm+Rdmi8Nyxng=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 61/75] perf header: Fix unchecked usage of strncpy()
Date:   Thu,  6 Dec 2018 18:25:48 -0300
Message-Id: <20181206212602.20474-62-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/header.c: In function 'perf_event__synthesize_event_update_unit':
  util/header.c:3586:2: error: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
    strncpy(ev->data, evsel->unit, size);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  util/header.c:3579:16: note: length computed here
    size_t size = strlen(evsel->unit);
                  ^~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: a6e5281780d1 ("perf tools: Add event_update event unit type")
Link: https://lkml.kernel.org/n/tip-fiikh5nay70bv4zskw2aa858@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4a64739c67e7..c87cfe6b7c96 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3583,7 +3583,7 @@ perf_event__synthesize_event_update_unit(struct perf_tool *tool,
 	if (ev == NULL)
 		return -ENOMEM;
 
-	strncpy(ev->data, evsel->unit, size);
+	strlcpy(ev->data, evsel->unit, size + 1);
 	err = process(tool, (union perf_event *)ev, NULL, NULL);
 	free(ev);
 	return err;
-- 
2.19.2


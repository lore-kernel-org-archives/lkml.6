Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E76AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA02621901
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358092;
	bh=Yz/cLXw5EhR4DD7EF1P7261FH+H1cfIGwot7oSRZc7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qady6JCu08+iBaunhK6UO3033bEgsOQTyWs8yfkhCquyzivaRYwvg1AiZr6g/hl5I
	 RrBJMF2j0qeppAD7hKMe0xwGzZwbITDEwYISbSbF1593QS9Sr+xdymIfCOxcnbfIXx
	 dl10FbYGTPN+8MowmJsEt+B/+bcEcIBLe2Oq151Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfAXT2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:28:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730879AbfAXT2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08C97218A6;
        Thu, 24 Jan 2019 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358086;
        bh=Yz/cLXw5EhR4DD7EF1P7261FH+H1cfIGwot7oSRZc7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TD4T7DNZKQpaCPbdRagsz1k2l+8mOlAOInKy4djSbfObEHDUaWDVT5X4Sx8u6tBS+
         wtMrSPhS4QfdKceCATF3xPMy3V11D77B8DF37SmfdSEu6qiEqcHAsut2hKLAb8ht8p
         QxwB680h3RuHYl40parsp+Dmj+xTZkt3Tnz1QwJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 094/104] perf parse-events: Fix unchecked usage of strncpy()
Date:   Thu, 24 Jan 2019 20:20:23 +0100
Message-Id: <20190124190205.195533193@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bd8d57fb7e25e9fcf67a9eef5fa13aabe2016e07 ]

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/parse-events.c: In function 'print_symbol_events':
  util/parse-events.c:2465:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy(name, syms->symbol, MAX_NAME_LEN);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In function 'print_symbol_events.constprop',
      inlined from 'print_events' at util/parse-events.c:2508:2:
  util/parse-events.c:2465:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy(name, syms->symbol, MAX_NAME_LEN);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In function 'print_symbol_events.constprop',
      inlined from 'print_events' at util/parse-events.c:2511:2:
  util/parse-events.c:2465:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
      strncpy(name, syms->symbol, MAX_NAME_LEN);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 947b4ad1d198 ("perf list: Fix max event string size")
Link: https://lkml.kernel.org/n/tip-b663e33bm6x8hrkie4uxh7u2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e81dfb2e239c..9351738df703 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1903,7 +1903,7 @@ restart:
 		if (!name_only && strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strncpy(name, syms->symbol, MAX_NAME_LEN);
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
 
 		evt_list[evt_i] = strdup(name);
 		if (evt_list[evt_i] == NULL)
-- 
2.19.1




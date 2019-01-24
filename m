Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B3DC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ABA218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358961;
	bh=FUw81VkmLDpyGq3CQDJ/DGapgUNeBr8hcO+bMuW6DM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sX0CbBSOSsrc0ZKmmNzqRya6Equ0auO0YE3y3ScBZF2SozhADP0nWtXJRP8uspaXR
	 kHMla/A6H5rbPD3wE54hHDhx+0YofxyxssBxOwcEpEyspkWxVCz6rcfiRQIriTpiYw
	 KeEkJA1BU6RliRLR9YvAw8qrHb1Xf+dV1r6aScFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfAXTmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733117AbfAXTmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:42:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 843D5218D9;
        Thu, 24 Jan 2019 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358955;
        bh=FUw81VkmLDpyGq3CQDJ/DGapgUNeBr8hcO+bMuW6DM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DdRYQl26WNiD6YpfJAofUDM59CuXL0Fkf5asFFlIknMwQ8WAEGIjv5wvjG/co3u2r
         uUeXbNOEwdfBW0XM6cMzMzYKZJ+NZWKx5+NhTgohAifwRk2hve/aCSu+M80pT5uA4r
         MfBJ4IF45U65oSHonQZlhWS7Hat2i7/Z3FixW/3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 086/127] perf parse-events: Fix unchecked usage of strncpy()
Date:   Thu, 24 Jan 2019 20:20:32 +0100
Message-Id: <20190124190215.748969903@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 59be3466d64d..920e1e6551dd 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2462,7 +2462,7 @@ restart:
 		if (!name_only && strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strncpy(name, syms->symbol, MAX_NAME_LEN);
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
 
 		evt_list[evt_i] = strdup(name);
 		if (evt_list[evt_i] == NULL)
-- 
2.19.1




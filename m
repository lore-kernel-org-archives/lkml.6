Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0736CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD8120645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976123;
	bh=682JroHyYVfmz3a6lhab9D+BI6LzhBG2ApdMCKC8Hhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=raXMGz7zQGE5/+beJQg8FsVCtyqXXXVQitw/eysSc89UOuMROR4iMBvVbU374ZAD1
	 VyesSb2b8HzIuFh2WWnxc6n/aN0UFAvOXG98OjQ0FgZWpW4upK1QU53Oc/3QBId2Vv
	 eiYBAr+8heHIqHhd0AVUZ8NexsJTH0NrKmbiQHp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfAHTfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:35:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732241AbfAHTfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:35:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9AE2063F;
        Tue,  8 Jan 2019 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976118;
        bh=682JroHyYVfmz3a6lhab9D+BI6LzhBG2ApdMCKC8Hhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzYwsI4gZFSMXe3zSMIIn8Y0dZgd2ZRPlLBZdhQkuF4dGBULIKpz+k8cpDprokLos
         dKnSToLCs9+cqhjzPFshoPxBHmclVOC8DKabEzNI+qSegis0PxoGB+k5voXS6oX4OF
         1yCHosdia9YM/FXRV/XuMc16hQ9LWSZD/2ndQf3A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 20/28] perf parse-events: Fix unchecked usage of strncpy()
Date:   Tue,  8 Jan 2019 14:34:37 -0500
Message-Id: <20190108193445.124251-20-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193445.124251-1-sashal@kernel.org>
References: <20190108193445.124251-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
@@ -1903,7 +1903,7 @@ void print_symbol_events(const char *event_glob, unsigned type,
 		if (!name_only && strlen(syms->alias))
 			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms->symbol, syms->alias);
 		else
-			strncpy(name, syms->symbol, MAX_NAME_LEN);
+			strlcpy(name, syms->symbol, MAX_NAME_LEN);
 
 		evt_list[evt_i] = strdup(name);
 		if (evt_list[evt_i] == NULL)
-- 
2.19.1


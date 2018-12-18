Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B456C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244D821873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeLROYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:24:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42765 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeLROYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:24:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEO78B2857664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:24:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEO6mk2857661;
        Tue, 18 Dec 2018 06:24:06 -0800
Date:   Tue, 18 Dec 2018 06:24:06 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-l7n8ggc9kl38qtdlouke5yp5@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, masami.hiramatsu.pt@hitachi.com,
        mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          masami.hiramatsu.pt@hitachi.com, mingo@kernel.org,
          jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf probe: Fix unchecked usage of strncpy()
Git-Commit-ID: bef0b8970f27da5ca223e522a174d03e2587761d
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
Message-ID: <20181218142406.wJmxfYmIXdN02BUD8J6Zq7KURWLor6CU5-wqFvOuQOM@z>

Commit-ID:  bef0b8970f27da5ca223e522a174d03e2587761d
Gitweb:     https://git.kernel.org/tip/bef0b8970f27da5ca223e522a174d03e2587761d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Dec 2018 11:50:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:28 -0300

perf probe: Fix unchecked usage of strncpy()

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this case the 'target' buffer is coming from a list of build-ids that
are expected to have a len of at most (SBUILD_ID_SIZE - 1) chars, so
probably we're safe, but since we're using strncpy() here, use strlcpy()
instead to provide the intended safety checking without the using the
problematic strncpy() function.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  util/probe-file.c: In function 'probe_cache__open.isra.5':
  util/probe-file.c:427:3: error: 'strncpy' specified bound 41 equals destination size [-Werror=stringop-truncation]
     strncpy(sbuildid, target, SBUILD_ID_SIZE);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 1f3736c9c833 ("perf probe: Show all cached probes")
Link: https://lkml.kernel.org/n/tip-l7n8ggc9kl38qtdlouke5yp5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index aac7817d9e14..0b1195cad0e5 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -424,7 +424,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target,
 
 	if (target && build_id_cache__cached(target)) {
 		/* This is a cached buildid */
-		strncpy(sbuildid, target, SBUILD_ID_SIZE);
+		strlcpy(sbuildid, target, SBUILD_ID_SIZE);
 		dir_name = build_id_cache__linkname(sbuildid, NULL, 0);
 		goto found;
 	}

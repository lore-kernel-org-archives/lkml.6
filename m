Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA11C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6544217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeLROVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:21:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeLROVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:21:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEL8aZ2855778
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:21:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEL8aZ2855775;
        Tue, 18 Dec 2018 06:21:08 -0800
Date:   Tue, 18 Dec 2018 06:21:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-fiikh5nay70bv4zskw2aa858@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf header: Fix unchecked usage of strncpy()
Git-Commit-ID: 7572588085a13d5db02bf159542189f52fdb507e
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
Message-ID: <20181218142108.4w2w2jjV6bHy7qFk2tgW0n7sFkZYCdeOaHOyX1c7Spc@z>

Commit-ID:  7572588085a13d5db02bf159542189f52fdb507e
Gitweb:     https://git.kernel.org/tip/7572588085a13d5db02bf159542189f52fdb507e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Dec 2018 11:02:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:06 -0300

perf header: Fix unchecked usage of strncpy()

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

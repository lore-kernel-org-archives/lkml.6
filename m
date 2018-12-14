Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4927C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47AB206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbeLNUxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:53:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53845 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730831AbeLNUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:53:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKrZip1458721
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:53:35 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKrZe71458718;
        Fri, 14 Dec 2018 12:53:35 -0800
Date:   Fri, 14 Dec 2018 12:53:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tl2hdxj64tt4k8btbi6a0ugw@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, mingo@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf dso: Fix unchecked usage of strncpy()
Git-Commit-ID: 9e107dbd15d087a4879184b5cf3deacdc2faf903
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

Commit-ID:  9e107dbd15d087a4879184b5cf3deacdc2faf903
Gitweb:     https://git.kernel.org/tip/9e107dbd15d087a4879184b5cf3deacdc2faf903
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Dec 2018 10:49:46 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:35 -0300

perf dso: Fix unchecked usage of strncpy()

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  In function 'decompress_kmodule',
      inlined from 'dso__decompress_kmodule_fd' at util/dso.c:305:9:
  util/dso.c:298:3: error: 'strncpy' destination unchanged after copying no bytes [-Werror=stringop-truncation]
     strncpy(pathname, tmpbuf, len);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    CC       /tmp/build/perf/util/values.o
    CC       /tmp/build/perf/util/debug.o
  cc1: all warnings being treated as errors

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: c9a8a6131fb6 ("perf tools: Move the temp file processing into decompress_kmodule")
Link: https://lkml.kernel.org/n/tip-tl2hdxj64tt4k8btbi6a0ugw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index bbed90e5d9bb..cee717a3794f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -295,7 +295,7 @@ static int decompress_kmodule(struct dso *dso, const char *name,
 		unlink(tmpbuf);
 
 	if (pathname && (fd >= 0))
-		strncpy(pathname, tmpbuf, len);
+		strlcpy(pathname, tmpbuf, len);
 
 	return fd;
 }

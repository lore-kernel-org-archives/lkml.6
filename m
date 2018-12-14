Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE37C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16550208C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbeLNU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:59:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45205 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeLNU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:59:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKxN0n1459926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:59:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKxM0V1459922;
        Fri, 14 Dec 2018 12:59:22 -0800
Date:   Fri, 14 Dec 2018 12:59:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sihyeon Jang <tipbot@zytor.com>
Message-ID: <tip-63ac3b59f0fba922f98537ada06bc2528d1d2702@git.kernel.org>
Cc:     mingo@kernel.org, jolsa@kernel.org, uneedsihyeon@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        namhyung@kernel.org, hpa@zytor.com
Reply-To: jolsa@kernel.org, uneedsihyeon@gmail.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, namhyung@kernel.org, hpa@zytor.com
In-Reply-To: <20181201154603.10093-1-uneedsihyeon@gmail.com>
References: <20181201154603.10093-1-uneedsihyeon@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf config: Modify size factor of snprintf
Git-Commit-ID: 63ac3b59f0fba922f98537ada06bc2528d1d2702
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

Commit-ID:  63ac3b59f0fba922f98537ada06bc2528d1d2702
Gitweb:     https://git.kernel.org/tip/63ac3b59f0fba922f98537ada06bc2528d1d2702
Author:     Sihyeon Jang <uneedsihyeon@gmail.com>
AuthorDate: Sun, 2 Dec 2018 00:46:03 +0900
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 16:43:27 -0300

perf config: Modify size factor of snprintf

According to definition of snprintf, it gets size factor including
null('\0') byte.  So '-1' is not neccessary. Also it will be helpful
unfied style with other cases. (eg. builtin-script.c)

Signed-off-by: Sihyeon Jang <uneedsihyeon@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181201154603.10093-1-uneedsihyeon@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 3beb4cf44c31..1ea8f898f1a1 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -815,14 +815,14 @@ int config_error_nonbool(const char *var)
 void set_buildid_dir(const char *dir)
 {
 	if (dir)
-		scnprintf(buildid_dir, MAXPATHLEN-1, "%s", dir);
+		scnprintf(buildid_dir, MAXPATHLEN, "%s", dir);
 
 	/* default to $HOME/.debug */
 	if (buildid_dir[0] == '\0') {
 		char *home = getenv("HOME");
 
 		if (home) {
-			snprintf(buildid_dir, MAXPATHLEN-1, "%s/%s",
+			snprintf(buildid_dir, MAXPATHLEN, "%s/%s",
 				 home, DEBUG_CACHE_DIR);
 		} else {
 			strncpy(buildid_dir, DEBUG_CACHE_DIR, MAXPATHLEN-1);

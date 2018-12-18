Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B3CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092A0218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLROW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:22:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34569 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:22:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEMLRv2855868
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:22:21 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEMKBT2855865;
        Tue, 18 Dec 2018 06:22:20 -0800
Date:   Tue, 18 Dec 2018 06:22:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2f69l7drca427ob4km8i7kvo@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org,
          namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf help: Remove needless use of strncpy()
Git-Commit-ID: b6313899f4ed2e76b8375cf8069556f5b94fbff0
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
Message-ID: <20181218142220.wQyo4zNIeI-zELoAAiaRbqKWTXsz9vQh9KpKdHF-GQw@z>

Commit-ID:  b6313899f4ed2e76b8375cf8069556f5b94fbff0
Gitweb:     https://git.kernel.org/tip/b6313899f4ed2e76b8375cf8069556f5b94fbff0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Dec 2018 11:20:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:18 -0300

perf help: Remove needless use of strncpy()

Since we make sure the destination buffer has at least strlen(orig) + 1,
no need to do a strncpy(dest, orig, strlen(orig)), just use strcpy(dest,
orig).

This silences this gcc 8.2 warning on Alpine Linux:

  In function 'add_man_viewer',
      inlined from 'perf_help_config' at builtin-help.c:284:3:
  builtin-help.c:192:2: error: 'strncpy' output truncated before terminating nul copying as many bytes from a string as its length [-Werror=stringop-truncation]
    strncpy((*p)->name, name, len);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  builtin-help.c: In function 'perf_help_config':
  builtin-help.c:187:15: note: length computed here
    size_t len = strlen(name);
                 ^~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 078006012401 ("perf_counter tools: add in basic glue from Git")
Link: https://lkml.kernel.org/n/tip-2f69l7drca427ob4km8i7kvo@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 1c41b4eaf73c..3d29d0524a89 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -189,7 +189,7 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p = &((*p)->next);
 	*p = zalloc(sizeof(**p) + len + 1);
-	strncpy((*p)->name, name, len);
+	strcpy((*p)->name, name);
 }
 
 static int supported_man_viewer(const char *name, size_t len)

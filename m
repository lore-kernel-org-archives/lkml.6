Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDF9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF248217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbeLROXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:23:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:23:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEMuqe2855921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:22:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEMtMf2855918;
        Tue, 18 Dec 2018 06:22:55 -0800
Date:   Tue, 18 Dec 2018 06:22:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xzkoo0gyr56gej39ltivuh9g@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        arjan@linux.intel.com
Reply-To: acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, arjan@linux.intel.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf svghelper: Fix unchecked usage of strncpy()
Git-Commit-ID: 2f5302533f306d5ee87bd375aef9ca35b91762cb
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
Message-ID: <20181218142255.LIaMltXrGWfR67WvKLDSQHGSmAaKOB-m98d_3hTDdMM@z>

Commit-ID:  2f5302533f306d5ee87bd375aef9ca35b91762cb
Gitweb:     https://git.kernel.org/tip/2f5302533f306d5ee87bd375aef9ca35b91762cb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 6 Dec 2018 11:29:48 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:20 -0300

perf svghelper: Fix unchecked usage of strncpy()

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() that we have a __weak fallback
implementation for systems without it.

In this specific case this would only happen if fgets() was buggy, as
its man page states that it should read one less byte than the size of
the destination buffer, so that it can put the nul byte at the end of
it, so it would never copy 255 non-nul chars, as fgets reads into the
orig buffer at most 254 non-nul chars and terminates it. But lets just
switch to strlcpy to keep the original intent and silence the gcc 8.2
warning.

This fixes this warning on an Alpine Linux Edge system with gcc 8.2:

  In function 'cpu_model',
      inlined from 'svg_cpu_box' at util/svghelper.c:378:2:
  util/svghelper.c:337:5: error: 'strncpy' output may be truncated copying 255 bytes from a string of length 255 [-Werror=stringop-truncation]
       strncpy(cpu_m, &buf[13], 255);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Fixes: f48d55ce7871 ("perf: Add a SVG helper library file")
Link: https://lkml.kernel.org/n/tip-xzkoo0gyr56gej39ltivuh9g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/svghelper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
index 1cbada2dc6be..f735ee038713 100644
--- a/tools/perf/util/svghelper.c
+++ b/tools/perf/util/svghelper.c
@@ -334,7 +334,7 @@ static char *cpu_model(void)
 	if (file) {
 		while (fgets(buf, 255, file)) {
 			if (strstr(buf, "model name")) {
-				strncpy(cpu_m, &buf[13], 255);
+				strlcpy(cpu_m, &buf[13], 255);
 				break;
 			}
 		}

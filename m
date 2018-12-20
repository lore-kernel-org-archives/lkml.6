Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D7EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2704F217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbeLTR6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:58:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733211AbeLTR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:58:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKHwUF43679556
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 09:58:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKHwTZw3679550;
        Thu, 20 Dec 2018 09:58:29 -0800
Date:   Thu, 20 Dec 2018 09:58:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-571766010ea6bf9726b288eb2db1abb59b1841af@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@redhat.com,
        mhiramat@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        acme@redhat.com
Reply-To: hpa@zytor.com, mathieu.poirier@linaro.org,
          linux-kernel@vger.kernel.org, mhiramat@kernel.org,
          jolsa@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          acme@redhat.com, tglx@linutronix.de
In-Reply-To: <20181127084634.12469-1-adrian.hunter@intel.com>
References: <20181127084634.12469-1-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Alter addr_filter__entire_dso() to
 work if there are no symbols
Git-Commit-ID: 571766010ea6bf9726b288eb2db1abb59b1841af
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

Commit-ID:  571766010ea6bf9726b288eb2db1abb59b1841af
Gitweb:     https://git.kernel.org/tip/571766010ea6bf9726b288eb2db1abb59b1841af
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 27 Nov 2018 10:46:34 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:21:44 -0300

perf auxtrace: Alter addr_filter__entire_dso() to work if there are no symbols

addr_filter__entire_dso() uses the first and last symbols from a dso,
and so does not work when there are no symbols.  Alter it to filter the
whole file instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Fixes: 1b36c03e3569 ("perf record: Add support for using symbols in address filters")
Link: http://lkml.kernel.org/r/20181127084634.12469-1-adrian.hunter@intel.com
[ split from a larger patch ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72d5ba2479bf..f69961c4a4f3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1983,17 +1983,14 @@ static int find_dso_sym(struct dso *dso, const char *sym_name, u64 *start,
 
 static int addr_filter__entire_dso(struct addr_filter *filt, struct dso *dso)
 {
-	struct symbol *first_sym = dso__first_symbol(dso);
-	struct symbol *last_sym = dso__last_symbol(dso);
-
-	if (!first_sym || !last_sym) {
-		pr_err("Failed to determine filter for %s\nNo symbols found.\n",
+	if (dso__data_file_size(dso, NULL)) {
+		pr_err("Failed to determine filter for %s\nCannot determine file size.\n",
 		       filt->filename);
 		return -EINVAL;
 	}
 
-	filt->addr = first_sym->start;
-	filt->size = last_sym->end - first_sym->start;
+	filt->addr = 0;
+	filt->size = dso->data.file_size;
 
 	return 0;
 }

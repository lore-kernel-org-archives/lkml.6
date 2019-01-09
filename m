Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72978C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D342070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfAIHQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:16:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52053 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfAIHQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:16:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097GlAF3856464
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:16:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097GlCT3856461;
        Tue, 8 Jan 2019 23:16:47 -0800
Date:   Tue, 8 Jan 2019 23:16:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f2e14cd2c93699aa0aeaa8240457ab359f1258ff@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, acme@redhat.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190107140854.GA28965@kernel.org>
References: <20190107140854.GA28965@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Lift restriction on using callchains
 without "sym" in --sort
Git-Commit-ID: f2e14cd2c93699aa0aeaa8240457ab359f1258ff
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

Commit-ID:  f2e14cd2c93699aa0aeaa8240457ab359f1258ff
Gitweb:     https://git.kernel.org/tip/f2e14cd2c93699aa0aeaa8240457ab359f1258ff
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 8 Jan 2019 10:56:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:13 -0300

perf top: Lift restriction on using callchains without "sym" in --sort

This restriction is not present in 'perf report' and since 'perf top'
uses the same hists browser, remove it from it as well.

With this we create per event buckets with callchain trees, so that

  # perf top --sort dso -g --no-children

Bucketizes samples by DSO and below it shows the callchains leading to
functions in this DSO.

Try also:

  # perf top -e sched:*switch -g --no-children

To see the callchains leading to sched switches, pressing 'E' to expand
all one can quickly see the most common scheduler switches and what
leads to them, for instance, calls to IO, futexes, etc.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lkml.kernel.org/r/20190107140854.GA28965@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index fe3ecfb2e64b..f64e312db787 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1028,12 +1028,7 @@ out_err:
 
 static int callchain_param__setup_sample_type(struct callchain_param *callchain)
 {
-	if (!perf_hpp_list.sym) {
-		if (callchain->enabled) {
-			ui__error("Selected -g but \"sym\" not present in --sort/-s.");
-			return -EINVAL;
-		}
-	} else if (callchain->mode != CHAIN_NONE) {
+	if (callchain->mode != CHAIN_NONE) {
 		if (callchain_register_param(callchain) < 0) {
 			ui__error("Can't register callchain params.\n");
 			return -EINVAL;

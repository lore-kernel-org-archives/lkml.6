Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1555DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA553208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA553208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeFNGU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:20:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51323 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeFNGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:20:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6K864763441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:20:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6K7ij763438;
        Wed, 13 Jun 2018 23:20:07 -0700
Date:   Wed, 13 Jun 2018 23:20:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8owkgrruzzi5emvblwh4e6le@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        yao.jin@linux.intel.com, adrian.hunter@intel.com, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, dsahern@gmail.com,
        namhyung@kernel.org, wangnan0@huawei.com
Reply-To: wangnan0@huawei.com, dsahern@gmail.com, namhyung@kernel.org,
          tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, adrian.hunter@intel.com,
          yao.jin@linux.intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser gtk: Use
 hist_entry__has_callchains()
Git-Commit-ID: 29f9fcdd3f8edccad5809cf939ce921752460fe7
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

Commit-ID:  29f9fcdd3f8edccad5809cf939ce921752460fe7
Gitweb:     https://git.kernel.org/tip/29f9fcdd3f8edccad5809cf939ce921752460fe7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 7 Jun 2018 14:33:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 14:33:31 -0300

perf hists browser gtk: Use hist_entry__has_callchains()

Since we can't go from struct hists to struct evsel for all cases (c2c
is an exception) and we have access to the hist_entry, use
hist_entry__has_callchains() in the GTK+ hists browser to figure out
if callchains are available.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8owkgrruzzi5emvblwh4e6le@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/gtk/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index b085f1b3e34d..4ab663ec3e5e 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -382,7 +382,7 @@ static void perf_gtk__show_hists(GtkWidget *window, struct hists *hists,
 			gtk_tree_store_set(store, &iter, col_idx++, s, -1);
 		}
 
-		if (hists__has_callchains(hists) &&
+		if (hist_entry__has_callchains(h) &&
 		    symbol_conf.use_callchain && hists__has(hists, sym)) {
 			if (callchain_param.mode == CHAIN_GRAPH_REL)
 				total = symbol_conf.cumulate_callchain ?

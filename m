Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EBDCC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F846208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F846208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752912AbeFNGTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:19:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752671AbeFNGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:19:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6J18S763363
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:19:01 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6J1cw763360;
        Wed, 13 Jun 2018 23:19:01 -0700
Date:   Wed, 13 Jun 2018 23:19:01 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ptvndealxs1k7myluvu9flnq@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        mingo@kernel.org, namhyung@kernel.org, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, yao.jin@linux.intel.com,
        adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          yao.jin@linux.intel.com, adrian.hunter@intel.com,
          jolsa@kernel.org, hpa@zytor.com, mingo@kernel.org,
          dsahern@gmail.com, namhyung@kernel.org, acme@redhat.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Save the callchain_size in struct
 hist_entry
Git-Commit-ID: 41477acf092251eb0cfe83068f48dbcb2521478a
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

Commit-ID:  41477acf092251eb0cfe83068f48dbcb2521478a
Gitweb:     https://git.kernel.org/tip/41477acf092251eb0cfe83068f48dbcb2521478a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 7 Jun 2018 14:19:54 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 14:22:53 -0300

perf hists: Save the callchain_size in struct hist_entry

So that we can figure out the real size of the struct and also be able
to tell if callchains may be present in this histogram entry.

Since we can't always guarantee that from hist_entry->hists we can use
hists_to_evsel, to then look at evsel->attr.sample_type for
PERF_SAMPLE_CALLCHAIN, like with the 'perf c2c' tool, that uses plain
'struct hists' instances, we need another way of deciding if a specific
hist_entry instance has callchains associated with it, i.e. if its
hist_entry->callchain[0] has space allocated for.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ptvndealxs1k7myluvu9flnq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 6 ++++--
 tools/perf/util/sort.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 52e8fda93a47..0441a92b855f 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -370,9 +370,11 @@ void hists__delete_entries(struct hists *hists)
 
 static int hist_entry__init(struct hist_entry *he,
 			    struct hist_entry *template,
-			    bool sample_self)
+			    bool sample_self,
+			    size_t callchain_size)
 {
 	*he = *template;
+	he->callchain_size = callchain_size;
 
 	if (symbol_conf.cumulate_callchain) {
 		he->stat_acc = malloc(sizeof(he->stat));
@@ -473,7 +475,7 @@ static struct hist_entry *hist_entry__new(struct hist_entry *template,
 
 	he = ops->new(callchain_size);
 	if (he) {
-		err = hist_entry__init(he, template, sample_self);
+		err = hist_entry__init(he, template, sample_self, callchain_size);
 		if (err) {
 			ops->free(he);
 			he = NULL;
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 7cf2d5cc038e..9ab9257ed887 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -112,6 +112,8 @@ struct hist_entry {
 
 	char			level;
 	u8			filtered;
+
+	u16			callchain_size;
 	union {
 		/*
 		 * Since perf diff only supports the stdio output, TUI

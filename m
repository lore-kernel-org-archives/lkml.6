Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DE4tGebmGFsQRwAAmS7hNA
	; Thu, 07 Jun 2018 08:04:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F1A9E607F7; Thu,  7 Jun 2018 08:04:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F51E605A2;
	Thu,  7 Jun 2018 08:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F51E605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932165AbeFGIEr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:04:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753028AbeFGIEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:04:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5784YW92123864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:04:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5784Yqu2123861;
        Thu, 7 Jun 2018 01:04:34 -0700
Date: Thu, 7 Jun 2018 01:04:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-u4761kyzhixw9ydk6kib3f0o@git.kernel.org>
Cc: acme@redhat.com, hpa@zytor.com, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, dsahern@gmail.com, wangnan0@huawei.com,
        namhyung@kernel.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
          namhyung@kernel.org, dsahern@gmail.com, adrian.hunter@intel.com,
          wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Introduce constructor/destructor
 for annotated_source
Git-Commit-ID: ca39650309a7ce471ed6077267a27a0ac1f28941
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

Commit-ID:  ca39650309a7ce471ed6077267a27a0ac1f28941
Gitweb:     https://git.kernel.org/tip/ca39650309a7ce471ed6077267a27a0ac1f28941
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 16:01:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: Introduce constructor/destructor for annotated_source

More stuff will go in there, all the parts that are not needed when a
symbol had no samples and that were mistakenly added to 'struct
annotation'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-u4761kyzhixw9ydk6kib3f0o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f0c6941bca6c..f6c9bb29ac84 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -678,6 +678,25 @@ static struct arch *arch__find(const char *name)
 	return bsearch(name, architectures, nmemb, sizeof(struct arch), arch__key_cmp);
 }
 
+static struct annotated_source *annotated_source__new(void)
+{
+	struct annotated_source *src = zalloc(sizeof(*src));
+
+	if (src != NULL)
+		INIT_LIST_HEAD(&src->source);
+
+	return src;
+}
+
+static void annotated_source__delete(struct annotated_source *src)
+{
+	if (src == NULL)
+		return;
+	zfree(&src->histograms);
+	zfree(&src->cycles_hist);
+	free(src);
+}
+
 int symbol__alloc_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
@@ -704,17 +723,17 @@ int symbol__alloc_hist(struct symbol *sym)
 	if (sizeof_sym_hist > SIZE_MAX / symbol_conf.nr_events)
 		return -1;
 
-	notes->src = zalloc(sizeof(*notes->src));
+	notes->src = annotated_source__new();
 	if (notes->src == NULL)
 		return -1;
 	notes->src->histograms = calloc(symbol_conf.nr_events, sizeof_sym_hist);
 	if (notes->src->histograms == NULL) {
-		zfree(&notes->src);
+		annotated_source__delete(notes->src);
+		notes->src = NULL;
 		return -1;
 	}
 	notes->src->sizeof_sym_hist = sizeof_sym_hist;
 	notes->src->nr_histograms   = symbol_conf.nr_events;
-	INIT_LIST_HEAD(&notes->src->source);
 	return 0;
 }
 

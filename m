Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6E84BC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24400208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLbPNmQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24400208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933551AbeFKRsh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932644AbeFKRs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:48:26 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8236208AF;
        Mon, 11 Jun 2018 17:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739305;
        bh=Dqa2t/yvZfBuDo+YdBLTvdXP1GZZRRSXbEJqor2vcKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLbPNmQC0EYSRMlqJ71u3PfzckC7DAJ1yEZES5+XRcuE9TxSz3EQJ7HjwHfWJv9d0
         XbirJlwUJP7osyhIGwGlpe2J12jkkbdJCOBLKrW9eJ/xuxQSeuwtE6TMacfWe00AQY
         vwR1Kcfu4A12RT9fTDzp6hq1H3EA16QcN4ayY9gQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/12] perf hists: Save the callchain_size in struct hist_entry
Date:   Mon, 11 Jun 2018 14:47:59 -0300
Message-Id: <20180611174810.14815-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3


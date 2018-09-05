Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E90F20867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaOaeXBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E90F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeIFCjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:39:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbeIFCjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:39:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09D22077C;
        Wed,  5 Sep 2018 22:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185232;
        bh=CkvqqiTVQjqzJ61Dtwf4mks0nNx6zPEiIjnYtqDbRHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaOaeXBskBgSv0+lX11ZBZknx833UyJNFZRSjhKjRFk1EwK8F6DkX1fRW75R0j9ca
         pdpV3x+R8X9qNr0jduMr80/RVmrKA1EEIhg+j/ZCO6L+JFFGqTl13lwQfsCOvSl0PE
         4n5H7ZL+3u6ITqmDl7SXqyzR6MZ59ManEOlqVjOM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 51/77] perf stat: Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases()
Date:   Wed,  5 Sep 2018 19:04:14 -0300
Message-Id: <20180905220440.20256-52-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Use 'evsel->evlist' instead of 'evsel_list' in collect_all_aliases(), to
get rid of the global 'evsel_list' variable dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-27-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 46181ac492c5..11741f3a8342 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1154,10 +1154,11 @@ static void collect_all_aliases(struct perf_evsel *counter,
 				       bool first),
 			    void *data)
 {
+	struct perf_evlist *evlist = counter->evlist;
 	struct perf_evsel *alias;
 
-	alias = list_prepare_entry(counter, &(evsel_list->entries), node);
-	list_for_each_entry_continue (alias, &evsel_list->entries, node) {
+	alias = list_prepare_entry(counter, &(evlist->entries), node);
+	list_for_each_entry_continue (alias, &evlist->entries, node) {
 		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
-- 
2.14.4


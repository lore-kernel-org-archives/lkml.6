Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EB712C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A185D20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1Uw0t0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A185D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeFKRvm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932768AbeFKRsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:48:36 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70925208AF;
        Mon, 11 Jun 2018 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739316;
        bh=T2UsRlmSkYmIHm1KTkqU2C8cpE22IywL25PyF0IvgLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1Uw0t0qJMixA65UXXmqoHAK7Hcaqedjqx7hLchoMqeeIfSuDbyVIGph1ZlIKlynU
         m+eaTLCVvgGhlbBTkOm5sSXB4HgrA17so/l61t/7mqUZuLpjuZkSaO3MaELkTFj5Ma
         mvXHtNoaFLtCkoFHwkjOfJVuMxKBwph6WhZScB2w=
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
Subject: [PATCH 04/12] perf hists: Reimplement hists__has_callchains()
Date:   Mon, 11 Jun 2018 14:48:02 -0300
Message-Id: <20180611174810.14815-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

There are places where we have only access to struct hists and need to
know if any of its hist_entries has callchains, like when drawing
headers for the various output modes (stdio, TUI, etc), so, when adding
a new hist_entry, check if it has callchains, storing this info for
later use by hists__has_callchains().

This reimplementation is necessary because not always a 'struct hists'
is allocated together with a 'struct perf evsel', so we can't go from
'hists' to 'perf_event_attr.sample_type & PERF_SAMPLE_CALLCHAIN'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hg5g7yddjio3ljwyqnnaj5dt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 6 ++++--
 tools/perf/util/hist.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0441a92b855f..828cb9794c76 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -621,9 +621,11 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
-	};
+	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
-	return hists__findnew_entry(hists, &entry, al, sample_self);
+	if (!hists->has_callchains && he && he->callchain_size != 0)
+		hists->has_callchains = true;
+	return he;
 }
 
 struct hist_entry *hists__add_entry(struct hists *hists,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 06607c434949..73049f7f0f60 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -85,6 +85,7 @@ struct hists {
 	struct events_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
+	bool			has_callchains;
 	int			socket_filter;
 	struct perf_hpp_list	*hpp_list;
 	struct list_head	hpp_formats;
@@ -222,8 +223,7 @@ static inline struct hists *evsel__hists(struct perf_evsel *evsel)
 
 static __pure inline bool hists__has_callchains(struct hists *hists)
 {
-	const struct perf_evsel *evsel = hists_to_evsel(hists);
-	return evsel__has_callchain(evsel);
+	return hists->has_callchains;
 }
 
 int hists__init(void);
-- 
2.14.3


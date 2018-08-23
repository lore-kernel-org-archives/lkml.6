Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FDEC04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8F22147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8F22147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbeHWMHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbeHWMHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E3C178B1;
        Thu, 23 Aug 2018 08:39:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        David Ahern <dsahern@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Milian Wolff <milian.wolff@kdab.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 003/324] perf tools: Fix error index for pmu event parser
Date:   Thu, 23 Aug 2018 09:51:09 +0200
Message-Id: <20180823074956.078847661@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit f7fa827f5f432a0b1f34e10fc49da93aeef9f817 ]

For events we provide specific error message we need to set error column
index, PMU parser is missing that, adding it.

Before:

  $ perf stat -e cycles,krava/cycles/ kill
  event syntax error: 'cycles,krava/cycles/'
                       \___ Cannot find PMU `krava'. Missing kernel support?

After:

  $ perf stat -e cycles,krava/cycles/ kill
  event syntax error: 'cycles,krava/cycles/'
                              \___ Cannot find PMU `krava'. Missing kernel support?

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180606221513.11302-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/parse-events.y |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -227,11 +227,16 @@ event_def: event_pmu |
 event_pmu:
 PE_NAME opt_pmu_config
 {
+	struct parse_events_state *parse_state = _parse_state;
+	struct parse_events_error *error = parse_state->error;
 	struct list_head *list, *orig_terms, *terms;
 
 	if (parse_events_copy_term_list($2, &orig_terms))
 		YYABORT;
 
+	if (error)
+		error->idx = @1.first_column;
+
 	ALLOC_LIST(list);
 	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;



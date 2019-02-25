Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B2C2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131613;
	bh=CDtah4pZzcc7IlORMl86dIzRVxzi96wf/eqitlqZoEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tbGQmG0CAgd5Gvq9MjpSDHV2eg8EhqXCaTi1e7GlyS76ke4zudTHLDpMb07YTfIZk
	 PrqEYCSrqtFsdi+u7iHDUUwyNbxcb40JDM7lLN7VQK8HD6+oPyv3lTZEbS+qfIAwJT
	 DIgVpiWt9+FNtFD6opy3+wqLKW7vLsQZulIstTzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfBYVxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbfBYVW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:22:26 -0500
Received: from quaco.ghostprotocols.net (179-240-165-120.3g.claro.net.br [179.240.165.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940F921872;
        Mon, 25 Feb 2019 21:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129745;
        bh=CDtah4pZzcc7IlORMl86dIzRVxzi96wf/eqitlqZoEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zR2JF7EFLfATXsqpYSogtHQtXxQCNJuwaiEBhS5Ppsp0Ix7XtG35V2ROuwewbj41P
         QFw+L66AYsva9z8BQO202lZ5xoh2N6+/JPEX8QXx36huTBrSlxZGebYRLtifwvYz2b
         N4yzE85FEMvkyzbWbHqYR6JknTepYyOwFi3l4mkA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 26/37] perf script: Handle missing fields with -F +..
Date:   Mon, 25 Feb 2019 18:20:24 -0300
Message-Id: <20190225212035.24781-27-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225212035.24781-1-acme@kernel.org>
References: <20190225212035.24781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When using -F + syntax to add a field the existing defaults are
currently all marked user_set. This can cause errors when some field is
missing in the perf.data

This patch tracks the actually user set fields separately, so that we don't
error out in this case.

Before:

  % perf record true
  % perf script -F +metric
  Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
  %

After:

  5 perf record true
  % perf script -F +metric
              perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
  ...
  %

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5b1543f42290..2d8cb1d1682c 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -149,6 +149,7 @@ static struct {
 	unsigned int print_ip_opts;
 	u64 fields;
 	u64 invalid_fields;
+	u64 user_set_fields;
 } output[OUTPUT_TYPE_MAX] = {
 
 	[PERF_TYPE_HARDWARE] = {
@@ -345,7 +346,7 @@ static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
 	if (attr->sample_type & sample_type)
 		return 0;
 
-	if (output[type].user_set) {
+	if (output[type].user_set_fields & field) {
 		if (allow_user_set)
 			return 0;
 		evname = perf_evsel__name(evsel);
@@ -2632,10 +2633,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
 					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
 						   all_output_options[i].str, event_type(j));
 				} else {
-					if (change == REMOVE)
+					if (change == REMOVE) {
 						output[j].fields &= ~all_output_options[i].field;
-					else
+						output[j].user_set_fields &= ~all_output_options[i].field;
+					} else {
 						output[j].fields |= all_output_options[i].field;
+						output[j].user_set_fields |= all_output_options[i].field;
+					}
 					output[j].user_set = true;
 					output[j].wildcard_set = true;
 				}
-- 
2.20.1


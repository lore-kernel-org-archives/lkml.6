Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CE7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B50206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfBXPir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:38:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:30217 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbfBXPhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,407,1544515200"; 
   d="scan'208";a="124836115"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 24 Feb 2019 07:37:30 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 85100300208; Sun, 24 Feb 2019 07:37:30 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 01/11] perf tools script: Handle missing fields with -F +..
Date:   Sun, 24 Feb 2019 07:37:12 -0800
Message-Id: <20190224153722.27020-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190224153722.27020-1-andi@firstfloor.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When using -F + syntax to add a field the existing defaults
are currently all marked user_set. This can cause errors when
some field is missing in the perf.data

This patch tracks the actually user set fields separately,
so that we don't error out in this case.

Before:

% perf record true
% perf script -F +metric
Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
%

After

5 perf record true
% perf script -F +metric
            perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
...
%

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8d5fe092525c..29e95a25c6e6 100644
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
@@ -2628,10 +2629,13 @@ static int parse_output_fields(const struct option *opt __maybe_unused,
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
2.17.2


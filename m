Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16093C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C675A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C675A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeIMSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728423AbeIMSF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 790A7307DA2B;
        Thu, 13 Sep 2018 12:56:06 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D720600C8;
        Thu, 13 Sep 2018 12:56:04 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 32/48] tools lib subcmd: Add OPT_INTEGER_OPTARG|_SET options
Date:   Thu, 13 Sep 2018 14:54:34 +0200
Message-Id: <20180913125450.21342-33-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Sep 2018 12:56:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding OPT_INTEGER_OPTARG|_SET option macros to allow
optional argument with set flag.

Link: http://lkml.kernel.org/n/tip-d01dcbwqvrv5762salo84105@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/subcmd/parse-options.c | 2 ++
 tools/lib/subcmd/parse-options.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index cb7154eccbdc..e2f68edd76d2 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -250,6 +250,8 @@ static int get_value(struct parse_opt_ctx_t *p,
 			*(int *)opt->value = 0;
 			return 0;
 		}
+		if (opt->set)
+			*(bool *)opt->set = true;
 		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
 			*(int *)opt->value = opt->defval;
 			return 0;
diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 92fdbe1519f6..e2edd6aada53 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -144,6 +144,15 @@ struct option {
 	  .value = check_vtype(v, const char **), .argh = (a), .help = (h), \
 	  .flags = PARSE_OPT_OPTARG, .defval = (intptr_t)(d), \
 	  .set = check_vtype(os, bool *)}
+#define OPT_INTEGER_OPTARG(s, l, v, a, h, d) \
+	{ .type = OPTION_INTEGER,  .short_name = (s), .long_name = (l), \
+	  .value = check_vtype(v, int *), .argh = (a), .help = (h), \
+	  .flags = PARSE_OPT_OPTARG, .defval = (intptr_t)(d) }
+#define OPT_INTEGER_OPTARG_SET(s, l, v, os, a, h, d) \
+	{ .type = OPTION_INTEGER, .short_name = (s), .long_name = (l), \
+	  .value = check_vtype(v, int *), .argh = (a), .help = (h), \
+	  .flags = PARSE_OPT_OPTARG, .defval = (intptr_t)(d), \
+	  .set = check_vtype(os, bool *)}
 #define OPT_STRING_NOEMPTY(s, l, v, a, h)   { .type = OPTION_STRING,  .short_name = (s), .long_name = (l), .value = check_vtype(v, const char **), .argh = (a), .help = (h), .flags = PARSE_OPT_NOEMPTY}
 #define OPT_DATE(s, l, v, h) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = "time", .help = (h), .callback = parse_opt_approxidate_cb }
-- 
2.17.1


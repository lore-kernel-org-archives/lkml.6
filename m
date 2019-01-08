Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C51E20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977745;
	bh=IlCi2PrbpJPRHzpSuKr6gFdESNaHGSWLKtnqZxGZtYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pAVh1ONJp7X6tVOZdwhV9dwfmNw3EgbrPC8jq9aLv3DMx+NeG6EK3pm3cnekp+zp+
	 wS5Hy3rLnceXjcG+pjQD+N3pgpxehuLG/+vabyWEBfonf/wQPLEUxPLKaRxyckxtWR
	 hgdtDWokb4blTeqz79GFTAR5ttqz3m/Odfta8upo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfAHUCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbfAHT3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94FF218A1;
        Tue,  8 Jan 2019 19:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975743;
        bh=IlCi2PrbpJPRHzpSuKr6gFdESNaHGSWLKtnqZxGZtYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPaNewMFvZIRLV0/oFBgyLR/UP/CHQAJk8EwWLxW5+o0vlqIZ+XWNlEHF14ZTgRkf
         /xsf7PJ+a1ZiojGUGAIi60M38eQ0cxqTXKfVAcH7azNHwQc81IbEzIIA0mPEcbVwZ0
         wi44tKk+Sz6ad9Ofvez1liEK4fPTml0+UHM1WDjQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 090/117] perf stat: Avoid segfaults caused by negated options
Date:   Tue,  8 Jan 2019 14:25:58 -0500
Message-Id: <20190108192628.121270-90-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

[ Upstream commit 51433ead1460fb3f46e1c34f68bb22fd2dd0f5d0 ]

Some 'perf stat' options do not make sense to be negated (event,
cgroup), some do not have negated path implemented (metrics). Due to
that, it is better to disable the "no-" prefix for them, since
otherwise, the later opt-parsing segfaults.

Before:

  $ perf stat --no-metrics -- ls
  Segmentation fault (core dumped)

After:

  $ perf stat --no-metrics -- ls
   Error: option `no-metrics' isn't available
   Usage: perf stat [<options>] [<command>]

Signed-off-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
LPU-Reference: 1485912065.62416880.1544457604340.JavaMail.zimbra@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-stat.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a635abfa77b6..1410d66192f7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -709,7 +709,7 @@ static int parse_metric_groups(const struct option *opt,
 	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
-static const struct option stat_options[] = {
+static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
 	OPT_CALLBACK('e', "event", &evsel_list, "event",
@@ -1599,6 +1599,12 @@ int cmd_stat(int argc, const char **argv)
 		return -ENOMEM;
 
 	parse_events__shrink_config_terms();
+
+	/* String-parsing callback-based options would segfault when negated */
+	set_option_flag(stat_options, 'e', "event", PARSE_OPT_NONEG);
+	set_option_flag(stat_options, 'M', "metrics", PARSE_OPT_NONEG);
+	set_option_flag(stat_options, 'G', "cgroup", PARSE_OPT_NONEG);
+
 	argc = parse_options_subcommand(argc, argv, stat_options, stat_subcommands,
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
-- 
2.19.1


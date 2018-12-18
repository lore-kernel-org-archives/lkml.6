Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890DCC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A4B218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170912;
	bh=LTISs7tvfU/K6YFB7Kh8dbDH/f+XsYp77Bp+kEbIvUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U8hV9Mr83+We8OkaFY/dMnupnMWcirikBMMeeE38jZ/bhyYYHaa0cmae8xbO4+t1g
	 cjK4P1PLMgoWQTiuqJHUJn/UuvgtHU77xKmGcxhMee+SFljawboKPxWuiR2ZSopY+a
	 so9QFjYyFnEtIl9313drHs4/dQ+FBUwe0tSo0qfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeLRWIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbeLRWIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:30 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AA79218A2;
        Tue, 18 Dec 2018 22:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170909;
        bh=LTISs7tvfU/K6YFB7Kh8dbDH/f+XsYp77Bp+kEbIvUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjDfdr/fnbJWTWAPyfjFVKXbzzkZa7BXVB+DyxL7k6RZS+GpYMwS1xX1Ch+3mWb3U
         LTCvsRtWVu6WJAcKzTBtO9zsPzhwmwwJ5nYlsF9bgcy2m0dXQsvLPBTDUFEmHCI1pU
         vAuXTYoXct2sEVgMfX8hk1Ei3rvAduZY2XxZM0Hs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/63] perf stat: Avoid segfaults caused by negated options
Date:   Tue, 18 Dec 2018 19:06:34 -0300
Message-Id: <20181218220733.15839-5-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Petlan <mpetlan@redhat.com>

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
2.19.2


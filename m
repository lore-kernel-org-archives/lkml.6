Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5FC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF29421726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359695;
	bh=E0UjCQ/9pL0zPHUH24atg127IlZt8OoHVNBOrIaSFMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CVdI9rsUHAF+1E1/CcqOek9nae7xuJe2CCJDliKB7GIVaQPgxkmrOWBcUYTbIjQv2
	 JF4MuYyRZc/gFrOHSPK350bjWIzcmXrXwAzvL6eKUztlp56ayAJDIyQcBvvUPUiU8P
	 4CGoRn1fO2LdcYIjGfSp/wKXNbSvBeIZrskbuVfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbfAXTyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbfAXThI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77069218FC;
        Thu, 24 Jan 2019 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358628;
        bh=E0UjCQ/9pL0zPHUH24atg127IlZt8OoHVNBOrIaSFMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEdWMcRDDDGs7wDLRE+Kj+4XbpgF8ag05/pPdrzJ4hhyqR5l03dIaH3fRlE/Zi8fS
         o7KFwA/R5P7660vLEp5QlSdfHKgHwf8VmlJNsp1kpddiD1Nyf7ge1KYRVVISnwlHNj
         7sHf4aiMzSrVn/cLokbogN8G6RD53afG4S1bY8zo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 076/106] perf stat: Avoid segfaults caused by negated options
Date:   Thu, 24 Jan 2019 20:20:33 +0100
Message-Id: <20190124190211.090290441@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d097b5b47eb8..40720150ccd8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1961,7 +1961,7 @@ static int parse_metric_groups(const struct option *opt,
 	return metricgroup__parse_groups(opt, str, &metric_events);
 }
 
-static const struct option stat_options[] = {
+static struct option stat_options[] = {
 	OPT_BOOLEAN('T', "transaction", &transaction_run,
 		    "hardware transaction statistics"),
 	OPT_CALLBACK('e', "event", &evsel_list, "event",
@@ -2847,6 +2847,12 @@ int cmd_stat(int argc, const char **argv)
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




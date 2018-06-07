Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id XT4KG+zqGFsXZwAAmS7hNA
	; Thu, 07 Jun 2018 08:21:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 55E60607F7; Thu,  7 Jun 2018 08:21:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C20FB601B4;
	Thu,  7 Jun 2018 08:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C20FB601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeFGIU5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:20:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55877 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932323AbeFGIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:20:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578JXE82125917
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:19:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578JXXX2125914;
        Thu, 7 Jun 2018 01:19:33 -0700
Date: Thu, 7 Jun 2018 01:19:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ceac7b79df7bd67ef9aaf464b0179a2686aff4ee@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
        dsahern@gmail.com, namhyung@kernel.org, jolsa@kernel.org,
        hpa@zytor.com
Reply-To: dsahern@gmail.com, tglx@linutronix.de, mingo@kernel.org,
          acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180605121416.31645-1-jolsa@kernel.org>
References: <20180605121416.31645-1-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix pmu events parsing rule
Git-Commit-ID: ceac7b79df7bd67ef9aaf464b0179a2686aff4ee
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  ceac7b79df7bd67ef9aaf464b0179a2686aff4ee
Gitweb:     https://git.kernel.org/tip/ceac7b79df7bd67ef9aaf464b0179a2686aff4ee
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 5 Jun 2018 14:14:16 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Jun 2018 12:52:05 -0300

perf tools: Fix pmu events parsing rule

Currently all the event parsing fails end up
in the event_pmu rule, and display misleading
help like:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ Cannot find PMU `inst'. Missing kernel support?
  ...

The reason is that the event_pmu is too strong
and match also single string. Changing it to
force the '/' separators to be part of the rule,
and getting the proper error now:

  $ perf stat -e inst kill
  event syntax error: 'inst'
                       \___ parser error
  Run 'perf list' for a list of valid events
  ...

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180605121416.31645-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e37608a87dba..155d2570274f 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -73,6 +73,7 @@ static void inc_group_count(struct list_head *list,
 %type <num> value_sym
 %type <head> event_config
 %type <head> opt_event_config
+%type <head> opt_pmu_config
 %type <term> event_term
 %type <head> event_pmu
 %type <head> event_legacy_symbol
@@ -224,7 +225,7 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME opt_event_config
+PE_NAME opt_pmu_config
 {
 	struct list_head *list, *orig_terms, *terms;
 
@@ -496,6 +497,17 @@ opt_event_config:
 	$$ = NULL;
 }
 
+opt_pmu_config:
+'/' event_config '/'
+{
+	$$ = $2;
+}
+|
+'/' '/'
+{
+	$$ = NULL;
+}
+
 start_terms: event_config
 {
 	struct parse_events_state *parse_state = _parse_state;

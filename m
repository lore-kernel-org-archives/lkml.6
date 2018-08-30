Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACEA20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 06:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACEA20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeH3Kda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 06:33:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbeH3Kda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 06:33:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A914D7D84D;
        Thu, 30 Aug 2018 06:32:54 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA8E5B27A5;
        Thu, 30 Aug 2018 06:32:52 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 00/43] perf stat: Make some of the stat code generic
Date:   Thu, 30 Aug 2018 08:32:09 +0200
Message-Id: <20180830063252.23729-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:32:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 30 Aug 2018 06:32:54 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
while going for the ability to store/display stat data
in perf record/top I ended up with bunch of generic
patches that make some of the stat functions standalone
and simplify/reduce the builtin-stat.c code.

This patchset mostly separates the display functions
into separate object, plus several other functions.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


---
Jiri Olsa (43):
      perf stat: Use evsel->threads in create_perf_stat_counter
      perf stat: Move initial_delay into struct perf_stat_config
      perf stat: Move no_inherit into struct perf_stat_config
      perf stat: Use local config arg for scale in create_perf_stat_counter
      perf stat: Add identifier flag into struct stat_opts
      perf tools: Switch session argument to evlist in perf_event__synthesize_attrs
      perf tools: Add perf_evsel__store_ids function
      perf stat: Move create_perf_stat_counter into stat.c
      perf stat: Rename is_pipe argument to attrs perf_stat_synthesize_config
      perf stat: Add struct perf_stat_config argument to perf_stat_synthesize_config
      perf stat: Add struct perf_tool argument to perf_stat_synthesize_config
      perf stat: Add struct perf_evlist argument to perf_stat_synthesize_config
      perf stat: Add perf_event__handler_t argument to perf_stat_synthesize_config
      perf stat: Move perf_stat_synthesize_config into stat.c
      perf stat: Add perf_evlist__print_counters function
      perf stat: Move STAT_RECORD out of perf_evlist__print_counters
      perf stat: Add stat_config argument to perf_evlist__print_counters
      perf stat: Pass stat_config argument to local print functions
      perf stat: Pass stat_config argument to global print functions
      perf stat: Move csv_* into struct perf_stat_config
      perf stat: Move interval_clear into struct perf_stat_config
      perf stat: Move metric_only into struct perf_stat_config
      perf stat: Move unit_width into struct perf_stat_config
      perf stat: Add target argument to perf_evlist__print_counters
      perf stat: Pass evlist argument to print functions
      perf stat: Use evsel->evlist instead of evsel_list in collect_all_aliases
      perf stat: Move run_count into struct perf_stat_config
      perf stat: Move metric_only_len into struct perf_stat_config
      perf stat: Pass stat_config to first_shadow_cpu
      perf stat: Pass evlist to aggr_update_shadow
      perf stat: Add walltime_nsecs_stats pointer into struct perf_stat_config
      perf stat: Move null_run into struct perf_stat_config
      perf stat: Move print_free_counters_hint into struct perf_stat_config
      perf stat: Move print_mixed_hw_group_error into struct perf_stat_config
      perf stat: Move ru_* data into struct perf_stat_config
      perf stat: Move *_aggr_* data into struct perf_stat_config
      perf stat: Do not use glovab evsel_list in print functions
      perf stat: Move big_num data into struct perf_stat_config
      perf stat: Move no_merge data into struct perf_stat_config
      perf stat: Propagate struct target arg to sort_aggr_thread
      perf stat: Move walltime_* data into struct perf_stat_config
      perf stat: Move metric_events into struct perf_stat_config
      perf stat: Move display functions into stat-display.c

 tools/perf/builtin-record.c    |    2 +-
 tools/perf/builtin-script.c    |    8 +-
 tools/perf/builtin-stat.c      | 1440 +++++++++--------------------------------------------------------------------------------------------------------------
 tools/perf/util/Build          |    1 +
 tools/perf/util/evsel.c        |   29 +++
 tools/perf/util/evsel.h        |    1 +
 tools/perf/util/header.c       |    6 +-
 tools/perf/util/header.h       |    2 +-
 tools/perf/util/stat-display.c | 1166 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stat-shadow.c  |  147 +++++++------
 tools/perf/util/stat.c         |   95 ++++++++
 tools/perf/util/stat.h         |   72 +++++-
 12 files changed, 1545 insertions(+), 1424 deletions(-)
 create mode 100644 tools/perf/util/stat-display.c

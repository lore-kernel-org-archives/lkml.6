Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D4C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692CA217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 692CA217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbeHDPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC5BF8182D0C;
        Sat,  4 Aug 2018 13:05:23 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02E8E215670D;
        Sat,  4 Aug 2018 13:05:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 00/20] perf annotate: Make symbol__annotate_fprintf2 local
Date:   Sat,  4 Aug 2018 15:05:01 +0200
Message-Id: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:24 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Stephane asked for key/option switch between local/global
percentage in annotation output/browser [1]. Local means
% within symbol, global within the whole perf data.

Adding the support to specify this by new --precent-type
option added for perf annotate and report.

Also adding 'p' key binding to annotation browser to change
between local/global percentages.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

thanks,
jirka


[1] https://marc.info/?l=linux-kernel&m=153195093118669&w=2

---
Jiri Olsa (20):
      perf annotate: Make symbol__annotate_fprintf2 local
      perf annotate: Make annotation_line__max_percent static
      perf annotate: Get rid of annotation__scnprintf_samples_period
      perf annotate: Rename struct annotation_line::samples* to data*
      perf annotate: Rename local sample variables to data
      perf annotate: Rename hist to sym_hist in annotation__calc_percent
      perf annotate: Loop group events directly in annotation__calc_percent
      perf annotate: Switch struct annotation_data::percent to array
      perf annotate: Add PERCENT_HITS_GLOBAL percent value
      perf annotate: Add PERCENT_PERIOD_LOCAL percent value
      perf annotate: Add PERCENT_PERIOD_GLOBAL percent value
      perf annotate: Add percent_type to struct annotation_options
      perf annotate: Pass struct annotation_options to symbol__calc_lines
      perf annotate: Pass struct annotation_options to map_symbol__annotation_dump
      perf annotate: Pass browser percent_type in annotate_browser__calc_percent
      perf annotate: Add support to togle percent type
      perf annotate: Make local period the default percent type
      perf annotate: Display percent type in stdio output
      perf annotate: Add --percent-type option
      perf report: Add --percent-type option

 tools/perf/Documentation/perf-annotate.txt |   9 ++++
 tools/perf/Documentation/perf-report.txt   |   9 ++++
 tools/perf/builtin-annotate.c              |   4 ++
 tools/perf/builtin-report.c                |   3 ++
 tools/perf/ui/browsers/annotate.c          |  81 +++++++++++++++++++++++++-------
 tools/perf/util/annotate.c                 | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 tools/perf/util/annotate.h                 |  55 ++++++++++++++++------
 tools/perf/util/evsel.h                    |   7 +++
 8 files changed, 319 insertions(+), 151 deletions(-)

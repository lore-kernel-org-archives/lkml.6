Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545FCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8E720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfBTMqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:46:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfBTMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:46:24 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D9BB81E09;
        Wed, 20 Feb 2019 12:46:22 +0000 (UTC)
Received: from krava (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id E6AC461B95;
        Wed, 20 Feb 2019 12:46:19 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:46:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com
Subject: Re: [PATCH 00/10] perf: Multi-die/package support
Message-ID: <20190220124619.GB25423@krava>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 20 Feb 2019 12:46:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 12:00:01PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Add Linux perf support for multi-die/package. The first product with
> multi-die is Xeon Cascade Lake-AP (CLX-AP).
> The code bases on the top of Len's multi-die/package support.
> https://lkml.org/lkml/2019/2/18/1534
> 
> Patch 1-4: They are generic codes for previous platforms.
> Perf supports miscellaneous modules, e.g cstate, RAPL and uncore.
> Their counters have the same scope of effect (per package).
> But they maintain their own scope information independently.
> It's very useful to abstract several common topology related codes
> for these modules to reduce the code redundancy, especially when
> adding counters with new scope.
> 
> Patch 5-8: Support die scope counters on CLX-AP for uncore, RAPL
> and cstate.
> 
> Patch 9-10: Support per-die aggregation for perf stat and header.
> 
> Kan Liang (10):
>   perf/x86/intel: Introduce a concept "domain" as the scope of counters
>   perf/x86/intel/cstate: Apply "domain" for cstate
>   perf/x86/intel/uncore: Apply "domain" for uncore
>   perf/x86/intel/rapl: Apply "domain" for RAPL
>   perf/x86/intel/domain: Add new domain type for die
>   perf/x86/intel/uncore: Support die scope counters on CLX-AP
>   perf/x86/intel/rapl: Support die scope counters on CLX-AP
>   perf/x86/intel/cstate: Support die scope counters on CLX-AP
>   perf header: Add die information in cpu topology
>   perf stat: Support per-die aggregation

hi,
what is based on? I'm getting conflicts when applying
on tip or Arnaldo's perf/core

thanks,
jirka

> 
>  arch/x86/events/Makefile                           |   2 +-
>  arch/x86/events/domain.c                           |  81 +++++
>  arch/x86/events/domain.h                           |  26 ++
>  arch/x86/events/intel/cstate.c                     | 364 ++++++++++++---------
>  arch/x86/events/intel/rapl.c                       | 333 ++++++++++++++-----
>  arch/x86/events/intel/uncore.c                     | 247 +++++++++-----
>  arch/x86/events/intel/uncore.h                     |   9 +-
>  arch/x86/events/intel/uncore_snbep.c               |   2 +-
>  tools/perf/Documentation/perf-stat.txt             |  10 +
>  tools/perf/Documentation/perf.data-file-format.txt |   9 +-
>  tools/perf/builtin-stat.c                          |  73 ++++-
>  tools/perf/util/cpumap.c                           |  55 +++-
>  tools/perf/util/cpumap.h                           |  10 +-
>  tools/perf/util/env.c                              |   1 +
>  tools/perf/util/env.h                              |   3 +
>  tools/perf/util/header.c                           | 185 ++++++++++-
>  tools/perf/util/stat-display.c                     |  24 +-
>  tools/perf/util/stat-shadow.c                      |   1 +
>  tools/perf/util/stat.c                             |   1 +
>  tools/perf/util/stat.h                             |   1 +
>  20 files changed, 1082 insertions(+), 355 deletions(-)
>  create mode 100644 arch/x86/events/domain.c
>  create mode 100644 arch/x86/events/domain.h
> 
> -- 
> 2.7.4
> 

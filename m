Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7EE2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025915;
	bh=5yGbcV2grHWFrTfNb1z35g6e8c4mJbvUiIjm84nIGJY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BxA7rYXN14YnB8+Ov1yzFNLpPcj7c4pYWtYUl0sb3DTk9710staMmx0aXbKaeNhS6
	 iyOMt6kEzeirt9d6Be06de2NaatoU1tVZjhrzncQjo4FAu2hE/FihotbQmoKWZ8Peu
	 KQBRlFE7c3NBhJl8bSpYPTBtM8DDR0TIaHHutHe4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7EE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeLEQFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24885 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbeLEQFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:14 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 264A23E2CC;
        Wed,  5 Dec 2018 16:05:13 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43C4A5C5FD;
        Wed,  5 Dec 2018 16:05:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [RFC 1/8] perf: Block perf calls for system call tracepoints
Date:   Wed,  5 Dec 2018 17:05:01 +0100
Message-Id: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 05 Dec 2018 16:05:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Steven asked for possibility to block traced process
in case the tracer can't keep up and we would loose
events.
    
This (RFC) patchset tries to implement this by adding
'block' bool in struct perf_event_attr to be set only
for syscalls tracepoints and adding code to block the
traced process, if there's no space in event's ring
buffer.
    
The blocking code will poll/periodically check for the
space and continue if the event was successfully written.

Available also here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/block

Thoughts?

thanks,
jirka


---
Jiri Olsa (8):
      perf: Allow to block process in syscall tracepoints
      perf tools: Sync uapi perf_event.h
      perf record: Add --block option
      perf trace: Add --block option
      perf tools: Add block term support for tracepoints
      perf tools: Add ordered_events__flush_time interface
      perf trace: Move event delivery to deliver_event function
      perf trace: Add ordered processing for --block option

 arch/x86/entry/common.c               | 36 ++++++++++++++++++++++++++++++++++--
 include/linux/perf_event.h            |  2 ++
 include/linux/sched.h                 |  2 ++
 include/linux/syscalls.h              |  2 ++
 include/uapi/linux/perf_event.h       |  3 ++-
 kernel/events/core.c                  | 40 ++++++++++++++++++++++++++++++++++++++--
 kernel/events/ring_buffer.c           |  4 +++-
 kernel/trace/trace_event_perf.c       |  4 ++++
 kernel/trace/trace_syscalls.c         | 28 ++++++++++++++++++++++++----
 tools/include/uapi/linux/perf_event.h |  3 ++-
 tools/perf/builtin-record.c           |  9 +++++++++
 tools/perf/builtin-trace.c            | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 tools/perf/perf.h                     |  1 +
 tools/perf/util/evsel.c               |  7 +++++++
 tools/perf/util/evsel.h               |  2 ++
 tools/perf/util/ordered-events.c      | 34 ++++++++++++++++++++++++++++++----
 tools/perf/util/ordered-events.h      |  3 +++
 tools/perf/util/parse-events.c        |  8 ++++++++
 tools/perf/util/parse-events.h        |  1 +
 tools/perf/util/parse-events.l        |  1 +
 20 files changed, 263 insertions(+), 24 deletions(-)

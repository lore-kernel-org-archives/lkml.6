Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3035C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7280422404
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7280422404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeHJNRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 09:17:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbeHJNRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 09:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B23281663CE;
        Fri, 10 Aug 2018 10:47:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D7F32026D65;
        Fri, 10 Aug 2018 10:47:30 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCHv3 0/5] perf/hw_breakpoint: Fix breakpoint modify
Date:   Fri, 10 Aug 2018 12:47:25 +0200
Message-Id: <20180810104730.3293-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 10:47:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 10 Aug 2018 10:47:39 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Milind reported that modify_user_hw_breakpoint wouldn't
allow the breakpoint changing if the new attr had 'disabled'
set to true.

I found a case where it actualy prevents ptrace user interface
to change the breakpoint. It's described in patch 1 as perf test,
patch 2 is the breakpoint code fix.

I ran strace tests, nothing (new) broken there..

v3 changes:
  - added Oleg's ack for patch 3
  - new patches 4,5 based on Oleg's suggestions
    replacing the v2 fallback approach by enabling
    the event directly after failed modification

v2 changes:
  - added Oleg's ack for patch 2
  - added new changes based on Oleg's questions
    plus new test code

thanks,
jirka

---
Jiri Olsa (5):
      perf tests: Add breakpoint modify tests
      perf/hw_breakpoint: Modify breakpoint even if the new attr has disabled set
      perf/hw_breakpoint: Remove superfluous bp->attr.disabled = 0
      perf/hw_breakpoint: Enable breakpoint in modify_user_hw_breakpoint
      perf/hw_breakpoint: Simplify breakpoint enable in perf_event_modify_breakpoint

 kernel/events/core.c                     |  11 ++-----
 kernel/events/hw_breakpoint.c            |  13 ++++----
 tools/perf/arch/x86/include/arch-tests.h |   1 +
 tools/perf/arch/x86/tests/Build          |   1 +
 tools/perf/arch/x86/tests/arch-tests.c   |   6 ++++
 tools/perf/arch/x86/tests/bp-modify.c    | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 230 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/bp-modify.c

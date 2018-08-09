Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3587CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC80C2150A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC80C2150A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbeHIO1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:27:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730261AbeHIO1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D86840216E8;
        Thu,  9 Aug 2018 12:03:10 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32C2F10FFE6F;
        Thu,  9 Aug 2018 12:03:06 +0000 (UTC)
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
Subject: [PATCHv2 0/5] perf/hw_breakpoint: Fix breakpoint modify
Date:   Thu,  9 Aug 2018 14:03:00 +0200
Message-Id: <20180809120305.20693-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 12:03:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 09 Aug 2018 12:03:10 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
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
      perf/hw_breakpoint: Set breakpoint as disabled in modify_user_hw_breakpoint error path
      perf/hw_breakpoint: Add fallback code for ptrace_set_breakpoint_addr

 arch/x86/kernel/ptrace.c                 |   5 +++
 kernel/events/hw_breakpoint.c            |  15 +++++----
 tools/perf/arch/x86/include/arch-tests.h |   1 +
 tools/perf/arch/x86/tests/Build          |   1 +
 tools/perf/arch/x86/tests/arch-tests.c   |   6 ++++
 tools/perf/arch/x86/tests/bp-modify.c    | 213 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 235 insertions(+), 6 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/bp-modify.c

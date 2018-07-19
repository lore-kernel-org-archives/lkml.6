Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53DBC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D93420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D93420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbeGSPRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:17:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731105AbeGSPRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:17:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C15C402243B;
        Thu, 19 Jul 2018 14:33:49 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-211.brq.redhat.com [10.40.204.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 047552026D6B;
        Thu, 19 Jul 2018 14:33:45 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCHv2 0/4] perf tools: Fix top crashes
Date:   Thu, 19 Jul 2018 16:33:41 +0200
Message-Id: <20180719143345.12963-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 14:33:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 19 Jul 2018 14:33:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
perf top is occasionaly crashes on hitting assert, because of
the synthesize function that runs on multiple threads now.

I found some issues with list/tree accessing and this patchset
is trying to fix them.

I was runing 'perf top' in a loop with attached change below
and haven't hit any other new crash. We're either clear now
or it's really hard to hit the rest ;-)

v2 changes:
  - remove the 'struct comm_str' only in the comm_str__put
    when the refcnt drops to 0 (Namhyung)

thanks,
jirka

---
Jiri Olsa (4):
      perf tools: Add threads__get_last_match function
      perf tools: Add threads__set_last_match function
      perf tools: Use last_match threads cache only in single thread mode
      perf tools: Fix struct comm_str removal crash

 tools/perf/util/comm.c    | 15 +++++++++------
 tools/perf/util/machine.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 22 deletions(-)
---
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index ffdc2769ff9f..1b57a66ef779 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1102,6 +1102,8 @@ static int __cmd_top(struct perf_top *top)
 	if (top->nr_threads_synthesize > 1)
 		perf_set_singlethreaded();
 
+	return 0;
+
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
 		if (ret < 0)

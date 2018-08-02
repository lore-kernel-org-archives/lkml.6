Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F35BC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C0E2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C0E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeHBJ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:58:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:58:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w72889aQ3430604
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:08:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w72889bx3430601;
        Thu, 2 Aug 2018 01:08:09 -0700
Date:   Thu, 2 Aug 2018 01:08:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-a6f39cecf71537d105f4bf87b8d4760851960838@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, sandipan@linux.ibm.com,
        hpa@zytor.com, mingo@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        alexey.budankov@linux.intel.com, ravi.bangoria@linux.ibm.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: jolsa@redhat.com, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, sandipan@linux.ibm.com,
          naveen.n.rao@linux.vnet.ibm.com, alexey.budankov@linux.intel.com,
          ravi.bangoria@linux.ibm.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <20180726105502.31670-1-sandipan@linux.ibm.com>
References: <20180726105502.31670-1-sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix complex event name parsing
Git-Commit-ID: a6f39cecf71537d105f4bf87b8d4760851960838
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

Commit-ID:  a6f39cecf71537d105f4bf87b8d4760851960838
Gitweb:     https://git.kernel.org/tip/a6f39cecf71537d105f4bf87b8d4760851960838
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Thu, 26 Jul 2018 16:25:02 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:52:23 -0300

perf tests: Fix complex event name parsing

The 'umask' event parameter is unsupported on some architectures like
powerpc64.

This can be observed on a powerpc64le system running Fedora 27 as shown
below.

  # perf test "Parse event definition strings" -v
   6: Parse event definition strings                        :
  --- start ---
  test child forked, pid 45915
  ...
  running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp'Invalid event/parameter 'umask'
  Invalid event/parameter 'umask'
  failed to parse event 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp', err 1, str 'unknown term'
  event syntax error: '..,event=0x2,umask=0x3/ukp'
                                    \___ unknown term

  valid terms: event,mark,pmc,cache_sel,pmcxsel,unit,thresh_stop,thresh_start,combine,thresh_sel,thresh_cmp,sample_mode,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,no-overwrite,overwrite,driver-config

  mem_access -> cpu/event=0x10401e0/
  running test 0 'config=10,config1,config2=3,umask=1'
  test child finished with 1
  ---- end ----
  Parse event definition strings: FAILED!

Committer testing:

After applying the patch these test passes and in verbose mode we get:

  # perf test -v "event definition"
   6: Parse event definition strings:
  --- start ---
  test child forked, pid 11061
  running test 0 'syscalls:sys_enter_openat'Using CPUID GenuineIntel-6-9E
  <SNIP>
  running test 53 'cycles/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks'/Duk'
  running test 0 'cpu/config=10,config1,config2=3,period=1000/u'
  running test 1 'cpu/config=1,name=krava/u,cpu/config=2/u'
  running test 2 'cpu/config=1,call-graph=fp,time,period=100000/,cpu/config=2,call-graph=no,time=0,period=2000/'
  running test 3 'cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp'
  <SNIP>
  test child finished with 0
  ---- end ----
  Parse event definition strings: Ok
  #

Suggested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Fixes: 06dc5bf21f3f ("perf tests: Check that complex event name is parsed correctly")
Link: http://lkml.kernel.org/r/20180726105502.31670-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index a36313daec4e..3b97ac018d5a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1690,7 +1690,7 @@ static struct evlist_test test__events_pmu[] = {
 		.id    = 2,
 	},
 	{
-		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2,umask=0x3/ukp",
+		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
 		.check = test__checkevent_complex_name,
 		.id    = 3,
 	}

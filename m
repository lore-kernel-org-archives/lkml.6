Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2789C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE85208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP25neYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE85208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbeHAXZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732307AbeHAXY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:24:59 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C80208A5;
        Wed,  1 Aug 2018 21:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159432;
        bh=QSC6DBvofKuopxJf1cvfqlS/cy1HjZLD7djW3WF0rNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TP25neYlfhPb0YW+dF6S73n4lRn8cFCBdnuWr5WKot8UNLQkiPIWR4Ftae6Nytegq
         /ZgpzlLssDhGrTKeFTtNUcmXJDrZgkInbKfZzQczHdPzvJ5FFNFYra2ySCUHD76yAB
         srG0wQAFdZo3nAdgtidi943sMYX8MipKd6qbWRgc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/21] perf tests: Fix complex event name parsing
Date:   Wed,  1 Aug 2018 18:36:30 -0300
Message-Id: <20180801213648.4814-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

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
-- 
2.14.4


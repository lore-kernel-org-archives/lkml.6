Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DCBC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B13E20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfAVLh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:37:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfAVLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:37:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBbkeO2929990
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:37:47 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBbkhQ2929984;
        Tue, 22 Jan 2019 03:37:46 -0800
Date:   Tue, 22 Jan 2019 03:37:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-8bf8c6da53c2265aea365a1de6038f118f522113@git.kernel.org>
Cc:     jolsa@kernel.org, ak@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        hpa@zytor.com, yao.jin@linux.intel.com, tonyj@suse.de,
        acme@redhat.com, mingo@kernel.org
Reply-To: ravi.bangoria@linux.ibm.com, hpa@zytor.com,
          yao.jin@linux.intel.com, jolsa@kernel.org, ak@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, tonyj@suse.de, acme@redhat.com
In-Reply-To: <20190120191414.12925-1-tonyj@suse.de>
References: <20190120191414.12925-1-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Fix crash when processing recorded
 stat data
Git-Commit-ID: 8bf8c6da53c2265aea365a1de6038f118f522113
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

Commit-ID:  8bf8c6da53c2265aea365a1de6038f118f522113
Gitweb:     https://git.kernel.org/tip/8bf8c6da53c2265aea365a1de6038f118f522113
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Sun, 20 Jan 2019 11:14:14 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 11:29:07 -0300

perf script: Fix crash when processing recorded stat data

While updating perf to work with Python3 and Python2 I noticed that the
stat-cpi script was dumping core.

$ perf  stat -e cycles,instructions record -o /tmp/perf.data /bin/false

 Performance counter stats for '/bin/false':

           802,148      cycles

           604,622      instructions                                                       802,148      cycles
           604,622      instructions

       0.001445842 seconds time elapsed

$ perf script -i /tmp/perf.data -s scripts/python/stat-cpi.py
Segmentation fault (core dumped)
...
...
    rblist=rblist@entry=0xb2a200 <rt_stat>,
    new_entry=new_entry@entry=0x7ffcb755c310) at util/rblist.c:33
    ctx=<optimized out>, type=<optimized out>, create=<optimized out>,
    cpu=<optimized out>, evsel=<optimized out>) at util/stat-shadow.c:118
    ctx=<optimized out>, type=<optimized out>, st=<optimized out>)
    at util/stat-shadow.c:196
    count=count@entry=727442, cpu=cpu@entry=0, st=0xb2a200 <rt_stat>)
    at util/stat-shadow.c:239
    config=config@entry=0xafeb40 <stat_config>,
    counter=counter@entry=0x133c6e0) at util/stat.c:372
...
...

The issue is that since 1fcd03946b52 perf_stat__update_shadow_stats now calls
update_runtime_stat passing rt_stat rather than calling update_stats but
perf_stat__init_shadow_stats has never been called to initialize rt_stat in
the script path processing recorded stat data.

Since I can't see any reason why perf_stat__init_shadow_stats() is presently
initialized like it is in builtin-script.c::perf_sample__fprint_metric()
[4bd1bef8bba2f] I'm proposing it instead be initialized once in __cmd_script

Committer testing:

After applying the patch:

  # perf script -i /tmp/perf.data -s tools/perf/scripts/python/stat-cpi.py
       0.001970: cpu -1, thread -1 -> cpi 1.709079 (1075684/629394)
  #

No segfault.

Signed-off-by: Tony Jones <tonyj@suse.de>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Fixes: 1fcd03946b52 ("perf stat: Update per-thread shadow stats")
Link: http://lkml.kernel.org/r/20190120191414.12925-1-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 357906ed1898..ac221f137ed2 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1681,13 +1681,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 		.force_header = false,
 	};
 	struct perf_evsel *ev2;
-	static bool init;
 	u64 val;
 
-	if (!init) {
-		perf_stat__init_shadow_stats();
-		init = true;
-	}
 	if (!evsel->stats)
 		perf_evlist__alloc_stats(script->session->evlist, false);
 	if (evsel_script(evsel->leader)->gnum++ == 0)
@@ -2359,6 +2354,8 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
+	perf_stat__init_shadow_stats();
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;

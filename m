Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB69C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5F020661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550957655;
	bh=M792OnU84TDTHeXfCOy/dNcQQphSph2DhL6pr/fKI40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L1j4dB1ZbfKFV/I/EljGJnDDXy5QkrWi9uOjFByyNMa3dWwJCbD4wKjdM6gPsOuaH
	 rXDamhgGsREHC2zA17gn/61hczLGEOQ4ci42GI/VEql4jpRcATAldEWvJJx2k57fnt
	 8N/5IqiSPnFklMCSCVJge4e0iNpoOb/PenvXNsbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbfBWVeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbfBWVEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:04:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C7A020868;
        Sat, 23 Feb 2019 21:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955882;
        bh=M792OnU84TDTHeXfCOy/dNcQQphSph2DhL6pr/fKI40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJN2B3WttTpUz6bRtAQ/dkpA1BuwP16V0WikZ5ZNzPsf9hY4822fDKhPernQZwg6V
         NaqF0DOig00Oaj3MIIiH6ufPvh7xYX5yLaFtg+WvywiTKQ1i23MIHUYWV1IiJuqBA/
         b/6kdMdo4a3Fg1PpnqRmbm63oi6up75B9+uIG9js=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Jones <tonyj@suse.de>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 12/72] perf script: Fix crash when processing recorded stat data
Date:   Sat, 23 Feb 2019 16:03:22 -0500
Message-Id: <20190223210422.199966-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

[ Upstream commit 8bf8c6da53c2265aea365a1de6038f118f522113 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5c070a600233a..d8791e0e5f75b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1633,13 +1633,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
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
@@ -2305,6 +2300,8 @@ static int __cmd_script(struct perf_script *script)
 
 	signal(SIGINT, sig_handler);
 
+	perf_stat__init_shadow_stats();
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
-- 
2.19.1


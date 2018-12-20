Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F108E218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388749AbeLTSTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:19:55 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58905 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbeLTSTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:19:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIJjGF3683472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:19:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIJjAW3683469;
        Thu, 20 Dec 2018 10:19:45 -0800
Date:   Thu, 20 Dec 2018 10:19:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-thd8s16pagyza71ufi5vjlan@git.kernel.org>
Cc:     wangnan0@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        lclaudio@redhat.com, mingo@kernel.org, namhyung@kernel.org,
        hpa@zytor.com, acme@redhat.com, jolsa@kernel.org
Reply-To: jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
          hpa@zytor.com, lclaudio@redhat.com, mingo@kernel.org,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Allow configuring default for
 perf_event_attr.inherit
Git-Commit-ID: d32de87e734191698dd1834146ee65ebd0f5e240
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

Commit-ID:  d32de87e734191698dd1834146ee65ebd0f5e240
Gitweb:     https://git.kernel.org/tip/d32de87e734191698dd1834146ee65ebd0f5e240
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 11:06:16 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:24:01 -0300

perf trace: Allow configuring default for perf_event_attr.inherit

I.f. if children should inherit the parent perf_event configuration,
i.e. if we should trace children as well or just the parent.

The default is to follow children, to disable this and have a behaviour
similar to strace, set this config option or use the --no_inherit 'perf
trace' option.

E.g.:

Default:

  # perf config trace.no_inherit
  # trace -e clone,*sleep time sleep 1
     0.000 time/21107 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11, newsp: 0, child_tidptr: 0x7f7b8f9ae810) = 21108 (time)
         ? time/21108  ... [continued]: clone()
     0.691 sleep/21108 nanosleep(rqtp: 0x7ffed01d0540, rmtp: 0                               ) = 0
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 1988maxresident)k
  0inputs+0outputs (0major+76minor)pagefaults 0swaps
  #

Disable it:

  # trace -e clone,*sleep time sleep 1
     0.000 clone(clone_flags: CHILD_CLEARTID|CHILD_SETTID|0x11, newsp: 0, child_tidptr: 0x7ff41e100810) = 21414 (time)
  0.00user 0.00system 0:01.00elapsed 0%CPU (0avgtext+0avgdata 1964maxresident)k
  0inputs+0outputs (0major+76minor)pagefaults 0swaps
  #

Notice that since there is just one thread, the "comm/TID" column is
suppressed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-thd8s16pagyza71ufi5vjlan@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 3 +++
 tools/perf/builtin-trace.c               | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 0d641b0d15ae..cd9bf12fb255 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -529,6 +529,9 @@ trace.*::
 		activate the 'perf trace' logic that looks for syscall
 		pointer contents after the normal tracepoint payload.
 
+	trace.no_inherit::
+		Do not follow children threads.
+
 	trace.show_duration::
 		Show syscall duration.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4355dadad232..a4e2290e57e0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3542,6 +3542,8 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_duration = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_zeros")) {
 		trace->show_zeros = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.no_inherit")) {
+		trace->opts.no_inherit = perf_config_bool(var, value);
 	}
 
 	return err;

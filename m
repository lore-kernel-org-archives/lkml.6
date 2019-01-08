Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD2C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F70620883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfAHPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:38:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33637 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:38:57 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08Fcin13566220
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:38:44 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08FchJi3566217;
        Tue, 8 Jan 2019 07:38:43 -0800
Date:   Tue, 8 Jan 2019 07:38:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-sg2pkmtjr5988bhbcp4yp6sw@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        namhyung@kernel.org, acme@redhat.com, kristina.martsenko@arm.com,
        jolsa@kernel.org, will.deacon@arm.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          will.deacon@arm.com, jolsa@kernel.org, acme@redhat.com,
          kristina.martsenko@arm.com, namhyung@kernel.org,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools beauty: Make the prctl option table
 generator catch all PR_ options
Git-Commit-ID: 805e4c8b61bd62f6d3f416c915cb9bb423835fee
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

Commit-ID:  805e4c8b61bd62f6d3f416c915cb9bb423835fee
Gitweb:     https://git.kernel.org/tip/805e4c8b61bd62f6d3f416c915cb9bb423835fee
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 3 Jan 2019 14:59:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 3 Jan 2019 15:16:04 -0300

tools beauty: Make the prctl option table generator catch all PR_ options

In ba8308856564 ("arm64: add prctl control for resetting ptrauth keys")
the PR_PAC_RESET_KEYS prctl option was introduced, get that into the
regex in addition to PR_GET_* and PR_SET_*:

So just get everything that matches '^#define PR_\w+' this ends up
adding these entries:

  $ tools/perf/trace/beauty/prctl_option.sh  > after
  $ diff -u before after
  --- before	2019-01-03 14:58:51.541807353 -0300
  +++ after	2019-01-03 15:17:05.909583804 -0300
  @@ -19,12 +19,18 @@
          [20] = "SET_ENDIAN",
          [21] = "GET_SECCOMP",
          [22] = "SET_SECCOMP",
  +       [23] = "CAPBSET_READ",
  +       [24] = "CAPBSET_DROP",
          [25] = "GET_TSC",
          [26] = "SET_TSC",
          [27] = "GET_SECUREBITS",
          [28] = "SET_SECUREBITS",
          [29] = "SET_TIMERSLACK",
          [30] = "GET_TIMERSLACK",
  +       [31] = "TASK_PERF_EVENTS_DISABLE",
  +       [32] = "TASK_PERF_EVENTS_ENABLE",
  +       [33] = "MCE_KILL",
  +       [34] = "MCE_KILL_GET",
          [35] = "SET_MM",
          [36] = "SET_CHILD_SUBREAPER",
          [37] = "GET_CHILD_SUBREAPER",
  @@ -33,8 +39,13 @@
          [40] = "GET_TID_ADDRESS",
          [41] = "SET_THP_DISABLE",
          [42] = "GET_THP_DISABLE",
  +       [43] = "MPX_ENABLE_MANAGEMENT",
  +       [44] = "MPX_DISABLE_MANAGEMENT",
          [45] = "SET_FP_MODE",
          [46] = "GET_FP_MODE",
  +       [47] = "CAP_AMBIENT",
  +       [50] = "SVE_SET_VL",
  +       [51] = "SVE_GET_VL",
          [52] = "GET_SPECULATION_CTRL",
          [53] = "SET_SPECULATION_CTRL",
          [54] = "PAC_RESET_KEYS",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kristina Martsenko <kristina.martsenko@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/n/tip-sg2pkmtjr5988bhbcp4yp6sw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/prctl_option.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/prctl_option.sh b/tools/perf/trace/beauty/prctl_option.sh
index d32f8f1124af..3109d7b05e11 100755
--- a/tools/perf/trace/beauty/prctl_option.sh
+++ b/tools/perf/trace/beauty/prctl_option.sh
@@ -4,7 +4,7 @@
 [ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
 
 printf "static const char *prctl_options[] = {\n"
-regex='^#define[[:space:]]+PR_([GS]ET\w+)[[:space:]]*([[:xdigit:]]+).*'
+regex='^#define[[:space:]]+PR_(\w+)[[:space:]]*([[:xdigit:]]+).*'
 egrep $regex ${header_dir}/prctl.h | grep -v PR_SET_PTRACER | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	sort -n | xargs printf "\t[%s] = \"%s\",\n"

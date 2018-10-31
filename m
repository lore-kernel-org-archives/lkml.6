Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6FB2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6FB2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeKAHBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:01:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:01:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM1QiE2558452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:01:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM1QSk2558449;
        Wed, 31 Oct 2018 15:01:26 -0700
Date:   Wed, 31 Oct 2018 15:01:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ukweodgzbmjd25lfkgryeft1@git.kernel.org>
Cc:     dsahern@gmail.com, tglx@linutronix.de, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, benjamin@python.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, mingo@kernel.org, hpa@zytor.com
Reply-To: wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
          dsahern@gmail.com, tglx@linutronix.de, acme@redhat.com,
          hpa@zytor.com, mingo@kernel.org, adrian.hunter@intel.com,
          benjamin@python.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Consider syscall aliases too
Git-Commit-ID: f932184e282f574cfd34afee917a10b782fd3e76
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

Commit-ID:  f932184e282f574cfd34afee917a10b782fd3e76
Gitweb:     https://git.kernel.org/tip/f932184e282f574cfd34afee917a10b782fd3e76
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 25 Oct 2018 17:24:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf trace: Consider syscall aliases too

When trying to trace the 'umount' syscall on x86_64 I noticed that it
was failing:

  # trace -e umount umount /mnt
  event syntax error: 'umount'
                       \___ parser error
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

This is because in the x86-64 we have it just as 'umount2':

  $ grep umount arch/x86/entry/syscalls/syscall_64.tbl
  166	common	umount2			__x64_sys_umount
  $

So if the syscall name fails, try fallbacking to looking at the aliases
we have in the syscall_fmts table to then re-lookup, now:

  # trace -e umount umount -f /mnt
  umount: /mnt: not mounted.
     1.759 ( 0.004 ms): umount/18365 umount2(name: 0x55fbfcbc4480, flags: 1) = -1 EINVAL Invalid argument
  #

Time to beautify the flags arg :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ukweodgzbmjd25lfkgryeft1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 76c14c0129fc..db8711061ca3 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -862,6 +862,18 @@ static struct syscall_fmt *syscall_fmt__find(const char *name)
 	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
+static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
+{
+	int i, nmemb = ARRAY_SIZE(syscall_fmts);
+
+	for (i = 0; i < nmemb; ++i) {
+		if (syscall_fmts[i].alias && strcmp(syscall_fmts[i].alias, alias) == 0)
+			return &syscall_fmts[i];
+	}
+
+	return NULL;
+}
+
 /*
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
@@ -3195,6 +3207,7 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 	int len = strlen(str) + 1, err = -1, list, idx;
 	char *strace_groups_dir = system_path(STRACE_GROUPS_DIR);
 	char group_name[PATH_MAX];
+	struct syscall_fmt *fmt;
 
 	if (strace_groups_dir == NULL)
 		return -1;
@@ -3212,12 +3225,19 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 		if (syscalltbl__id(trace->sctbl, s) >= 0 ||
 		    syscalltbl__strglobmatch_first(trace->sctbl, s, &idx) >= 0) {
 			list = 1;
+			goto do_concat;
+		}
+
+		fmt = syscall_fmt__find_by_alias(s);
+		if (fmt != NULL) {
+			list = 1;
+			s = fmt->name;
 		} else {
 			path__join(group_name, sizeof(group_name), strace_groups_dir, s);
 			if (access(group_name, R_OK) == 0)
 				list = 1;
 		}
-
+do_concat:
 		if (lists[list]) {
 			sprintf(lists[list] + strlen(lists[list]), ",%s", s);
 		} else {

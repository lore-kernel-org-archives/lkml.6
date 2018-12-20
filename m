Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3F5217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbeLTSCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:02:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLTSCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:02:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI1tYB3680152
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:01:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI1taq3680148;
        Thu, 20 Dec 2018 10:01:55 -0800
Date:   Thu, 20 Dec 2018 10:01:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8q9l92eh9eee3y2bwyqku3tc@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org, acme@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com
Reply-To: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Beautify renameat2's fd arg wrt
 AT_FDCWD
Git-Commit-ID: 84a835412cdc36f3821a1daa10853f9c9aa3fc7c
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

Commit-ID:  84a835412cdc36f3821a1daa10853f9c9aa3fc7c
Gitweb:     https://git.kernel.org/tip/84a835412cdc36f3821a1daa10853f9c9aa3fc7c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 09:53:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:55 -0300

perf trace beauty: Beautify renameat2's fd arg wrt AT_FDCWD

Just like is done with the 'renameat' syscall.

  # strace -e renameat2 -f perf trace -e rename* mv c /tmp
  [pid 12334] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp", RENAME_NOREPLACE) = -1 EXDEV (Invalid cross-device link)
  [pid 12334] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp/c", RENAME_NOREPLACE) = -1 EEXIST (File exists)
     1.947 ( 0.007 ms): mv/12334 renameat2(olddfd: CWD, oldname: 0x7ffce8b7fd81, newdfd: CWD, newname: 0x7ffce8b7fd83, flags: 1) = -1 EXDEV Invalid cross-device link
     2.073 ( 0.009 ms): mv/12334 renameat2(olddfd: CWD, oldname: 0x7ffce8b7fd81, newdfd: CWD, newname: 0x55ce7f0a1cc0, flags: 1mv: ) = -1 EEXIST File exists'c' and '/tmp/c' are the same file
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8q9l92eh9eee3y2bwyqku3tc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 406bceda6a2b..60c61a89436f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -799,6 +799,9 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "renameat2",
+	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
+		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_sigprocmask",

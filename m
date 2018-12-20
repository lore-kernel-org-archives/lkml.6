Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C08C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1634C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbeLTSax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:30:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbeLTSau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:30:50 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIUfkh3687066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:30:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIUfJW3687063;
        Thu, 20 Dec 2018 10:30:41 -0800
Date:   Thu, 20 Dec 2018 10:30:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-27qhouo1kaac2iyl85nfnsf5@git.kernel.org>
Cc:     mingo@kernel.org, lclaudio@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        namhyung@kernel.org
Reply-To: wangnan0@huawei.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, lclaudio@redhat.com, mingo@kernel.org,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty mmap: Print mmap's 'offset' arg in
 hexadecimal
Git-Commit-ID: a66313408a08a9758e3007fe9a6cfe47b0dec88b
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

Commit-ID:  a66313408a08a9758e3007fe9a6cfe47b0dec88b
Gitweb:     https://git.kernel.org/tip/a66313408a08a9758e3007fe9a6cfe47b0dec88b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 11:25:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:20 -0300

perf beauty mmap: Print mmap's 'offset' arg in hexadecimal

Also to make it match 'strace' output, for regression testing.

Both now produce this option, when 'perf trace' uses a .perfconfig
asking for the strace like output:

  mmap(0x7faf66e6a000, 1363968, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22000) = 0x7faf66e6a000

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-27qhouo1kaac2iyl85nfnsf5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2cc62ca75b2e..ebde59e61133 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -756,7 +756,8 @@ static struct syscall_fmt {
 	.alias = "old_mmap",
 #endif
 	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
-		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ },
+		   [5] = { .scnprintf = SCA_HEX,	/* offset */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
 		   [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */

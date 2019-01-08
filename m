Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B1B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfAHPoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:44:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36059 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfAHPoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:44:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08FiDI73568738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:44:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08FiDia3568735;
        Tue, 8 Jan 2019 07:44:13 -0800
Date:   Tue, 8 Jan 2019 07:44:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ivan Krylov <tipbot@zytor.com>
Message-ID: <tip-442b4eb3af44906fcbb526d98c314b27f8c9acf3@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        hpa@zytor.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        namhyung@kernel.org, krylov.r00t@gmail.com, acme@redhat.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          krylov.r00t@gmail.com, acme@redhat.com, namhyung@kernel.org
In-Reply-To: <20181014111803.5d83b806@Tarkus>
References: <20181014111803.5d83b806@Tarkus>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Pass filename to objdump via execl
Git-Commit-ID: 442b4eb3af44906fcbb526d98c314b27f8c9acf3
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

Commit-ID:  442b4eb3af44906fcbb526d98c314b27f8c9acf3
Gitweb:     https://git.kernel.org/tip/442b4eb3af44906fcbb526d98c314b27f8c9acf3
Author:     Ivan Krylov <krylov.r00t@gmail.com>
AuthorDate: Sun, 14 Oct 2018 11:18:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 4 Jan 2019 12:54:49 -0300

perf annotate: Pass filename to objdump via execl

The symbol__disassemble() function uses shell to launch objdump and
filter its output via grep. Passing filenames by interpolating them into
the command line via "%s" may lead to problems if said filenames contain
special characters.

Instead, pass the filename as a command line argument where it is not
subject to any kind of interpretation, then use quoted shell
interpolation to build the strings we need safely.

Signed-off-by: Ivan Krylov <krylov.r00t@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181014111803.5d83b806@Tarkus
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ac9805e0bc76..70de8f6b3aee 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1723,15 +1723,14 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"%s\" 2>/dev/null|grep -v \"%s:\"|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
 		 opts->show_asm_raw ? "" : "--no-show-raw",
-		 opts->annotate_src ? "-S" : "",
-		 symfs_filename, symfs_filename);
+		 opts->annotate_src ? "-S" : "");
 
 	if (err < 0) {
 		pr_err("Failure allocating memory for the command to run\n");
@@ -1756,7 +1755,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		close(stdout_fd[0]);
 		dup2(stdout_fd[1], 1);
 		close(stdout_fd[1]);
-		execl("/bin/sh", "sh", "-c", command, NULL);
+		execl("/bin/sh", "sh", "-c", command, "--", symfs_filename,
+		      NULL);
 		perror(command);
 		exit(-1);
 	}

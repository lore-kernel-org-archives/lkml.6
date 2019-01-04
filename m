Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E685C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52674218E0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626884;
	bh=wcV2ekQYwBjc//N2/7/ML4ZBsilyMMq/aDqXQEd09bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NnnMI1xe31uD1RBQ4NCuMHJIX7VfCFceRqie66xvRGf3HEdx0oIDhWJrm4msmsAcN
	 UE/uZqzjRCY9ZRIga5s/+gNSlMGJQ//Tgy3eRPK9NhOItWd8lD00qrCj+I9CU/Z8QY
	 WvyEsqrOr+PTLK2ZnvaWxCFYlAKLlXvcqkaT241s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfADSen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728731AbfADSej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:39 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827C9218E2;
        Fri,  4 Jan 2019 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626879;
        bh=wcV2ekQYwBjc//N2/7/ML4ZBsilyMMq/aDqXQEd09bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWIBIEfqeMvDkOiNAL2eqRyPNkbcfNZsgLrc5tsXTYJvx5Mu1SyqYetZziKvzBejx
         4jNecgBjcMoWDix/4WcdlSrC+yCCem9e/WPdo5DhvOBbRXn0BxgRjDrs+2Y/Q9jjaC
         I7C+BUWre9USsahzeH1TTrR2kTUfaiU86xnGK+Ec=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Ivan Krylov <krylov.r00t@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 13/16] perf annotate: Pass filename to objdump via execl
Date:   Fri,  4 Jan 2019 15:33:34 -0300
Message-Id: <20190104183337.12771-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Krylov <krylov.r00t@gmail.com>

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
-- 
2.20.1


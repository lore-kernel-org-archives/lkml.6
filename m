Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD49EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C0B2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96C0B2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbeHWMIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:08:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729534AbeHWMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:08:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8dfmt3188462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:39:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8degY3188457;
        Thu, 23 Aug 2018 01:39:40 -0700
Date:   Thu, 23 Aug 2018 01:39:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2354ae9bdc320939cc74695b564ccf178780dd61@git.kernel.org>
Cc:     mpetlan@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          mpetlan@redhat.com, acme@redhat.com, jolsa@kernel.org,
          mingo@kernel.org, alexander.shishkin@linux.intel.com,
          dsahern@gmail.com, namhyung@kernel.org, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <20180817094813.15086-3-jolsa@kernel.org>
References: <20180817094813.15086-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Get rid of dso__needs_decompress()
 call in symbol__disassemble()
Git-Commit-ID: 2354ae9bdc320939cc74695b564ccf178780dd61
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

Commit-ID:  2354ae9bdc320939cc74695b564ccf178780dd61
Gitweb:     https://git.kernel.org/tip/2354ae9bdc320939cc74695b564ccf178780dd61
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Get rid of dso__needs_decompress() call in symbol__disassemble()

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4268b948e0e..20061cf42288 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1629,6 +1629,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	char symfs_filename[PATH_MAX];
 	struct kcore_extract kce;
 	bool delete_extract = false;
+	bool decomp = false;
 	int stdout_fd[2];
 	int lineno = 0;
 	int nline;
@@ -1662,6 +1663,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 						 tmp, sizeof(tmp)) < 0)
 			goto out;
 
+		decomp = true;
 		strcpy(symfs_filename, tmp);
 	}
 
@@ -1748,7 +1750,7 @@ out_free_command:
 out_remove_tmp:
 	close(stdout_fd[0]);
 
-	if (dso__needs_decompress(dso))
+	if (decomp)
 		unlink(symfs_filename);
 
 	if (delete_extract)

Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4A7C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5036820857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5036820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbeIFRmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:42:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43803 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbeIFRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:42:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D6CrT303432
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:06:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D6CI5303429;
        Thu, 6 Sep 2018 06:06:12 -0700
Date:   Thu, 6 Sep 2018 06:06:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chris Phlipot <tipbot@zytor.com>
Message-ID: <tip-c9f23d2bc21cb263ae931f3e264d003d746107bb@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, cphlipot0@gmail.com
Reply-To: cphlipot0@gmail.com, peterz@infradead.org, tglx@linutronix.de,
          namhyung@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20180830021950.15563-1-cphlipot0@gmail.com>
References: <20180830021950.15563-1-cphlipot0@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf event-parse: Use fixed size string for comms
Git-Commit-ID: c9f23d2bc21cb263ae931f3e264d003d746107bb
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

Commit-ID:  c9f23d2bc21cb263ae931f3e264d003d746107bb
Gitweb:     https://git.kernel.org/tip/c9f23d2bc21cb263ae931f3e264d003d746107bb
Author:     Chris Phlipot <cphlipot0@gmail.com>
AuthorDate: Wed, 29 Aug 2018 19:19:50 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:51:45 -0300

perf event-parse: Use fixed size string for comms

Some implementations of libc do not support the 'm' width modifier as
part of the scanf string format specifier. This can cause the parsing to
fail.  Since the parser never checks if the scanf parsing was
successesful, this can result in a crash.

Change the comm string to be allocated as a fixed size instead of
dynamically using 'm' scanf width modifier. This can be safely done
since comm size is limited to 16 bytes by TASK_COMM_LEN within the
kernel.

This change prevents perf from crashing when linked against bionic as
well as reduces the total number of heap allocations and frees invoked
while accomplishing the same task.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830021950.15563-1-cphlipot0@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-parse.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 920b1d58a068..e76214f8d596 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -164,16 +164,15 @@ void parse_ftrace_printk(struct tep_handle *pevent,
 void parse_saved_cmdline(struct tep_handle *pevent,
 			 char *file, unsigned int size __maybe_unused)
 {
-	char *comm;
+	char comm[17]; /* Max comm length in the kernel is 16. */
 	char *line;
 	char *next = NULL;
 	int pid;
 
 	line = strtok_r(file, "\n", &next);
 	while (line) {
-		sscanf(line, "%d %ms", &pid, &comm);
-		tep_register_comm(pevent, comm, pid);
-		free(comm);
+		if (sscanf(line, "%d %16s", &pid, comm) == 2)
+			tep_register_comm(pevent, comm, pid);
 		line = strtok_r(NULL, "\n", &next);
 	}
 }

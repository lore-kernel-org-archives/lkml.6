Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B828CC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73AD920862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMnRbwQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AD920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeICTNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbeICTNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:35 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929242086A;
        Mon,  3 Sep 2018 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986384;
        bh=kARh+K82HaIKQFzLkEAVhImxVWPLKPd+L8SUDs5orsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMnRbwQJE3Ln9iNBj1tcHNABpu7PmjNdDw1f6YPckXxiUhu5QoP+yYN0e5YlqkXpi
         gjqZr2u18WwztMI3eE5vTv022+g4YRJDh+9JfEwW58NifLVKCFkX6ttc2TgE7JW32u
         VDSFIyfzD4jmq3owBkw124iR1h8s3w4ei5mnSlfI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Chris Phlipot <cphlipot0@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/13] perf event-parse: Use fixed size string for comms
Date:   Mon,  3 Sep 2018 11:52:22 -0300
Message-Id: <20180903145224.12318-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Phlipot <cphlipot0@gmail.com>

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
-- 
2.14.4


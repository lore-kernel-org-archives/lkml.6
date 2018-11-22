Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF40C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7CB20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7CB20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392363AbeKVRjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:39:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeKVRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:39:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM71SvT3688980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:01:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM71R673688976;
        Wed, 21 Nov 2018 23:01:27 -0800
Date:   Wed, 21 Nov 2018 23:01:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-oshrcgcekiyhd0whwisxfvtv@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, dsahern@gmail.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, namhyung@kernel.org, mingo@kernel.org,
        wangnan0@huawei.com
Reply-To: hpa@zytor.com, dsahern@gmail.com, acme@redhat.com,
          jolsa@kernel.org, wangnan0@huawei.com, mingo@kernel.org,
          namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Filter on a hard coded pid
Git-Commit-ID: 55f127b43143363d000165c7cb72e4b95de1380d
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

Commit-ID:  55f127b43143363d000165c7cb72e4b95de1380d
Gitweb:     https://git.kernel.org/tip/55f127b43143363d000165c7cb72e4b95de1380d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 15:23:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf augmented_syscalls: Filter on a hard coded pid

Just to show where we'll hook pid based filters, and what we use to
obtain the current pid, using a BPF getpid() equivalent.

Now we need to remove that hardcoded PID with a BPF hash map, so that we
start by filtering 'perf trace's own PID, implement the --filter-pid
functionality, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oshrcgcekiyhd0whwisxfvtv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 90a19336310b..2feb00018f79 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -15,6 +15,7 @@
  */
 
 #include <stdio.h>
+#include <unistd.h>
 #include <linux/socket.h>
 
 /* bpf-output associated map */
@@ -56,6 +57,9 @@ int sys_enter(struct syscall_enter_args *args)
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
 
+	if (getpid() == 2971)
+		return 0;
+
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
 	/*
 	 * Yonghong and Edward Cree sayz:
@@ -125,7 +129,7 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */
+	return getpid() != 2971;
 }
 
 license(GPL);

Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAEFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D21120864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D21120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404855AbeKVRl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:41:58 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404841AbeKVRl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:41:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM73jRW3689314
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:03:45 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM73j1c3689311;
        Wed, 21 Nov 2018 23:03:45 -0800
Date:   Wed, 21 Nov 2018 23:03:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-rkbu536af66dbsfx51sr8yof@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dsahern@gmail.com
Reply-To: jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          acme@redhat.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, dsahern@gmail.com, hpa@zytor.com,
          mingo@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Drop 'write', 'poll' for
 testing without self pid filter
Git-Commit-ID: 77ecb64050ff580963cbb8b8f1b02db91dc9efaf
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

Commit-ID:  77ecb64050ff580963cbb8b8f1b02db91dc9efaf
Gitweb:     https://git.kernel.org/tip/77ecb64050ff580963cbb8b8f1b02db91dc9efaf
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 16:01:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter

When testing system wide tracing without filtering the syscalls called
by 'perf trace' itself we get into a feedback loop, drop for now those
two syscalls, that are the ones that 'perf trace' does in its loop for
writing the syscalls it intercepts, to help with testing till we get
that filtering in place.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-rkbu536af66dbsfx51sr8yof@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index ec109c12ff24..7d729319618c 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -43,7 +43,9 @@ struct augmented_filename {
 	char		value[256];
 };
 
+#define SYS_WRITE 1
 #define SYS_OPEN 2
+#define SYS_POLL 7
 #define SYS_OPENAT 257
 
 SEC("raw_syscalls:sys_enter")
@@ -101,6 +103,8 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
+	case SYS_WRITE:
+	case SYS_POLL:	 return 0;
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;

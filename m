Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4BDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CEE2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CEE2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeIFRyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:54:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:53:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DILWw305375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:18:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DILG4305372;
        Thu, 6 Sep 2018 06:18:21 -0700
Date:   Thu, 6 Sep 2018 06:18:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6qh8aph1jklyvdu7w89c0izc@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, acme@redhat.com,
        hpa@zytor.com, mingo@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de
Reply-To: dsahern@gmail.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
          hpa@zytor.com, mingo@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add syscall_exit() helper
Git-Commit-ID: 664b6a95d771a6dcd7069996c825a03be411ef99
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

Commit-ID:  664b6a95d771a6dcd7069996c825a03be411ef99
Gitweb:     https://git.kernel.org/tip/664b6a95d771a6dcd7069996c825a03be411ef99
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 30 Aug 2018 08:48:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf bpf: Add syscall_exit() helper

So that we can hook to the syscalls:sys_exit_SYSCALL tracepoints in
addition to the syscalls:sys_enter_SYSCALL we hook using the
syscall_enter() helper.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6qh8aph1jklyvdu7w89c0izc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 47897d65e799..52b6d87fe822 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -26,6 +26,9 @@ struct bpf_map {
 #define syscall_enter(name) \
 	SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name
 
+#define syscall_exit(name) \
+	SEC("syscalls:sys_exit_" #name) syscall_exit_ ## name
+
 #define license(name) \
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;

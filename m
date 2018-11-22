Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7170C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB7D20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB7D20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392349AbeKVRjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:39:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53751 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732578AbeKVRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:39:19 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM70rGj3688930
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:00:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM70r063688927;
        Wed, 21 Nov 2018 23:00:53 -0800
Date:   Wed, 21 Nov 2018 23:00:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-zo8hv22onidep7tm785dzxfk@git.kernel.org>
Cc:     namhyung@kernel.org, wangnan0@huawei.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, dsahern@gmail.com,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org, wangnan0@huawei.com, tglx@linutronix.de,
          hpa@zytor.com, dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add unistd.h to the headers accessible to
 bpf proggies
Git-Commit-ID: 1475d35c4a6174d4ec633b9af5713e9770b3ac0d
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

Commit-ID:  1475d35c4a6174d4ec633b9af5713e9770b3ac0d
Gitweb:     https://git.kernel.org/tip/1475d35c4a6174d4ec633b9af5713e9770b3ac0d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 15:21:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:30 -0300

perf bpf: Add unistd.h to the headers accessible to bpf proggies

Start with a getpid() function wrapping BPF_FUNC_get_current_pid_tgid,
idea is to mimic the system headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zo8hv22onidep7tm785dzxfk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/unistd.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/include/bpf/unistd.h b/tools/perf/include/bpf/unistd.h
new file mode 100644
index 000000000000..ca7877f9a976
--- /dev/null
+++ b/tools/perf/include/bpf/unistd.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+#include <bpf.h>
+
+static int (*bpf_get_current_pid_tgid)(void) = (void *)BPF_FUNC_get_current_pid_tgid;
+
+static pid_t getpid(void)
+{
+	return bpf_get_current_pid_tgid();
+}

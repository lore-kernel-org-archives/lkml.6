Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3674220864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3674220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbeKVRl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:41:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49643 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeKVRl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:41:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM73Bse3689284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:03:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM73BTl3689281;
        Wed, 21 Nov 2018 23:03:11 -0800
Date:   Wed, 21 Nov 2018 23:03:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9sybmz4vchlbpqwx2am13h9e@git.kernel.org>
Cc:     namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        wangnan0@huawei.com, dsahern@gmail.com, jolsa@kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, dsahern@gmail.com,
          jolsa@kernel.org, wangnan0@huawei.com, acme@redhat.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Add simple pid_filter class accessible to
 BPF proggies
Git-Commit-ID: 8008aab0962ea68cc00d15e8d7b0637b48837a40
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

Commit-ID:  8008aab0962ea68cc00d15e8d7b0637b48837a40
Gitweb:     https://git.kernel.org/tip/8008aab0962ea68cc00d15e8d7b0637b48837a40
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 15:50:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf bpf: Add simple pid_filter class accessible to BPF proggies

Will be used in the augmented_raw_syscalls.c to implement 'perf trace
--filter-pids'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9sybmz4vchlbpqwx2am13h9e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/pid_filter.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/include/bpf/pid_filter.h b/tools/perf/include/bpf/pid_filter.h
new file mode 100644
index 000000000000..6e61c4bdf548
--- /dev/null
+++ b/tools/perf/include/bpf/pid_filter.h
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: LGPL-2.1
+
+#ifndef _PERF_BPF_PID_FILTER_
+#define _PERF_BPF_PID_FILTER_
+
+#include <bpf.h>
+
+#define pid_filter(name) pid_map(name, bool)
+
+static int pid_filter__add(struct bpf_map *pids, pid_t pid)
+{
+	bool value = true;
+	return bpf_map_update_elem(pids, &pid, &value, BPF_NOEXIST);
+}
+
+static bool pid_filter__has(struct bpf_map *pids, pid_t pid)
+{
+	return bpf_map_lookup_elem(pids, &pid) != NULL;
+}
+
+#endif // _PERF_BPF_PID_FILTER_

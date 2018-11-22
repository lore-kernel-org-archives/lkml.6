Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB9FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D352080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocUn0o87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D352080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404255AbeKVOOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404188AbeKVOOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:04 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9652080F;
        Thu, 22 Nov 2018 03:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857799;
        bh=XViYGOUyCenudCsE1fLn56/acuTwIByVFJkStqErcNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocUn0o87mtzRvfmn/yy7Su1+W4qqcXzPQQII2O1vFg5t0t68ymVNzZ1mq3zPCFMwg
         1TRijJKTGcPaxKAJqV3KmQSQ6UEmdQ93jsjMoJvq4f6Lko39ALOy6EKgsOyeOJN4DF
         5c0JN6lv7NChuqsDlqD3pnhbHWgESmmZc2mTmJRs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/28] perf bpf: Add simple pid_filter class accessible to BPF proggies
Date:   Thu, 22 Nov 2018 00:35:48 -0300
Message-Id: <20181122033611.15890-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 create mode 100644 tools/perf/include/bpf/pid_filter.h

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
-- 
2.14.5


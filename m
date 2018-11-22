Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626720821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rajhGuUc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0626720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404200AbeKVON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbeKVONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:13:53 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8837B20878;
        Thu, 22 Nov 2018 03:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857787;
        bh=VKrJsk0wqStekzwkSud8oafyoCEB9b3bndImewGBYyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rajhGuUcKtLqRTSV3KdjCyOyTlHdDYIgoxkR+ece+dIyJ37eoUsuvoDn5azbtg81o
         SE06Z/MVcgsHGWdDBXF+mEoBcWEZA5l2i/Fv5xoeDtI61FTx5uZtcyLKFY3upnWiqB
         UAtn4B8rn5I9k7WND+3sHbS/RfSwG/DtVFNgXHXk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/28] perf bpf: Add unistd.h to the headers accessible to bpf proggies
Date:   Thu, 22 Nov 2018 00:35:44 -0300
Message-Id: <20181122033611.15890-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 create mode 100644 tools/perf/include/bpf/unistd.h

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
-- 
2.14.5


Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D60C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9252080F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY5Kn7Jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9252080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404367AbeKVOO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:28 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167AC206BA;
        Thu, 22 Nov 2018 03:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857822;
        bh=vNoyr4ztF4Zy/XaFFR6tIwJUnwOsA1bOV4AkTgjsJSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PY5Kn7JdbDHkbT5D2lTW4XOiHG/Nu3oFGxzZrw9j+4fB8G99YG7GfLpEPSAcjcbUu
         p4ERYWInZmmSxBSScax5Js86Zuo0B9D1UooWa+fn59SumnfpTT2xFLn7/3qb9z5nfd
         O4uW1QNEGXCWe284mBGBSOW7gQJYlbQUa7UoDRZ4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 13/28] Revert "perf augmented_syscalls: Drop 'write', 'poll' for testing without self pid filter"
Date:   Thu, 22 Nov 2018 00:35:56 -0300
Message-Id: <20181122033611.15890-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that we have the "filtered_pids" logic in place, no need to do this
rough filter to avoid the feedback loop from 'perf trace's own syscalls,
revert it.

This reverts commit 7ed71f124284359676b6496ae7db724fee9da753.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-88vh02cnkam0vv5f9vp02o3h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 3f26e705b86c..74ce7574073d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -44,9 +44,7 @@ struct augmented_filename {
 	char		value[256];
 };
 
-#define SYS_WRITE 1
 #define SYS_OPEN 2
-#define SYS_POLL 7
 #define SYS_OPENAT 257
 
 pid_filter(pids_filtered);
@@ -106,8 +104,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
-	case SYS_WRITE:
-	case SYS_POLL:	 return 0;
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
-- 
2.14.5


Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887B0C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAF42087E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEyliJ8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DAF42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404213AbeKVON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404188AbeKVON4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:13:56 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A652080F;
        Thu, 22 Nov 2018 03:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857790;
        bh=LQCTGUqw6dzx/msz6xY4/C5DIvZ1pdgTKSn/HJhnVn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEyliJ8d48sPk6wgBE97aGsjC+x1MSZLYn7udSiaFmAtcJ2AuNwQ/LmJxEzyrGfwF
         7x22GXJBbUudy5MwewEUS0fpGO1zzqzFIYerX2ccDgGkyX4QScCYAZm8Yl0ecoIrKc
         y8UhR08MnOjm89uNLHdy+WW/M13rvNKd653n3/lE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/28] perf augmented_syscalls: Filter on a hard coded pid
Date:   Thu, 22 Nov 2018 00:35:45 -0300
Message-Id: <20181122033611.15890-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.5


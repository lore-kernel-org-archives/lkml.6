Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437E920844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458405;
	bh=3q1MT++GyIIy1yC6+fYQ8UlBmTndj32nV68n5m4umSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ktEFBDspc+iBt3+Z6g0qPIyhxHcQQ2K9OunMios98chV/nq7Nt4PjButhlc+TGj9N
	 aVs1coKxP1RpBt+hSSRz0mPioSVVjkR4zWHQS504HOeWMWBRNUBlGm9N3IWm5Xd5CF
	 Yw+24PG/BNFMmtK90pySyqrjqHajEkNL5J1j2mfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbfAYXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730015AbfAYXT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:56 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3496A21902;
        Fri, 25 Jan 2019 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458396;
        bh=3q1MT++GyIIy1yC6+fYQ8UlBmTndj32nV68n5m4umSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJdeG27AHzTueFlx4qMT/1t7PnRAqbxXyNze4eI8tcpfHdXzY6RFGzbADzPy+sDIl
         TlPSjTMtWGwUlmr9cwsWC3Tlqu/R5kJuscd7Dls9zGviFtemOAnhEv4++cmp53SNyN
         foshIVdTBdWZd3932zmp9FW6ti8iL+hl1DMiIpbM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 29/29] perf augmented_syscalls: Convert to bpf_map()
Date:   Sat, 26 Jan 2019 00:18:43 +0100
Message-Id: <20190125231843.2895-30-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To make the code more compact, end result is the same:

  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c sleep 1
     0.000 ( 0.008 ms): sleep/9663 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.022 ( 0.005 ms): sleep/9663 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.226 ( 0.006 ms): sleep/9663 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-23z08bgizqnbc3qdsyl7jyyg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index b7dba114e36c..524fdb8534b3 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -19,12 +19,8 @@
 #include <stdio.h>
 #include <linux/socket.h>
 
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-       .key_size = sizeof(int),
-       .value_size = sizeof(u32),
-       .max_entries = __NR_CPUS__,
-};
+/* bpf-output associated map */
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct syscall_exit_args {
 	unsigned long long common_tp_fields;
-- 
2.20.1


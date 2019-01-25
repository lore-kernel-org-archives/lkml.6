Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C47C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0872A21907
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458394;
	bh=pQFbNYB5EgENRYD0KH5SdpGhHhEUTWsR6THAnZpjNoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wUkwedQIxM/movpYmvlmxhP4SV1stFRb2rX5XlufNTKg0rHpx/a01kkVWnFsAHPlT
	 zYlUJ2L6pLP54Li1Z9CMW+tP0RKIbW4j+otxQa9X+HRM2UNysjtOLqul8sYFREd9ZK
	 umGwo3I7V+VieNX/g7eory3AvVhqzL6D/jxbuv1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfAYXTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729959AbfAYXTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:50 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5945218FF;
        Fri, 25 Jan 2019 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458389;
        bh=pQFbNYB5EgENRYD0KH5SdpGhHhEUTWsR6THAnZpjNoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSYLCjJ4Du2nWl+rH+seSmxUNXscoVnfv7hwcRXRYBJ+8KQbMvE7bd/ihnnDSE7U9
         Du5AGzyXxcTOjoqn5k2CyNp2nF263cW4f1tZL6/CMYUOB6o2EdWlk2QdG3LqOryu0a
         1/1tO6TlVA0DGGhXTC/3+roe3Fhy/Fv9H11PQ97g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 26/29] perf augmented_raw_syscalls: Use bpf_map()
Date:   Sat, 26 Jan 2019 00:18:40 +0100
Message-Id: <20190125231843.2895-27-acme@kernel.org>
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

To make the code more compact and also paving the way to have the BTF
annotation to be done transparently.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-pjlf38sv3i1hbn5vzkr4y3ol@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 9e9d4c66e53c..f9b2161e1ca4 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -18,23 +18,13 @@
 #include <pid_filter.h>
 
 /* bpf-output associated map */
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(u32),
-	.max_entries = __NR_CPUS__,
-};
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct syscall {
 	bool	enabled;
 };
 
-struct bpf_map SEC("maps") syscalls = {
-	.type	     = BPF_MAP_TYPE_ARRAY,
-	.key_size    = sizeof(int),
-	.value_size  = sizeof(struct syscall),
-	.max_entries = 512,
-};
+bpf_map(syscalls, ARRAY, int, struct syscall, 512);
 
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
-- 
2.20.1


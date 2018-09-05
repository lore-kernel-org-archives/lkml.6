Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0101FC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9562083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOp0ast1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE9562083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeIFChS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:17 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F7E82083D;
        Wed,  5 Sep 2018 22:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185106;
        bh=BeklGlUxecL8vM/mmOFme74Dze9Ydnr1A8gIJvEI5dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MOp0ast15L5E/HrcvY+JDIjHC508W+ae9vY0h96oArbTrPZqdFgX5Xdm4H3+hNG0R
         mJGnLacfcbRQHhludgdJBELNeJNtmTCbHk/BTIRJdmI/CI1JeVLTNMHi9epKVjrBF9
         vXsLEbix/paNLZWRl6j7vQVk95E9zhfEgCVcKLY0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/77] perf trace: Show comm/tid for augmented_syscalls
Date:   Wed,  5 Sep 2018 19:03:28 -0300
Message-Id: <20180905220440.20256-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get us a bit more like the sys_enter + sys_exit combo:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC)
     0.009 ( 0.009 ms): cat/3619 openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC) = 3
     0.051 (         ): openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC)
     0.054 ( 0.010 ms): cat/3619 openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC) = 3
     0.539 (         ): openat(dfd: CWD, filename: 0xca71506b)
     0.543 ( 0.115 ms): cat/3619 openat(dfd: CWD, filename: 0xca71506b) = 3
  #

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): cat/4919 openat(dfd: CWD, filename: 0xc8358da8, flags: CLOEXEC)
     0.007 ( 0.005 ms): cat/4919 openat(dfd: CWD, filename: 0xc8358da8, flags: CLOEXEC) = 3
     0.032 (         ): cat/4919 openat(dfd: CWD, filename: 0xc8560ce0, flags: CLOEXEC)
     0.033 ( 0.006 ms): cat/4919 openat(dfd: CWD, filename: 0xc8560ce0, flags: CLOEXEC) = 3
     0.301 (         ): cat/4919 openat(dfd: CWD, filename: 0x91fa306b)
     0.304 ( 0.004 ms): cat/4919 openat(dfd: CWD, filename: 0x91fa306b) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6w8ytyo5y655a1hsyfpfily6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 92488edd00eb..e46ac9009172 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2069,6 +2069,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 
 			if (thread) {
+				trace__fprintf_comm_tid(trace, thread, trace->output);
 				fprintf(trace->output, "%s(", sc->name);
 				trace__fprintf_sys_enter(trace, evsel, sample);
 				fputc(')', trace->output);
-- 
2.14.4


Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46077C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00ED821D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQe2CTcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00ED821D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733229AbeHIR1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:27:18 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E003214FF;
        Thu,  9 Aug 2018 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826920;
        bh=PHpTCiIKF82VDWDQRz3Ahv8+VjcLR5iF8+G6NT8Akk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQe2CTcz+cw9/rOpNkyOkvDGewbdn91aRIl1ejMnqwitj2F7QRFdvW4QMeI6u9IWX
         LHtdasGh1kM90B/kN+xXZXDjfa5IzbOE3Wtpb+HpLhsPkvulJzAMAKaylmVN79lpd1
         pjsrccxnpu7cQnUJ/G5hUMJ53lqV6E8iK1xjatpE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 42/44] perf trace: Wire up the augmented syscalls with the syscalls:sys_enter_FOO beautifier
Date:   Thu,  9 Aug 2018 11:58:20 -0300
Message-Id: <20180809145822.21391-43-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We just check that the evsel is the one we associated with the
bpf-output event associated with the "__augmented_syscalls__" eBPF map,
to show that the formatting is done properly:

  # perf trace -e perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC
     0.007 ( 0.004 ms): cat/11486 openat(dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC                 ) = 3
     0.029 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC
     0.030 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC
     0.031 ( 0.004 ms): cat/11486 openat(dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC                 ) = 3
     0.249 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xc3700d6
     0.250 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0xc3700d6
     0.252 ( 0.003 ms): cat/11486 openat(dfd: CWD, filename: 0xc3700d6                                  ) = 3
  #

Now we just need to get the full blown enter/exit handlers to check if the
evsel being processed is the augmented_syscalls one to go pick the pointer
payloads from the end of the payload.

We also need to state somehow what is the layout for multi pointer arg syscalls.

Also handy would be to have a BTF file with the struct definitions used in
syscalls, compact, generated at kernel built time and available for use in eBPF
programs.

Till we get there we can go on doing some manual coupling of the most relevant
syscalls with some hand built beautifiers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r6ba5izrml82nwfmwcp7jpkm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 06215acb1481..22ab8e67c760 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2042,7 +2042,10 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	fprintf(trace->output, "%s:", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
-		bpf_output__fprintf(trace, sample);
+		if (evsel == trace->syscalls.events.augmented)
+			trace__fprintf_sys_enter(trace, evsel, sample);
+		else
+			bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
 		    trace__fprintf_sys_enter(trace, evsel, sample)) {
-- 
2.14.4


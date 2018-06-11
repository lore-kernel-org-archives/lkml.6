Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65710C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFEB208B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hygXtL7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BFEB208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933940AbeFKRtN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933838AbeFKRtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:49:09 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D91D5208AF;
        Mon, 11 Jun 2018 17:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528739349;
        bh=wuiUAmUZzPprye6t7CYLOLulSlnT9ewKfNm4OTzqX9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hygXtL7aqrR6SA0bb5NxrggcjJdPSgvaDgTue9PaxYjhAKlR5AHGapXZTEe0wKa+p
         ZnDC1zwjQulh3E87X6ySb7MqA2nnxnx6853yuoBRDcn5gOxxX3IQZft25Yy2B28gP8
         E+rfTHi3f4LKkg1DTDvCbdlYsI92VR7tGC2IkX9Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/12] perf script: Show hw-cache events
Date:   Mon, 11 Jun 2018 14:48:10 -0300
Message-Id: <20180611174810.14815-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611174810.14815-1-acme@kernel.org>
References: <20180611174810.14815-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>

'perf script' fails to report hardware cache events (PERF_TYPE_HW_CACHE)
where as 'perf report' shows the samples. Fix it. Ex,

  # perf record -e L1-dcache-loads ./a.out
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.008 MB perf.data (11 samples)]

Before patch:

  # perf script | wc -l
  0

After patch:

  # perf script | wc -l
  11

Committer testing:

  [root@jouet ~]# perf script | head -30 | tail
        Timer 9803 [2] 8.963330:  1554 L1-dcache-loads: 7ffef89baae4 __vdso_clock_gettime+0xf4 ([vdso])
      swapper    0 [2] 8.963343:  5626 L1-dcache-loads: ffffffffa66f4f6b cpuidle_not_av+0xb (/lib/modules/4.17.0-rc5/build/vmlinux)
      firefox 4853 [2] 8.964070: 18935 L1-dcache-loads: 7f0b9a00dc30 xcb_poll_for_event+0x0 (/usr/lib64/libxcb.so.1.1.0)
  Softwar~cTh 4928 [2] 8.964548: 15928 L1-dcache-loads: ffffffffa60d795c update_curr+0x10c (/lib/modules/4.17.0-rc5/build/vmlinux)
      firefox 4853 [2] 8.964675: 14978 L1-dcache-loads: ffffffffa6897018 mutex_unlock+0x18 (/lib/modules/4.17.0-rc5/build/vmlinux)
  gnome-shell 2026 [3] 8.964693: 50670 L1-dcache-loads: 7fa08854de6d g_source_iter_next+0x6d (/usr/lib64/libglib-2.0.so.0.5400.3)
   Compositor 4929 [1] 8.964784: 71772 L1-dcache-loads: 7f0b936bf078 [unknown] (/usr/lib64/firefox/libxul.so)
     Xwayland 2096 [2] 8.964919: 16799 L1-dcache-loads: 7f68ce2fcb8a glXGetCurrentContext+0x1a (/usr/lib64/libGLX.so.0.0.0)
  gnome-shell 2026 [3] 8.964997: 50670 L1-dcache-loads: 7fa08854de6d g_source_iter_next+0x6d (/usr/lib64/libglib-2.0.so.0.5400.3)
  [root@jouet ~]#

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1528455748-20087-1-git-send-email-s1seetee@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b3bf35512d21..a31d7082188e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -180,6 +180,18 @@ static struct {
 				  PERF_OUTPUT_EVNAME | PERF_OUTPUT_TRACE
 	},
 
+	[PERF_TYPE_HW_CACHE] = {
+		.user_set = false,
+
+		.fields = PERF_OUTPUT_COMM | PERF_OUTPUT_TID |
+			      PERF_OUTPUT_CPU | PERF_OUTPUT_TIME |
+			      PERF_OUTPUT_EVNAME | PERF_OUTPUT_IP |
+			      PERF_OUTPUT_SYM | PERF_OUTPUT_SYMOFFSET |
+			      PERF_OUTPUT_DSO | PERF_OUTPUT_PERIOD,
+
+		.invalid_fields = PERF_OUTPUT_TRACE | PERF_OUTPUT_BPF_OUTPUT,
+	},
+
 	[PERF_TYPE_RAW] = {
 		.user_set = false,
 
-- 
2.14.3


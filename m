Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEUIyE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 04:54:04 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41248 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeEUIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 04:54:00 -0400
X-Google-Smtp-Source: AB8JxZqQJb10smTJX1GyMKYt41JhARlwzG4PlVNTBHkO6SDpePpjRIPVxD5TPtV53ih6j9D4Tae0Yw==
From: Leo Yan <leo.yan@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tor Jeremiassen <tor@ti.com>,
        mike.leach@linaro.org, kim.phillips@arm.com,
        Robert Walker <Robert.Walker@arm.com>, coresight@lists.linaro.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [RFT v2 4/4] coresight: Document for CoreSight trace disassembler
Date: Mon, 21 May 2018 16:52:28 +0800
Message-Id: <1526892748-326-5-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
References: <1526892748-326-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit documents CoreSight trace disassembler usage and gives
example for it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 Documentation/trace/coresight.txt | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 6f0120c..b8f2359 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -381,3 +381,55 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
 	$ taskset -c 2 ./sort_autofdo
 	Bubble sorting array of 30000 elements
 	5806 ms
+
+
+Tracing data disassembler
+-------------------------
+
+'perf script' supports to use script to parse tracing packet and rely on
+'objdump' for disassembled lines, this can convert tracing data to readable
+program execution flow for easily reviewing tracing data.
+
+The CoreSight trace disassembler is located in the folder:
+tools/perf/scripts/python/arm-cs-trace-disasm.py.  This script support below
+options:
+
+	-d, --objdump: Set path to objdump executable, this option is
+		       mandatory.
+	-k, --vmlinux: Set path to vmlinux file.
+	-v, --verbose: Enable debugging log, after enable this option the
+		       script dumps every event data.
+
+Below is one example for using python script to dump CoreSight trace
+disassembler:
+
+	$ perf script -s arm-cs-trace-disasm.py -i perf.data \
+	    -F cpu,event,ip,addr,sym -- -d objdump -k ./vmlinux > cs-disasm.log
+
+Below is one example for the disassembler log:
+
+ARM CoreSight Trace Data Assembler Dump
+	ffff000008a5f2dc <etm4_enable_hw+0x344>:
+	ffff000008a5f2dc:	340000a0 	cbz	w0, ffff000008a5f2f0 <etm4_enable_hw+0x358>
+	ffff000008a5f2f0 <etm4_enable_hw+0x358>:
+	ffff000008a5f2f0:	f9400260 	ldr	x0, [x19]
+	ffff000008a5f2f4:	d5033f9f 	dsb	sy
+	ffff000008a5f2f8:	913ec000 	add	x0, x0, #0xfb0
+	ffff000008a5f2fc:	b900001f 	str	wzr, [x0]
+	ffff000008a5f300:	f9400bf3 	ldr	x19, [sp, #16]
+	ffff000008a5f304:	a8c27bfd 	ldp	x29, x30, [sp], #32
+	ffff000008a5f308:	d65f03c0 	ret
+	ffff000008a5fa18 <etm4_enable+0x1b0>:
+	ffff000008a5fa18:	14000025 	b	ffff000008a5faac <etm4_enable+0x244>
+	ffff000008a5faac <etm4_enable+0x244>:
+	ffff000008a5faac:	b9406261 	ldr	w1, [x19, #96]
+	ffff000008a5fab0:	52800015 	mov	w21, #0x0                   	// #0
+	ffff000008a5fab4:	f901ca61 	str	x1, [x19, #912]
+	ffff000008a5fab8:	2a1503e0 	mov	w0, w21
+	ffff000008a5fabc:	3940e261 	ldrb	w1, [x19, #56]
+	ffff000008a5fac0:	f901ce61 	str	x1, [x19, #920]
+	ffff000008a5fac4:	a94153f3 	ldp	x19, x20, [sp, #16]
+	ffff000008a5fac8:	a9425bf5 	ldp	x21, x22, [sp, #32]
+	ffff000008a5facc:	a94363f7 	ldp	x23, x24, [sp, #48]
+	ffff000008a5fad0:	a8c47bfd 	ldp	x29, x30, [sp], #64
+	ffff000008a5fad4:	d65f03c0 	ret
-- 
2.7.4

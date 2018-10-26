Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0F2C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2790020834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2790020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeJZQLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:11:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:11:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7Z4RW137317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:35:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7Z01S137272;
        Fri, 26 Oct 2018 00:35:00 -0700
Date:   Fri, 26 Oct 2018 00:35:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Milian Wolff <tipbot@zytor.com>
Message-ID: <tip-7ee40678af935fb489b0c6cf0f75808175214cd7@git.kernel.org>
Cc:     acme@redhat.com, tglx@linutronix.de, milian.wolff@kdab.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org
Reply-To: acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          milian.wolff@kdab.com, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20181021191424.16183-2-milian.wolff@kdab.com>
References: <20181021191424.16183-2-milian.wolff@kdab.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Flush output stream after events in
 verbose mode
Git-Commit-ID: 7ee40678af935fb489b0c6cf0f75808175214cd7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7ee40678af935fb489b0c6cf0f75808175214cd7
Gitweb:     https://git.kernel.org/tip/7ee40678af935fb489b0c6cf0f75808175214cd7
Author:     Milian Wolff <milian.wolff@kdab.com>
AuthorDate: Sun, 21 Oct 2018 21:14:24 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 14:27:11 -0300

perf script: Flush output stream after events in verbose mode

When the perf script output is written to a terminal stream, the normal
output of `perf script` would get buffered, but its debug output would
be written directly. This made it quite hard to figure out where a given
debug output is coming from.

We can improve on this by flushing the output buffer after processing an
event. To see the value, compare the following output for a `perf script
-v` run:

Before this patch:
```
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
... lots and lots of verbose debug output
cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)

cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
...
```

After this patch:
```
...
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)

unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
...
```

This new output format makes it much easier to use perf script output
for debugging purposes, e.g. to investigate broken dwarf unwinding.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181021191424.16183-2-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bd468b90801b..ca09b7d2adb7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1737,6 +1737,9 @@ static void process_event(struct perf_script *script,
 
 	if (PRINT_FIELD(METRIC))
 		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
+
+	if (verbose)
+		fflush(fp);
 }
 
 static struct scripting_ops	*scripting_ops;

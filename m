Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB91ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A1C20847
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGITyqAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A1C20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeJYTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727666AbeJYTnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:46 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D97402083E;
        Thu, 25 Oct 2018 11:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465887;
        bh=4u1K5x0wlhyQW5nslxGkFgCBhMgd06apBgCvgndVKkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGITyqAtFv/Wv+dzFQTTos9gNFIRm6G2xLSWo4iy+8R/zR3hJksyhby/SvnicC/G8
         l84MWDyC8yTfNg3rTtnnSJ9Qsxi/qQqAke/nQr7qyQJAxT90pqtQWhO2O64buQJ+GJ
         MAhmEOZolp6k+hG2gOpOQfuTOzdd5T0aBu8HAcYU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/37] perf script: Flush output stream after events in verbose mode
Date:   Thu, 25 Oct 2018 08:10:08 -0300
Message-Id: <20181025111031.3440-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

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
-- 
2.14.4


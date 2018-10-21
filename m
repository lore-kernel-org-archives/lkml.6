Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95260ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620DD2083A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="hxJVvxUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620DD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeJVDaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:30:07 -0400
Received: from mail.kdab.com ([176.9.126.58]:7871 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeJVDaG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:30:06 -0400
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:date:subject:subject:from:from; s=dkim; t=
 1540149285; x=1541013286; bh=P70s8qO8BSSmjUfKWWRycg2v2KxyieYQlXg
 Mw5G13ug=; b=hxJVvxUDImO4eWwp77ma8CGyfodMU+ZUC8lAevtLS4mXL3jvALs
 zw9VJQG86tQQddSELtVTEGbnlLcdRIdOZNeOdBdpcaDar2t1ICbES07JA1BeP7q7
 9KUmyjDELdRWTOY/QVbH/Xn2UdP0JCPE5lgZ4FHlSQnOowjsAZieN4kE=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 2/2] perf script: flush output stream after events in verbose
 mode
Date:   Sun, 21 Oct 2018 21:14:24 +0200
Message-Id: <20181021191424.16183-2-milian.wolff@kdab.com>
In-Reply-To: <20181021191424.16183-1-milian.wolff@kdab.com>
References: <20181021191424.16183-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the perf script output is written to a terminal stream,
the normal output of `perf script` would get buffered, but its
debug output would be written directly. This made it quite hard
to figure out where a given debug output is coming from. We can
improve on this by flushing the output buffer after processing an
event. To see the value, compare the following output for a
`perf script -v` run:

Before this patch:
```
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip =3D 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip =3D 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip =3D 0x7faf7dfdc000 (0x2000)
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
unwind: _start:ip =3D 0x7faf7dfdc000 (0x2000)
cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)

unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip =3D 0x7faf7dfdc000 (0x2000)
cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
...
```

This new output format makes it much easier to use perf script
output for debugging purposes, e.g. to investigate broken dwarf
unwinding.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bd468b90801b..ca09b7d2adb7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1737,6 +1737,9 @@ static void process_event(struct perf_script *scrip=
t,
=20
 	if (PRINT_FIELD(METRIC))
 		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
+
+	if (verbose)
+		fflush(fp);
 }
=20
 static struct scripting_ops	*scripting_ops;
--=20
2.19.1

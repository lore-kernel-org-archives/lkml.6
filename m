Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00A52086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="gUF9WNXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00A52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbeKGTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:06:43 -0500
Received: from mail.kdab.com ([176.9.126.58]:50178 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbeKGTGn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:06:43 -0500
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1541583428; x=1542447429;
 bh=7Qg2K5UFKCyPWm0FKNjN5FXBD5ZhHFZJEpVwYDpaxkQ=; b=gUF9WNXZnTlT
 cyuqj+r52VDZMS2NAHqHue7y6HZo51fIoqVm52y4E0DxIqG2GM/4OVfLW9prVbAA
 sKXZFzX09M+iTtQPi99fVzgcKs1s745GtTyxfRCaPMOrNt+WmKAZlsV7FMsb44kI
 EFJHEIuNyRCuYvVKuP9SR8vV/ggRf8M=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf script: add newline after uregs output
Date:   Wed,  7 Nov 2018 10:37:05 +0100
Message-Id: <20181107093705.16346-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes it much easier to easily distinguish
between consecutive samples by keeping the empty line
between them, like we see when we do not enable uregs
output.

Before:

```
cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
            7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...
cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
            7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...
```

After:

```
cpp-inlining 28298 [-01] 54837.342780:    3068085 cycles:pp:
            7ffff7c96709 __hypot_finite+0xa9 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x0    BX:0x40f56cf6    CX:0x294a3ae7    ...

cpp-inlining 28298 [-01] 54837.344493:    2881929 cycles:pp:
            7ffff7c96696 __hypot_finite+0x36 (/usr/lib/libm-2.28.so)
            ...
 ABI:2    AX:0x40d440c7    BX:0x40d440c7    CX:0x4d45e5da    ...
```

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index b5bc85bd0bbe..daf73832743e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -603,6 +603,8 @@ static int perf_sample__fprintf_uregs(struct perf_sam=
ple *sample,
 		printed +=3D fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
=20
+	fprintf(fp, "\n");
+
 	return printed;
 }
=20
--=20
2.19.1

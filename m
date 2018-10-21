Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F3ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACED20838
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="H5ouM1MK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACED20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeJVDaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 23:30:03 -0400
Received: from mail.kdab.com ([176.9.126.58]:7837 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbeJVDaD (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 23:30:03 -0400
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1540149275; x=1541013276;
 bh=hXtXS6LZ1RoLCwDlMFV42y2gkAATmsNlVuaiKRe5k9Q=; b=H5ouM1MKiIb0
 CJxrvBmHCByjRQ0f0DAXcwJQRhIMy7YrxhisAIfIlUv2MGpGaoIZGCChCMRuY846
 85O5NqZzVNArNLq8t6rjYGjJ92tGLEqUlO50VIZwzoyeR/GSEHrFeltl1YO6pUnf
 G+z1O1CGwLx1ETtD/nVmq1LSZ+DzyYI=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 1/2] perf script: allow extended console debug output
Date:   Sun, 21 Oct 2018 21:14:23 +0200
Message-Id: <20181021191424.16183-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script tool isn't using a browser, yet use_browser
wasn't set explicitly to zero. This in turn lead to confusing
output such as:

```
$ perf script -vvv ...
...
overlapping maps in /home/milian/foobar (disable tui for more info)
...
```

Explicitly set use_browser to 0 now, which gives us the extended
debug information now in perf script as expected.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 4da5e32b9e03..bd468b90801b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3417,8 +3417,10 @@ int cmd_script(int argc, const char **argv)
 		exit(-1);
 	}
=20
-	if (!script_name)
+	if (!script_name) {
 		setup_pager();
+		use_browser =3D 0;
+	}
=20
 	session =3D perf_session__new(&data, false, &script.tool);
 	if (session =3D=3D NULL)
--=20
2.19.1

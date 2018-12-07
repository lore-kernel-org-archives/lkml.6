Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3F4C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laK+ZKgS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1456B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLGUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:55:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32927 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:55:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so5053823wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0xoNrQkseCwTbqhjkwAB/YJUidI3WFOgT0fYEoyTxY=;
        b=laK+ZKgSdBxf79h8QlNKJ1HFa+y1PtUEKiAFhnJAOT6bZ5ToT3AjOVfidYe9kkMpI9
         AjdILxQl4XjLdwtiCJSPJVxxdFp/ZQPKgPMsUB8Qi0NeyiPoOEfipBxd4Q4ccwlG4JsR
         gtZs+2yymsHHFwXeJe31OZ3Vf7yrZ9YzT0t8iqQMt5h9a5lIvvSVDPTRFyUCaY9w7WM4
         lv2UcVTanRznARqa48gmdvXrCDdPW7nsz3R0H/eLgiD8bux8nWmxo8aC8M4zoHQ+mkjg
         UCfqkXiqWAR3LwtvrZnG5zbD1FaUe4gdz8LepplohDNkDH0jvoa3X/I6UJL14qIpFQMB
         wk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0xoNrQkseCwTbqhjkwAB/YJUidI3WFOgT0fYEoyTxY=;
        b=mx9eKIDSNfIlvR2EaGgKUBoQEayvTOQ89Q9wYCtJ1i0EI/TlsutDmsHYoyapA3V805
         52cbI9Dq2UkhHnpKEOLQM7vNb6FbgIr2b1as2IU/UQ45SBtT+62+6DhxQMhsKE89PBOE
         Mi0VgOzi7XctLd7NGm0pExWYG+uuvHx11rXXbvNyE0nCWKRO/rDnH7otPqNMlmk98nkM
         /4LRGBqtdYj4zRsajcRB7PE+aOcHRh3lNJAy1Zl01VqGlyPyVjy9SwBEhJI5sVVxjZey
         8ON+2pX2PPNaydGSuD+ka+2QhZuWJUDp7Cox/z9PNvbJQwGzAqYmIXGm6FyV3ntTDVv3
         N2QQ==
X-Gm-Message-State: AA+aEWbbG/ZzgR205h8Eazu6jU4dcTlKixntVAHm+65Xqtixejk9VSkX
        kAPC+SzOSlLH9fPFLQh92zH6ElLi
X-Google-Smtp-Source: AFSGD/WcdKXgHgE3JcasLugo84ZSerxv4wCWnZLSblcv7jgW+zUMZxD5jwT3YHgvc3UGOSRdNy+lnw==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr2854465wrj.91.1544216128528;
        Fri, 07 Dec 2018 12:55:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id k128sm4059413wmd.37.2018.12.07.12.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 12:55:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8188eu: simplify loop in rtl88eu_phy_iq_calibrate()
Date:   Fri,  7 Dec 2018 21:55:14 +0100
Message-Id: <20181207205515.7290-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zeroing the array result[m][n] and setting only the values at
even 'n's simplifies the code and slightly reduces object file
size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/phy.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index 482d48e003b7..051cfbab78b1 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -1225,15 +1225,10 @@ void rtl88eu_phy_iq_calibrate(struct adapter *adapt, bool recovery)
 		return;
 	}
 
-	for (i = 0; i < 8; i++) {
-		result[0][i] = 0;
-		result[1][i] = 0;
-		result[2][i] = 0;
-		if ((i == 0) || (i == 2) || (i == 4)  || (i == 6))
-			result[3][i] = 0x100;
-		else
-			result[3][i] = 0;
-	}
+	memset(result, 0, sizeof(result));
+	for (i = 0; i < 8; i += 2)
+		result[3][i] = 0x100;
+
 	final = 0xff;
 	pathaok = false;
 	pathbok = false;
-- 
2.19.2


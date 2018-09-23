Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A9DC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA5A214AB
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klKH1go0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA5A214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeIWTvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:51:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41364 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIWTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:51:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so7934903pfk.8;
        Sun, 23 Sep 2018 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=O/UP/NH+0fQ3nXlGR/XjRcen0/inU6kasxxd6kr+Wuo=;
        b=klKH1go05LRyApjEamOjYCkJ7fdIuRiQ+Mh6lPMazUDMlXJsyWYMNUKlFUWg78SCMb
         UiQoCxKDhswPKl78wwNoVL+lhM3769rB0p9BnG41EzOKKziYU8InY6bZcFQS5Crd0MZQ
         xW0tYMngJbte+4fERZleGcvKvTDIs4HCQwUI6ZaW0mif4FkfnheSqYm6igfghs0XS1S/
         gJ1cdqdHXl3ikXEmEvosQbqbzoj17DwR4YaHYhQ7N9D6alL2sjsR93QprLJu4KXv6i1g
         vXC8P7PapExCBL0Rksc5bTHylzl6huf8qALxqYqQwMtjho4bcI3IHBpbbKiPXiJvbYDj
         /ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=O/UP/NH+0fQ3nXlGR/XjRcen0/inU6kasxxd6kr+Wuo=;
        b=qysZzRPHrAgbwAnrKaGzomBI2W8ChWCS5top3HdxRgEP5cr86FR5RTH91+5HY25WaV
         mIZAdB2xv0MqLaBiYkK9xT9CFgememTBUM2B53gwSWivdLFkMT14fpF1IRssCUn/sn0p
         V79QQ7DH5yWk6hSUCMia5HcJQqh9sVWN0k7kG3MhCq0IlgJaQVcMLsxC1frZC2w8Yzr/
         aiXojdaGbDUt5xLXwqJ6P98nK1th2qFSnYjGVgrjvBSU2TtCw7XbNFJPIK+0+AtihLte
         Z6yfMMLues4KxmBxuQ5ggPUAiQg1E36cM2YGc6DuFWVv15amvYKYeMCqxe/DMxqRp2VI
         qE2A==
X-Gm-Message-State: ABuFfog656O9g/XDzxKJ9lNmk7kcB6NSqG6L7aqVEpz95GcurwvjxmWR
        gX/P+E8GeITDi2Di656RgJJivwDt
X-Google-Smtp-Source: ACcGV62Dyi6L4/3na4e/TLRNBnvZL4iszoimPtxG0/OVGVzooOjjF7zZjeGWYh0fPxge6+hNCE13sA==
X-Received: by 2002:a63:5922:: with SMTP id n34-v6mr3829896pgb.134.1537710853471;
        Sun, 23 Sep 2018 06:54:13 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d9-v6sm63126604pfb.86.2018.09.23.06.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 06:54:12 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: w83627hf_wdt: Support NCT6796D, NCT6797D, NCT6798D
Date:   Sun, 23 Sep 2018 06:54:11 -0700
Message-Id: <1537710851-11017-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog controller on NCT6796D, NCT6797D, and NCT6798D is compatible
with the wtachdog controller on other Nuvoton chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/w83627hf_wdt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 7817836bff55..4b9365d4de7a 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -50,7 +50,7 @@ static int cr_wdt_csr;		/* WDT control & status register */
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
 	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
-	     nct6795, nct6102 };
+	     nct6795, nct6796, nct6102 };
 
 static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
@@ -100,6 +100,7 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define NCT6792_ID		0xc9
 #define NCT6793_ID		0xd1
 #define NCT6795_ID		0xd3
+#define NCT6796_ID		0xd4	/* also NCT9697D, NCT9698D */
 
 #define W83627HF_WDT_TIMEOUT	0xf6
 #define W83697HF_WDT_TIMEOUT	0xf4
@@ -209,6 +210,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case nct6792:
 	case nct6793:
 	case nct6795:
+	case nct6796:
 	case nct6102:
 		/*
 		 * These chips have a fixed WDTO# output pin (W83627UHG),
@@ -407,6 +409,9 @@ static int wdt_find(int addr)
 	case NCT6795_ID:
 		ret = nct6795;
 		break;
+	case NCT6796_ID:
+		ret = nct6796;
+		break;
 	case NCT6102_ID:
 		ret = nct6102;
 		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
@@ -450,6 +455,7 @@ static int __init wdt_init(void)
 		"NCT6792",
 		"NCT6793",
 		"NCT6795",
+		"NCT6796",
 		"NCT6102",
 	};
 
-- 
2.7.4


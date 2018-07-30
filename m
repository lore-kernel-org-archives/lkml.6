Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8CD208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzMwIT0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8CD208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeG3P21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:28:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44691 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbeG3P21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:28:27 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so5584339pls.11;
        Mon, 30 Jul 2018 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eXo+fRHT04dd8A4LBYXDXuvaLubri1WNPrXqAmSjUeQ=;
        b=DzMwIT0f3hLvpBLdsTcLT5u/T20aTWfmeBUUBu3ujCnBSumKseVXzEc+pZ2KMayKGi
         +CFzt2I7gFPv4342Zj5iVo6svtMbN6FKFHVMWt6dRpGAGBLWvai82bM/9WF6LK3TovIP
         kI+ldVMkEdYvhKjyLfuy8a7QjPQQ/eA2TId72iQ7Wf9bj5Y0d0cwtV3uloZ+r5R0zVfh
         e/y2zNEg41Zuu3fXWwQ9Gh+gf/S/kFxvziT+x8NhR9v0D1wXVCFYAOFtnloQtTaKGAvO
         caCBbOfEmhiy29fN0dZf4IQep5VL0osavYma6yhqEUg0Lpg7WC2omiW3y+YzCTKwMjwR
         4UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eXo+fRHT04dd8A4LBYXDXuvaLubri1WNPrXqAmSjUeQ=;
        b=T2Jn1fA7ZOOqujg8LynRSNgvXKKDWMq5xk9mHjiqnkYobQxe6mCppDZmwXstnWvTr1
         6QpEgCwnHWGAQD8y+cD79kIMtbsGr8uPMGMyqS5A+dh4dRI3dgVlG7vEJ9qcHxD20hou
         QDp8xGrxIpmDI3N7HNQEa/HZyVTSOJJs2mI738nLdtMUqJPK7UuMLMNYVJ+a8Gq8QKgl
         qjVWNFARaLLVvHSGv7MZg8zBT8rqDWs64T595XzaNbn5DqH2YzpiWkUVN8zSj2R3GbbF
         FHaYj7qfD1blAze2ldrslfyFx7l7nznu7+NTUU2mLyj6+MQUyg1R0qHA6GtAjPvIplVr
         EOlQ==
X-Gm-Message-State: AOUpUlF/WmBQ0YtZQB0MUQgJ+QvukSAk9j5P/PmqkOjFMoSTDwc5V6Jm
        5LELCHyhQFbUKdtxpQqbmM0=
X-Google-Smtp-Source: AAOMgpdqxMCNSTCICexhv1kJIVPiM3KKOx732/XDzztzjk9ZwT7GEN1NCCOr1e3CIXLBHpDNBw1HAQ==
X-Received: by 2002:a17:902:c6:: with SMTP id a64-v6mr5682628pla.180.1532958800868;
        Mon, 30 Jul 2018 06:53:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id p19-v6sm23264546pgh.60.2018.07.30.06.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:53:20 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] rtc: rtc-omap: Replace mdelay() with msleep() in omap_rtc_power_off()
Date:   Mon, 30 Jul 2018 21:53:14 +0800
Message-Id: <20180730135314.9336-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

omap_rtc_power_off() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/rtc/rtc-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 39086398833e..ef3d09525d0f 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -476,7 +476,7 @@ static void omap_rtc_power_off(void)
 	 * power off the system. Add a 500 ms margin for external latencies
 	 * (e.g. debounce circuits).
 	 */
-	mdelay(2500);
+	msleep(2500);
 }
 
 static const struct rtc_class_ops omap_rtc_ops = {
-- 
2.17.0


Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228732077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VQzOFXEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228732077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJKASU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:18:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45850 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJKASU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:18:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so2806766plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsUazj8e/ZQvu767Lde9xfu4UDysKXiIgFVGUwQWDTU=;
        b=VQzOFXErf9dAQUoo77i5/5X2LefJhDDuTib3m5P7mygOk708bwxjo+kN274f+4a5Q/
         XTY+lHhdZqqzwbHa9BWwH9CA9pOg79suyVd89TlzGtI6e6wUXMLaL05/vsX9tOSNYd6x
         SqdZm2lDenn4pkEUiw+Hx3Rtud0aTk6uMZ28g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsUazj8e/ZQvu767Lde9xfu4UDysKXiIgFVGUwQWDTU=;
        b=NDh3dmRz7H4sKlTZYuGlQ1hR8dL0ZOVaLt/wk5KLlppqGsSZK77d2/CNyprWL5Lz8s
         VP344FkThsC/bSTynKtb+xP6s+bF8kupAearMqHTsAz8IKEkgNsLC5mRJnWOQy8lHR+d
         SaXVxbnhdpy4ZzSe49mtBKAz79XCJcI/piL2pdjtP2I8gYYaDZIhD2k4PxLQ2KrGmJ+4
         KO8ERUvtBNtcsR28QMspa1OsLsmzuh9vvvLfqSQoeBV+F6CSCSDrVwOZ0j7VGsUlac1t
         BkZl+6ZYKWGPZQxdljD9mZO1unRoYDy4u0lUS1i5ar8LX1PDrUCQ9fbGVQuFmERIvxps
         WsyQ==
X-Gm-Message-State: ABuFfohLCPlQSEuRjpHhg9MAgNVy4A0vSX1Q+vwi+ncmqdCPZhHYJ1op
        cB07FfFWxSwgO41AweBAnAXogx2aI5o=
X-Google-Smtp-Source: ACcGV63W8Fi2YvaX8767dvN8DGWugpfDdb1Ii0+GAaZ9mNVkA4OW592PyxXZQN51dUuRr5a/wpdaDw==
X-Received: by 2002:a17:902:8a4:: with SMTP id 33-v6mr34135506pll.65.1539190520234;
        Wed, 10 Oct 2018 09:55:20 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id k12-v6sm8961180pgo.34.2018.10.10.09.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 09:55:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] Input: elants_i2c - Use DMA safe i2c when possible
Date:   Wed, 10 Oct 2018 09:55:17 -0700
Message-Id: <20181010165517.178545-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This irq handler is always reading bytes from the device into a
kmalloced buffer, so it's safe to mark this transaction as DMA safe.
This avoids bouncing the buffer when an i2c controller decides to use
DMA for a transaction.

Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/input/touchscreen/elants_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..be44abb8de33 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -863,7 +863,7 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
 	int i;
 	int len;
 
-	len = i2c_master_recv(client, ts->buf, sizeof(ts->buf));
+	len = i2c_master_recv_dmasafe(client, ts->buf, sizeof(ts->buf));
 	if (len < 0) {
 		dev_err(&client->dev, "%s: failed to read data: %d\n",
 			__func__, len);
-- 
Sent by a computer through tubes


Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA720652
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSnth3Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCA720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeJKDYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:24:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbeJKDYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:24:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id g12-v6so3016640pgs.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 13:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxoZz210WU3emzSTDYAt6L2retk8yyhL4yJgnH8MmJQ=;
        b=PSnth3BbrlXmrhADCeij34F7b75p8XMnhvLAmeZoMeKugrFgGBmDn2jn30dWA0F5Co
         m8UErn9j4hpIkLjks0JqUz38n3VFBXAuK471MiqMUBC7nYFr4r+pa/J0t9NbpxST+2Wd
         801h3pX9Lvj2ac0dCN7u4xP0A9trf47tLCszQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxoZz210WU3emzSTDYAt6L2retk8yyhL4yJgnH8MmJQ=;
        b=OP4A2r/QajOo5O2J/ynUlt0LpTMGIXGOpEwNvBliS1F/K2dUZvUKJHmX+4sfXD9lyI
         FBOi5JqMu0r+6cYCcrcPqMbzwSEb25Vc+MKAiAQI9vDUMWetCwn3RDzG6MmM9JGTLdW0
         E078Uw33YPvI1q9csMEFlcTe0oQNePk1Spvo2rVXsBiwPCgFb32ruZB33e9AKrgavGDy
         lO45mm3pq4nMYih9V3rR8EAXDFgMjIDyJQJW0CGeMJVTw7CqJBF+rs33jAi2eYoCYQe6
         HUsLqqmxqX1UVkOjgNLLMhwJmTWgMOJVrPpei8d33t+hZnjHJzJkdPRPPPSfbwfsc5EE
         eR4A==
X-Gm-Message-State: ABuFfojEBksVlgSDrYn26WIISmEcHqIoK1CiYv+EJlYsRSQsPD2mCDky
        8yAQ5EtfslgspRKj8eiNlbFVuQ==
X-Google-Smtp-Source: ACcGV61YqYu5MDG8HSIV07mjL/iVDrAFCVmd4Cn6cY+bP97ouxgTgzvLoUBcn5aVh8Ss28dwmAQAGg==
X-Received: by 2002:a63:d208:: with SMTP id a8-v6mr28700522pgg.99.1539201619183;
        Wed, 10 Oct 2018 13:00:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 20-v6sm25776996pge.77.2018.10.10.13.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 13:00:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2] Input: elants_i2c - Use DMA safe i2c when possible
Date:   Wed, 10 Oct 2018 13:00:17 -0700
Message-Id: <20181010200017.255874-1-swboyd@chromium.org>
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

Changes from v1:
 * Moved buf to end of structure to keep it cacheline aligned and DMA
   safe

 drivers/input/touchscreen/elants_i2c.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..f2cb23121833 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -147,10 +147,11 @@ struct elants_data {
 	u8 cmd_resp[HEADER_SIZE];
 	struct completion cmd_done;
 
-	u8 buf[MAX_PACKET_SIZE];
-
 	bool wake_irq_enabled;
 	bool keep_power_in_suspend;
+
+	/* Must be last to be used for DMA operations */
+	u8 buf[MAX_PACKET_SIZE] ____cacheline_aligned;
 };
 
 static int elants_i2c_send(struct i2c_client *client,
@@ -863,7 +864,7 @@ static irqreturn_t elants_i2c_irq(int irq, void *_dev)
 	int i;
 	int len;
 
-	len = i2c_master_recv(client, ts->buf, sizeof(ts->buf));
+	len = i2c_master_recv_dmasafe(client, ts->buf, sizeof(ts->buf));
 	if (len < 0) {
 		dev_err(&client->dev, "%s: failed to read data: %d\n",
 			__func__, len);
-- 
Sent by a computer through tubes


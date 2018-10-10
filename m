Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58951C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCCB206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DomMXjkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCCB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJKDXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:23:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36950 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeJKDXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:23:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so3163248pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 12:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxoZz210WU3emzSTDYAt6L2retk8yyhL4yJgnH8MmJQ=;
        b=DomMXjkgmiZG0Q/3KTBCBL27e3gK9JflZrdkif0O167oTaXnCh9LQwlybyBUF23ZiK
         L0fvl9Bju/HvDJ0wcIzW8pOM7iNVPCfqQH8yHB7AKdy4DS2T8jhmTwmfw4jWQu/xncjB
         tLeVeHt1o5UHaQGbXANKh+eHWi8N9jcJ8WqDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxoZz210WU3emzSTDYAt6L2retk8yyhL4yJgnH8MmJQ=;
        b=LKe0leABQqCDqwz6teFUPgx3+eTt1DETRhZBMCTwxl7eiOFxPUYzig9AGl8xp3iOBv
         Yj6cdZgUnfzqyh+n4v0eFaXJuYe2oScJ9TssISHsjwa39MUUgVZ3GqV+IL03LpCwf6jV
         TH0WZlnU0wvlDZ1aBWuomgiadyxJFrJZCiZvwmkg1yDYQL+mgcTSpd36ULckhP5t7j99
         AbbRQxRebiBDQ2enGaBEw+NvLW5cUNvsDrgDLoeBoASnFTPfQCxRVJQMmNNpO+tKTImU
         1ww/Hfo943dnImNUDa08YmIcf61NF9bVM5fbYA20k/CKg6o0uS3qOkpIVD++8Aw7Zgv8
         h01Q==
X-Gm-Message-State: ABuFfohBa3i+Xeo/0/QKL8dqnREvK9aPmrmB6A4xn+AmGvDEuHRrpmTv
        HT9HLU5PXPRSOPp7Wag43/WtQb+InlM=
X-Google-Smtp-Source: ACcGV60Eofk/DgAW+wsO7JDqOzcIWYHnUxUquV9URMWcnwyYgI6hOxqzkWNKWOfbhz/YU8T7Tcjahw==
X-Received: by 2002:aa7:8001:: with SMTP id j1-v6mr35623034pfi.73.1539201569341;
        Wed, 10 Oct 2018 12:59:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id e64-v6sm33941499pfe.55.2018.10.10.12.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 12:59:28 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2] Input: elants_i2c - Use DMA safe i2c when possible
Date:   Wed, 10 Oct 2018 12:59:27 -0700
Message-Id: <20181010195927.255503-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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


Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA2820848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGouDii7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA2820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJYXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:55756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbeJYWri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:38 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D7EB20834;
        Thu, 25 Oct 2018 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476882;
        bh=/tkllQJYWzzJZvhdj9RFvf0frDJa8qbpjzsUbZBk4qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGouDii7y4M4qWkswKMbef7yLAqJgvQGQ2oGn3wSoRTwkxhjRcCAs7mTJm7RoPUan
         2OS4G/031kTX7K5GOLJTLeNQxge1H3mA+hMo8BgSjwXmXGCq6FmF8cSKw3KVl8aDBM
         JGzc6iZKTODY4iun7DaLAL8Mo0iA2ve0aZJcgoZE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 10/98] i2c: bcm2835: Avoid possible NULL ptr dereference
Date:   Thu, 25 Oct 2018 10:12:55 -0400
Message-Id: <20181025141423.213774-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit ababb08938df7ac245d30a58b95b94ecf8dc04fc ]

Since commit e2474541032d ("bcm2835: Fix hang for writing messages
larger than 16 bytes") the interrupt handler is prone to a possible
NULL pointer dereference. This could happen if an interrupt fires
before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
on the RPi 3. Even this is an unexpected behavior the driver must
handle that with an error instead of a crash.

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index f283b714aa79..7ed09865cb4b 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -128,7 +128,9 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 	}
 
 	if (val & BCM2835_I2C_S_DONE) {
-		if (i2c_dev->curr_msg->flags & I2C_M_RD) {
+		if (!i2c_dev->curr_msg) {
+			dev_err(i2c_dev->dev, "Got unexpected interrupt (from firmware?)\n");
+		} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
 			bcm2835_drain_rxfifo(i2c_dev);
 			val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
 		}
-- 
2.17.1


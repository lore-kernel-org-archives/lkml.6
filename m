Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F0E20936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F0E20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbeGJShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:37:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390062AbeGJShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:37:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EA64DCC2;
        Tue, 10 Jul 2018 18:36:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.17 46/56] i2c: smbus: kill memory leak on emulated and failed DMA SMBus xfers
Date:   Tue, 10 Jul 2018 20:25:28 +0200
Message-Id: <20180710182505.767096921@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

commit 9aa613674f89d01248ae2e4afe691b515ff8fbb6 upstream.

If DMA safe memory was allocated, but the subsequent I2C transfer
fails the memory is leaked. Plug this leak.

Fixes: 8a77821e74d6 ("i2c: smbus: use DMA safe buffers for emulated SMBus transactions")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-smbus.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -465,15 +465,18 @@ static s32 i2c_smbus_xfer_emulated(struc
 
 	status = i2c_transfer(adapter, msg, num);
 	if (status < 0)
-		return status;
-	if (status != num)
-		return -EIO;
+		goto cleanup;
+	if (status != num) {
+		status = -EIO;
+		goto cleanup;
+	}
+	status = 0;
 
 	/* Check PEC if last message is a read */
 	if (i && (msg[num-1].flags & I2C_M_RD)) {
 		status = i2c_smbus_check_pec(partial_pec, &msg[num-1]);
 		if (status < 0)
-			return status;
+			goto cleanup;
 	}
 
 	if (read_write == I2C_SMBUS_READ)
@@ -499,12 +502,13 @@ static s32 i2c_smbus_xfer_emulated(struc
 			break;
 		}
 
+cleanup:
 	if (msg[0].flags & I2C_M_DMA_SAFE)
 		kfree(msg[0].buf);
 	if (msg[1].flags & I2C_M_DMA_SAFE)
 		kfree(msg[1].buf);
 
-	return 0;
+	return status;
 }
 
 /**



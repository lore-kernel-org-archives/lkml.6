Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3308ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658B52146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658B52146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbeIREmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:42:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbeIREmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:42:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48866C49;
        Mon, 17 Sep 2018 23:13:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 122/158] tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Tue, 18 Sep 2018 00:42:32 +0200
Message-Id: <20180917211716.850017375@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Rosin <peda@axentia.se>

[ Upstream commit bb853aac2c478ce78116128263801189408ad2a8 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_i2c_infineon.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -117,7 +117,7 @@ static int iic_tpm_read(u8 addr, u8 *buf
 	/* Lock the adapter for the duration of the whole sequence. */
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 
 	if (tpm_dev.chip_type == SLB9645) {
 		/* use a combined read for newer chips
@@ -192,7 +192,7 @@ static int iic_tpm_read(u8 addr, u8 *buf
 	}
 
 out:
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 
@@ -224,7 +224,7 @@ static int iic_tpm_write_generic(u8 addr
 
 	if (!tpm_dev.client->adapter->algo->master_xfer)
 		return -EOPNOTSUPP;
-	i2c_lock_adapter(tpm_dev.client->adapter);
+	i2c_lock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 
 	/* prepend the 'register address' to the buffer */
 	tpm_dev.buf[0] = addr;
@@ -243,7 +243,7 @@ static int iic_tpm_write_generic(u8 addr
 		usleep_range(sleep_low, sleep_hi);
 	}
 
-	i2c_unlock_adapter(tpm_dev.client->adapter);
+	i2c_unlock_bus(tpm_dev.client->adapter, I2C_LOCK_SEGMENT);
 	/* take care of 'guard time' */
 	usleep_range(SLEEP_DURATION_LOW, SLEEP_DURATION_HI);
 



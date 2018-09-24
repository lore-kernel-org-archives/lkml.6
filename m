Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6702ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E35F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E35F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388833AbeIXStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:49:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbeIXStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:49:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 56EB61099;
        Mon, 24 Sep 2018 12:47:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 206/235] input: rohm_bu21023: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Mon, 24 Sep 2018 13:53:12 +0200
Message-Id: <20180924113124.595198699@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

[ Upstream commit 193c2a07cfaacb9249ab0e3d34bce32490879355 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/rohm_bu21023.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/input/touchscreen/rohm_bu21023.c
+++ b/drivers/input/touchscreen/rohm_bu21023.c
@@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2
 	msg[1].len = len;
 	msg[1].buf = buf;
 
-	i2c_lock_adapter(adap);
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
 
 	for (i = 0; i < 2; i++) {
 		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
@@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2
 		}
 	}
 
-	i2c_unlock_adapter(adap);
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
 
 	return ret;
 }



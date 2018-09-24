Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20035C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72542083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72542083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389083AbeIXSpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:45:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59506 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388731AbeIXSpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:45:44 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5D00D1099;
        Mon, 24 Sep 2018 12:43:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 205/235] mfd: 88pm860x-i2c: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)
Date:   Mon, 24 Sep 2018 13:53:11 +0200
Message-Id: <20180924113124.533031471@linuxfoundation.org>
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

[ Upstream commit 8c8f74f327a76604a499fad8c54c15e1c0ee8051 ]

Locking the root adapter for __i2c_transfer will deadlock if the
device sits behind a mux-locked I2C mux. Switch to the finer-grained
i2c_lock_bus with the I2C_LOCK_SEGMENT flag. If the device does not
sit behind a mux-locked mux, the two locking variants are equivalent.

Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/88pm860x-i2c.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/mfd/88pm860x-i2c.c
+++ b/drivers/mfd/88pm860x-i2c.c
@@ -146,14 +146,14 @@ int pm860x_page_reg_write(struct i2c_cli
 	unsigned char zero;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xFA, 0, &zero);
 	read_device(i2c, 0xFB, 0, &zero);
 	read_device(i2c, 0xFF, 0, &zero);
 	ret = write_device(i2c, reg, 1, &data);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_reg_write);
@@ -164,14 +164,14 @@ int pm860x_page_bulk_read(struct i2c_cli
 	unsigned char zero = 0;
 	int ret;
 
-	i2c_lock_adapter(i2c->adapter);
+	i2c_lock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	read_device(i2c, 0xfa, 0, &zero);
 	read_device(i2c, 0xfb, 0, &zero);
 	read_device(i2c, 0xff, 0, &zero);
 	ret = read_device(i2c, reg, count, buf);
 	read_device(i2c, 0xFE, 0, &zero);
 	read_device(i2c, 0xFC, 0, &zero);
-	i2c_unlock_adapter(i2c->adapter);
+	i2c_unlock_bus(i2c->adapter, I2C_LOCK_SEGMENT);
 	return ret;
 }
 EXPORT_SYMBOL(pm860x_page_bulk_read);



Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35F5C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD35A20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD35A20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbeKLGbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:31:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49348 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729758AbeKLFsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:02 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0000lJ-2y; Sun, 11 Nov 2018 19:58:32 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001ND-Q8; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "John Syne" <john3909@gmail.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        "John Syne" <rodrigosiqueiramelo@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.384667038@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 015/366] staging:iio:ade7854: Fix error handling on
 read/write
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: John Syne <rodrigosiqueiramelo@gmail.com>

commit 4297b23d927fa5265378f4a71372ecef3c33023a upstream.

The original code does not correctly handle the error related to I2C
read and write. This patch fixes the error handling related to all
read/write functions for I2C.

Signed-off-by: John Syne <john3909@gmail.com>
Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Fixes: 8d97a5877 ("staging: iio: meter: new driver for ADE7754 devices")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 24 ++++++++++++------------
 drivers/staging/iio/meter/ade7854.c     | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -31,7 +31,7 @@ static int ade7854_i2c_write_reg_8(struc
 	ret = i2c_master_send(st->i2c, st->tx, 3);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_16(struct device *dev,
@@ -51,7 +51,7 @@ static int ade7854_i2c_write_reg_16(stru
 	ret = i2c_master_send(st->i2c, st->tx, 4);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_24(struct device *dev,
@@ -72,7 +72,7 @@ static int ade7854_i2c_write_reg_24(stru
 	ret = i2c_master_send(st->i2c, st->tx, 5);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_write_reg_32(struct device *dev,
@@ -94,7 +94,7 @@ static int ade7854_i2c_write_reg_32(stru
 	ret = i2c_master_send(st->i2c, st->tx, 6);
 	mutex_unlock(&st->buf_lock);
 
-	return ret;
+	return ret < 0 ? ret : 0;
 }
 
 static int ade7854_i2c_read_reg_8(struct device *dev,
@@ -110,11 +110,11 @@ static int ade7854_i2c_read_reg_8(struct
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 1);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = st->rx[0];
@@ -136,11 +136,11 @@ static int ade7854_i2c_read_reg_16(struc
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 8) | st->rx[1];
@@ -162,11 +162,11 @@ static int ade7854_i2c_read_reg_24(struc
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 16) | (st->rx[1] << 8) | st->rx[2];
@@ -188,11 +188,11 @@ static int ade7854_i2c_read_reg_32(struc
 	st->tx[1] = reg_address & 0xFF;
 
 	ret = i2c_master_send(st->i2c, st->tx, 2);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	ret = i2c_master_recv(st->i2c, st->rx, 3);
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	*val = (st->rx[0] << 24) | (st->rx[1] << 16) | (st->rx[2] << 8) | st->rx[3];
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -33,7 +33,7 @@ static ssize_t ade7854_read_8bit(struct
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_8(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -50,7 +50,7 @@ static ssize_t ade7854_read_16bit(struct
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_16(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -67,7 +67,7 @@ static ssize_t ade7854_read_24bit(struct
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_24(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -84,7 +84,7 @@ static ssize_t ade7854_read_32bit(struct
 	struct ade7854_state *st = iio_priv(indio_dev);
 
 	ret = st->read_reg_32(dev, this_attr->address, &val);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	return sprintf(buf, "%u\n", val);
@@ -416,7 +416,7 @@ static int ade7854_set_irq(struct device
 	u32 irqen;
 
 	ret = st->read_reg_32(dev, ADE7854_MASK0, &irqen);
-	if (ret)
+	if (ret < 0)
 		goto error_ret;
 
 	if (enable)


Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8F8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAB820864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAB820864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935977AbeFRJiR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:38:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55824 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935723AbeFRIXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:23:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A71CCC5C;
        Mon, 18 Jun 2018 08:23:30 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 171/279] usb: typec: tps6598x: handle block reads separately with plain-I2C adapters
Date:   Mon, 18 Jun 2018 10:12:36 +0200
Message-Id: <20180618080615.892081270@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

[ Upstream commit 1a2f474d328f292ee706414824ec4ca690cdf5ba ]

If the I2C adapter that the PD controller is attached to
does not support SMBus protocol, the driver needs to handle
block reads separately. The first byte returned in block
read protocol will show the total number of bytes. It needs
to be stripped away.

This is handled separately in the driver only because right
now we have no way of requesting the used protocol with
regmap-i2c. This is in practice a workaround for what is
really a problem in regmap-i2c. The other option would have
been to register custom regmap, or not use regmap at all,
however, since the solution is very simple, I choose to use
it in this case for convenience. It is easy to remove once
we figure out how to handle this kind of cases in
regmap-i2c.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tps6598x.c |   47 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -73,6 +73,7 @@ struct tps6598x {
 	struct device *dev;
 	struct regmap *regmap;
 	struct mutex lock; /* device lock */
+	u8 i2c_protocol:1;
 
 	struct typec_port *port;
 	struct typec_partner *partner;
@@ -80,19 +81,39 @@ struct tps6598x {
 	struct typec_capability typec_cap;
 };
 
+static int
+tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
+{
+	u8 data[len + 1];
+	int ret;
+
+	if (!tps->i2c_protocol)
+		return regmap_raw_read(tps->regmap, reg, val, len);
+
+	ret = regmap_raw_read(tps->regmap, reg, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	if (data[0] < len)
+		return -EIO;
+
+	memcpy(val, &data[1], len);
+	return 0;
+}
+
 static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
 {
-	return regmap_raw_read(tps->regmap, reg, val, sizeof(u16));
+	return tps6598x_block_read(tps, reg, val, sizeof(u16));
 }
 
 static inline int tps6598x_read32(struct tps6598x *tps, u8 reg, u32 *val)
 {
-	return regmap_raw_read(tps->regmap, reg, val, sizeof(u32));
+	return tps6598x_block_read(tps, reg, val, sizeof(u32));
 }
 
 static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
 {
-	return regmap_raw_read(tps->regmap, reg, val, sizeof(u64));
+	return tps6598x_block_read(tps, reg, val, sizeof(u64));
 }
 
 static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
@@ -121,8 +142,8 @@ static int tps6598x_read_partner_identit
 	struct tps6598x_rx_identity_reg id;
 	int ret;
 
-	ret = regmap_raw_read(tps->regmap, TPS_REG_RX_IDENTITY_SOP,
-			      &id, sizeof(id));
+	ret = tps6598x_block_read(tps, TPS_REG_RX_IDENTITY_SOP,
+				  &id, sizeof(id));
 	if (ret)
 		return ret;
 
@@ -223,13 +244,13 @@ static int tps6598x_exec_cmd(struct tps6
 	} while (val);
 
 	if (out_len) {
-		ret = regmap_raw_read(tps->regmap, TPS_REG_DATA1,
-				      out_data, out_len);
+		ret = tps6598x_block_read(tps, TPS_REG_DATA1,
+					  out_data, out_len);
 		if (ret)
 			return ret;
 		val = out_data[0];
 	} else {
-		ret = regmap_read(tps->regmap, TPS_REG_DATA1, &val);
+		ret = tps6598x_block_read(tps, TPS_REG_DATA1, &val, sizeof(u8));
 		if (ret)
 			return ret;
 	}
@@ -384,6 +405,16 @@ static int tps6598x_probe(struct i2c_cli
 	if (!vid)
 		return -ENODEV;
 
+	/*
+	 * Checking can the adapter handle SMBus protocol. If it can not, the
+	 * driver needs to take care of block reads separately.
+	 *
+	 * FIXME: Testing with I2C_FUNC_I2C. regmap-i2c uses I2C protocol
+	 * unconditionally if the adapter has I2C_FUNC_I2C set.
+	 */
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		tps->i2c_protocol = true;
+
 	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
 	if (ret < 0)
 		return ret;



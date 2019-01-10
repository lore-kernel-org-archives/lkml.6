Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AA6214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547095029;
	bh=YS4bOeBRj1uAgPleSAiz+qGPfAh3p7ilw6e8+XDNSeA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1G7+n1BCxmMQ/L4gZBRIRh8m+IkVBxcRiFjSA5oeDjbEEKcGdrn8LVw7EugpVBhWv
	 G7e9Bzn8Xzq7Ieu+MuwuCct2XVOYn66frqW6lEm1LeaULEbQ0G4mV7oaK1V+nLXfJ3
	 dz/DNHO9Q75/ySkj8uP0HVblkPyiZSkU05DXwwXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfAJEhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:37:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37668 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfAJEhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:37:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so4297944pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 20:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37o2uRgfDsaQ1kb7wmLl1hggrlC0/1EENLocV2pymkg=;
        b=tPQTfZc/WWpl4NYHN4rOrfNQyZWlSnLryjyUKU63YgxEjsgJkRFm495FfKxYeLKBEH
         HieF4UecapS7VyC3f4/sknb/aoV11ApNrTVl70uaXoOIG4fd/XwEstX+nJmmc4BwQA8p
         k2JLAgPOYjsPhAfXQZFG1JE0XZrb1vlQLu1GFDgG3Jb9JZp37dfooOVYM2AxBBwOjRmP
         yhDJRQhy8eqGCWBKM7IayqH+f8O7Ocm4iu+uRDOg6H1WOwV99FPZgK8gVf/Mwydilqmp
         1cZueJtCgVG53Mlw0kyCrzGVPr7xfoqHWK55u65QqVRPwOpdt+Wn6MmuA/9wncj+ikZ9
         km+w==
X-Gm-Message-State: AJcUukeoMpdNYOfaVRpyIVd00/KdwhnpMujUBNNCzf5EMVkd5NbA3Qs/
        V8mDMzM+ms1dxEJH6EJR4GdJtwXrkIM=
X-Google-Smtp-Source: ALg8bN5W1itknuOO6hJEmLDjmy+Ml2wNeb2zoStmfN+oskirV+S/NpIbSYJaDHgN0KP3IOpMOCtkqA==
X-Received: by 2002:a63:d10:: with SMTP id c16mr8047729pgl.382.1547095026161;
        Wed, 09 Jan 2019 20:37:06 -0800 (PST)
Received: from localhost ([2601:647:4700:93d:e313:c934:6975:1b63])
        by smtp.gmail.com with ESMTPSA id u29sm100804726pgn.23.2019.01.09.20.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 20:37:05 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, moritz@ettus.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v3] platform/chrome: Add cros_ec_readmem() helpers for I2C/SPI based ECs
Date:   Wed,  9 Jan 2019 20:36:53 -0800
Message-Id: <20190110043653.25901-1-mdf@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cros_ec_readmem() helpers for I2C/SPI based ECs.
Unlike the LPC based ECs the I2C/SPI based ones cannot just directly
read the mapped region, but have to resort to EC_CMD_READ_MEMMAP.

This is useful for things like accessing fan speeds or temperatures.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi all,

This can be used for a hwmon or thermal driver such as [1], but also
alone can be used with 'ectool' via the ioctl() interface.

Thanks,
Moritz


Changes from v2:
- Addressed KBuild complaint about max() with size_t vs unsigned int
  parameters

Changes from v1:
- Moved to drivers/platform/proto


[1] https://patchwork.kernel.org/patch/9670517/ (needs work)
---
 drivers/platform/chrome/cros_ec_i2c.c   |  1 +
 drivers/platform/chrome/cros_ec_proto.c | 39 +++++++++++++++++++++++++
 drivers/platform/chrome/cros_ec_spi.c   |  1 +
 include/linux/mfd/cros_ec.h             | 12 ++++++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
index ef9b4763356f..c3a9bee37b1d 100644
--- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -303,6 +303,7 @@ static int cros_ec_i2c_probe(struct i2c_client *client,
 	ec_dev->irq = client->irq;
 	ec_dev->cmd_xfer = cros_ec_cmd_xfer_i2c;
 	ec_dev->pkt_xfer = cros_ec_pkt_xfer_i2c;
+	ec_dev->cmd_readmem = cros_ec_readmem;
 	ec_dev->phys_name = client->adapter->name;
 	ec_dev->din_size = sizeof(struct ec_host_response_i2c) +
 			   sizeof(struct ec_response_get_protocol_info);
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index cc7baf0ecb3c..d2ba662fc713 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -636,3 +636,42 @@ u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev)
 	return host_event;
 }
 EXPORT_SYMBOL(cros_ec_get_host_event);
+
+int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
+		    unsigned int bytes, void *dest)
+{
+	struct ec_params_read_memmap *params;
+	struct cros_ec_command *msg;
+	int ret;
+
+	if (offset >= EC_MEMMAP_SIZE - bytes)
+		return -EINVAL;
+
+	msg = kzalloc(sizeof(*msg) + max_t(size_t, sizeof(*params), bytes),
+		      GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->version = 0;
+	msg->command = EC_CMD_READ_MEMMAP;
+	msg->insize = bytes;
+	msg->outsize = sizeof(*params);
+
+	params = (struct ec_params_read_memmap *)msg->data;
+	params->offset = offset;
+	params->size = bytes;
+
+	ret = cros_ec_cmd_xfer_status(ec, msg);
+	if (ret < 0) {
+		dev_warn(ec->dev, "cannot read mapped reg: %d/%d\n",
+			 ret, msg->result);
+		goto out_free;
+	}
+
+	memcpy(dest, msg->data, bytes);
+
+out_free:
+	kfree(msg);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cros_ec_readmem);
diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index 2060d1483043..b95c1a25adfc 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -666,6 +666,7 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	ec_dev->irq = spi->irq;
 	ec_dev->cmd_xfer = cros_ec_cmd_xfer_spi;
 	ec_dev->pkt_xfer = cros_ec_pkt_xfer_spi;
+	ec_dev->cmd_readmem = cros_ec_readmem;
 	ec_dev->phys_name = dev_name(&ec_spi->spi->dev);
 	ec_dev->din_size = EC_MSG_PREAMBLE_COUNT +
 			   sizeof(struct ec_host_response) +
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index de8b588c8776..0228fb42dcda 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -335,6 +335,18 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event);
  */
 u32 cros_ec_get_host_event(struct cros_ec_device *ec_dev);
 
+/**
+ * cros_ec_readmem - Read mapped memory in the ChromeOS EC
+ *
+ * @ec: Device to read from
+ * @offset: Offset to read within the mapped region
+ * @bytes: number of bytes to read
+ * @data: Return data
+ * @return: 0 if Ok, -ve on error
+ */
+int cros_ec_readmem(struct cros_ec_device *ec, unsigned int offset,
+		    unsigned int bytes, void *dest);
+
 /* sysfs stuff */
 extern struct attribute_group cros_ec_attr_group;
 extern struct attribute_group cros_ec_lightbar_attr_group;
-- 
2.20.1


Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF92C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99302192D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwUwd6Yg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfBPAPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:15:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35658 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfBPAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:15:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so5748777plo.2;
        Fri, 15 Feb 2019 16:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnwgvlgKZzgDcW1p8jYLFZ+O7mxKkO66Ee7GWaCiVz0=;
        b=kwUwd6YgJAzlATPcvoPez7U5OfgKswR8/EaZ/MxsE/Th+pm8diDIMsEB0Ajtg9Xgvv
         pVuMHpt38dcMjeYvrD27P7+e2y8JgvK7TSk1bJAF5dRld4CyLOUKGa527epsvLfiTKfQ
         iaiXdkY+GQx7uveNH46zKmnzeEGImzlCxhCX7lw2pYxNbTSh0vfD8avgM91af18DghzJ
         6H3XqjzKNCKG5NfNMuqobYTgIfsW0k3DkpVG0ITeKiz2SY5F6fzyiGfTegQghkD/miW3
         +hqyhRRAaN0k9V2gCXNHXyMB9G6DsUn5fHdqyt3Hr5wzcAHHZ21prgkgLWZA+xlyn517
         0RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnwgvlgKZzgDcW1p8jYLFZ+O7mxKkO66Ee7GWaCiVz0=;
        b=fANs16JFJs0cwReeNYI30u/N4BnYg4XmxJZ7vbrvdro4bgXN0xLv+gyaF4cFCRYM7F
         qeNH61gI9zPsNwzNmXI+t5VnN0+IXXOQagf2pV2U0hqn3pX0Ii41CKw/k91mn4D25jPl
         Q+Bomld0sQ51tCzcdgLTk/XApkVtCb0wmrDhDWupuOH+75nScx7821rAJHRPIkd8pzvi
         zQ0l+1gsNIZXXvtTJNqqlYw6aOwzJP7/pKYP42MFlKnJtWdI9MMAF45o/6ll+yKRNgio
         EcwCvh30kfAkKVHBB+FosGB/bqdBRVlIfabGHYyJiUozKfWF0XuZY3uRvs1N293QLf9M
         T6xQ==
X-Gm-Message-State: AHQUAuYH1s9FfUv+SkQI11qGWV6mHaw3evDeJPHLW+nwuF/vtvsebVx6
        3zXGw5/uxTPevsGZN+h9BF0=
X-Google-Smtp-Source: AHgI3IbSbZR/+llTn5ADPp+oaXvv0xdgQWMoTbn7dofoCrqJmLnKpFJ1CvLhGCeWPFx6Ro4Vt0D9bg==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr12747662pll.33.1550276151603;
        Fri, 15 Feb 2019 16:15:51 -0800 (PST)
Received: from abbey.corp.xevo.com (hq.xevo.com. [4.14.243.50])
        by smtp.gmail.com with ESMTPSA id k66sm12343287pgc.24.2019.02.15.16.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 16:15:50 -0800 (PST)
From:   Jim Broadus <jbroadus@gmail.com>
To:     ckeepax@opensource.cirrus.com, benjamin.tissoires@redhat.com,
        wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Broadus <jbroadus@gmail.com>
Subject: [PATCH] i2c: Allow recovery of the initial IRQ by a i2c client device.
Date:   Fri, 15 Feb 2019 16:15:33 -0800
Message-Id: <20190216001533.5465-1-jbroadus@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous change allowed i2c client devices to discover new IRQs upon
reprobe. By clearing the IRQ in i2c_device_remove. However, if an IRQ was
assigned in i2c_new_device, that information is lost.

For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
client device structures are initialized during an ACPI walk. After
removing the i2c_hid device, modprobe fails.

This change caches the initial IRQ value in i2c_new_device and then resets
the client device IRQ to the initial value in i2c_device_remove.

Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
Signed-off-by: Jim Broadus <jbroadus@gmail.com>
---
 drivers/i2c/i2c-core-base.c | 9 +++++----
 include/linux/i2c.h         | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..af87a16ac3a5 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
 	dev_pm_clear_wake_irq(&client->dev);
 	device_init_wakeup(&client->dev, false);
 
-	client->irq = 0;
+	client->irq = client->init_irq;
 
 	return status;
 }
@@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->flags = info->flags;
 	client->addr = info->addr;
 
-	client->irq = info->irq;
-	if (!client->irq)
-		client->irq = i2c_dev_irq_from_resources(info->resources,
+	client->init_irq = info->irq;
+	if (!client->init_irq)
+		client->init_irq = i2c_dev_irq_from_resources(info->resources,
 							 info->num_resources);
+	client->irq = client->init_irq;
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..7e748648c7d3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -333,6 +333,7 @@ struct i2c_client {
 	char name[I2C_NAME_SIZE];
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct device dev;		/* the device structure		*/
+	int init_irq;			/* irq set at initialization	*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
-- 
2.20.1


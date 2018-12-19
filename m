Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EE1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCE4217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbeLSQsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:48:40 -0500
Received: from sauhun.de ([88.99.104.3]:55846 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbeLSQsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:48:36 -0500
Received: from localhost (p54B333DA.dip0.t-ipconnect.de [84.179.51.218])
        by pokefinder.org (Postfix) with ESMTPSA id 55BAD2E3560;
        Wed, 19 Dec 2018 17:48:34 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] i2c: add suspended flag and accessors for i2c adapters
Date:   Wed, 19 Dec 2018 17:48:17 +0100
Message-Id: <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few drivers open code handling of suspended adapters. It could be
handled by the core, though, to ensure generic handling. This patch adds
the flag and accessor functions. The usage of these helpers is optional,
though. See the kerneldoc in this patch.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-base.c |  1 +
 include/linux/i2c.h         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..2c465455b2f6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1232,6 +1232,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (!adap->lock_ops)
 		adap->lock_ops = &i2c_adapter_lock_ops;
 
+	adap->locked_flags = 0;
 	rt_mutex_init(&adap->bus_lock);
 	rt_mutex_init(&adap->mux_lock);
 	mutex_init(&adap->userspace_clients_lock);
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 65b4eaed1d96..b7401c55dc83 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -680,6 +680,8 @@ struct i2c_adapter {
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
+	unsigned long locked_flags;	/* owned by the I2C core */
+#define I2C_ALF_IS_SUSPENDED	0
 
 	int nr;
 	char name[48];
@@ -762,6 +764,38 @@ i2c_unlock_bus(struct i2c_adapter *adapter, unsigned int flags)
 	adapter->lock_ops->unlock_bus(adapter, flags);
 }
 
+/**
+ * i2c_mark_adapter_suspended - Report suspended state of the adapter to the core
+ * @adap: Adapter to mark as suspended
+ *
+ * When using this helper to mark an adapter as suspended, the core will reject
+ * further transfers to this adapter. The usage of this helper is optional but
+ * recommended for devices having distinct handlers for systems suspend and
+ * runtime suspend. More complex devices are free to implement custom solutions
+ * to reject transfers when suspended.
+ */
+static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
+{
+	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+}
+
+/**
+ * i2c_mark_adapter_resumed - Report resumed state of the adapter to the core
+ * @adap: Adapter to mark as resumed
+ *
+ * When using this helper to mark an adapter as resumed, the core will allow
+ * further transfers to this adapter. See also further notes to
+ * @i2c_mark_adapter_suspended().
+ */
+static inline void i2c_mark_adapter_resumed(struct i2c_adapter *adap)
+{
+	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+	clear_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
+	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
+}
+
 /*flags for the client struct: */
 #define I2C_CLIENT_PEC		0x04	/* Use Packet Error Checking */
 #define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
-- 
2.11.0


Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C58C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293E2196E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 20:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404557AbeLVU0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 15:26:36 -0500
Received: from sauhun.de ([88.99.104.3]:52664 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392813AbeLVU0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 15:26:34 -0500
Received: from localhost (p54B67A8B.dip0.t-ipconnect.de [84.182.122.139])
        by pokefinder.org (Postfix) with ESMTPSA id 1B15A2E35C9;
        Sat, 22 Dec 2018 21:26:33 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 2/9] i2c: reject new transfers when adapters are suspended
Date:   Sat, 22 Dec 2018 21:26:16 +0100
Message-Id: <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the 'is_suspended' flag from the PM core, we now reject new
transfers if the parent of the adapter is already marked suspended.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/fault-codes | 4 ++++
 drivers/i2c/i2c-core-base.c   | 3 +++
 drivers/i2c/i2c-core-smbus.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/Documentation/i2c/fault-codes b/Documentation/i2c/fault-codes
index 47c25abb7d52..0cee0fc545b4 100644
--- a/Documentation/i2c/fault-codes
+++ b/Documentation/i2c/fault-codes
@@ -112,6 +112,10 @@ EPROTO
 	case is when the length of an SMBus block data response
 	(from the SMBus slave) is outside the range 1-32 bytes.
 
+ESHUTDOWN
+	Returned when a transfer was requested using an adapter
+	which is already suspended.
+
 ETIMEDOUT
 	This is returned by drivers when an operation took too much
 	time, and was aborted before it completed.
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 28460f6a60cc..3ce238b782f3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1865,6 +1865,9 @@ int __i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 
 	if (WARN_ON(!msgs || num < 1))
 		return -EINVAL;
+	if (WARN(device_is_suspended(adap->dev.parent),
+		 "Accessing already suspended I2C/SMBus adapter"))
+		return -ESHUTDOWN;
 
 	if (adap->quirks && i2c_check_for_quirks(adap, msgs, num))
 		return -EOPNOTSUPP;
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 9cd66cabb84f..e0f7f22feabd 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -547,6 +547,10 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	int try;
 	s32 res;
 
+	if (WARN(device_is_suspended(adapter->dev.parent),
+		 "Accessing already suspended I2C/SMBus adapter"))
+		return -ESHUTDOWN;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
-- 
2.19.1


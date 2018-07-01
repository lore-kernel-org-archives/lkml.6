Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF319C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55D125417
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55D125417
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032249AbeGAQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:45:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeGAQph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:45:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8464EA73;
        Sun,  1 Jul 2018 16:45:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.17 198/220] Input: elan_i2c_smbus - fix more potential stack buffer overflows
Date:   Sun,  1 Jul 2018 18:23:42 +0200
Message-Id: <20180701160916.451995436@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
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

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 50fc7b61959af4b95fafce7fe5dd565199e0b61a upstream.

Commit 40f7090bb1b4 ("Input: elan_i2c_smbus - fix corrupted stack")
fixed most of the functions using i2c_smbus_read_block_data() to
allocate a buffer with the maximum block size.  However three
functions were left unchanged:

* In elan_smbus_initialize(), increase the buffer size in the same
  way.
* In elan_smbus_calibrate_result(), the buffer is provided by the
  caller (calibrate_store()), so introduce a bounce buffer.  Also
  name the result buffer size.
* In elan_smbus_get_report(), the buffer is provided by the caller
  but happens to be the right length.  Add a compile-time assertion
  to ensure this remains the case.

Cc: <stable@vger.kernel.org> # 3.19+
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c.h       |    2 ++
 drivers/input/mouse/elan_i2c_core.c  |    2 +-
 drivers/input/mouse/elan_i2c_smbus.c |   10 ++++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -27,6 +27,8 @@
 #define ETP_DISABLE_POWER	0x0001
 #define ETP_PRESSURE_OFFSET	25
 
+#define ETP_CALIBRATE_MAX_LEN	3
+
 /* IAP Firmware handling */
 #define ETP_PRODUCT_ID_FORMAT_STRING	"%d.0"
 #define ETP_FW_NAME		"elan_i2c_" ETP_PRODUCT_ID_FORMAT_STRING ".bin"
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -610,7 +610,7 @@ static ssize_t calibrate_store(struct de
 	int tries = 20;
 	int retval;
 	int error;
-	u8 val[3];
+	u8 val[ETP_CALIBRATE_MAX_LEN];
 
 	retval = mutex_lock_interruptible(&data->sysfs_mutex);
 	if (retval)
--- a/drivers/input/mouse/elan_i2c_smbus.c
+++ b/drivers/input/mouse/elan_i2c_smbus.c
@@ -56,7 +56,7 @@
 static int elan_smbus_initialize(struct i2c_client *client)
 {
 	u8 check[ETP_SMBUS_HELLOPACKET_LEN] = { 0x55, 0x55, 0x55, 0x55, 0x55 };
-	u8 values[ETP_SMBUS_HELLOPACKET_LEN] = { 0, 0, 0, 0, 0 };
+	u8 values[I2C_SMBUS_BLOCK_MAX] = {0};
 	int len, error;
 
 	/* Get hello packet */
@@ -117,12 +117,16 @@ static int elan_smbus_calibrate(struct i
 static int elan_smbus_calibrate_result(struct i2c_client *client, u8 *val)
 {
 	int error;
+	u8 buf[I2C_SMBUS_BLOCK_MAX] = {0};
+
+	BUILD_BUG_ON(ETP_CALIBRATE_MAX_LEN > sizeof(buf));
 
 	error = i2c_smbus_read_block_data(client,
-					  ETP_SMBUS_CALIBRATE_QUERY, val);
+					  ETP_SMBUS_CALIBRATE_QUERY, buf);
 	if (error < 0)
 		return error;
 
+	memcpy(val, buf, ETP_CALIBRATE_MAX_LEN);
 	return 0;
 }
 
@@ -472,6 +476,8 @@ static int elan_smbus_get_report(struct
 {
 	int len;
 
+	BUILD_BUG_ON(I2C_SMBUS_BLOCK_MAX > ETP_SMBUS_REPORT_LEN);
+
 	len = i2c_smbus_read_block_data(client,
 					ETP_SMBUS_PACKET_QUERY,
 					&report[ETP_SMBUS_REPORT_OFFSET]);



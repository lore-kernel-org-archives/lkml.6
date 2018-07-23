Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703CDECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2370420685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2370420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbeGWV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:29:51 -0400
Received: from sauhun.de ([88.99.104.3]:51260 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388039AbeGWV3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:29:50 -0400
Received: from localhost (p54B3377D.dip0.t-ipconnect.de [84.179.55.125])
        by pokefinder.org (Postfix) with ESMTPSA id 2CDAE631A4F;
        Mon, 23 Jul 2018 22:26:56 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] i2c: qup: use core to detect 'no zero length' quirk
Date:   Mon, 23 Jul 2018 22:26:10 +0200
Message-Id: <20180723202617.15230-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And don't reimplement in the driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested.

 drivers/i2c/busses/i2c-qup.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index c86c3ae1318f..e09cd0775ae9 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1088,11 +1088,6 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
 	writel(I2C_MINI_CORE | I2C_N_VAL, qup->base + QUP_CONFIG);
 
 	for (idx = 0; idx < num; idx++) {
-		if (msgs[idx].len == 0) {
-			ret = -EINVAL;
-			goto out;
-		}
-
 		if (qup_i2c_poll_state_i2c_master(qup)) {
 			ret = -EIO;
 			goto out;
@@ -1520,9 +1515,6 @@ qup_i2c_determine_mode_v2(struct qup_i2c_dev *qup,
 
 	/* All i2c_msgs should be transferred using either dma or cpu */
 	for (idx = 0; idx < num; idx++) {
-		if (msgs[idx].len == 0)
-			return -EINVAL;
-
 		if (msgs[idx].flags & I2C_M_RD)
 			max_rx_len = max_t(unsigned int, max_rx_len,
 					   msgs[idx].len);
@@ -1636,9 +1628,14 @@ static const struct i2c_algorithm qup_i2c_algo_v2 = {
  * which limits the possible read to 256 (QUP_READ_LIMIT) bytes.
  */
 static const struct i2c_adapter_quirks qup_i2c_quirks = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
 	.max_read_len = QUP_READ_LIMIT,
 };
 
+static const struct i2c_adapter_quirks qup_i2c_quirks_v2 = {
+	.flags = I2C_AQ_NO_ZERO_LEN,
+};
+
 static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
 {
 	clk_prepare_enable(qup->clk);
@@ -1701,6 +1698,7 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		is_qup_v1 = true;
 	} else {
 		qup->adap.algo = &qup_i2c_algo_v2;
+		qup->adap.quirks = &qup_i2c_quirks_v2;
 		is_qup_v1 = false;
 		if (acpi_match_device(qup_i2c_acpi_match, qup->dev))
 			goto nodma;
-- 
2.11.0


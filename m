Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30B06C07D5D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2D8208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2D8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932650AbeFLFUH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:20:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:51970 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeFLFUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:20:05 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C5JDa6008698;
        Tue, 12 Jun 2018 00:19:25 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 4/5] fsi/scom: Add register definitions
Date:   Tue, 12 Jun 2018 15:19:10 +1000
Message-Id: <20180612051911.20690-5-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612051911.20690-1-benh@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few more register and bit definitions, also define and use
SCOM_READ_CMD (which is 0 but it makes the code clearer)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-scom.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 6ddfb6021420..e98573ecdae1 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -30,8 +30,25 @@
 #define SCOM_DATA0_REG		0x00
 #define SCOM_DATA1_REG		0x04
 #define SCOM_CMD_REG		0x08
+#define SCOM_FSI2PIB_RESET_REG	0x18
+#define SCOM_STATUS_REG		0x1C /* Read */
+#define SCOM_PIB_RESET_REG	0x1C /* Write */
 
+/* Command register */
 #define SCOM_WRITE_CMD		0x80000000
+#define SCOM_READ_CMD		0x00000000
+
+/* Status register bits */
+#define SCOM_STATUS_ERR_SUMMARY		0x80000000
+#define SCOM_STATUS_PROTECTION		0x01000000
+#define SCOM_STATUS_PIB_ABORT		0x00100000
+#define SCOM_STATUS_PIB_RESP_MASK	0x00007000
+#define SCOM_STATUS_PIB_RESP_SHIFT	12
+
+#define SCOM_STATUS_ANY_ERR		(SCOM_STATUS_ERR_SUMMARY | \
+					 SCOM_STATUS_PROTECTION | \
+					 SCOM_STATUS_PIB_ABORT | \
+					 SCOM_STATUS_PIB_RESP_MASK)
 
 struct scom_device {
 	struct list_head link;
@@ -85,7 +102,7 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
 
 	mutex_lock(&scom_dev->lock);
 	*value = 0ULL;
-	data = cpu_to_be32(addr);
+	data = cpu_to_be32(SCOM_READ_CMD | addr);
 	rc = fsi_device_write(scom_dev->fsi_dev, SCOM_CMD_REG, &data,
 				sizeof(uint32_t));
 	if (rc)
-- 
2.17.0


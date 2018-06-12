Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A46BCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACC2208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACC2208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932547AbeFLFUF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:20:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:51968 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeFLFUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:20:03 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5C5JDa5008698;
        Tue, 12 Jun 2018 00:19:22 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 3/5] fsi/scom: Fixup endian annotations
Date:   Tue, 12 Jun 2018 15:19:09 +1000
Message-Id: <20180612051911.20690-4-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180612051911.20690-1-benh@kernel.crashing.org>
References: <20180612051911.20690-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper annotated type __be32 and fixup the
accessor used for get_scom()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/fsi/fsi-scom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 8a608db0aa07..6ddfb6021420 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -51,8 +51,8 @@ static DEFINE_IDA(scom_ida);
 static int put_scom(struct scom_device *scom_dev, uint64_t value,
 		    uint32_t addr)
 {
+	__be32 data;
 	int rc;
-	uint32_t data;
 
 	mutex_lock(&scom_dev->lock);
 
@@ -79,7 +79,7 @@ static int put_scom(struct scom_device *scom_dev, uint64_t value,
 static int get_scom(struct scom_device *scom_dev, uint64_t *value,
 		    uint32_t addr)
 {
-	uint32_t result, data;
+	__be32 result, data;
 	int rc;
 
 
@@ -96,14 +96,13 @@ static int get_scom(struct scom_device *scom_dev, uint64_t *value,
 	if (rc)
 		goto bail;
 
-	*value |= (uint64_t)cpu_to_be32(result) << 32;
+	*value |= (uint64_t)be32_to_cpu(result) << 32;
 	rc = fsi_device_read(scom_dev->fsi_dev, SCOM_DATA1_REG, &result,
 				sizeof(uint32_t));
 	if (rc)
 		goto bail;
 
-	*value |= cpu_to_be32(result);
-
+	*value |= be32_to_cpu(result);
  bail:
 	mutex_unlock(&scom_dev->lock);
 	return rc;
-- 
2.17.0


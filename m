Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC7C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0065206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h0X5Rub5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0065206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIKWr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:47:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52794 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeIKWr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:47:27 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8BHkkPr044137;
        Tue, 11 Sep 2018 12:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536688006;
        bh=lGkxae0idkG9O6iI5j3ScufmdGgRG3WnEEttniLuimQ=;
        h=From:To:CC:Subject:Date;
        b=h0X5Rub5dsFKxIEXEuKbYcGlVGrLMogzvrtk4aw1oUvO91gkqjIH3Dhot1htTD2dX
         +0wNyyqukvEijjkJxDmaFIGlQJG59mRTERbPIvIAiDB/HU74pQBkL6ZcRJJ0u+7c/p
         Wzbmnfjk79PtsbHC8GRyub3nSie1dOrH1TOqVf6Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BHkkMx026793;
        Tue, 11 Sep 2018 12:46:46 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 11
 Sep 2018 12:46:46 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 11 Sep 2018 12:46:46 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8BHkkXH012565;
        Tue, 11 Sep 2018 12:46:46 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8BHkkx23076;
        Tue, 11 Sep 2018 12:46:46 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH] samples/rpmsg: Introduce a module parameter for message count
Date:   Tue, 11 Sep 2018 12:46:43 -0500
Message-ID: <20180911174643.26199-1-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rpmsg_client_sample uses a fixed number of messages to
be sent to each instance. This is currently set at 100. Introduce
an optional module parameter 'count' so that the number of messages
to be exchanged can be made flexible.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 samples/rpmsg/rpmsg_client_sample.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/rpmsg/rpmsg_client_sample.c b/samples/rpmsg/rpmsg_client_sample.c
index f161dfd3e70a..9b6b27ea504f 100644
--- a/samples/rpmsg/rpmsg_client_sample.c
+++ b/samples/rpmsg/rpmsg_client_sample.c
@@ -22,7 +22,9 @@
 #include <linux/rpmsg.h>
 
 #define MSG		"hello world!"
-#define MSG_LIMIT	100
+
+static int count = 100;
+module_param(count, int, 0644);
 
 struct instance_data {
 	int rx_count;
@@ -41,7 +43,7 @@ static int rpmsg_sample_cb(struct rpmsg_device *rpdev, void *data, int len,
 		       data, len,  true);
 
 	/* samples should not live forever */
-	if (idata->rx_count >= MSG_LIMIT) {
+	if (idata->rx_count >= count) {
 		dev_info(&rpdev->dev, "goodbye!\n");
 		return 0;
 	}
-- 
2.18.0


Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACE9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E3321855
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfAHHkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:40:40 -0500
Received: from emcscan.emc.com.tw ([192.72.220.5]:24844 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfAHHkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:40:40 -0500
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2019 02:40:39 EST
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with SMTP; 08 Jan 2019 15:30:50 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(2816:0:AUTH_RELAY)
        (envelope-from <kt.liao@emc.com.tw>); Tue, 08 Jan 2019 15:30:49 +0800 (CST)
Received: from 192.168.82.59
        by webmail.emc.com.tw with Mail2000 ESMTPA Server V7.00(2481:0:AUTH_LOGIN)
        (envelope-from <kt.liao@emc.com.tw>); Tue, 08 Jan 2019 15:30:48 +0800 (CST)
From:   KT Liao <kt.liao@emc.com.tw>
To:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc:     kt.liao@emc.com.tw
Subject: [PATCH] Input: elan_i2c - Add auto recovery handle for absolute mode
Date:   Tue,  8 Jan 2019 15:30:42 +0800
Message-Id: <1546932642-3621-1-git-send-email-kt.liao@emc.com.tw>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes touchpad will be reset to mouse mode unexpectedly.
And cause invalid report detection.
I add a mouse report detection and send mode-switching command again.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2690a4b..56b5766 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -51,6 +51,7 @@
 
 #define ETP_MAX_FINGERS		5
 #define ETP_FINGER_DATA_LEN	5
+#define ETP_MOUSE_REPORT_ID	0x01
 #define ETP_REPORT_ID		0x5D
 #define ETP_TP_REPORT_ID	0x5E
 #define ETP_REPORT_ID_OFFSET	2
@@ -988,6 +989,14 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	case ETP_TP_REPORT_ID:
 		elan_report_trackpoint(data, report);
 		break;
+	case ETP_MOUSE_REPORT_ID:
+		dev_info(dev, "Mouse report now, mode switch again\n");
+		data->mode |= ETP_ENABLE_ABS;
+		error = data->ops->set_mode(data->client, data->mode);
+		if (error)
+			dev_err(dev, "fail to switch to absolute mode(%d)\n",
+					error);
+		break;
 	default:
 		dev_err(dev, "invalid report id data (%x)\n",
 			report[ETP_REPORT_ID_OFFSET]);
-- 
2.7.4


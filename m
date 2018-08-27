Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD24C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A822174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A822174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeH0F2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 01:28:20 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:34653 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeH0F2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 01:28:19 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75b835755c7d-00741; Mon, 27 Aug 2018 09:43:49 +0800 (CST)
X-RM-TRANSID: 2ee75b835755c7d-00741
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55b835753896-e26b6;
        Mon, 27 Aug 2018 09:43:49 +0800 (CST)
X-RM-TRANSID: 2ee55b835753896-e26b6
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] Bluetooth: bt3c_cs: Fix obsolete function
Date:   Sun, 26 Aug 2018 22:55:00 -0400
Message-Id: <1535338500-7682-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtol and simple_strtoul are obsolete, both place
use kstrtouint instead.

V2: fix error tmp += tn
V3: fix compile error

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/bluetooth/bt3c_cs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 25b0cf9..5471383 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -448,7 +448,7 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 {
 	char *ptr = (char *) firmware;
 	char b[9];
-	unsigned int iobase, tmp;
+	unsigned int iobase, tmp, tn;
 	unsigned long size, addr, fcs;
 	int i, err = 0;
 
@@ -490,7 +490,9 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 		memset(b, 0, sizeof(b));
 		for (tmp = 0, i = 0; i < size; i++) {
 			memcpy(b, ptr + (i * 2) + 2, 2);
-			tmp += simple_strtol(b, NULL, 16);
+			if (kstrtouint(b, 16, &tn))
+				return -EINVAL;
+			tmp += tn;
 		}
 
 		if (((tmp + fcs) & 0xff) != 0xff) {
@@ -505,7 +507,8 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 			memset(b, 0, sizeof(b));
 			for (i = 0; i < (size - 4) / 2; i++) {
 				memcpy(b, ptr + (i * 4) + 12, 4);
-				tmp = simple_strtoul(b, NULL, 16);
+				if (kstrtouint(b, 16, &tmp))
+					return -EINVAL;
 				bt3c_put(iobase, tmp);
 			}
 		}
-- 
1.8.3.1




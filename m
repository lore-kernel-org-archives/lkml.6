Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1A0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147E421710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147E421710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeHXMp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:45:59 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:38096 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbeHXMp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:45:59 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85b7fcbecf11-d9925; Fri, 24 Aug 2018 17:12:12 +0800 (CST)
X-RM-TRANSID: 2ee85b7fcbecf11-d9925
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65b7fcbeb777-45906;
        Fri, 24 Aug 2018 17:12:12 +0800 (CST)
X-RM-TRANSID: 2ee65b7fcbeb777-45906
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: bt3c_cs: Fix obsolete function
Date:   Fri, 24 Aug 2018 06:23:32 -0400
Message-Id: <1535106212-21514-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtol and simple_strtoul are obsolete, both place
use kstrtoul instead.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/bluetooth/bt3c_cs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 25b0cf9..5e4800d 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -449,7 +449,7 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 	char *ptr = (char *) firmware;
 	char b[9];
 	unsigned int iobase, tmp;
-	unsigned long size, addr, fcs;
+	unsigned long size, addr, fcs, tn;
 	int i, err = 0;
 
 	iobase = info->p_dev->resource[0]->start;
@@ -490,7 +490,9 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 		memset(b, 0, sizeof(b));
 		for (tmp = 0, i = 0; i < size; i++) {
 			memcpy(b, ptr + (i * 2) + 2, 2);
-			tmp += simple_strtol(b, NULL, 16);
+			if (kstrtoul(b, 16, &tn))
+				return -EINVAL;
+			tmp += tn;
 		}
 
 		if (((tmp + fcs) & 0xff) != 0xff) {
@@ -505,7 +507,9 @@ static int bt3c_load_firmware(struct bt3c_info *info,
 			memset(b, 0, sizeof(b));
 			for (i = 0; i < (size - 4) / 2; i++) {
 				memcpy(b, ptr + (i * 4) + 12, 4);
-				tmp = simple_strtoul(b, NULL, 16);
+				if (kstrtoul(b, 16, &tn))
+					return -EINVAL;
+				tmp += tn;
 				bt3c_put(iobase, tmp);
 			}
 		}
-- 
1.8.3.1




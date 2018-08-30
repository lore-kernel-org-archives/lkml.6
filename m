Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE4AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9C82054F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 09:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9C82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbeH3Nco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 09:32:44 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:41997 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeH3Nco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 09:32:44 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85b87b96ed0e-628dd; Thu, 30 Aug 2018 17:31:26 +0800 (CST)
X-RM-TRANSID: 2ee85b87b96ed0e-628dd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95b87b96d08c-15c2f;
        Thu, 30 Aug 2018 17:31:26 +0800 (CST)
X-RM-TRANSID: 2ee95b87b96d08c-15c2f
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: misc: fix obsolete function
Date:   Thu, 30 Aug 2018 17:31:18 +0800
Message-Id: <1535621478-15208-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtoul is obsolete, and use kstrtoint instead

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/usb/misc/trancevibrator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/trancevibrator.c b/drivers/usb/misc/trancevibrator.c
index b3e1f55..ac357ce 100644
--- a/drivers/usb/misc/trancevibrator.c
+++ b/drivers/usb/misc/trancevibrator.c
@@ -46,7 +46,9 @@ static ssize_t speed_store(struct device *dev, struct device_attribute *attr,
 	struct trancevibrator *tv = usb_get_intfdata(intf);
 	int temp, retval, old;
 
-	temp = simple_strtoul(buf, NULL, 10);
+	retval = kstrtoint(buf, 10, &temp);
+	if (retval)
+		return retval;
 	if (temp > 255)
 		temp = 255;
 	else if (temp < 0)
-- 
1.9.1




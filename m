Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40444C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA7C2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EA7C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeH0NTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:19:37 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:38110 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0NTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:19:37 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45b83c572a65-1185d; Mon, 27 Aug 2018 17:33:38 +0800 (CST)
X-RM-TRANSID: 2ee45b83c572a65-1185d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from bclinux72.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5b83c572302-06af4;
        Mon, 27 Aug 2018 17:33:38 +0800 (CST)
X-RM-TRANSID: 2eea5b83c572302-06af4
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: ab8500_fg: fix obsolete function
Date:   Mon, 27 Aug 2018 06:49:15 -0400
Message-Id: <1535366955-12733-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_strtoul is obsolete, and use kstrtoint instead

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/power/supply/ab8500_fg.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 02356f9..2bdadb5 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2582,11 +2582,12 @@ static ssize_t ab8505_powercut_flagtime_write(struct device *dev,
 				  const char *buf, size_t count)
 {
 	int ret;
-	long unsigned reg_value;
+	int reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
 
 	if (reg_value > 0x7F) {
 		dev_err(dev, "Incorrect parameter, echo 0 (1.98s) - 127 (15.625ms) for flagtime\n");
@@ -2636,7 +2637,9 @@ static ssize_t ab8505_powercut_maxtime_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0x7F) {
 		dev_err(dev, "Incorrect parameter, echo 0 (0.0s) - 127 (1.98s) for maxtime\n");
 		goto fail;
@@ -2684,7 +2687,9 @@ static ssize_t ab8505_powercut_restart_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0xF) {
 		dev_err(dev, "Incorrect parameter, echo 0 - 15 for number of restart\n");
 		goto fail;
@@ -2777,7 +2782,9 @@ static ssize_t ab8505_powercut_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0x1) {
 		dev_err(dev, "Incorrect parameter, echo 0/1 to disable/enable Pcut feature\n");
 		goto fail;
@@ -2849,7 +2856,9 @@ static ssize_t ab8505_powercut_debounce_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0x7) {
 		dev_err(dev, "Incorrect parameter, echo 0 to 7 for debounce setting\n");
 		goto fail;
-- 
1.8.3.1




Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B80C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90703215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90703215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbeI1SYg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:24:36 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:14264 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbeI1SYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:24:36 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2018 14:24:35 EDT
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.54,314,1534802400"; 
   d="scan'208";a="36654630"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Denis OSTERLAND" <denis.osterland@diehl.com>
Subject: [PATCH] rtc: isl1208: access i2c client via rtc parent
Thread-Topic: [PATCH] rtc: isl1208: access i2c client via rtc parent
Thread-Index: AQHUVyGQKP+USsTTMEa4uID7TSMNXQ==
Date:   Fri, 28 Sep 2018 11:51:17 +0000
Message-ID: <20180928114832.27383-1-Denis.Osterland@diehl.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: 415AWy8o668fDtCxszluzyTxtule2fzpl/mNt4bSsMHQALdi8BOj7OdbdMtiUqvX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Osterland <Denis.Osterland@diehl.com>

The move of atrim, dtrim usr sysfs properties from i2c device
to rtc device require to access them via dev->parent.
This patch also aligns timestamp0.

Fixes: 03df75dd03301307ec578ccd4e8c1c0117b8e65c
Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
---
 drivers/rtc/rtc-isl1208.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 15094df12985..ec5ef518a09b 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -517,7 +517,7 @@ static ssize_t timestamp0_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct i2c_client *client = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	int sr;
 
 	sr = isl1208_i2c_get_sr(client);
@@ -539,7 +539,7 @@ static ssize_t timestamp0_store(struct device *dev,
 static ssize_t timestamp0_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
-	struct i2c_client *client = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev->parent);
 	u8 regs[ISL1219_EVT_SECTION_LEN] = { 0, };
 	struct rtc_time tm;
 	int sr;
@@ -649,7 +649,7 @@ static ssize_t
 isl1208_sysfs_show_atrim(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	int atr = isl1208_i2c_get_atr(to_i2c_client(dev));
+	int atr = isl1208_i2c_get_atr(to_i2c_client(dev->parent));
 	if (atr < 0)
 		return atr;
 
@@ -662,7 +662,7 @@ static ssize_t
 isl1208_sysfs_show_dtrim(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
-	int dtr = isl1208_i2c_get_dtr(to_i2c_client(dev));
+	int dtr = isl1208_i2c_get_dtr(to_i2c_client(dev->parent));
 	if (dtr < 0)
 		return dtr;
 
@@ -675,7 +675,7 @@ static ssize_t
 isl1208_sysfs_show_usr(struct device *dev,
 		       struct device_attribute *attr, char *buf)
 {
-	int usr = isl1208_i2c_get_usr(to_i2c_client(dev));
+	int usr = isl1208_i2c_get_usr(to_i2c_client(dev->parent));
 	if (usr < 0)
 		return usr;
 
@@ -700,7 +700,10 @@ isl1208_sysfs_store_usr(struct device *dev,
 	if (usr < 0 || usr > 0xffff)
 		return -EINVAL;
 
-	return isl1208_i2c_set_usr(to_i2c_client(dev), usr) ? -EIO : count;
+	if (isl1208_i2c_set_usr(to_i2c_client(dev->parent), usr))
+		return -EIO;
+
+	return count;
 }
 
 static DEVICE_ATTR(usr, S_IRUGO | S_IWUSR, isl1208_sysfs_show_usr,
@@ -764,7 +767,6 @@ isl1208_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	rtc->ops = &isl1208_rtc_ops;
 
 	i2c_set_clientdata(client, rtc);
-	dev_set_drvdata(&rtc->dev, client);
 
 	rc = isl1208_i2c_get_sr(client);
 	if (rc < 0) {
-- 
2.19.0



Diehl Connectivity Solutions GmbH
Geschäftsführung: Horst Leonberger
Sitz der Gesellschaft: Nürnberg - Registergericht: Amtsgericht
Nürnberg: HRB 32315
___________________________________________________________________________________________________

Der Inhalt der vorstehenden E-Mail ist nicht rechtlich bindend. Diese E-Mail enthaelt vertrauliche und/oder rechtlich geschuetzte Informationen.
Informieren Sie uns bitte, wenn Sie diese E-Mail faelschlicherweise erhalten haben. Bitte loeschen Sie in diesem Fall die Nachricht.
Jede unerlaubte Form der Reproduktion, Bekanntgabe, Aenderung, Verteilung und/oder Publikation dieser E-Mail ist strengstens untersagt.
The contents of the above mentioned e-mail is not legally binding. This e-mail contains confidential and/or legally protected information. Please inform us if you have received this e-mail by
mistake and delete it in such a case. Each unauthorized reproduction, disclosure, alteration, distribution and/or publication of this e-mail is strictly prohibited. 
